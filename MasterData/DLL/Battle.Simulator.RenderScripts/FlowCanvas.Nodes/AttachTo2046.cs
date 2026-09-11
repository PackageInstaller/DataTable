using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("4015附加到2046(渲染)", 0)]
[Category("Render/Agent")]
[Description("把4015挂到2046上")]
public class AttachTo2046 : FlowControlNode
{
	private ValueInput<int> _Agent4015IDInput;

	private ValueInput<int> _Agent2046IDInput;

	private ValueInput<string> _AttachPointNameInput;

	private ValueInput<Vector3> _RotateOffsetInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_Agent4015IDInput = AddValueInput<int>("4015实体ID", "4015AgentID");
		_Agent2046IDInput = AddValueInput<int>("2046实体ID", "2046AgnetID");
		_AttachPointNameInput = AddValueInput<string>("挂点", "attachPointName").SetDefaultAndSerializedValue("Bip_Bone_ride");
		_RotateOffsetInput = AddValueInput<Vector3>("额外旋转", "rotateOffset").SetDefaultAndSerializedValue(new Vector3(0f, -90f, -90f));
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			NAgent agent = agentManager.GetAgent(_Agent4015IDInput.GetValue());
			NAgent agent2 = agentManager.GetAgent(_Agent2046IDInput.GetValue());
			if (agent == null || agent2 == null)
			{
				_Error.Call(f);
			}
			else
			{
				ComponentTimeline4015 component = agent.GetComponent<ComponentTimeline4015>();
				AttachPointSetup component2 = agent2.GetComponent<AttachPointSetup>();
				if (component == null || component2 == null)
				{
					_Error.Call(f);
				}
				else
				{
					component.AttachTo2046();
					component.transform.SetParent(component2.GetAttachPoint(_AttachPointNameInput.GetValue()), worldPositionStays: false);
					component.AttachTo2046Info(Vector3.zero, _RotateOffsetInput.GetValue());
					_Out.Call(f);
				}
			}
		});
	}
}
