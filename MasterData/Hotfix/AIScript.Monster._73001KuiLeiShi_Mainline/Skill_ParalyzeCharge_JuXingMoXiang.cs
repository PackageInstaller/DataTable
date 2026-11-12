using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_ParalyzeCharge_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_ParalyzeCharge = "ParalyzeCharge";

	private const string beamFxAlias = "fx_m72011_loop_Skill5_link_5";

	private static FP conduitLifespan = 20;

	private static FP BossEnergyRecoverPerSec = 6;

	private static FP ConduitEnergyGrantPerSec = 1;

	private FP beamWidth = 2;

	private FP getDamageBuffInterval = 1;

	private FP chargingThreshold = 2;

	private static readonly string[] ConduitSpawnKeys = new string[4] { "Nv_Skill6_1", "Nv_Skill6_2", "Nv_Skill6_3", "Nv_Skill6_4" };

	private const string playerBlockBeamTag = "JX_ParalyzeBlockBeam";

	private List<LogicEntity> _conduitBuffer = new List<LogicEntity>();

	private List<PlayFX> _beamFxList = new List<PlayFX>();

	private List<bool> _beamFxBlockedList = new List<bool>();

	private List<FP> _conduitAccumList = new List<FP>();

	private SummonCfg _summonCfg;

	private bool finished;

	private int _summonLevel;

	private int _damageBuffId;

	private int _damageReductionBuffId;

	private int _vulnerableBuffId;

	private int _conduitId;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		_damageBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageBuffIds);
		_damageReductionBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
		_vulnerableBuffId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
		_conduitId = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.zhuNengKuiLeiMonsterIds);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.ParalyzeActiveTag, value: true);
		BeginAttack(1, "ParalyzeCharge", flushInputedKeys: true);
		yield return WaitTime(1.2);
		ClearOwnerBullet();
		KillActors(GetTargetsByFaction(isFriend: true));
		if (_summonCfg == null)
		{
			_summonCfg = new SummonCfg
			{
				leftTime = conduitLifespan
			};
		}
		_conduitBuffer.Clear();
		for (int i = 0; i < ConduitSpawnKeys.Length; i++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(ConduitSpawnKeys[i]);
			ILRuntimeAPI.SummonMonster(_actor, 0, _conduitId, placeHolderPosition, GetPosition() - placeHolderPosition, _summonCfg, null, (MonsterAdventureActor conduit) =>
			{
				_conduitBuffer.Add(conduit);
			});
		}
		yield return WaitUntil(() => _conduitBuffer.Count >= ConduitSpawnKeys.Length);
		yield return WaitTime(0.8);
		_conduitAccumList.Clear();
		for (int num = 0; num < _conduitBuffer.Count; num++)
		{
			_conduitAccumList.Add(FP.Zero);
		}
		StartBeamFxes();
		yield return StartCor(ParalyzeLoop());
		StopBeamFxes();
		CancelAttack();
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		for (int num2 = 0; num2 < _conduitBuffer.Count; num2++)
		{
			if (!_conduitBuffer.get_Item(num2).IsDead() && _conduitBuffer.get_Item(num2) is MonsterAdventureActor monsterAdventureActor)
			{
				monsterAdventureActor.DestroySelf(forceDestory: true);
				AddBossDamageReductionBuff();
			}
		}
		SetLogicTagToggleValue(_actor, Config_JuXingMoXiang.ParalyzeActiveTag, value: false);
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ParalyzeLoop()
	{
		FP lastTime = LockStepManager.time;
		while (true)
		{
			FP time = LockStepManager.time;
			FP fP = time - lastTime;
			lastTime = time;
			FP fP2 = GetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag);
			FP fP3 = fP2;
			TSVector2 position = GetPosition();
			LogicEntity currentPlayer = GetCurrentPlayer();
			bool flag = false;
			for (int i = 0; i < _conduitBuffer.Count; i++)
			{
				LogicEntity entity = _conduitBuffer.get_Item(i);
				if (entity.IsDead())
				{
					if (i < _beamFxList.Count && _beamFxList.get_Item(i) != null)
					{
						_beamFxList.get_Item(i).Stop(dontPlaySubFX: true);
						_beamFxList.get_Item(i).Clear();
						_beamFxList.set_Item(i, (PlayFX)null);
					}
					continue;
				}
				TSVector2 entityPosition = GetEntityPosition(entity);
				bool flag2 = IsPlayerInBeam(entityPosition, position);
				if (i < _beamFxBlockedList.Count && flag2 != _beamFxBlockedList.get_Item(i))
				{
					_beamFxBlockedList.set_Item(i, flag2);
					RecreateBeamFx(i, flag2);
				}
				if (!flag2)
				{
					fP2 += ConduitEnergyGrantPerSec * fP;
					if (i < _conduitAccumList.Count)
					{
						_conduitAccumList.get_Item(i) += fP;
						if (_conduitAccumList.get_Item(i) >= chargingThreshold)
						{
							_conduitAccumList.set_Item(i, FP.Zero);
							AddBossDamageReductionBuff();
						}
					}
				}
				else
				{
					flag = true;
				}
			}
			if (flag)
			{
				OnPlayerBlockBeam(currentPlayer, fP);
			}
			else if (currentPlayer != null && !currentPlayer.IsDead())
			{
				SetLogicTagFpValue(currentPlayer, "JX_ParalyzeBlockBeam", FP.Zero);
			}
			fP2 += BossEnergyRecoverPerSec * fP;
			if (fP2 > 100)
			{
				fP2 = 100;
			}
			SetLogicTagFpValue(_actor, Config_JuXingMoXiang.EnergyTag, fP2);
			BossEnergyValueChage((int)(long)fP2, _actor);
			if (GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1 && Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP2 - fP3, _damageReductionBuffId, _vulnerableBuffId, 8))
			{
				PlayFx("fx_m72012_base_Shield", 1f, default, GetPosition(), default);
			}
			if (!(fP2 >= 100))
			{
				yield return null;
				continue;
			}
			break;
		}
	}

	private void AddBossDamageReductionBuff()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		int num = ((monsterAdventureActor != null && monsterAdventureActor.buffComponent != null) ? monsterAdventureActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0);
		if (Common_73001.TryAddDamageReduction(monsterAdventureActor, _damageReductionBuffId, _vulnerableBuffId, 8))
		{
			FP logicTagFpValue = GetLogicTagFpValue(_actor, Common_73001.EnergyTag);
			FP fP = logicTagFpValue + 5;
			if (fP > 100)
			{
				fP = 100;
			}
			SetLogicTagFpValue(_actor, Common_73001.EnergyTag, fP);
			BossEnergyValueChage((int)(long)fP, _actor);
			if (GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1)
			{
				Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP - logicTagFpValue, _damageReductionBuffId, _vulnerableBuffId, 8);
			}
		}
		if (((monsterAdventureActor != null && monsterAdventureActor.buffComponent != null) ? monsterAdventureActor.buffComponent.GetBuffNumByID(_damageReductionBuffId) : 0) > num)
		{
			PlayFx("fx_m72012_base_Shield", 1f, default, GetPosition(), default);
		}
	}

	private bool IsPlayerInBeam(TSVector2 from, TSVector2 to)
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return false;
		}
		TSVector2 entityPosition = GetEntityPosition(currentPlayer);
		TSVector2 tSVector = to - from;
		FP magnitude = tSVector.magnitude;
		if (magnitude <= FP.Zero)
		{
			return false;
		}
		TSVector2 tSVector2 = tSVector / magnitude;
		FP fP = TSVector2.Dot(entityPosition - from, tSVector2);
		if (fP < FP.Zero || fP > magnitude)
		{
			return false;
		}
		return TSVector2.Distance(entityPosition, from + tSVector2 * fP) <= beamWidth / 2;
	}

	private void StartBeamFxes()
	{
		_beamFxList.Clear();
		_beamFxBlockedList.Clear();
		GameObject gameObject = _actor.gameObject;
		for (int i = 0; i < _conduitBuffer.Count; i++)
		{
			LogicEntity logicEntity = _conduitBuffer.get_Item(i);
			if (logicEntity.IsDead())
			{
				_beamFxList.Add(null);
				_beamFxBlockedList.Add(item: false);
				continue;
			}
			TSVector2 entityPosition = GetEntityPosition(logicEntity);
			TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
			GameObject source = (logicEntity as AdventureActor)?.gameObject;
			PlayFX playFX = PlayLinkFX("fx_m72011_loop_Skill5_link_5", useCustomSource: true, source, sourcePosition, FP.Zero, gameObject, TSVector.zero, FP.Zero);
			playFX?.fxInstance?.Bind(_actor.gameObject);
			_beamFxList.Add(playFX);
			_beamFxBlockedList.Add(item: false);
		}
	}

	private void StopBeamFxes()
	{
		for (int i = 0; i < _beamFxList.Count; i++)
		{
			_beamFxList.get_Item(i)?.Stop();
			_beamFxList.get_Item(i)?.Clear();
		}
		_beamFxList.Clear();
		_beamFxBlockedList.Clear();
	}

	private void RecreateBeamFx(int i, bool blocked)
	{
		if (i >= _beamFxList.Count)
		{
			return;
		}
		_beamFxList.get_Item(i)?.Stop(dontPlaySubFX: true);
		_beamFxList.get_Item(i)?.Clear();
		_beamFxList.set_Item(i, (PlayFX)null);
		LogicEntity logicEntity = ((i < _conduitBuffer.Count) ? _conduitBuffer.get_Item(i) : null);
		if (!(logicEntity == null) && !logicEntity.IsDead())
		{
			TSVector2 entityPosition = GetEntityPosition(logicEntity);
			TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
			GameObject source = (logicEntity as AdventureActor)?.gameObject;
			GameObject gameObject = ((!blocked) ? _actor.gameObject : GetCurrentPlayer()?.gameObject);
			if (!(gameObject == null))
			{
				_beamFxList.set_Item(i, PlayLinkFX("fx_m72011_loop_Skill5_link_5", useCustomSource: true, source, sourcePosition, FP.Zero, gameObject, TSVector.zero, FP.Zero));
				_beamFxList.get_Item(i)?.fxInstance?.Bind(_actor.gameObject);
			}
		}
	}

	private void OnPlayerBlockBeam(LogicEntity player, FP deltaTime)
	{
		if (player == null || player.IsDead())
		{
			return;
		}
		FP logicTagFpValue = GetLogicTagFpValue(player, "JX_ParalyzeBlockBeam");
		logicTagFpValue += deltaTime;
		if (logicTagFpValue >= getDamageBuffInterval)
		{
			logicTagFpValue -= getDamageBuffInterval;
			if (player is AdventureActor)
			{
				List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
				if (list != null)
				{
					foreach (PlayerAdventureActor item in list)
					{
						item?.buffComponent?.AddBuff(_damageBuffId, _actor);
					}
				}
			}
		}
		SetLogicTagFpValue(player, "JX_ParalyzeBlockBeam", logicTagFpValue);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		StopBeamFxes();
		_conduitBuffer.Clear();
		_conduitAccumList.Clear();
		if (!finished)
		{
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_conduitId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		DispatchCustomEvent("StopEnergyLine", isSelfEvent: false);
		StopBeamFxes();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_conduitId));
	}
}
