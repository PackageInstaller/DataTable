using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取charactor_param配置信息", 0)]
[Category("Logic/Config")]
[Description("获取charactor_param配置信息")]
public class GetCharactorParamConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("id");
		FlowOutput output = AddFlowOutput("");
		FlowOutput outputError = AddFlowOutput("error");
		int consumeEnduranceValue = 0;
		AddValueOutput("ConsumeEnduranceValue", () => consumeEnduranceValue);
		int maxEnduranceValue = 0;
		AddValueOutput("MaxEnduranceValue", () => maxEnduranceValue);
		int resumeEnduranceSpeed = 0;
		AddValueOutput("ResumeEnduranceSpeed", () => resumeEnduranceSpeed);
		AddFlowInput("", delegate(Flow f)
		{
			if (ConfigHelper.GetInstance().TryGetConfig<charactor_param>(idInput.value, out var config))
			{
				consumeEnduranceValue = config.ConsumeEnduranceValue;
				maxEnduranceValue = config.MaxEnduranceValue;
				resumeEnduranceSpeed = config.ResumeEnduranceSpeed;
				output.Call(f);
			}
			else
			{
				outputError.Call(f);
			}
		});
	}
}
