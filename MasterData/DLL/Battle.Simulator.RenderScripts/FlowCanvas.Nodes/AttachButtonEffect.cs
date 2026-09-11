using UnityEngine;

namespace FlowCanvas.Nodes;

public class AttachButtonEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		ValueInput<GameObject> buttonEffectInput = AddValueInput<GameObject>("按钮");
		FlowOutput flowOutput = AddFlowOutput("OUT");
		AddFlowInput("IN", delegate(Flow f)
		{
			Invoke(pathInput.value, buttonEffectInput.value);
			flowOutput.Call(f);
		});
	}

	protected virtual void Invoke(string path, GameObject button)
	{
	}
}
