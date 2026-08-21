using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Self", 100)]
[Description("Returns the Owner GameObject")]
[ContextDefinedOutputs(new Type[] { typeof(GameObject) })]
public class OwnerVariable : VariableNode
{
	public override string name => "<size=20>SELF</size>";

	protected override void RegisterPorts()
	{
		AddValueOutput("Value", () => (!base.graphAgent) ? null : base.graphAgent.gameObject);
	}

	public override void SetVariable(object o)
	{
	}
}
