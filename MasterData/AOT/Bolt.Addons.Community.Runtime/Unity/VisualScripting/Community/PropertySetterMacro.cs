namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Code.PropertySetterMacro")]
public sealed class PropertySetterMacro : Macro<FlowGraph>
{
	public override FlowGraph DefaultGraph()
	{
		return new FlowGraph();
	}
}
