using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

[TypeIcon(typeof(IBranchUnit))]
public abstract class SwitchUnit<T> : Unit, IBranchUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[DoNotSerialize]
	public List<KeyValuePair<T, ControlOutput>> branches { get; private set; }

	[Inspectable]
	[Serialize]
	public List<T> options { get; set; } = new List<T>();

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput selector { get; private set; }

	[DoNotSerialize]
	public ControlOutput @default { get; private set; }

	public override bool canDefine => options != null;

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		selector = ValueInput<T>("selector");
		Requirement(selector, enter);
		branches = new List<KeyValuePair<T, ControlOutput>>();
		foreach (T option in options)
		{
			T val = option;
			string key = "%" + val;
			if (!controlOutputs.Contains(key))
			{
				ControlOutput controlOutput = ControlOutput(key);
				branches.Add(new KeyValuePair<T, ControlOutput>(option, controlOutput));
				Succession(enter, controlOutput);
			}
		}
		@default = ControlOutput("default");
		Succession(enter, @default);
	}

	protected virtual bool Matches(T a, T b)
	{
		return object.Equals(a, b);
	}

	public ControlOutput Enter(Flow flow)
	{
		T value = flow.GetValue<T>(selector);
		foreach (KeyValuePair<T, ControlOutput> branch in branches)
		{
			if (Matches(branch.Key, value))
			{
				return branch.Value;
			}
		}
		return @default;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
