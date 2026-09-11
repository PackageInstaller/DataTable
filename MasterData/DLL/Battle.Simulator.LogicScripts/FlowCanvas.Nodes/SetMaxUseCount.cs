using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]修改CD最大使用次数", 0)]
[Category("Logic/Attribute")]
[Description("修改CD最大使用次数")]
public class SetMaxUseCount : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		ValueInput<int> countIDInput = AddValueInput<int>("次数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				CDProcessor.SetMaxUse(entityWithEntityID, abilityIDInput.value, countIDInput.value);
				output.Call(f);
			}
		});
	}
}
