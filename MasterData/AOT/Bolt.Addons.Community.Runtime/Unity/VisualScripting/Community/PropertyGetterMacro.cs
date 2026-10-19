namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Code.PropertyGetterMacro")]
public sealed class PropertyGetterMacro : Macro<FlowGraph>
{
	public override FlowGraph DefaultGraph()
	{
		return new FlowGraph();
	}
}
