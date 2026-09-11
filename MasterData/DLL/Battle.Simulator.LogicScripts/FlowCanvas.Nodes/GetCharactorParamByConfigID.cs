using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取配置神系(配置ID)", 0)]
[Category("Logic/Config")]
[Description("获取配置神系")]
public class GetCharactorParamByConfigID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID");
		AddValueOutput("RaceID", () => ConfigHelper.GetInstance().GetConfig<charactor_param>(configIDInput.value).RaceID);
	}
}
