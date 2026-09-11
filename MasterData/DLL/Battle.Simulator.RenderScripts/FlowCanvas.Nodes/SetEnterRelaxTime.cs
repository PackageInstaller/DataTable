using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置休闲动作间隔(渲染)", 0)]
[Category("Render/Config")]
[Description("设置进入休闲动作的间隔时长")]
public class SetEnterRelaxTime : FlowControlNode
{
	private ValueInput<int> _AgentIDInput;

	private ValueInput<float> _TimeInput;

	private ValueInput<bool> _ResetCurTimeInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_AgentIDInput = AddValueInput<int>("实体ID", "agentID");
		_TimeInput = AddValueInput<float>("时长(秒)", "time").SetDefaultAndSerializedValue(8f);
		_ResetCurTimeInput = AddValueInput<bool>("重置计时", "resetCurTime").SetDefaultAndSerializedValue(v: true);
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(_AgentIDInput.GetValue());
			if (agent == null)
			{
				_Error.Call(f);
			}
			else
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline == null)
				{
					_Error.Call(f);
				}
				else
				{
					componentTimeline.SetEnterRelaxTime(_TimeInput.GetValue(), _ResetCurTimeInput.GetValue());
					_Out.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => _AgentIDInput.GetValue());
	}
}
