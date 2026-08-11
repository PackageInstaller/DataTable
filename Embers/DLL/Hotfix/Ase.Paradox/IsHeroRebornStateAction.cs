using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检测角色是否正在重生", 0)]
[Category("✫ DragonLost/State")]
[Description("检测当前角色是否正在进行重生状态。")]
public class IsHeroRebornStateAction : ConditionTaskBase
{
	protected override bool OnCheck()
	{
		base.OnCheck();
		return ownerEntity.GetComponent<ReBornComponent>().IsRebornState;
	}
}
