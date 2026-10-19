using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using UnityEngine;

namespace Unity.VisualScripting;

public abstract class MultiInputUnit<T> : Unit, IMultiInputUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	[SerializeAs("inputCount")]
	private int _inputCount = 2;

	[DoNotSerialize]
	protected virtual int minInputCount => 2;

	[UnitHeaderInspectable("Inputs")]
	[Inspectable]
	[DoNotSerialize]
	public virtual int inputCount
	{
		get
		{
			return _inputCount;
		}
		set
		{
			_inputCount = Mathf.Clamp(value, minInputCount, 10);
		}
	}

	[DoNotSerialize]
	public ReadOnlyCollection<ValueInput> multiInputs { get; protected set; }

	protected override void Definition()
	{
		List<ValueInput> list = new List<ValueInput>();
		multiInputs = list.AsReadOnly();
		for (int i = 0; i < inputCount; i++)
		{
			list.Add(ValueInput<T>(i.ToString()));
		}
	}

	protected void InputsAllowNull()
	{
		foreach (ValueInput multiInput in multiInputs)
		{
			multiInput.AllowsNull();
		}
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
