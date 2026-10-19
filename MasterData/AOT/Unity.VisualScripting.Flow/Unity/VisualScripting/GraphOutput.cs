using System;
using System.Linq;

namespace Unity.VisualScripting;

[UnitTitle("Output")]
[UnitCategory("Nesting")]
[UnitOrder(2)]
public sealed class GraphOutput : Unit
{
	public override bool canDefine => graph != null;

	protected override void Definition()
	{
		isControlRoot = true;
		foreach (ControlOutputDefinition item in graph.validPortDefinitions.OfType<ControlOutputDefinition>())
		{
			string key = item.key;
			ControlInput(key, (Flow flow) =>
			{
				SubgraphUnit parent = flow.stack.GetParent<SubgraphUnit>();
				flow.stack.ExitParentElement();
				parent.EnsureDefined();
				return parent.controlOutputs[key];
			});
		}
		foreach (ValueOutputDefinition item2 in graph.validPortDefinitions.OfType<ValueOutputDefinition>())
		{
			string key2 = item2.key;
			Type type = item2.type;
			ValueInput(type, key2);
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
