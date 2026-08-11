using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("是否有移动输入", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查实体是否有移动输入。")]
public class CheckHaveMoveInput : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetComponent<MoveComponent>()?.HaveMoveInput() ?? false;
	}
}
