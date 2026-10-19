using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

namespace Unity.VisualScripting;

public sealed class InvokeMember : MemberUnit
{
	private bool useExpandedParameters;

	[DoNotSerialize]
	private int parameterCount;

	[Serialize]
	private List<string> parameterNames;

	[InspectableIf("supportsChaining")]
	[Serialize]
	public bool chainable { get; set; }

	[DoNotSerialize]
	public bool supportsChaining => member.requiresTarget;

	[DoNotSerialize]
	[MemberFilter(Methods = true, Constructors = true)]
	public Member invocation
	{
		get
		{
			return member;
		}
		set
		{
			member = value;
		}
	}

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public Dictionary<int, ValueInput> inputParameters { get; private set; }

	[DoNotSerialize]
	[PortLabel("Target")]
	[PortLabelHidden]
	public ValueOutput targetOutput { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput result { get; private set; }

	[DoNotSerialize]
	public Dictionary<int, ValueOutput> outputParameters { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	public InvokeMember()
	{
	}

	public InvokeMember(Member member)
		: base(member)
	{
	}

	public override bool HandleDependencies()
	{
		if (!base.HandleDependencies())
		{
			return false;
		}
		if (parameterNames == null && member.parameterTypes.Length == Enumerable.Count(defaultValues, (KeyValuePair<string, object> d) => d.Key != "target"))
		{
			parameterNames = (from defaultValue in defaultValues
				where defaultValue.Key != "target"
				select defaultValue.Key.Substring(1)).ToList();
		}
		return true;
	}

	protected override void Definition()
	{
		base.Definition();
		inputParameters = new Dictionary<int, ValueInput>();
		outputParameters = new Dictionary<int, ValueOutput>();
		useExpandedParameters = true;
		enter = ControlInput("enter", Enter);
		exit = ControlOutput("exit");
		Succession(enter, exit);
		if (member.requiresTarget)
		{
			Requirement(target, enter);
		}
		if (supportsChaining && chainable)
		{
			targetOutput = ValueOutput(member.targetType, "targetOutput");
			Assignment(enter, targetOutput);
		}
		if (member.isGettable)
		{
			result = ValueOutput(member.type, "result", Result);
			if (member.requiresTarget)
			{
				Requirement(target, result);
			}
		}
		ParameterInfo[] array = member.GetParameterInfos().ToArray();
		parameterCount = array.Length;
		bool flag = false;
		for (int i = 0; i < parameterCount; i++)
		{
			ParameterInfo parameterInfo = array[i];
			Type type = parameterInfo.UnderlyingParameterType();
			if (!parameterInfo.HasOutModifier())
			{
				string key = "%" + parameterInfo.Name;
				if (parameterNames != null && parameterNames[i] != parameterInfo.Name)
				{
					key = "%" + parameterNames[i];
					flag = true;
				}
				ValueInput valueInput = ValueInput(type, key);
				inputParameters.Add(i, valueInput);
				valueInput.SetDefaultValue(parameterInfo.PseudoDefaultValue());
				if (parameterInfo.AllowsNull())
				{
					valueInput.AllowsNull();
				}
				Requirement(valueInput, enter);
				if (member.isGettable)
				{
					Requirement(valueInput, result);
				}
			}
			if (parameterInfo.ParameterType.IsByRef || parameterInfo.IsOut)
			{
				string key2 = "&" + parameterInfo.Name;
				if (parameterNames != null && parameterNames[i] != parameterInfo.Name)
				{
					key2 = "&" + parameterNames[i];
					flag = true;
				}
				ValueOutput valueOutput = ValueOutput(type, key2);
				outputParameters.Add(i, valueOutput);
				Assignment(enter, valueOutput);
				useExpandedParameters = false;
			}
		}
		if (inputParameters.Count > 5)
		{
			useExpandedParameters = false;
		}
		if (parameterNames == null)
		{
			parameterNames = array.Select((ParameterInfo pInfo) => pInfo.Name).ToList();
		}
	}

	private void PostDeserializeRemapParameterNames()
	{
		ParameterInfo[] array = member.GetParameterInfos().ToArray();
		if (parameterNames?.Count != array.Length)
		{
			return;
		}
		List<(ValueInput, ValueOutput[])> list = null;
		List<(ValueOutput, ValueInput[])> list2 = null;
		List<(string, object)> list3 = null;
		for (int i = 0; i < array.Length; i++)
		{
			ParameterInfo parameterInfo = array[i];
			string text = parameterNames[i];
			if (!(parameterInfo.Name != text))
			{
				continue;
			}
			ValueOutput value3;
			if (valueInputs.TryGetValue("%" + text, out var value))
			{
				ValueOutput[] array2 = value.validConnections.Select((ValueConnection con) => con.source).ToArray();
				ValueOutput[] array3 = array2;
				for (int num = 0; num < array3.Length; num++)
				{
					array3[num].DisconnectFromValid(value);
				}
				valueInputs.Remove(value);
				if (list == null)
				{
					list = new List<(ValueInput, ValueOutput[])>(1);
				}
				list.Add((new ValueInput("%" + parameterInfo.Name, parameterInfo.ParameterType), array2));
				if (defaultValues.TryGetValue(value.key, out var value2))
				{
					defaultValues.Remove(value.key);
					if (list3 == null)
					{
						list3 = new List<(string, object)>(1);
					}
					list3.Add(("%" + parameterInfo.Name, value2));
				}
			}
			else if (valueOutputs.TryGetValue("&" + text, out value3))
			{
				ValueInput[] array4 = value3.validConnections.Select((ValueConnection con) => con.destination).ToArray();
				ValueInput[] array5 = array4;
				for (int num = 0; num < array5.Length; num++)
				{
					array5[num].DisconnectFromValid(value3);
				}
				valueOutputs.Remove(value3);
				if (list2 == null)
				{
					list2 = new List<(ValueOutput, ValueInput[])>(1);
				}
				list2.Add((new ValueOutput("&" + parameterInfo.Name, parameterInfo.ParameterType), array4));
			}
			parameterNames[i] = parameterInfo.Name;
		}
		if (list != null)
		{
			foreach (var item in list)
			{
				valueInputs.Add(item.Item1);
				ValueOutput[] array3 = item.Item2;
				for (int num = 0; num < array3.Length; num++)
				{
					array3[num].ConnectToValid(item.Item1);
				}
			}
			if (list3 != null)
			{
				foreach (var item2 in list3)
				{
					defaultValues[item2.Item1] = item2.Item2;
				}
			}
		}
		if (list2 != null)
		{
			foreach (var item3 in list2)
			{
				valueOutputs.Add(item3.Item1);
				ValueInput[] array5 = item3.Item2;
				for (int num = 0; num < array5.Length; num++)
				{
					array5[num].ConnectToValid(item3.Item1);
				}
			}
		}
		if (list != null || list2 != null)
		{
			Define();
		}
	}

	protected override bool IsMemberValid(Member member)
	{
		return member.isInvocable;
	}

	private object Invoke(object target, Flow flow)
	{
		if (useExpandedParameters)
		{
			return inputParameters.Count switch
			{
				0 => member.Invoke(target), 
				1 => member.Invoke(target, flow.GetConvertedValue(inputParameters[0])), 
				2 => member.Invoke(target, flow.GetConvertedValue(inputParameters[0]), flow.GetConvertedValue(inputParameters[1])), 
				3 => member.Invoke(target, flow.GetConvertedValue(inputParameters[0]), flow.GetConvertedValue(inputParameters[1]), flow.GetConvertedValue(inputParameters[2])), 
				4 => member.Invoke(target, flow.GetConvertedValue(inputParameters[0]), flow.GetConvertedValue(inputParameters[1]), flow.GetConvertedValue(inputParameters[2]), flow.GetConvertedValue(inputParameters[3])), 
				5 => member.Invoke(target, flow.GetConvertedValue(inputParameters[0]), flow.GetConvertedValue(inputParameters[1]), flow.GetConvertedValue(inputParameters[2]), flow.GetConvertedValue(inputParameters[3]), flow.GetConvertedValue(inputParameters[4])), 
				_ => throw new NotSupportedException(), 
			};
		}
		object[] array = new object[parameterCount];
		for (int i = 0; i < parameterCount; i++)
		{
			if (inputParameters.TryGetValue(i, out var value))
			{
				array[i] = flow.GetConvertedValue(value);
			}
		}
		object obj = member.Invoke(target, array);
		for (int j = 0; j < parameterCount; j++)
		{
			if (outputParameters.TryGetValue(j, out var value2))
			{
				flow.SetValue(value2, array[j]);
			}
		}
		return obj;
	}

	private object GetAndChainTarget(Flow flow)
	{
		if (member.requiresTarget)
		{
			object value = flow.GetValue(target, member.targetType);
			if (supportsChaining && chainable)
			{
				flow.SetValue(targetOutput, value);
			}
			return value;
		}
		return null;
	}

	private object Result(Flow flow)
	{
		object andChainTarget = GetAndChainTarget(flow);
		return Invoke(andChainTarget, flow);
	}

	private ControlOutput Enter(Flow flow)
	{
		object andChainTarget = GetAndChainTarget(flow);
		object value = Invoke(andChainTarget, flow);
		if (result != null)
		{
			flow.SetValue(result, value);
		}
		return exit;
	}

	public override AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		string text = member.targetType.FullName + "." + member.name;
		if (member.parameterTypes != null)
		{
			text += "(";
			for (int i = 0; i < member.parameterTypes.Length; i++)
			{
				if (i >= 5)
				{
					text += $"->{i}";
					break;
				}
				text += member.parameterTypes[i].FullName;
				if (i < member.parameterTypes.Length - 1)
				{
					text += ", ";
				}
			}
			text += ")";
		}
		AnalyticsIdentifier analyticsIdentifier = new AnalyticsIdentifier
		{
			Identifier = text,
			Namespace = member.targetType.Namespace
		};
		analyticsIdentifier.Hashcode = analyticsIdentifier.Identifier.GetHashCode();
		return analyticsIdentifier;
	}
}
