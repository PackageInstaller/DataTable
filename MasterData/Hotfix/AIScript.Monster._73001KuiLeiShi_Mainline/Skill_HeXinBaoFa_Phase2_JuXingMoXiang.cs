using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_HeXinBaoFa_Phase2_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_HeXinBaoFa_Phase2 = "HeXinBaoFaP1";

	private const string evt_ChargeEnd = "ChargeEnd";

	private FP repulseWarningTime = 3.2;

	private const string repulseWarningFxAlias = "fx_m72012_loop_skill4_warning";

	private const string repulseWaveFxAlias = "fx_m72012_base_skill4_wave";

	private const string repulseAreaFxAlias = "AreaEffect_72012_Skill4_JiTui";

	private FP repulseAreaOffset = 100;

	private static readonly int[] laserBallCountsPerDir = new int[6] { 1984716651, 50, 1229010432, 1769104211, 1345221744, 1769173857 };

	private static readonly int[] trapCountsPerDir = new int[6] { 1768641372, 1666411628, 1953524082, 1919897183, 1097621869, 1667331188 };

	private FP spawnRingRadius = 0.5f;

	private FP directionInterval = 0.5f;

	private static readonly int[] _nengLiangQiuMonsterIds;

	private static readonly TSVector2[] _orbSpawnPositions;

	private const int playerAbsorbThreshold = 1;

	private const int juXingAbsorbThreshold = 1;

	private string juXingAbsorbAreaEffect = "AreaEffect_72012_Skill1_LiPao";

	private static readonly int[][] _dirPatterns;

	private static int _castCount;

	private readonly TSVector2[] _repulseDirections = new TSVector2[4]
	{
		TSVector2.up,
		TSVector2.right,
		TSVector2.down,
		TSVector2.left
	};

	private static readonly TSVector2[][] _dirSpawnPoints;

	private long _warningFxId = -1L;

	private long _waveFxId = -1L;

	private int _orbId;

	private int _playerDamageUpBuffId;

	private int _damageReductionBuffId;

	private int _vulnerableBuffId;

	private SummonCfg _summonCfg;

	private int orblifetime = 7;

	private List<LogicEntity> entityBuffer = new List<LogicEntity>();

	private readonly HashSet<string> _laserUsedAnchors = new HashSet<string>();

	private readonly HashSet<string> _trapUsedAnchors = new HashSet<string>();

	private bool finished;

	private int _summonLevel;

	private int _laserBallId;

	private int _trapId;

	protected override void OnSkillEnable()
	{
		SetLogicTagFpValue(_actor, Config_JuXingMoXiang.PhaseTag, 2);
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.HeXinBaoFa_Phase2_SummonActiveTag, value: true);
		base.OnSkillEnable();
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_laserBallId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.laserOrbMonsterIds);
		_trapId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.trapMonsterIds);
		_orbId = Common_73001.GetMonsterIdByLevel(_summonLevel, _nengLiangQiuMonsterIds);
		_playerDamageUpBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.orbPlayerDamageUpBuffIds);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
		SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag, FP.Zero);
		SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag, FP.Zero);
		_warningFxId = -1L;
		_waveFxId = -1L;
		_laserUsedAnchors.Clear();
		_trapUsedAnchors.Clear();
		finished = false;
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.HeXinBaoFa_Phase2_SummonActiveTag, value: false);
		base.OnSkillDisable();
		StopFx(ref _warningFxId);
		StopFx(ref _waveFxId);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnOrbEvent);
		entityBuffer.Clear();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_laserBallId));
			ClearActors(GetTargetByDataID(_trapId));
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
		ClearActors(GetTargetByDataID(_orbId));
	}

	protected override IEnumerator DoMainLogic()
	{
		ClearOwnerBullet();
		ClearOwnedSummons();
		BeginLookAtCameraDir(DirectionType.Down, 0.2, 1000);
		yield return WaitTime(0.2);
		BeginAttack(1, "HeXinBaoFaP1", flushInputedKeys: true);
		yield return WaitCustomEvent("ChargeEnd");
		int[] dirIndices = _dirPatterns[_castCount % _dirPatterns.Length];
		_castCount = (_castCount + 1) % _dirPatterns.Length;
		int dirCount = ((_summonLevel <= 3) ? 2 : dirIndices.Length);
		for (int i = 0; i < dirCount; i++)
		{
			int num = dirIndices[i];
			TSVector2 forward = _repulseDirections[num];
			SpawnDirectionalMonsters(num);
			if (_summonCfg == null)
			{
				_summonCfg = new SummonCfg
				{
					leftTime = orblifetime
				};
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, _orbId, _orbSpawnPositions[num], TSVector2.up, _summonCfg);
			_warningFxId = PlayDirectionalFx("fx_m72012_loop_skill4_warning", forward);
			yield return WaitTime(repulseWarningTime);
			StopFx(ref _warningFxId);
			yield return WaitTime(0.3);
			ExecuteRepulse(forward);
			_waveFxId = PlayDirectionalFx("fx_m72012_base_skill4_wave", forward);
			DispatchCustomEvent(Config_JuXingMoXiang.evt_GiantGolemBombard);
			if (i < dirCount - 1)
			{
				yield return WaitTime(directionInterval);
			}
		}
		yield return WaitTime(3.5f);
		CancelAttack();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
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

	private AdventureActor GetBossActor()
	{
		return _actor;
	}

	private AdventureActor GetEnergyTarget()
	{
		return _actor;
	}

	private void PlayDamageReductionAddedFx(AdventureActor boss)
	{
		if (!(boss == null))
		{
			PlayFx("fx_m72012_base_Shield", 1f, default, GetEntityPosition(boss), default);
		}
	}

	private void PlayDamageReductionRemovedFx(AdventureActor boss, AdventureActor player)
	{
		if (!(boss == null))
		{
			GameObject gameObject = player?.gameObject;
			if (gameObject != null)
			{
				TSVector2 entityPosition = GetEntityPosition(player);
				TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
				PlayLinkFX("fx_m72012_base_shootline_1", useCustomSource: true, gameObject, sourcePosition, FP.Zero, boss.gameObject, TSVector.zero, FP.Zero, breakWhenLostSourceOrTarget: false);
			}
			PlayFx("fx_m72012_base_Shield_down", 1f, default, GetEntityPosition(boss), default);
		}
	}

	private void OnOrbEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		AdventureActor bossActor = GetBossActor();
		if (adventureActorCustomEvent.eventHashCode == Config_XiaoMoXiang.evt_OrbAbsorbedByPlayer)
		{
			AdventureActor player = adventureActorCustomEvent.sender as AdventureActor;
			List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
			if (list != null)
			{
				foreach (PlayerAdventureActor item in list)
				{
					item?.buffComponent?.AddBuff(_playerDamageUpBuffId, _actor);
				}
			}
			FP fP = GetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag) + 1;
			SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag, fP);
			if (fP >= 1)
			{
				SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_PlayerAbsorbCountTag, FP.Zero);
				Common_73001.TryRemoveBuffOrAddBuff(bossActor, _damageReductionBuffId, _vulnerableBuffId);
				PlayDamageReductionRemovedFx(bossActor, player);
			}
		}
		else
		{
			if (adventureActorCustomEvent.eventHashCode != Config_XiaoMoXiang.evt_OrbAbsorbedByJuXing)
			{
				return;
			}
			FP fP2 = GetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag) + 1;
			SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag, fP2);
			if (!(fP2 >= 1))
			{
				return;
			}
			SetLogicTagFpValue(_actor, Config_XiaoMoXiang.NLQ_JuXingAbsorbCountTag, FP.Zero);
			int num = ((bossActor != null && bossActor.buffComponent != null) ? bossActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0);
			if (Common_73001.TryAddDamageReduction(bossActor, _damageReductionBuffId, _vulnerableBuffId, 8))
			{
				AdventureActor energyTarget = GetEnergyTarget();
				if (energyTarget != null)
				{
					FP fP3 = GetLogicTagFpValue(energyTarget, Common_73001.EnergyTag) + 5;
					if (fP3 > 100)
					{
						fP3 = 100;
					}
					SetLogicTagFpValue(energyTarget, Common_73001.EnergyTag, fP3);
					BossEnergyValueChage((int)(long)fP3, GetBossActor());
				}
			}
			if (((bossActor != null && bossActor.buffComponent != null) ? bossActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0) > num)
			{
				PlayDamageReductionAddedFx(bossActor);
			}
			if (!string.IsNullOrEmpty(juXingAbsorbAreaEffect) && bossActor != null)
			{
				PlayAreaEffect(juXingAbsorbAreaEffect, GetEntityPosition(bossActor));
			}
		}
	}

	static Skill_HeXinBaoFa_Phase2_JuXingMoXiang()
	{
		//IL_0038: Field data (rva=0x510) could not be found in any section!
		//IL_0038: Field data (rva=0x510) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0934105E7A1DCCE5426C80921717951A0AF9D1A8FFFDF1AB68EA303BE98C28B3));
		_nengLiangQiuMonsterIds = array;
		_orbSpawnPositions = new TSVector2[4]
		{
			new TSVector2(0, -13),
			new TSVector2(-13, 0),
			new TSVector2(3, 10),
			new TSVector2(13, 0)
		};
		_dirPatterns = new int[3][]
		{
			new int[2] { 2, 3 },
			new int[3] { 1885958755, 1632644724, 1986622323 },
			new int[3] { 0, 1, 2 }
		};
		_castCount = 0;
		_dirSpawnPoints = new TSVector2[4][]
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
				new TSVector2(6, 6f),
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
	}
}
