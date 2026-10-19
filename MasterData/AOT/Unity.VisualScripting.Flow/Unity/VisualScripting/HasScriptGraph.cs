using JetBrains.Annotations;

namespace Unity.VisualScripting;

[UnitCategory("Graphs/Graph Nodes")]
[TypeIcon(typeof(FlowGraph))]
public sealed class HasScriptGraph : HasGraph<FlowGraph, ScriptGraphAsset, ScriptMachine>
{
	[UsedImplicitly]
	[UnitHeaderInspectable]
	[Serialize]
	[Inspectable]
	public ScriptGraphContainerType containerType { get; set; }

	protected override bool isGameObject => containerType == ScriptGraphContainerType.GameObject;
}
