namespace Ase.Paradox;

public class HitEventParamProcessor : BattleEventParamProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		if (!(observerParams is ObserverHitParams observerHitParams))
		{
			return;
		}
		base.Processor(observerHitParams);
		ConditionParams[6001] = EventTreeConditionParams.Create(observerHitParams.AttackEntity?.Id ?? 0);
		ConditionParams[6003] = EventTreeConditionParams.Create(observerHitParams.HitEntity?.Id ?? 0);
		ConditionParams[6002] = EventTreeConditionParams.Create(observerHitParams.SkillId);
		ConditionParams[6006] = EventTreeConditionParams.Create(observerHitParams.WeaknessData?.Level ?? 0);
		ConditionParams[6008] = EventTreeConditionParams.Create(observerHitParams.HitColliderVariableData?.SiteLevel ?? 0);
		ConditionParams[6009] = EventTreeConditionParams.Create(observerHitParams.IsCrit ? 1 : 0);
		ConditionParams[8002] = EventTreeConditionParams.Create(observerHitParams.DamageValue);
		int bulletId = observerHitParams.BulletId;
		if (bulletId != 0)
		{
			DRBullet dataRow = GameEntry.DataTable.GetDataRow<DRBullet>(bulletId);
			if (dataRow != null)
			{
				ConditionParams[6015] = EventTreeConditionParamsArray<string>.Create(dataRow.BulletLabel);
			}
		}
	}
}
