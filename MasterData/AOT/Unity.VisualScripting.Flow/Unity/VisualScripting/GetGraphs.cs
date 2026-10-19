using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Graphs/Graph Nodes")]
public abstract class GetGraphs<TGraph, TGraphAsset, TMachine> : Unit where TGraph : class, IGraph, new() where TGraphAsset : Macro<TGraph> where TMachine : Machine<TGraph, TGraphAsset>
{
	[DoNotSerialize]
	[PortLabelHidden]
	[NullMeansSelf]
	public ValueInput gameObject { get; protected set; }

	[PortLabelHidden]
	[DoNotSerialize]
	[PortLabel("Graphs")]
	public ValueOutput graphList { get; protected set; }

	protected override void Definition()
	{
		gameObject = ValueInput<GameObject>("gameObject", null).NullMeansSelf();
		graphList = ValueOutput("graphList", Get);
	}

	private List<TGraphAsset> Get(Flow flow)
	{
		GameObject go = flow.GetValue<GameObject>(gameObject);
		return (from machine in go.GetComponents<TMachine>()
			where go.GetComponent<TMachine>().nest.macro != null
			select machine.nest.macro).ToList();
	}
}
