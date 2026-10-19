using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Collections\\Lists")]
[UnitOrder(20)]
[UnitTitle("Random Numbers")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.RandomNumbersv2")]
[TypeIcon(typeof(IList))]
public class RandomNumbersv2 : Unit
{
	private IList _list;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput input { get; private set; }

	[DoNotSerialize]
	public ValueInput count { get; private set; }

	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[DoNotSerialize]
	public ValueInput maximum { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	[Inspectable]
	[Serialize]
	[InspectorToggleLeft]
	public bool integer { get; set; }

	[Serialize]
	[Inspectable]
	[InspectorToggleLeft]
	public bool aotList { get; set; }

	[Serialize]
	[Inspectable]
	[InspectorToggleLeft]
	public bool unique { get; set; } = true;

	protected override void Definition()
	{
		input = ControlInput("input", (Flow x) => Enter(x));
		count = ValueInput("count", 10);
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
		Requirement(count, output);
		Requirement(minimum, output);
		Assignment(input, output);
	}

	private void BuildList(Flow flow)
	{
		int value = flow.GetValue<int>(count);
		ManageList(value);
		if (integer)
		{
			int min = flow.GetValue<int>(minimum);
			int max = flow.GetValue<int>(maximum);
			if (unique && max - min < value)
			{
				throw new ArgumentException("Random Number generation failed.  Unique range is too small for the number of elements specified.");
			}
			PopulateList(unique, value, _list, () => UnityEngine.Random.Range(min, max));
		}
		else
		{
			float min2 = flow.GetValue<float>(minimum);
			float max2 = flow.GetValue<float>(maximum);
			PopulateList(unique, value, _list, () => UnityEngine.Random.Range(min2, max2));
		}
	}

	private void ManageList(int num)
	{
		if (_list == null)
		{
			if (aotList)
			{
				_list = new AotList(num);
			}
			else if (integer)
			{
				_list = new List<int>(num);
			}
			else
			{
				_list = new List<float>(num);
			}
		}
		_list.Clear();
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
