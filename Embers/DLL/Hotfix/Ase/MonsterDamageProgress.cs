using System;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class MonsterDamageProgress : DamageProgressBase
{
	private readonly FormulaZoneBase[] _damageFormulaZones = new FormulaZoneBase[8]
	{
		new BaseDamageFormulaZone(),
		new CritFormulaZone(),
		new AttributeAdditionFormulaZone(),
		new DefenceFormulaZone(),
		new ResistanceFormulaZone(),
		new AttributeRestraintFormulaZone(),
		new SpecialFormulaZone(),
		new AIDamageFormulaZone()
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
		for (int i = 0; i < _damageFormulaZones.Length; i++)
		{
			FormulaZoneDataBase item = _damageFormulaZones[i].CalcFormulaZone(damageParams);
			damageFormulaDataList.Add(item);
		}
		double num = damageFormulaDataList[0].result;
		for (int j = 1; j < damageFormulaDataList.Count; j++)
		{
			num *= (double)damageFormulaDataList[j].result;
		}
		resultData.damage = Mathf.Max(0, num.CeilToInt());
	}

	protected override void ExecuteDamageLog()
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Monster伤害公式流程计算： 攻击者实体ID:{attacker.Id} => 受击者实体ID:{defender.Id} 是否免疫伤害:{damageParams.isImmuneState} ------------>", attacker);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId("Monster伤害公式流程计算结束 ------------>", attacker);
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
			resultData.damageBeforeState = component.GetCurrentState()?.Id ?? 0;
			flag = component.IsNearDeathState();
			resultData.damageBeforeState = component.GetCurrentState()?.Id ?? 0;
		}
		HandleBulletProperty(isHitDown: false, 0);
		DealEntityParadoxData();
		bool flag2 = DamageConsumeEnergy(ref resultData.damage);
		resultData.isParry = flag2;
		bool flag3 = GetDamageFormulaData<DefenceFormulaData>()?.isExtraReduceDamage ?? false;
		if (!dataDamage.IsIgnoreHit)
		{
			RecodeHitData(null, resultData.damage, flag3);
		}
		if (!flag)
		{
			if (!flag2)
			{
				SwitchState();
			}
			HandleBulletState();
			RecordEntityDamageState();
		}
		float value = AccountDamage(resultData.damage, flag, out resultData.isKillDown);
		resultData.damage = value.CeilToInt();
		SendBattleMsg();
		SendBattleAddEnergy();
		HandleDamageText();
		AttackBossWeakNotify();
		if (!flag)
		{
			PlayHitEffect(flag3);
		}
	}

	protected virtual bool DamageConsumeEnergy(ref int damage)
	{
		return defender.GetComponent<ParryComponent>()?.DamageConsumeEnergy(ref damage) ?? false;
	}

	protected override void OnExecuteProgressDisplay()
	{
		base.OnExecuteProgressDisplay();
		ShowHpBar();
	}

	protected void ShowHpBar()
	{
		if (defender is MonsterEntity { IsBoss: false })
		{
			defender.GetComponent<HpComponent>().ShowHpBar();
		}
	}
}
