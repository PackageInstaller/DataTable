using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能获取管理员实体ID", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能获取管理员实体ID")]
public class GetMasterSkillEntity : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => base.mSimContext.sEntityWorldState.status.mMasterSkillEntityID);
	}
}
