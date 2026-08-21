using System;
using Ase.ECS;

namespace Ase;

public class InteractiveDamageProgress : DamageProgressBase
{
	private readonly FormulaZoneBase[] _damageFormulaZones = new FormulaZoneBase[1]
	{
		new InteractiveDamageFormulaZone()
	};

	protected override void OnExecuteProgressStart()
	{
		InitFormulaParams();
		SendBeforeBuffMessage();
	}

	protected override void OnExecuteProgressLogic()
	{
		OnExcuteDamageProcess();
		ExecuteDamageLog();
	}

	protected void InitFormulaParams()
	{
		bool isImmuneState = CheckImmuneState();
		damageParams = new DamageFormulaDataParams
		{
			attacker = attacker,
			defender = defender,
			dataDamage = dataDamage,
			isImmuneState = isImmuneState
		};
	}

	protected override void OnExcuteDamageProcess()
	{
		base.OnExcuteDamageProcess();
		if (damageParams.isImmuneState)
		{
			resultData.damage = 0;
			return;
		}
		double num = 1.0;
		for (int i = 0; i < _damageFormulaZones.Length; i++)
		{
			FormulaZoneDataBase formulaZoneDataBase = _damageFormulaZones[i].CalcFormulaZone(damageParams);
			num *= (double)formulaZoneDataBase.result;
			damageFormulaDataList.Add(formulaZoneDataBase);
		}
		resultData.damage = Math.Max(0, num.CeilToInt());
	}

	protected override void ExecuteDamageLog()
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"交互物伤害公式流程计算： 攻击者实体ID:{attacker.Id} => 受击者实体ID:{defender.Id} 是否免疫伤害:{damageParams.isImmuneState} ------------>", attacker);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId("交互物伤害公式流程计算结束 ------------>", attacker);
		}
	}

	protected override void ExecuteTenacityLog()
	{
		throw new NotImplementedException();
	}

	protected override void OnExcuteProcessSettlement()
	{
		bool flag = false;
		StateComponent component = defender.GetComponent<StateComponent>();
		if (component != null)
		{
			resultData.hitDownState = component.IsDownState();
			flag = component.IsNearDeathState();
			resultData.damageBeforeState = component.GetCurrentState()?.Id ?? 0;
		}
		HandleBulletProperty(isHitDown: false, 0);
		DealEntityParadoxData();
		if (!flag)
		{
			SwitchState();
			HandleBulletState();
			RecordEntityDamageState();
		}
		float value = AccountDamage(resultData.damage, flag, out resultData.isKillDown);
		bool flag2 = GetDamageFormulaData<DefenceFormulaData>()?.isExtraReduceDamage ?? false;
		if (!dataDamage.IsIgnoreHit)
		{
			RecodeHitData(null, resultData.damage, flag2);
		}
		resultData.damage = value.CeilToInt();
		SendBattleMsg();
		SendBattleAddEnergy();
		HandleDamageText();
		AttackBossWeakNotify();
		if (!flag)
		{
			PlayHitEffect(flag2);
		}
	}

	protected override void OnExecuteProgressDisplay()
	{
	}
}
