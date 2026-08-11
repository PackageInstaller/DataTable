using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体自杀", 0)]
[Category("✫ DragonLost/Entity")]
[Description("实体自杀(节点描述)")]
public class EntitySuicide : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			OnActionFail($"获取不到实体，实体ID:{entityId.value}");
			return;
		}
		entity.GetProperty("Hp");
		entity.GetComponent<HpComponent>()?.ForceToDead();
		EndAction();
	}
}
