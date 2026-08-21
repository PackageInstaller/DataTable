using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("回收傀儡绳(傀儡GO)", 0)]
[Category("Render/Asset")]
[Description("回收傀儡绳")]
public class RecyclePuppetRope3 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> puppetGoVar = AddValueInput<GameObject>("傀儡", "puppetGoVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GameObject value = puppetGoVar.GetValue();
			if (value == null)
			{
				error.Call(f);
			}
			else
			{
				Puppet component = value.GetComponent<Puppet>();
				if (component == null)
				{
					error.Call(f);
				}
				else
				{
					component.RemoveRope();
					output.Call(f);
				}
			}
		});
	}
}
