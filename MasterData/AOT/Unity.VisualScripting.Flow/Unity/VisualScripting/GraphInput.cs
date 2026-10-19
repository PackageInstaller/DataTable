using System;
using System.Linq;

namespace Unity.VisualScripting;

[UnitOrder(1)]
[UnitTitle("Input")]
[UnitCategory("Nesting")]
public sealed class GraphInput : Unit
{
	public override bool canDefine => graph != null;

	protected override void Definition()
	{
		isControlRoot = true;
		foreach (ControlInputDefinition item in graph.validPortDefinitions.OfType<ControlInputDefinition>())
		{
			ControlOutput(item.key);
		}
		foreach (ValueInputDefinition item2 in graph.validPortDefinitions.OfType<ValueInputDefinition>())
		{
			string key = item2.key;
			Type type = item2.type;
			ValueOutput(type, key, (Flow flow) =>
			{
				SubgraphUnit parent = flow.stack.GetParent<SubgraphUnit>();
				if (flow.enableDebug)
				{
					IUnitDebugData elementDebugData = flow.stack.GetElementDebugData<IUnitDebugData>(parent);
					elementDebugData.lastInvokeFrame = EditorTimeBinding.frame;
					elementDebugData.lastInvokeTime = EditorTimeBinding.time;
				}
				flow.stack.ExitParentElement();
				parent.EnsureDefined();
				object value = flow.GetValue(parent.valueInputs[key], type);
				flow.stack.EnterParentElement(parent);
				return value;
			});
		}
	}

	protected override void AfterDefine()
	{
		graph.onPortDefinitionsChanged += Define;
	}

	protected override void BeforeUndefine()
	{
		graph.onPortDefinitionsChanged -= Define;
	}
}
