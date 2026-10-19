using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Math")]
[UnitShortTitle("Math")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.MathParamNode")]
[TypeIcon(typeof(Absolute<float>))]
[UnitTitle("Math Op")]
public class MathParamNode : VariadicNode<float>
{
	public enum MathType
	{
		Add,
		Subtract,
		Multiply,
		Divide
	}

	[SerializeAs("OperationType")]
	private MathType _operationType;

	[Serialize]
	[InspectorLabel("Non-Numeric Inputs")]
	[Inspectable]
	private bool nonNumeric;

	[Inspectable]
	[DoNotSerialize]
	[UnitHeaderInspectable("Operation")]
	public MathType OperationType
	{
		get
		{
			return _operationType;
		}
		set
		{
			_operationType = value;
		}
	}

	[PortLabel("Result")]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		arguments = new List<ValueInput>();
		if (nonNumeric)
		{
			output = ValueOutput("output", GetObjectValue);
			for (int i = 0; i < argumentCount; i++)
			{
				ValueInput valueInput = ValueInput<object>("Arg_" + i);
				arguments.Add(valueInput);
				BuildRelations(valueInput);
			}
			return;
		}
		output = ValueOutput("output", GetFloatValue);
		for (int j = 0; j < argumentCount; j++)
		{
			ValueInput valueInput2 = ValueInput<float>("Arg_" + j);
			valueInput2.SetDefaultValue(GetDefaultValue(typeof(float)));
			arguments.Add(valueInput2);
			BuildRelations(valueInput2);
		}
	}

	protected override void BuildRelations(ValueInput arg)
	{
		Requirement(arg, output);
	}

	private float GetFloatValue(Flow flow)
	{
		float num = flow.GetValue<float>(arguments[0]);
		for (int i = 1; i < argumentCount; i++)
		{
			switch (OperationType)
			{
			case MathType.Add:
				num += flow.GetValue<float>(arguments[i]);
				break;
			case MathType.Subtract:
				num -= flow.GetValue<float>(arguments[i]);
				break;
			case MathType.Multiply:
				num *= flow.GetValue<float>(arguments[i]);
				break;
			case MathType.Divide:
				num /= flow.GetValue<float>(arguments[i]);
				break;
			}
		}
		return num;
	}

	private object GetObjectValue(Flow flow)
	{
		object obj = flow.GetValue<object>(arguments[0]);
		for (int i = 1; i < argumentCount; i++)
		{
			switch (OperationType)
			{
			case MathType.Add:
				obj = OperatorUtility.Add(obj, flow.GetValue<object>(arguments[i]));
				break;
			case MathType.Subtract:
				obj = OperatorUtility.Subtract(obj, flow.GetValue<object>(arguments[i]));
				break;
			case MathType.Multiply:
				obj = OperatorUtility.Multiply(obj, flow.GetValue<object>(arguments[i]));
				break;
			case MathType.Divide:
				obj = OperatorUtility.Divide(obj, flow.GetValue<object>(arguments[i]));
				break;
			}
		}
		return obj;
	}
}
