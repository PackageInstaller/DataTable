using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到连携奥义资源路径(渲染)", 0)]
[Category("Render/奥义")]
[Description("如题")]
public class GetCooperateUniqueSkillAssetPath : FlowControlNode
{
	private ValueInput<int> _CooperateUniqueSkillIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private string _Path;

	protected override void RegisterPorts()
	{
		_CooperateUniqueSkillIDInput = AddValueInput<int>("连携奥义ID", "cooperateUniqueSkillID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(_CooperateUniqueSkillIDInput.GetValue(), out var config))
			{
				_Error.Call(f);
			}
			else
			{
				_Path = "CooperateUniqueSkillTimeline/" + config.PrefabPath;
				_Out.Call(f);
			}
		});
		AddValueOutput("路径", "path", () => _Path);
	}
}
