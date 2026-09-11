using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连击计时", 0)]
[Category("Logic/Abilities")]
[Description("连击计时")]
public class ComboUpdate : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> maxTimeInput = AddValueInput<int>("连击重置时间");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			entityWithEntityID.entityComboNumber.runningTime += CommonProcessor.GetLogicConstTick();
			if (entityWithEntityID.entityComboNumber.runningTime > maxTimeInput.value)
			{
				entityWithEntityID.entityComboNumber.runningTime = 0;
				entityWithEntityID.entityComboNumber.comboCount = 0;
			}
			output.Call(f);
		});
	}
}
