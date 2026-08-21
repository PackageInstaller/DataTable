#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("移除方向减伤", 0)]
[Description("移除指定实体的护盾，即移除方向减伤效果。")]
[Category("✫ DragonLost/Entity")]
public class RemoveEntityDefenceAction : ActionTaskBase
{
	[Name("护盾持有者实体ID", 0)]
	[Description("要移除护盾的实体的ID")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError("移除实体护盾失败! 实体为空!");
			EndAction(success: false);
		}
		else
		{
			entity.GetComponent<EntityDefenceComponent>()?.RemoveDefence();
			EndAction();
		}
	}
}
