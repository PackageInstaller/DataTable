using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Category("Events/Object/UI")]
public class GetButtonOnClick : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject");
		AddValueOutput("onClick", () => goInput.value.GetComponent<Button>().onClick);
	}
}
