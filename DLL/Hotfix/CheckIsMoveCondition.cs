using Ase;
using Ase.ECS;
using ParadoxNotion.Design;

[Name("判断是否可以移动", 0)]
[Description("判断英雄实体是否可以移动,包括状态限制")]
[Category("✫ DragonLost/Entity")]
public class CheckIsMoveCondition : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		bool flag = ownerEntity?.GetComponent<MoveComponent>().MoveEnable ?? false;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"判断是否可以移动  result : {flag}", ownerEntity);
		}
		return flag;
	}
}
