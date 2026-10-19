using System;
using System.Collections;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.GetDictionaryVariableItem")]
[UnitTitle("Get Dictionary Variable")]
public sealed class GetDictionaryVariableItem : DictionaryVariableItem
{
	[DoNotSerialize]
	public ValueInput fallback { get; private set; }

	[Serialize]
	[Inspectable]
	[InspectorLabel("Fallback")]
	public bool specifyFallback { get; set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		output = ValueOutput("output", Get).PredictableIf(IsDefined);
		if (specifyFallback)
		{
			fallback = ValueInput("fallback", (object)0);
		}
		Requirement(name, output);
		Requirement(key, output);
		if (specifyFallback)
		{
			Requirement(fallback, output);
		}
	}

	private object GetDefaultValue(Type t)
	{
		if (t.IsValueType)
		{
			return Activator.CreateInstance(t);
		}
		if (t == typeof(string))
		{
			return "";
		}
		return null;
	}

	private bool IsDefined(Flow flow)
	{
		string value = flow.GetValue<string>(name);
		if (string.IsNullOrEmpty(value))
		{
			return false;
		}
		return GetDeclarations(flow)?.IsDefined(value) ?? false;
	}

	private object Get(Flow flow)
	{
		string value = flow.GetValue<string>(name);
		string value2 = flow.GetValue<string>(key);
		object obj = GetDeclarations(flow).Get(value);
		if (obj == null)
		{
			if (specifyFallback)
			{
				return flow.GetValue(fallback);
			}
			throw new ArgumentException("Indicated variable does not exist.");
		}
		if (!(obj is IDictionary dictionary))
		{
			if (specifyFallback)
			{
				return flow.GetValue(fallback);
			}
			throw new ArgumentException("Indicated variable is not a dictionary.");
		}
		if (specifyFallback && !dictionary.Contains(value2))
		{
			return flow.GetValue(fallback);
		}
		return dictionary[value2];
	}
}
