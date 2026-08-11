using Ase;
using Ase.ECS;
using ParadoxNotion.Design;

[Name("判断是否可以旋转", 0)]
[Description("判断英雄实体是否可以旋转,包括状态限制")]
[Category("✫ DragonLost/Entity")]
public class CheckIsRotateCondition : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity?.GetComponent<MoveComponent>().RotateEnable ?? false;
	}
}
