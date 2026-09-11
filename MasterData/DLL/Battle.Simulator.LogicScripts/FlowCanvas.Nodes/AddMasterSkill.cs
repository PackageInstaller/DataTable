using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能添加组件", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能添加组件")]
public class AddMasterSkill : FlowNode
{
	public static void UpdateLogic(SimContext simContext, int entityID, int maxValue, int maxCD, int consumeValue, int consumeCD, int configID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && !entityWithEntityID.hasEntityMasterSkill)
		{
			entityWithEntityID.AddEntityMasterSkill(EntityActionStatus.None, 0, maxValue, maxCD, maxCD, consumeValue, consumeCD, configID);
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> cdInput = AddValueInput<int>("最大CD值");
		ValueInput<int> configIDInput = AddValueInput<int>("芯片ID", "configID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			UpdateLogic(base.graph.mSimContext, entityIDInput.value, 0, cdInput.value, 0, cdInput.value, configIDInput.value);
			f.Call(output);
		});
	}
}
