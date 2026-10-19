using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitOrder(13)]
[UnitCategory("Control")]
public sealed class Sequence : Unit
{
	[SerializeAs("outputCount")]
	private int _outputCount = 2;

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[InspectorLabel("Steps")]
	[UnitHeaderInspectable("Steps")]
	[Inspectable]
	public int outputCount
	{
		get
		{
			return _outputCount;
		}
		set
		{
			_outputCount = Mathf.Clamp(value, 1, 10);
		}
	}

	[DoNotSerialize]
	public ReadOnlyCollection<ControlOutput> multiOutputs { get; private set; }

	protected override void Definition()
	{
		enter = ControlInputCoroutine("enter", Enter, EnterCoroutine);
		List<ControlOutput> list = new List<ControlOutput>();
		multiOutputs = list.AsReadOnly();
		for (int i = 0; i < outputCount; i++)
		{
			ControlOutput controlOutput = ControlOutput(i.ToString());
			Succession(enter, controlOutput);
			list.Add(controlOutput);
		}
	}

	private ControlOutput Enter(Flow flow)
	{
		GraphStack stack = flow.PreserveStack();
		foreach (ControlOutput multiOutput in multiOutputs)
		{
			flow.Invoke(multiOutput);
			flow.RestoreStack(stack);
		}
		flow.DisposePreservedStack(stack);
		return null;
	}

	private IEnumerator EnterCoroutine(Flow flow)
	{
		GraphStack stack = flow.PreserveStack();
		foreach (ControlOutput multiOutput in multiOutputs)
		{
			yield return multiOutput;
			flow.RestoreStack(stack);
		}
		flow.DisposePreservedStack(stack);
	}

	public void CopyFrom(Sequence source)
	{
		CopyFrom((Unit)source);
		outputCount = source.outputCount;
	}
}
