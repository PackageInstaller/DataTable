using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("移除免疫异常状态", 0)]
[Category("✫ DragonLost/State")]
[Description("移除目标实体的特定免疫异常状态。")]
public class RemoveImmuneState : ActionTaskBase
{
	[RequiredField]
	[Name("实体Id", 0)]
	[Description("要移除免疫状态的目标实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("状态ID", 0)]
	[Description("要移除的免疫状态的ID。")]
	public BBParameter<int> StateId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		entity.GetComponent<StateComponent>().RemoveImmuneBuff(StateId.value);
		EndAction();
	}
}
