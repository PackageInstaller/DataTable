using System.Collections;
using System.Collections.Generic;
using TrueSync;
using TrueSync.Physics2D;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_HeXinBaoFa_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_HeXinBaoFa_Phase2 = "HeXinBaoFaP1";

	private const string evt_ChargeEnd = "ChargeEnd";

	private FP repulseWarningTime = 3.2;

	private const string repulseWarningFxAlias = "fx_m72012_loop_skill4_warning";

	private const string repulseWaveFxAlias = "fx_m72012_base_skill4_wave";

	private const string repulseAreaFxAlias = "AreaEffect_72012_Skill4_JiTui";

	private FP repulseAreaOffset = 100;

	private static readonly int[] laserBallCountsPerDir = new int[6] { 1415346281, 1701668200, 1802659152, 1701336156, 1180657005, 1768713313 };

	private static readonly int[] trapCountsPerDir = new int[6];

	private FP spawnRingRadius = 0.5;

	private FP directionInterval = 0;

	private static readonly string[] fromPositionHolders = new string[3] { "JuXingApproach_From_Left", "JuXingApproach_From_Right", "JuXingApproach_From_Up" };

	private static readonly string[] toPositionHolders = new string[3] { "JuXingApproach_To_Left", "JuXingApproach_To_Right", "JuXingApproach_To_Up" };

	private FP approachMoveSpeed = 36;

	private readonly TSVector2[] _repulseDirections = new TSVector2[4]
	{
		TSVector2.up,
		TSVector2.right,
		TSVector2.down,
		TSVector2.left
	};

	private static readonly TSVector2[][] _dirSpawnPoints = new TSVector2[4][]
	{
		new TSVector2[4]
		{
			new TSVector2(-10.5f, 10.5f),
			new TSVector2(10.5f, 10.5f),
			new TSVector2(-6f, 6f),
			new TSVector2(6f, 6f)
		},
		new TSVector2[4]
		{
			new TSVector2(10.5f, 10.5f),
			new TSVector2(10.5f, -10.5f),
			new TSVector2(6f, 6f),
			new TSVector2(6f, -6f)
		},
		new TSVector2[4]
		{
			new TSVector2(-10.5f, -10.5f),
			new TSVector2(10.5f, -10.5f),
			new TSVector2(-6f, -6f),
			new TSVector2(6f, -6f)
		},
		new TSVector2[4]
		{
			new TSVector2(-10.5f, 10.5f),
			new TSVector2(-10.5f, -10.5f),
			new TSVector2(-6f, 6f),
			new TSVector2(-6f, -6f)
		}
	};

	private long _warningFxId = -1L;

	private long _waveFxId = -1L;

	private List<LogicEntity> entityBuffer = new List<LogicEntity>();

	private readonly HashSet<string> _laserUsedAnchors = new HashSet<string>();

	private readonly HashSet<string> _trapUsedAnchors = new HashSet<string>();

	private bool finished;

	private int _summonLevel;

	private int _laserBallId;

	private int _trapId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_laserBallId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.laserOrbMonsterIds);
		_trapId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.trapMonsterIds);
		finished = false;
		_warningFxId = -1L;
		_waveFxId = -1L;
		_laserUsedAnchors.Clear();
		_trapUsedAnchors.Clear();
		SetLogicTagFpValue(_actor, Common_73001.PillarStrengthTag, 2);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopFx(ref _warningFxId);
		StopFx(ref _waveFxId);
		entityBuffer.Clear();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_laserBallId));
			ClearActors(GetTargetByDataID(_trapId));
			AddBuffToTarget(_actor, 720130108);
			RemoveBuffFromTarget(_actor, 720130107);
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		StopFx(ref _warningFxId);
		StopFx(ref _waveFxId);
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_laserBallId));
		ClearActors(GetTargetByDataID(_trapId));
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = (int)(long)GetRandomValue(0, fromPositionHolders.Length, isInt: true);
		TSVector2 fromPos = GetPlaceHolderPosition(fromPositionHolders[num]);
		TSVector2 toPos = GetPlaceHolderPosition(toPositionHolders[num]);
		Teleport(fromPos, checkPositionReachable: false);
		BeginLookAtByPos(TSVector2.zero, default, 1000);
		yield return WaitTime(0.1);
		AddBuffToTarget(_actor, 720130109);
		AddBuffToTarget(_actor, 720130107);
		FP origSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(toPos, 0.2f);
		PlayWwiseSound("mon_72012_move");
		yield return WaitMoveStatus();
		_actor.actorInfo.runSpeed = origSpeed;
		_actor.actorInfo.walkSpeed = origSpeed;
		ClearOwnerBullet();
		ClearOwnedSummons();
		BeginAttack(1, "HeXinBaoFaP1", flushInputedKeys: true);
		yield return WaitCustomEvent("ChargeEnd");
		int count = ((_summonLevel <= 4) ? 2 : 3);
		int[] dirIndices = SelectDirections(count);
		for (int i = 0; i < dirIndices.Length; i++)
		{
			int num2 = dirIndices[i];
			TSVector2 forward = _repulseDirections[num2];
			SpawnDirectionalMonsters(num2);
			_warningFxId = PlayDirectionalFx("fx_m72012_loop_skill4_warning", forward);
			yield return WaitTime(repulseWarningTime);
			StopFx(ref _warningFxId);
			yield return WaitTime(0.3);
			ExecuteRepulse(forward);
			_waveFxId = PlayDirectionalFx("fx_m72012_base_skill4_wave", forward);
			DispatchCustomEvent(Config_JuXingMoXiang.evt_GiantGolemBombard);
			if (i < dirIndices.Length - 1)
			{
				yield return WaitTime(directionInterval);
			}
		}
		CancelAttack();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtPosition(TSVector2.zero, 1000);
		FP retSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(fromPos, 0.2f);
		yield return WaitMoveStatus();
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
		_actor.actorInfo.runSpeed = retSpeed;
		_actor.actorInfo.walkSpeed = retSpeed;
		CancelAim();
	}

	private int[] SelectDirections(int count)
	{
		int[] array = new int[4] { 1718906696, 1415346281, 1550868850, 808661041 };
		for (int i = 0; i < count; i++)
		{
			int num = array.Length - i;
			int num2 = MathUtils.Clamp((int)(long)GetRandomValue(0, num - 1), 0, num - 1);
			int num3 = i + num2;
			ref int reference = ref array[i];
			ref int reference2 = ref array[num3];
			int num4 = array[num3];
			int num5 = array[i];
			reference = num4;
			reference2 = num5;
		}
		int[] array2 = new int[count];
		for (int j = 0; j < count; j++)
		{
			array2[j] = array[j];
		}
		return array2;
	}

	private void SpawnDirectionalMonsters(int dirIdx)
	{
		TSVector2[] array = _dirSpawnPoints[dirIdx];
		TSVector2 spawnDirection = _repulseDirections[dirIdx];
		int[] shuffled = ShuffleAnchorIndices(array.Length);
		int num = ((_summonLevel >= 0) ? ((_summonLevel >= laserBallCountsPerDir.Length) ? (laserBallCountsPerDir.Length - 1) : _summonLevel) : 0);
		int num2 = laserBallCountsPerDir[num];
		int num3 = trapCountsPerDir[num];
		for (int i = 0; i < num2; i++)
		{
			int num4 = PickAnchorIndex(shuffled, _laserUsedAnchors, _trapUsedAnchors, array);
			_laserUsedAnchors.Add(AnchorKey(array[num4]));
			SummonMonster(_laserBallId, 0, GetSpawnPosAt(array, num4), spawnDirection);
		}
		for (int j = 0; j < num3; j++)
		{
			int num5 = PickAnchorIndex(shuffled, _trapUsedAnchors, _laserUsedAnchors, array);
			_trapUsedAnchors.Add(AnchorKey(array[num5]));
			SummonMonster(_trapId, 0, GetSpawnPosAt(array, num5), spawnDirection);
		}
	}

	private int PickAnchorIndex(int[] shuffled, HashSet<string> selfUsed, HashSet<string> otherUsed, TSVector2[] anchors)
	{
		int num = -1;
		int num2 = -1;
		for (int i = 0; i < shuffled.Length; i++)
		{
			string item = AnchorKey(anchors[shuffled[i]]);
			if (!selfUsed.Contains(item) && !otherUsed.Contains(item))
			{
				return shuffled[i];
			}
			if (num < 0 && !selfUsed.Contains(item))
			{
				num = shuffled[i];
			}
			if (num2 < 0)
			{
				num2 = shuffled[i];
			}
		}
		if (num < 0)
		{
			return num2;
		}
		return num;
	}

	private static string AnchorKey(TSVector2 anchor)
	{
		return $"{anchor.x}_{anchor.y}";
	}

	private int[] ShuffleAnchorIndices(int count)
	{
		int[] array = new int[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = i;
		}
		for (int num = count - 1; num > 0; num--)
		{
			int num2 = MathUtils.Clamp((int)(long)GetRandomValue(0, num), 0, num);
			ref int reference = ref array[num];
			ref int reference2 = ref array[num2];
			int num3 = array[num2];
			int num4 = array[num];
			reference = num3;
			reference2 = num4;
		}
		return array;
	}

	private TSVector2 GetSpawnPosAt(TSVector2[] anchors, int anchorIdx)
	{
		TSVector2 position = anchors[anchorIdx];
		FP radius = spawnRingRadius;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
		return GetShapeRandomPoint(shapeData, _actor, isReachable: true);
	}

	private void ExecuteRepulse(TSVector2 forward)
	{
		TSVector2 position = -forward * repulseAreaOffset;
		PlayAreaEffect("AreaEffect_72012_Skill4_JiTui", position, GetTSVectToAngle(forward, 0));
	}

	private long PlayDirectionalFx(string fxAlias, TSVector2 forward)
	{
		if (string.IsNullOrEmpty(fxAlias))
		{
			return -1L;
		}
		return PlayEffect(fxAlias, 1f, 0.7, TSVector2.zero, GetTSVectToAngle(forward, 0));
	}

	private void StopFx(ref long fxId)
	{
		if (fxId >= 0)
		{
			StopEffect(fxId);
		}
		fxId = -1L;
	}

	private void ClearOwnedSummons()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		for (int i = 0; i < targetsByFaction.Count; i++)
		{
			AdventureActor adventureActor = targetsByFaction.get_Item(i) as AdventureActor;
			if (!(adventureActor == null) && !(adventureActor == _actor))
			{
				int num = (int)(long)GetLogicTagFpValue(_actor, Config_JuXingMoXiang.PartnerDataIdTag);
				if (adventureActor.dataID != num)
				{
					entityBuffer.Add(adventureActor);
				}
			}
		}
		ClearActors(entityBuffer);
	}
}
