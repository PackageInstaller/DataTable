using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加连击数", 0)]
[Category("Logic/Abilities")]
[Description("添加连击数")]
public class AddCombo : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				if (entityWithEntityID.hasEntityComboNumber)
				{
					entityWithEntityID.entityComboNumber.comboCount++;
					entityWithEntityID.entityComboNumber.runningTime = 0;
				}
				else
				{
					entityWithEntityID.AddEntityComboNumber(1, 0);
				}
				output.Call(f);
			}
		});
	}
}
