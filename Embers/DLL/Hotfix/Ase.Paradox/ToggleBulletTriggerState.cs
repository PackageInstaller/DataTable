using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("改变子弹可触发状态", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于修改子弹是否可触发的状态")]
public class ToggleBulletTriggerState : ActionTaskBase
{
	private QuerryBulletType querryType;

	[Name("子弹实体Id", 0)]
	[ShowIf("querryType", 0)]
	[Description("要查询的子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("子弹可否被触发", 0)]
	[Description("设置子弹是否可以被触发")]
	public bool triggerAble;

	protected override void OnExecute()
	{
		base.OnExecute();
		BulletEntity bulletEntity = null;
		switch (querryType)
		{
		case QuerryBulletType.ID:
			bulletEntity = (BulletEntity)GetOwnerEntity().GetSystem<EntitySystem>().GetEntity(bulletId.value);
			break;
		}
		if (bulletEntity == null)
		{
			EndAction();
			return;
		}
		bulletEntity.GetComponent<BulletTriggerComponent>()?.ToggleTriggerAble(triggerAble);
		EndAction();
	}
}
