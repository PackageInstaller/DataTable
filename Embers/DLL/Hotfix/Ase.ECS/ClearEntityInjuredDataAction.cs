using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("清空实体的受击信息", 0)]
[Category("✫ DragonLost/Entity")]
[Description("清空实体的受击信息")]
public class ClearEntityInjuredDataAction : ActionTaskBase
{
	[RequiredField]
	[Name("实体ID", 0)]
	[Description("要检测的实体的ID。")]
	public BBParameter<int> EntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		HitComponent component = entity.GetComponent<HitComponent>();
		if (component == null)
		{
			EndAction();
			return;
		}
		component.ClearEntityInjuredData();
		component.ClearEntityInjuredByDamageBefore();
		EndAction();
	}
}
