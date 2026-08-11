using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("对受击者直接执行子弹效果", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于对指定受击者直接执行子弹效果")]
public class CreateExecuteHitBullet : ActionTaskBase
{
	[Name("子弹Id", 0)]
	[Description("要执行的子弹的ID")]
	public BBParameter<int> bulletId;

	[Name("受击者Id", 0)]
	[Description("受击者的ID")]
	public BBParameter<int> targetId;

	protected override bool IsDisplayNode => false;

	protected override async void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(targetId.value);
		if (entity == null)
		{
			EndAction();
			return;
		}
		BulletEntity bulletEntity = ownerEntity.GetSystem<BulletSystem>().CreateEmptyBulletEntity(bulletId.value, ownerEntity, entity, entity.transform.position);
		if (bulletEntity == null)
		{
			EndAction();
			return;
		}
		bulletEntity.GetComponent<BulletHitJudgmentComponent>().ExecuteEntityHitJudgement(entity);
		EndAction();
	}
}
