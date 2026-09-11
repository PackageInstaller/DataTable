using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被抓取(逻辑)(过时)", 0)]
[Category("Logic/Config")]
[Description("能否被抓取")]
public class CanBeGrab : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleIDInput.value, out var config) && config.CanBeGrab)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
