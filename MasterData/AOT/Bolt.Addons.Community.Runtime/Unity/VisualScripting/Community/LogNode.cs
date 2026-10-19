using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitTitle("Log")]
[UnitCategory("Community\\Logic")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.logic.LogUnit")]
public class LogNode : Unit
{
	public const int ArgumentLimit = 10;

	[SerializeAs("argumentCount")]
	private int _argumentCount;

	[UnitHeaderInspectable("LogType")]
	public LogType type;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput format { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput input { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput output { get; private set; }

	[DoNotSerialize]
	public List<ValueInput> arguments { get; protected set; }

	[DoNotSerialize]
	[Inspectable]
	[UnitHeaderInspectable("Arguments")]
	public int argumentCount
	{
		get
		{
			return Mathf.Max(0, _argumentCount);
		}
		set
		{
			_argumentCount = Mathf.Clamp(value, 0, 10);
		}
	}

	protected override void Definition()
	{
		format = ValueInput("format", "");
		input = ControlInput("input", (Flow flow) => Log(flow));
		output = ControlOutput("output");
		arguments = new List<ValueInput>();
		for (int num = 0; num < Math.Min(argumentCount, 10); num++)
		{
			ValueInput valueInput = ValueInput<object>("Arg_" + num);
			arguments.Add(valueInput);
			Requirement(valueInput, input);
		}
		Succession(input, output);
		Requirement(format, input);
	}

	private ControlOutput Log(Flow flow)
	{
		string value = flow.GetValue<string>(format);
		if (argumentCount == 1 && string.IsNullOrEmpty(value))
		{
			Debug.Log(flow.GetValue(arguments[0]).ToString());
			return output;
		}
		IEnumerable<string> source = arguments.Select((ValueInput x) =>
		{
			object value5 = flow.GetValue(x);
			return (value5 is string) ? (value5 as string) : value5.ToString();
		});
		switch (type)
		{
		case LogType.Log:
		{
			string value4 = flow.GetValue<string>(format);
			object[] args = source.ToArray();
			Debug.Log(string.Format(value4, args));
			break;
		}
		case LogType.Warning:
		{
			string value3 = flow.GetValue<string>(format);
			object[] args = source.ToArray();
			Debug.LogWarning(string.Format(value3, args));
			break;
		}
		case LogType.Error:
		{
			string value2 = flow.GetValue<string>(format);
			object[] args = source.ToArray();
			Debug.LogError(string.Format(value2, args));
			break;
		}
		}
		return output;
	}
}
