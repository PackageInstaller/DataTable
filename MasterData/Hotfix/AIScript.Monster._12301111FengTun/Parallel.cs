using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._12301111FengTun;

public class Parallel : ParallelBase
{
	private DeterministicShape shape = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		innerRadius = 1,
		radius = 1
	};

	public const int perkId_01 = 512301;

	public const int buff_p1 = 12301011;

	public const int perkId_02 = 512302;

	public static readonly int perkId_p3 = 512303;

	public const int time_03 = 5;

	private readonly int perkId_p4 = 512304;

	private readonly int buff_p4 = 12304011;

	private readonly string area_04 = "AreaEffect_123_FengTun_P4_JiGuang";

	private readonly FP cd_04 = 0.3f;

	public const int perkId_05 = 512305;

	public const int buff_05 = 12305011;

	private readonly int perkId_p6 = 512306;

	public const int buff_p6 = 12306011;

	public const int perkId_07 = 512307;

	private const int parameterId_07 = 12307001;

	public const int perkId_08 = 512308;

	public const int buff_08 = 12308011;

	public const int perkId_12 = 512312;

	public const int buff_p12 = 12312011;

	public const int perkId_13 = 512313;

	public const int buff_13 = 12313011;

	private PlayerAdventureActor summoner;

	public static FP start_p3_Time;

	public static FP parmValue_07;

	public static bool iPerk6;

	public override void OnEnable()
	{
		base.OnEnable();
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor as PlayerAdventureActor;
		if (GetPerk(512307))
		{
			parmValue_07 = CommonUtils.GetScriptValue(summoner, 12307001);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnActorGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		GetAssitActiveNum();
		if (GetPerk(perkId_p4))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.isAssist && playerAdventureActor.CheckSkillReady())
				{
					playerAdventureActor.buffComponent.AddBuff(buff_p4, _actor);
				}
			}
		}
		iPerk6 = GetPerk(perkId_p6);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnActorGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		summoner = null;
	}

	private void OnPlayerEnter(IEvent _evt)
	{
		AdventurePlayerEnterEvent adventurePlayerEnterEvent = _evt as AdventurePlayerEnterEvent;
		if (adventurePlayerEnterEvent.player != null && adventurePlayerEnterEvent.player.isAssist && GetPerk(512308))
		{
			_actor.buffComponent.AddBuff(12308011, summoner);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		_ = adventureElementMarkTriggerEvent.markActor;
		if (adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.AE && GetPerk(perkId_p4, cd_04) && adventureElementMarkTriggerEvent.triggerActor.Id != summoner.Id)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, area_04, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		if (summoner != null)
		{
			shape.position = summoner.tsTransform.Position;
			TSVector2 targetPosition = _actor.RandomActorReachablePointInsideShape(shape);
			_actor.Teleport(targetPosition);
		}
	}

	private int GetAssitActiveNum()
	{
		int num = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.isAssist && playerAdventureActor.actived)
			{
				num++;
			}
		}
		return num;
	}

	private void OnActorGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (!(adventureActorGetBuff.from != _actor))
		{
			adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Wind);
		}
	}

	private void OnReceiveDamage(IEvent _evt)
	{
		if (!(summoner == null))
		{
			AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = _evt as AdventureActorReceiveDamageEvent;
			if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from?.Id)
			{
				_ = adventureActorReceiveDamageEvent.to is MonsterAdventureActor;
			}
		}
	}

	public void OnUpdate()
	{
	}
}
