using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取移动是否被实体目标阻挡", 0)]
[Category("✫ DragonLost/Transform")]
[Description("检查实体的移动是否被实体目标阻挡。")]
public class CheckObstructState : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		return GetOwnerEntity().GetComponent<KinematicMoveComponent>()?.GetObstructState() ?? false;
	}
}
