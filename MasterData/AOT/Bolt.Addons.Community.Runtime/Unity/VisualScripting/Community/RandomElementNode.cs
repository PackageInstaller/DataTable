using System.Collections;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitTitle("Random Element")]
[UnitCategory("Collections")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Collections.RandomElementUnit")]
[TypeIcon(typeof(IEnumerable))]
public class RandomElementNode : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter;

	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	public ValueInput collection;

	[DoNotSerialize]
	public ValueOutput key;

	[DoNotSerialize]
	public ValueOutput value;

	[Inspectable]
	public bool Dictionary;

	protected override void Definition()
	{
		enter = ControlInput("enter", (Flow flow) =>
		{
			PerformOperation(flow);
			return exit;
		});
		collection = ValueInput<IEnumerable>("collection");
		exit = ControlOutput("exit");
		if (Dictionary)
		{
			key = ValueOutput<object>("key");
			Assignment(enter, key);
		}
		value = ValueOutput<object>("item");
		Succession(enter, exit);
		Assignment(enter, value);
		Requirement(collection, enter);
	}

	private void PerformOperation(Flow flow)
	{
		IEnumerable enumerable = flow.GetValue<IEnumerable>(collection);
		IList list = enumerable as IList;
		if (list != null)
		{
			if (Dictionary)
			{
				Debug.LogWarning("Unit is configured as Dictionary, but recieved list.  Key will be unset.");
				flow.SetValue(key, null);
			}
			if (list.Count == 0)
			{
				Debug.LogWarning("Collection is empty, null returned.");
				flow.SetValue(value, null);
			}
			else
			{
				flow.SetValue(value, list[Random.Range(0, list.Count)]);
			}
		}
		else if (enumerable is IDictionary dictionary)
		{
			if (!Dictionary)
			{
				Debug.LogWarning("Unit is configured as simple collection, but recieved Dictionary.  Key will be innaccessible.");
			}
			if (dictionary.Count == 0)
			{
				Debug.LogWarning("Collection is empty, null returned.");
				if (Dictionary)
				{
					flow.SetValue(key, null);
				}
				flow.SetValue(value, null);
			}
			else
			{
				object obj = dictionary.Keys.Cast<object>().ElementAt(Random.Range(0, dictionary.Count));
				if (Dictionary)
				{
					flow.SetValue(key, obj);
				}
				flow.SetValue(value, dictionary[obj]);
			}
		}
		else
		{
			if (Dictionary)
			{
				Debug.LogWarning("Unit is configured as Dictionary, but recieved non-dictionary collection.  Key will be unset.");
				flow.SetValue(key, null);
			}
			flow.SetValue(value, enumerable.Cast<object>().ElementAt(Random.Range(0, list.Count)));
		}
	}
}
