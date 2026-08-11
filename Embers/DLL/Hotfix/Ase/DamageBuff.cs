using GameFramework;

namespace Ase;

public class DamageBuff : BuffOperationBase<BuffDataDamage>
{
	protected DamageProgressBase damageProgress;

	protected override void OnInit()
	{
		base.OnInit();
		EntityType entityType = base.buffFrom?.GetEntityType() ?? EntityType.Unknown;
		damageProgress = BattleFormulaUtility.GetDamageProgress(entityType, dataBase);
		if (damageProgress != null)
		{
			damageProgress.ProgressStart(base.buffFrom, base.buffOwner, dataBase);
		}
	}

	protected override void OnExecute()
	{
		damageProgress?.OnExcuteProgress();
	}

	protected override void OnDispose()
	{
		if (damageProgress != null)
		{
			ReferencePool.Release(damageProgress);
			damageProgress = null;
		}
		dataBase.bulletAttackData?.OnDispose();
	}
}
