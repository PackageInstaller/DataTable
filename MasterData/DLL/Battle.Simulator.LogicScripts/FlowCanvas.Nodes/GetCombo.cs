using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取连击数", 0)]
[Category("Logic/Abilities")]
[Description("获取连击数")]
public class GetCombo : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int res = 0;
		AddValueOutput("连击数", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("实体 为空");
			}
			else
			{
				if (entityWithEntityID.hasEntityComboNumber)
				{
					res = entityWithEntityID.entityComboNumber.comboCount;
				}
				else
				{
					res = 0;
				}
				output.Call(f);
			}
		});
	}
}
