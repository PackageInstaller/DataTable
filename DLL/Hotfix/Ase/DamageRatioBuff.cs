using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class DamageRatioBuff : BuffOperationBase<BuffDataDamageRatio>
{
	private EntityType entityType;

	protected override void OnInit()
	{
		entityType = base.buffFrom?.GetEntityType() ?? EntityType.Unknown;
	}

	protected override void OnExecute()
	{
		BuffDataDamage dataDamage = CreateDamageData();
		DamageProgressBase damageProgress = BattleFormulaUtility.GetDamageProgress(entityType, dataDamage);
		if (damageProgress != null)
		{
			damageProgress.ProgressStart(base.buffFrom, base.buffOwner, dataDamage);
			damageProgress.OnExcuteProgress();
			ReferencePool.Release(damageProgress);
		}
	}

	private float GetDamageByTeamType()
	{
		BaseEntity targetByTeamType = BuffExtension.GetTargetByTeamType(base.buffFrom, base.buffOwner, dataBase.teamType);
		if (targetByTeamType == null)
		{
			return 0f;
		}
		return Mathf.CeilToInt(BattleFormulaUtility.GetProperty(targetByTeamType, dataBase.propertyKey, dataBase.propertyType) * dataBase.ratio + dataBase.fixedValue);
	}

	private BuffDataDamage CreateDamageData()
	{
		BuffDataDamage buffDataDamage = ReferencePool.Acquire<BuffDataDamage>();
		buffDataDamage.fixedValue = (int)GetDamageByTeamType();
		buffDataDamage.damageTextId = dataBase.damageTextId;
		buffDataDamage.isExcuteFormula = false;
		buffDataDamage.effectId = dataBase.effectId;
		buffDataDamage.pointKey = dataBase.pointKey;
		return buffDataDamage;
	}
}
