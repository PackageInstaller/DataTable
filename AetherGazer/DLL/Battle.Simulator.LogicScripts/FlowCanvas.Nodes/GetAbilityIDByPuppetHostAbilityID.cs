using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("通过当前宿主技能ID获取获取傀儡技能ID", 0)]
[Category("Logic/Puppet")]
[Description("通过当前宿主技能ID获取获取傀儡技能ID")]
public class GetAbilityIDByPuppetHostAbilityID : PureFunctionNode<int, int, int>
{
	public override int Invoke(int abilityID, int roleID)
	{
		return roleID * 1000 + abilityID % 1000;
	}
}
