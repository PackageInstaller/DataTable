using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取移动是否被场景墙阻挡", 0)]
[Category("✫ DragonLost/Transform")]
[Description("检查实体的移动是否被场景墙阻挡。")]
public class CheckObstructDefaultWallState : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		return GetOwnerEntity().GetComponent<KinematicMoveComponent>()?.GetObstructWallState() ?? false;
	}
}
