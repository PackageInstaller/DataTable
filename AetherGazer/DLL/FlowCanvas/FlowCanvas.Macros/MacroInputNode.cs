using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Macros;

[DoNotList]
[Icon("MacroIn", false, "")]
[Description("Defines the Input ports of the Macro.\nTo quickly create ports, you can also Drag&Drop a connection on top of this node!")]
[ProtectedSingleton]
public class MacroInputNode : FlowNode
{
	public override Alignment2x2 iconAlignment => Alignment2x2.Default;

	private Macro macro => base.graph as Macro;

	protected override void RegisterPorts()
	{
		if (macro == null)
		{
			return;
		}
		for (int i = 0; i < macro.inputDefinitions.Count; i++)
		{
			DynamicPortDefinition def = macro.inputDefinitions[i];
			if (def.type == typeof(Flow))
			{
				macro.entryActionMap[def.ID] = AddFlowOutput(def.name, def.ID).Call;
				continue;
			}
			AddValueOutput(def.name, def.type, () => macro.entryFunctionMap[def.ID](), def.ID);
		}
	}
}
