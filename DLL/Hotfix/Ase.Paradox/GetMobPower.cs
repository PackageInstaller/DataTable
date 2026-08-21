using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取小怪强度", 0)]
[Category("✫ DragonLost/Monster")]
[Description("获取小怪强度.")]
public class GetMobPower : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("实体Id(变量描述)")]
	public BBParameter<int> entityId;

	[Name("返回的小怪强度", 0)]
	[Description("返回的小怪强度(变量描述)")]
	public BBParameter<int> mobPower;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFail("获取小怪强度节点：未成功获取实体");
			return;
		}
		if (entity is MonsterEntity monsterEntity)
		{
			mobPower.value = monsterEntity.MonsterTypeConfig.MobPower;
		}
		EndAction();
	}
}
