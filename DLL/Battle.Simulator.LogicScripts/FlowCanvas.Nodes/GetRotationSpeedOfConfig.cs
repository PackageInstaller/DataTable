using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到转身速度(配置)", 0)]
[Category("Common/Attribute")]
[Description("得到实体转身速度, 单位为每秒x毫度")]
public class GetRotationSpeedOfConfig : FlowControlNodeOfCommon
{
	private int _rotationSpeed;

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
				_rotationSpeed = config.RotationSpeed;
				output.Call(f);
			}
		});
		AddValueOutput("转身速度", "rotationSpeed", () => _rotationSpeed);
	}
}
