using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Graphs/Graph Nodes")]
public abstract class SetGraph<TGraph, TMacro, TMachine> : Unit where TGraph : class, IGraph, new() where TMacro : Macro<TGraph> where TMachine : Machine<TGraph, TMacro>
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; protected set; }

	[NullMeansSelf]
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput target { get; protected set; }

	[PortLabelHidden]
	[PortLabel("Graph")]
	[DoNotSerialize]
	public ValueInput graphInput { get; protected set; }

	[DoNotSerialize]
	[PortLabel("Graph")]
	[PortLabelHidden]
	public ValueOutput graphOutput { get; protected set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; protected set; }

	protected abstract bool isGameObject { get; }

	private Type targetType
	{
		get
		{
			if (!isGameObject)
			{
				return typeof(TMachine);
			}
			return typeof(GameObject);
		}
	}

	protected override void Definition()
	{
		enter = ControlInput("enter", SetMacro);
		target = ValueInput(targetType, "target").NullMeansSelf();
		target.SetDefaultValue(targetType.PseudoDefault());
		graphInput = ValueInput<TMacro>("graphInput", null);
		graphOutput = ValueOutput<TMacro>("graphOutput");
		exit = ControlOutput("exit");
		Requirement(graphInput, enter);
		Assignment(enter, graphOutput);
		Succession(enter, exit);
	}

	private ControlOutput SetMacro(Flow flow)
	{
		TMacro value = flow.GetValue<TMacro>(graphInput);
		object value2 = flow.GetValue(target, targetType);
		if (value2 is GameObject gameObject)
		{
			gameObject.GetComponent<TMachine>().nest.SwitchToMacro(value);
		}
		else
		{
			((TMachine)value2).nest.SwitchToMacro(value);
		}
		flow.SetValue(graphOutput, value);
		return exit;
	}
}
