using System;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Graphs/Graph Nodes")]
public abstract class HasGraph<TGraph, TMacro, TMachine> : Unit where TGraph : class, IGraph, new() where TMacro : Macro<TGraph> where TMachine : Machine<TGraph, TMacro>
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[NullMeansSelf]
	[PortLabelHidden]
	public ValueInput target { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	[PortLabel("Graph")]
	public ValueInput graphInput { get; private set; }

	[PortLabelHidden]
	[PortLabel("Has Graph")]
	[DoNotSerialize]
	public ValueOutput hasGraphOutput { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

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
		enter = ControlInput("enter", TriggerHasGraph);
		target = ValueInput(targetType, "target").NullMeansSelf();
		target.SetDefaultValue(targetType.PseudoDefault());
		graphInput = ValueInput<TMacro>("graphInput", null);
		hasGraphOutput = ValueOutput("hasGraphOutput", OutputHasGraph);
		exit = ControlOutput("exit");
		Requirement(graphInput, enter);
		Assignment(enter, hasGraphOutput);
		Succession(enter, exit);
	}

	private ControlOutput TriggerHasGraph(Flow flow)
	{
		flow.SetValue(hasGraphOutput, OutputHasGraph(flow));
		return exit;
	}

	private bool OutputHasGraph(Flow flow)
	{
		TMacro macro = flow.GetValue<TMacro>(graphInput);
		if (flow.GetValue(target, targetType) is GameObject gameObject)
		{
			if (gameObject != null)
			{
				TMachine[] components = gameObject.GetComponents<TMachine>();
				macro = flow.GetValue<TMacro>(graphInput);
				return components.Where((TMachine currentMachine) => currentMachine != null).Any((TMachine currentMachine) => currentMachine.graph != null && currentMachine.graph.Equals(macro.graph));
			}
		}
		else
		{
			TMachine value = flow.GetValue<TMachine>(target);
			if (value.graph != null && value.graph.Equals(macro.graph))
			{
				return true;
			}
		}
		return false;
	}
}
