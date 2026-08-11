using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检测怪物弱点时刻", 0)]
[Category("✫ DragonLost/Monster")]
[Description("检查指定目标是否处于怪物弱点时刻。")]
public class CheckMonsterWeaknessTiming : ConditionTaskBase
{
	[Name("目标ID", 0)]
	[RequiredField]
	[Description("要检查的目标实体的ID。")]
	public BBParameter<int> targetId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(targetId.value, isSyncEntity: true);
		if (entity != null)
		{
			return entity.GetComponent<WeaknessComponent>()?.IsWeaknessTimer ?? false;
		}
		return false;
	}
}
