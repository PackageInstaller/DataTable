using System;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Set Of Type", 10)]
[Category("Variables/Blackboard")]
[Description("Set a Blackboard variable value")]
[ContextDefinedInputs(new Type[] { typeof(Wild) })]
public class SetVariable<T> : FlowNode
{
	[BlackboardOnly]
	public BBParameter<T> targetVariable;

	[HideInInspector]
	public OperationMethod operation;

	[HideInInspector]
	public bool perSecond;

	public override string name => string.Format("{0}{1}{2}", targetVariable.ToString(), OperationTools.GetOperationString(operation), "Value");

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		targetVariable.varRef = null;
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		if (targetVariable != null)
		{
			targetVariable.varRef = targetVariable.PromoteToVariable(targetVariable.bb);
		}
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write((int)operation);
		writer.Write(perSecond);
		options.Resolver.GetFormatterWithVerify<BBParameter<T>>().Serialize(ref writer, targetVariable, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		operation = (OperationMethod)reader.ReadInt32();
		perSecond = reader.ReadBoolean();
		targetVariable = options.Resolver.GetFormatterWithVerify<BBParameter<T>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		FlowOutput o = AddFlowOutput("Out");
		ValueInput<T> v = AddValueInput<T>("Value");
		AddValueOutput("Value", () => targetVariable.value);
		AddFlowInput("In", delegate(Flow f)
		{
			DoSet(v);
			o.Call(f);
		});
	}

	private void DoSet(T value)
	{
		if (operation != OperationMethod.Set)
		{
			if (typeof(T) == typeof(float))
			{
				targetVariable.value = (T)(object)OperationTools.Operate((float)(object)targetVariable.value, (float)(object)value, operation);
			}
			else if (typeof(T) == typeof(int))
			{
				targetVariable.value = (T)(object)OperationTools.Operate((int)(object)targetVariable.value, (int)(object)value, operation);
			}
			else if (typeof(T) == typeof(Vector3))
			{
				targetVariable.value = (T)(object)OperationTools.Operate((Vector3)(object)targetVariable.value, (Vector3)(object)value, operation);
			}
			else
			{
				targetVariable.value = value;
			}
		}
		else
		{
			targetVariable.value = value;
		}
	}

	private void DoSet(ValueInput<T> input)
	{
		if (operation != OperationMethod.Set)
		{
			if (typeof(T) == typeof(float))
			{
				BBParameter<float> obj = targetVariable as BBParameter<float>;
				ValueInput<float> valueInput = input as ValueInput<float>;
				obj.value = OperationTools.Operate(obj.value, valueInput.value, operation);
			}
			else if (typeof(T) == typeof(int))
			{
				BBParameter<int> obj2 = targetVariable as BBParameter<int>;
				ValueInput<int> valueInput2 = input as ValueInput<int>;
				obj2.value = OperationTools.Operate(obj2.value, valueInput2.value, operation);
			}
			else if (typeof(T) == typeof(Vector3))
			{
				BBParameter<Vector3> obj3 = targetVariable as BBParameter<Vector3>;
				ValueInput<Vector3> valueInput3 = input as ValueInput<Vector3>;
				obj3.value = OperationTools.Operate(obj3.value, valueInput3.value, operation);
			}
			else
			{
				targetVariable.value = input.value;
			}
		}
		else
		{
			targetVariable.value = input.value;
		}
	}

	public void SetTargetVariableName(string name)
	{
		targetVariable.name = name;
	}
}
