using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到抛掷物位置(渲染)", 0)]
[Category("Render/抛掷物")]
[Description("得到抛掷物在渲染层的位置")]
public class GetThrownPosition : FlowControlNode
{
	private ValueInput<int> m_thrownIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private Vector3 m_position = Vector3.zero;

	private Vector3 m_forward = Vector3.forward;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "抛掷物ID");
		AddValueOutput("抛掷物ID", "抛掷物ID", () => m_thrownIDInput.value);
		AddValueOutput("位置", "position", () => m_position);
		AddValueOutput("朝向", "forward", () => m_forward);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			ThrownManager thrownManager = (NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager;
			if (thrownManager != null)
			{
				if (thrownManager.TryGetThrownPosition(m_thrownIDInput.value, out m_position, out m_forward))
				{
					m_out.Call(f);
				}
				else
				{
					m_error.Call(f);
				}
			}
		});
	}
}
