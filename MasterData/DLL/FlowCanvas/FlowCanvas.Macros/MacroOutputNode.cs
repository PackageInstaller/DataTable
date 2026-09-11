using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Macros;

[DoNotList]
[Icon("MacroOut", false, "")]
[Description("Defines the Output ports of the Macro.\nTo quickly create ports, you can also Drag&Drop a connection on top of this node!")]
[ProtectedSingleton]
public class MacroOutputNode : FlowNode
{
	public override Alignment2x2 iconAlignment => Alignment2x2.Default;

	private Macro macro => base.graph as Macro;

	protected override void RegisterPorts()
	{
		if (macro == null)
		{
			return;
		}
		for (int i = 0; i < macro.outputDefinitions.Count; i++)
		{
			DynamicPortDefinition def = macro.outputDefinitions[i];
			if (def.type == typeof(Flow))
			{
				AddFlowInput(def.name, delegate(Flow f)
				{
					macro.exitActionMap[def.ID](f);
				}, def.ID);
			}
			else
			{
				macro.exitFunctionMap[def.ID] = AddValueInput(def.name, def.type, def.ID).GetObjectValue;
			}
		}
	}
}
