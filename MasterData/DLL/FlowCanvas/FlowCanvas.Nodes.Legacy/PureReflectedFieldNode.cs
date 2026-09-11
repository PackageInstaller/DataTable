using System;
using System.Reflection;
using ParadoxNotion;

namespace FlowCanvas.Nodes.Legacy;

public sealed class PureReflectedFieldNode : ReflectedFieldNode
{
	public override void RegisterPorts(FlowNode node, FieldInfo field, ReflectedFieldNodeWrapper.AccessMode accessMode)
	{
		if (field.IsConstant())
		{
			object constantValue = field.GetValue(null);
			node.AddValueOutput("Value", field.FieldType, () => constantValue);
			return;
		}
		Type declaringType = field.DeclaringType;
		if (accessMode == ReflectedFieldNodeWrapper.AccessMode.GetField)
		{
			ValueInput instanceInput = node.AddValueInput(declaringType.FriendlyName(), declaringType);
			node.AddValueOutput("Value", field.FieldType, () => field.GetValue(instanceInput.value));
			return;
		}
		object instance = null;
		ValueInput instanceInput2 = node.AddValueInput(declaringType.FriendlyName(), declaringType);
		ValueInput valueInput = node.AddValueInput("Value", field.FieldType);
		FlowOutput flowOut = node.AddFlowOutput(" ");
		node.AddValueOutput(declaringType.FriendlyName(), declaringType, () => instance);
		node.AddFlowInput(" ", delegate(Flow f)
		{
			instance = instanceInput2.value;
			field.SetValue(instance, valueInput.value);
			flowOut.Call(f);
		});
	}
}
