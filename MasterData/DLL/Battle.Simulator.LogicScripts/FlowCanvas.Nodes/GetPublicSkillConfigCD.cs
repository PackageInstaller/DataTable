using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取配置CD", 0)]
[Category("Logic/Config")]
[Description("获取配置CD")]
public class GetPublicSkillConfigCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID");
		AddValueOutput("CD", () => ConfigHelper.GetInstance().GetConfig<public_skill>(configIDInput.value).Cd);
		AddValueOutput("强化模组之后的cd", () => ConfigHelper.GetInstance().TryGetConfig<public_skill>(configIDInput.value, out var config) ? config.Cd : 0);
	}
}
