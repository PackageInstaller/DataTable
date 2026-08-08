using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class RelayValueInput<T> : RelayValueInputBase, IEditorMenuCallbackReceiver
{
	[Tooltip("The identifier name of the internal var")]
	[DelayedField]
	public string identifier = "MyInternalVarName";

	[HideInInspector]
	public ValueInput<T> port { get; private set; }

	public override Type relayType => typeof(T);

	public override string name => $"@ {identifier}";

	protected override void RegisterPorts()
	{
		port = AddValueInput<T>("Value");
	}
}
