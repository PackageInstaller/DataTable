using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Graphs/Graph Nodes")]
public abstract class GetGraph<TGraph, TGraphAsset, TMachine> : Unit where TGraph : class, IGraph, new() where TGraphAsset : Macro<TGraph> where TMachine : Machine<TGraph, TGraphAsset>
{
	[DoNotSerialize]
	[PortLabelHidden]
	[NullMeansSelf]
	public ValueInput gameObject { get; protected set; }

	[DoNotSerialize]
	[PortLabel("Graph")]
	[PortLabelHidden]
	public ValueOutput graphOutput { get; protected set; }

	protected override void Definition()
	{
		gameObject = ValueInput<GameObject>("gameObject", null).NullMeansSelf();
		graphOutput = ValueOutput("graphOutput", Get);
	}

	private TGraphAsset Get(Flow flow)
	{
		return flow.GetValue<GameObject>(gameObject).GetComponent<TMachine>().nest.macro;
	}
}
