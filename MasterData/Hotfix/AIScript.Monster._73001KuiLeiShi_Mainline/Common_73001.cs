using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public static class Common_73001
{
	public static readonly string Skill_SilkPierce_Finish = "Skill_SilkPierce_Finish";

	public static readonly string Skill_PuppetControl_Finish = "Skill_PuppetControl_Finish";

	public static readonly string Skill_GiantGolemBombard_Finish = "JX_GiantGolemBombard_Finish";

	public static readonly string Skill_GiantGolemLaserSweep_Finish = "JX_GiantGolemLaserSweep_Finish";

	public static int evt_PuppetSyncAttack = CommonHelper.StringToHash("evt_puppetSyncAttack");

	public static int evt_EnergyRingSync = CommonHelper.StringToHash("evt_energyRingSync");

	public static int evt_GiantGolemApproach = CommonHelper.StringToHash("evt_giantGolemApproach");

	public static int evt_Phase2Enter = CommonHelper.StringToHash("evt_kuiLeiShiPhase2Enter");

	public static readonly string EnergyTag = "BossEnergy";

	public static readonly string PillarStrengthTag = "PillarStrength";

	public static readonly string PuppetSync_Tag = "PuppetSync";

	public static readonly string EnergyRingSync_Tag = "EnergyRingSync";

	public static readonly string PuppetSeqCounter_Tag = "PuppetSeqCounter";

	public static readonly string PuppetSeqIndex_Tag = "PuppetSeqIndex";

	public static readonly string SummonLevel_Tag = "SummonLevel";

	public static readonly string EnergyToReductionEnabledTag = "KLS_EnergyToReduction_Enabled";

	public static readonly string EnergyAccumTag = "KLS_EnergyAccum";

	public static TSVector2 ClampToCenter(TSVector2 pos, FP maxDist)
	{
		if (pos.LengthSquared() > maxDist * maxDist)
		{
			return pos.normalized * maxDist;
		}
		return pos;
	}

	public static int GetMonsterIdByLevel(int level, int[] ids)
	{
		if (ids == null || ids.Length == 0)
		{
			return 0;
		}
		if (level < 0)
		{
			level = 0;
		}
		if (level >= ids.Length)
		{
			level = ids.Length - 1;
		}
		return ids[level];
	}

	public static void TryRemoveBuffOrAddBuff(AdventureActor target, int removeBuffId, int addBuffId)
	{
		if (!(target == null) && !(target.buffComponent == null))
		{
			if (target.buffComponent.GetBuffNumByID(removeBuffId) > 0)
			{
				target.buffComponent.RemoveBuffByBuffId(removeBuffId, 1);
			}
			else
			{
				target.buffComponent.AddBuff(addBuffId, target);
			}
		}
	}

	public static bool TryAddDamageReduction(AdventureActor boss, int damageReductionBuffId, int vulnerableBuffId, int damageReductionBuffLayers)
	{
		if (boss == null || boss.buffComponent == null)
		{
			return false;
		}
		if (boss.buffComponent.GetBuffNumByID(damageReductionBuffId) >= damageReductionBuffLayers)
		{
			return true;
		}
		TryRemoveBuffOrAddBuff(boss, vulnerableBuffId, damageReductionBuffId);
		return false;
	}

	public static void SyncBossBuffChange(AdventureActor boss, int damageReductionBuffId, int vulnerableBuffId)
	{
		if (!(boss == null) && !(boss.buffComponent == null))
		{
			int buffNumByID = boss.buffComponent.GetBuffNumByID(damageReductionBuffId);
			int buffNumByID2 = boss.buffComponent.GetBuffNumByID(vulnerableBuffId);
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossBuffChange", boss.Id, buffNumByID, buffNumByID2);
		}
	}

	public static void SyncBossEnergyChange(AdventureActor hudTarget, int energy)
	{
		if (!(hudTarget == null))
		{
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossEnergyValueChange", hudTarget.Id, energy);
		}
	}

	public static void SetSummonLevelByTag(AdventureActor actor, string levelTag)
	{
		int num = 0;
		int num2 = 0;
		switch (levelTag)
		{
		case "Lv1":
			num = 0;
			break;
		case "Lv2":
			num = 1;
			break;
		case "Lv3":
			num = 2;
			break;
		case "Lv4":
			num = 3;
			break;
		case "Lv5":
			num = 4;
			break;
		case "Lv6":
			num = 5;
			num2 = 1;
			break;
		}
		actor.logicVariable.SetLogicTagValue(SummonLevel_Tag, num);
		actor.logicVariable.SetLogicTagValue(EnergyToReductionEnabledTag, num2);
	}

	public static void PlayShieldDownFx(ref PlayFX breakLineFx, ref PlayFX shieldDownFx, AdventureActor boss, AdventureActor player, string breakLineAlias, string shieldDownAlias)
	{
		if (!(boss == null))
		{
			GameObject gameObject = player?.gameObject;
			if (gameObject != null)
			{
				TSVector2 position = player.tsTransform.Position;
				TSVector sourcePosition = new TSVector(position.x, 0, position.y);
				ILRuntimeAPI.PlayLinFx(ref breakLineFx, boss, breakLineAlias, 1f, useCustSource: true, gameObject, sourcePosition, FP.Zero, boss.gameObject, TSVector.zero, FP.Zero);
			}
			ILRuntimeAPI.PlayFX(ref shieldDownFx, boss, null, shieldDownAlias, default, boss.tsTransform.Position, TSVector2.zero);
		}
	}

	public static bool TryAddDamageReductionByEnergyGain(AdventureActor boss, FP energyGain, int damageReductionBuffId, int vulnerableBuffId, int damageReductionBuffLayers)
	{
		if (boss == null || energyGain <= FP.Zero)
		{
			return false;
		}
		FP fP = CommonUtils_MonsterAPI.GetLogicTagFpValue(boss, EnergyAccumTag) + energyGain;
		if (fP < 33)
		{
			CommonUtils_MonsterAPI.SetLogicTagFpValue(boss, EnergyAccumTag, fP);
			return false;
		}
		fP -= (FP)33;
		CommonUtils_MonsterAPI.SetLogicTagFpValue(boss, EnergyAccumTag, fP);
		int num = ((boss.buffComponent != null) ? boss.buffComponent.GetBuffNumByID(damageReductionBuffId) : 0);
		TryAddDamageReduction(boss, damageReductionBuffId, vulnerableBuffId, damageReductionBuffLayers);
		return ((boss.buffComponent != null) ? boss.buffComponent.GetBuffNumByID(damageReductionBuffId) : 0) > num;
	}
}
