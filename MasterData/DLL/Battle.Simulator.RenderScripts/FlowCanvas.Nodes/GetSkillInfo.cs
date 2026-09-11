using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到skill表内容", 0)]
[Category("Render/UI")]
[Description("得到 Function 下 skill 表的内容")]
public class GetSkillInfo : FlowControlNodeOfRender
{
	private string _name;

	private string _simpleDesc;

	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("ID", "id");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<skill>(idInput.value, out var config))
			{
				errorOut.Call(f);
			}
			else
			{
				_name = WorldStateManager.GetSystemTableI18N(config.Name);
				_simpleDesc = WorldStateManager.GetSystemTableI18N(config.SimpleDesc);
				output.Call(f);
			}
		});
		AddValueOutput("名称", "name", () => _name);
		AddValueOutput("描述", "simpleDesc", () => _simpleDesc);
	}
}
