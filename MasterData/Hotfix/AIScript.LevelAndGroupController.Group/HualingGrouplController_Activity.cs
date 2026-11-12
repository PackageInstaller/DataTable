using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class HualingGrouplController_Activity : GroupControllerBase
{
	private enum BubbleColor
	{
		None,
		Red,
		Blue
	}

	private string monsterClearEvent = "monsterClearEvent";

	private readonly string eventStr = "paopaoShuaxing";

	private const int dropId_Red = 136;

	private const int dropId_Blue = 135;

	private const int buffId_Red = 314010200;

	private const int buffId_Blue = 314010100;

	private static readonly FP refreshInnerRadius = 5;

	private static readonly FP refreshOuterRadius = 7;

	private static readonly FP refreshFanAngle = 180;

	private static readonly FP minBubbleGap = 5;

	private const int maxSampleTry = 8;

	private static readonly string[] burstFxAlias_Red = new string[3] { "Area_RedBubbleBurst_Lv1", "Area_RedBubbleBurst_Lv2", "Area_RedBubbleBurst_Lv3" };

	private static readonly string[] burstFxAlias_Blue = new string[3] { "Area_BlueBubbleBurst_Lv1", "Area_BlueBubbleBurst_Lv2", "Area_BlueBubbleBurst_Lv3" };

	private static readonly int[] burstGainBuffId_Red = new int[3] { 1718906696, 1415346281, 1701668200 };

	private static readonly int[] burstGainBuffId_Blue;

	private readonly Dictionary<long, BubbleColor> _spawnedBubbles = new Dictionary<long, BubbleColor>();

	private bool clearMonster;

	private readonly List<TSVector2> _bubblePosBuffer = new List<TSVector2>();

	protected override void OnStart()
	{
		base.OnStart();
		clearMonster = false;
		_spawnedBubbles.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnReceiveInterActiveMessage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	protected override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INTERACTIVEID", OnReceiveInterActiveMessage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		_spawnedBubbles.Clear();
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (!clearMonster)
		{
			return;
		}
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance?.monsterActors;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		for (int num = list.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = list.get_Item(num);
			if (logicEntity != null && logicEntity is MonsterAdventureActor { state: not ActorState.Spawn } monsterAdventureActor && !monsterAdventureActor.IsDead())
			{
				monsterAdventureActor.DestroySelf();
			}
		}
	}

	private void OnReceiveInterActiveMessage(IEvent iEvt)
	{
		if (iEvt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger)
		{
			if (adventureInteractiveIDTrigger.interactiveID == eventStr)
			{
				SpawnBubble(BubbleColor.Red);
				SpawnBubble(BubbleColor.Blue);
			}
			if (adventureInteractiveIDTrigger.interactiveID == monsterClearEvent)
			{
				clearMonster = true;
			}
		}
	}

	private void SpawnBubble(BubbleColor color)
	{
		AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
		if (adventureActor == null)
		{
			return;
		}
		int dropIdByColor = GetDropIdByColor(color);
		if (dropIdByColor != 0)
		{
			TSVector2 refreshPosition = GetRefreshPosition(adventureActor);
			long num = SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(adventureActor, dropIdByColor, refreshPosition, adventureActor.tsTransform.PositionY);
			if (num != 0L)
			{
				_spawnedBubbles.set_Item(num, color);
			}
		}
	}

	private TSVector2 GetRefreshPosition(AdventureActor player)
	{
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			position = player.tsTransform.Position,
			radius = refreshOuterRadius,
			innerRadius = refreshInnerRadius,
			rotation = player.tsTransform.Rotation,
			angle = refreshFanAngle
		};
		List<TSVector2> positions = CollectExistingBubblePositions();
		FP fP = minBubbleGap * minBubbleGap;
		TSVector2 result = shape.position;
		FP fP2 = FP.MinValue;
		for (int i = 0; i < 8; i++)
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shape, player, isReachable: true);
			if (TSVector2.Distance(shape.position, shapeRandomPoint) < FP.EN1)
			{
				shape.shapeType = DeterministicShape.ShapeType.Circle;
				shape.rotation = 0;
				shapeRandomPoint = GetShapeRandomPoint(shape, player, isReachable: true);
			}
			FP fP3 = NearestDistanceSqr(shapeRandomPoint, positions);
			if (fP3 >= fP)
			{
				return shapeRandomPoint;
			}
			if (fP3 > fP2)
			{
				fP2 = fP3;
				result = shapeRandomPoint;
			}
		}
		return result;
	}

	private List<TSVector2> CollectExistingBubblePositions()
	{
		_bubblePosBuffer.Clear();
		foreach (long key in _spawnedBubbles.Keys)
		{
			DropEntity dropsEntity = SceneSingleton<DropsManager>.Instance.GetDropsEntity(key);
			if (dropsEntity != null)
			{
				_bubblePosBuffer.Add(dropsEntity.tsTransform.Position);
			}
		}
		return _bubblePosBuffer;
	}

	private FP NearestDistanceSqr(TSVector2 point, List<TSVector2> positions)
	{
		if (positions.Count == 0)
		{
			return FP.MaxValue;
		}
		FP fP = FP.MaxValue;
		for (int i = 0; i < positions.Count; i++)
		{
			FP fP2 = (point - positions.get_Item(i)).LengthSquared();
			if (fP2 < fP)
			{
				fP = fP2;
			}
		}
		return fP;
	}

	private void OnDropFinish(IEvent iEvt)
	{
		if (iEvt is AdventureDropFinishEvent { isPickUp: not false } adventureDropFinishEvent && _spawnedBubbles.TryGetValue(adventureDropFinishEvent.entityID, out var value))
		{
			_spawnedBubbles.Remove(adventureDropFinishEvent.entityID);
			AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
			if (!(adventureActor == null))
			{
				OnEatBubble(adventureActor, value);
				SpawnBubble(value);
			}
		}
	}

	private void OnEatBubble(AdventureActor player, BubbleColor eatenColor)
	{
		int buffIdByColor = GetBuffIdByColor(eatenColor);
		if (buffIdByColor != 0)
		{
			BubbleColor bubbleColor = ((eatenColor != BubbleColor.Red) ? BubbleColor.Red : BubbleColor.Blue);
			int buffIdByColor2 = GetBuffIdByColor(bubbleColor);
			int num = ((buffIdByColor2 != 0) ? GetBuffNum(player, buffIdByColor2) : 0);
			if (num > 0)
			{
				TriggerBubbleBurst(player, bubbleColor, num);
				GrantBurstGainBuff(player, bubbleColor, num);
				RemoveBuffFromTarget(player, buffIdByColor2);
				AddBuffToTarget(player, player, buffIdByColor);
			}
			else
			{
				AddBuffToTarget(player, player, buffIdByColor);
			}
		}
	}

	private void TriggerBubbleBurst(AdventureActor player, BubbleColor burstColor, int layer)
	{
		string burstFxAlias = GetBurstFxAlias(burstColor, layer);
		if (!string.IsNullOrEmpty(burstFxAlias))
		{
			ILRuntimeAPI.PlayAreaEffect(player, burstFxAlias, player.tsTransform.Position, player.tsTransform.Forward.GetAngle());
		}
	}

	private string GetBurstFxAlias(BubbleColor color, int layer)
	{
		string[] array = ((color == BubbleColor.Red) ? burstFxAlias_Red : burstFxAlias_Blue);
		if (array == null || array.Length == 0)
		{
			return string.Empty;
		}
		int num = layer - 1;
		if (num < 0)
		{
			num = 0;
		}
		if (num >= array.Length)
		{
			num = array.Length - 1;
		}
		return array[num];
	}

	private void GrantBurstGainBuff(AdventureActor player, BubbleColor burstColor, int layer)
	{
		int burstGainBuffId = GetBurstGainBuffId(burstColor, layer);
		if (burstGainBuffId != 0)
		{
			AddBuffToTarget(player, player, burstGainBuffId);
		}
	}

	private int GetBurstGainBuffId(BubbleColor color, int layer)
	{
		int[] array = ((color == BubbleColor.Red) ? burstGainBuffId_Red : burstGainBuffId_Blue);
		if (array == null || array.Length == 0)
		{
			return 0;
		}
		int num = layer - 1;
		if (num < 0)
		{
			num = 0;
		}
		if (num >= array.Length)
		{
			num = array.Length - 1;
		}
		return array[num];
	}

	private int GetDropIdByColor(BubbleColor color)
	{
		if (color != BubbleColor.Red)
		{
			return 135;
		}
		return 136;
	}

	private int GetBuffIdByColor(BubbleColor color)
	{
		if (color != BubbleColor.Red)
		{
			return 314010100;
		}
		return 314010200;
	}

	static HualingGrouplController_Activity()
	{
		//IL_0098: Field data (rva=0x560) could not be found in any section!
		//IL_0098: Field data (rva=0x560) could not be found in any section!
		int[] array = new int[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0C81937AF26AE64B7A5780DDD6243E71D3646E94A596E20A85960AB3B9453750));
		burstGainBuffId_Blue = array;
	}
}
