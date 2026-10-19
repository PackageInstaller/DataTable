using System;
using UnityEngine;

namespace Unity.VisualScripting.Community.Deprecated;

[UnitCategory("Nulls")]
[Obsolete("This unit can be replaced by the built-in Equals (not Object.Equals, but the Bolt one in Logic)")]
[TypeIcon(typeof(Null))]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.IsNullValue")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.IsNullValue")]
[UnitTitle("Is Null")]
public class IsNullValue : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[PortLabel("Null")]
	[DoNotSerialize]
	public ValueOutput isNull { get; private set; }

	[PortLabel("Not Null")]
	[DoNotSerialize]
	public ValueOutput isNotNull { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<object>("input").AllowsNull();
		isNull = ValueOutput("isNull", (Flow x) => IsNull(x));
		isNotNull = ValueOutput("isNotNull", (Flow x) => !IsNull(x));
		Requirement(input, isNull);
		Requirement(input, isNotNull);
	}

	private bool IsNull(Flow flow)
	{
		object value = flow.GetValue(input);
		if (value is UnityEngine.Object)
		{
			return (UnityEngine.Object)value == null;
		}
		return value == null;
	}
}
