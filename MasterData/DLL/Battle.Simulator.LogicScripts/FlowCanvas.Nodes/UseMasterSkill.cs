using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("芯片技能释放判断", 0)]
[Category("Logic/芯片技能")]
[Description("芯片技能释放判断,这里仅做判断，通知执行使用【通知芯片技能执行】节点")]
public class UseMasterSkill : FlowNode
{
	public static bool UpdateLogic(SimContext simContext, int entityID, int configID)
	{
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (!entityWithEntityID.hasEntityMasterSkill)
		{
			return false;
		}
		EntityMasterSkill entityMasterSkill = entityWithEntityID.entityMasterSkill;
		if (configID != 0 && configID != entityMasterSkill.mConfigID)
		{
			return false;
		}
		if (entityMasterSkill.mCD <= 0 && entityMasterSkill.mState == EntityActionStatus.E_ACTIVE)
		{
			return true;
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> configIDInput = AddValueInput<int>("指定芯片ID", "限定ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("释放成功");
		FlowOutput outputFalse = AddFlowOutput("释放失败");
		AddFlowInput("", delegate(Flow f)
		{
			if (UpdateLogic(base.graph.mSimContext, entityIDInput.value, configIDInput.value))
			{
				f.Call(output);
			}
			else
			{
				f.Call(outputFalse);
			}
		});
	}
}
