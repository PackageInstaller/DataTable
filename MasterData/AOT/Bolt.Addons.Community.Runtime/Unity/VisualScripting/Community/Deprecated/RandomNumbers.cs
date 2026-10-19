using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community.Deprecated;

[UnitTitle("Random Numbers")]
[UnitCategory("Community\\Collections\\Lists")]
[Obsolete]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.RandomNumbers")]
[TypeIcon(typeof(IList))]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.RandomNumbers")]
[UnitOrder(20)]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Deprecated.IsNullValue")]
public class RandomNumbers : Unit
{
	private IList _list = new List<object>();

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput input { get; private set; }

	[DoNotSerialize]
	public ValueInput count { get; private set; }

	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[DoNotSerialize]
	public ValueInput maximum { get; private set; }

	[DoNotSerialize]
	public ValueInput unique { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	[Serialize]
	[Inspectable]
	[InspectorToggleLeft]
	public bool integer { get; set; }

	protected override void Definition()
	{
		input = ControlInput("input", (Flow x) => Enter(x));
		count = ValueInput("count", 10);
		unique = ValueInput("unique", @default: true);
		exit = ControlOutput("exit");
		if (integer)
		{
			minimum = ValueInput("minimum", 0);
			maximum = ValueInput("maximum", 100);
			output = ValueOutput("output", (Flow x) =>
			{
				if (_list == null)
				{
					BuildList(x);
				}
				return _list;
			});
		}
		else
		{
			minimum = ValueInput("minimum", 0f);
			maximum = ValueInput("maximum", 100f);
			output = ValueOutput("output", (Flow x) =>
			{
				if (_list == null)
				{
					BuildList(x);
				}
				return _list;
			});
		}
		Succession(input, exit);
		Requirement(count, input);
		Requirement(minimum, input);
		Requirement(unique, input);
		Requirement(count, output);
		Requirement(minimum, output);
		Requirement(unique, output);
	}

	private void BuildList(Flow flow)
	{
		bool value = flow.GetValue<bool>(unique);
		int value2 = flow.GetValue<int>(count);
		_list.Clear();
		if (value)
		{
			_ = integer;
		}
		if (integer)
		{
			int min = flow.GetValue<int>(minimum);
			int max = flow.GetValue<int>(maximum);
			if (value && max - min < value2)
			{
				throw new ArgumentException("Random Number generation failed.  Unique range is too small for the number of elements specified.");
			}
			PopulateList(value, value2, _list, () => UnityEngine.Random.Range(min, max));
		}
		else
		{
			float min2 = flow.GetValue<float>(minimum);
			float max2 = flow.GetValue<float>(maximum);
			PopulateList(value, value2, _list, () => UnityEngine.Random.Range(min2, max2));
		}
	}

	private void PopulateList<T>(bool unique, int count, IList list, Func<T> p)
	{
		HashSet<T> hashSet = new HashSet<T>();
		while (list.Count < count)
		{
			T val = p();
			if (unique)
			{
				if (!hashSet.Contains(val))
				{
					hashSet.Add(val);
					list.Add(val);
				}
			}
			else
			{
				list.Add(val);
			}
		}
	}

	private ControlOutput Enter(Flow flow)
	{
		BuildList(flow);
		return exit;
	}
}
