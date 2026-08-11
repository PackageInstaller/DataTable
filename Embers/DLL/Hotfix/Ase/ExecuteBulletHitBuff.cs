using Ase.ECS;

namespace Ase;

public class ExecuteBulletHitBuff : BuffOperationBase<BuffDataExecuteBulletHit>
{
	protected override void OnExecute()
	{
		if (base.buff.BuffRuntimeData is BuffBulletRuntimeData buffBulletRuntimeData)
		{
			base.buffOwner.GetSystem<BulletSystem>().CreateEmptyBulletEntity(dataBase.bulletId, base.buffFrom, base.buffOwner, buffBulletRuntimeData.bulletPos)?.GetComponent<BulletHitJudgmentComponent>().ExecuteHit(base.buffOwner, buffBulletRuntimeData.variableData, buffBulletRuntimeData.hitVolume);
		}
	}
}
