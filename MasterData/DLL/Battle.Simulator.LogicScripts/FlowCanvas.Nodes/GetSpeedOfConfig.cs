using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到速度配置(非曲线移动)(逻辑)", 0)]
[Category("Common/Attribute")]
[Description("得到配置表中配置的非曲线移动速度")]
public class GetSpeedOfConfig : FlowControlNodeOfCommon
{
	private int _speed;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleIDInput.value, out var config))
			{
				errorOut.Call(f);
			}
			else
			{
				_speed = config.Speed;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => roleIDInput.value);
		AddValueOutput("速度(毫米)", "speed", () => _speed);
	}
}
