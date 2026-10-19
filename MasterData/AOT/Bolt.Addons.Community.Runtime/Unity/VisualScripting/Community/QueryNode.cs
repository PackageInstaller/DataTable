using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Collections.QueryUnit")]
[UnitTitle("Query")]
[UnitCategory("Community/Collections")]
[TypeIcon(typeof(IEnumerable))]
[RenamedFrom("Lasm.BoltExtensions.QueryUnit")]
[RenamedFrom("Lasm.UAlive.QueryUnit")]
public class QueryNode : Unit
{
	[UnitHeaderInspectable(null)]
	[Inspectable]
	[InspectorWide]
	[Serialize]
	public QueryOperation operation;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter;

	[DoNotSerialize]
	public ControlOutput body;

	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	public ValueInput collection;

	[DoNotSerialize]
	public ValueInput condition;

	[DoNotSerialize]
	public ValueInput key;

	[DoNotSerialize]
	public ValueOutput item;

	[DoNotSerialize]
	public ValueOutput result;

	private object current;

	private IEnumerable<object> output;

	private object single;

	private bool outCondition;

	[Obsolete]
	private string serializedOperation;

	protected override void Definition()
	{
		enter = ControlInput("enter", (Flow flow) =>
		{
			PerformOperation(flow);
			return exit;
		});
		collection = ValueInput<IEnumerable<object>>("collection");
		bool flag = true;
		bool flag2 = true;
		switch (operation)
		{
		case QueryOperation.Any:
			flag = false;
			flag2 = false;
			break;
		case QueryOperation.AnyWithCondition:
			condition = ValueInput<bool>("condition");
			break;
		case QueryOperation.First:
			condition = ValueInput<bool>("condition");
			break;
		case QueryOperation.FirstOrDefault:
			condition = ValueInput<bool>("condition");
			break;
		case QueryOperation.OrderBy:
			key = ValueInput<object>("key");
			break;
		case QueryOperation.OrderByDescending:
			key = ValueInput<object>("key");
			break;
		case QueryOperation.Single:
			condition = ValueInput<bool>("condition");
			break;
		case QueryOperation.Where:
			condition = ValueInput<bool>("condition");
			break;
		}
		exit = ControlOutput("exit");
		if (flag2)
		{
			body = ControlOutput("body");
		}
		if (flag)
		{
			item = ValueOutput("item", (Flow flow) => current);
		}
		switch (operation)
		{
		case QueryOperation.Any:
			result = ValueOutput("result", (Flow flow) => outCondition);
			break;
		case QueryOperation.AnyWithCondition:
			result = ValueOutput("result", (Flow flow) => outCondition);
			break;
		case QueryOperation.First:
			result = ValueOutput("result", (Flow flow) => single);
			break;
		case QueryOperation.FirstOrDefault:
			result = ValueOutput("result", (Flow flow) => single);
			break;
		case QueryOperation.OrderBy:
			result = ValueOutput("result", (Flow flow) => output);
			break;
		case QueryOperation.OrderByDescending:
			result = ValueOutput("result", (Flow flow) => output);
			break;
		case QueryOperation.Single:
			result = ValueOutput("result", (Flow flow) => single);
			break;
		case QueryOperation.Where:
			result = ValueOutput("result", (Flow flow) => output);
			break;
		}
		Succession(enter, exit);
		if (flag2)
		{
			Succession(enter, body);
		}
		if (flag)
		{
			Assignment(enter, item);
		}
		Requirement(collection, enter);
		switch (operation)
		{
		case QueryOperation.AnyWithCondition:
			Requirement(condition, enter);
			break;
		case QueryOperation.First:
			Requirement(condition, enter);
			break;
		case QueryOperation.FirstOrDefault:
			Requirement(condition, enter);
			break;
		case QueryOperation.OrderBy:
			Requirement(key, enter);
			break;
		case QueryOperation.OrderByDescending:
			Requirement(key, enter);
			break;
		case QueryOperation.Single:
			Requirement(condition, enter);
			break;
		case QueryOperation.Where:
			Requirement(condition, enter);
			break;
		case QueryOperation.Any:
			break;
		}
	}

	private void PerformOperation(Flow flow)
	{
		Flow _flow = null;
		switch (operation)
		{
		case QueryOperation.Any:
			outCondition = flow.GetValue<IEnumerable>(collection).Cast<object>().Any();
			break;
		case QueryOperation.AnyWithCondition:
			outCondition = flow.GetValue<IEnumerable>(collection).Cast<object>().Any((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<bool>(condition);
			});
			break;
		case QueryOperation.First:
			single = flow.GetValue<IEnumerable>(collection).Cast<object>().First((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<bool>(condition);
			});
			break;
		case QueryOperation.FirstOrDefault:
			single = flow.GetValue<IEnumerable>(collection).Cast<object>().FirstOrDefault((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<bool>(condition);
			});
			break;
		case QueryOperation.OrderBy:
			output = flow.GetValue<IEnumerable>(collection).Cast<object>().OrderBy((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<object>(key);
			});
			break;
		case QueryOperation.OrderByDescending:
			output = flow.GetValue<IEnumerable>(collection).Cast<object>().OrderByDescending((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<object>(key);
			});
			break;
		case QueryOperation.Single:
			single = flow.GetValue<IEnumerable>(collection).Cast<object>().Single((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<bool>(condition);
			});
			break;
		case QueryOperation.Where:
			output = flow.GetValue<IEnumerable>(collection).Cast<object>().Where((object item) =>
			{
				current = item;
				_flow = Flow.New(flow.stack.AsReference());
				_flow.Invoke(body);
				return _flow.GetValue<bool>(condition);
			});
			break;
		}
	}
}
