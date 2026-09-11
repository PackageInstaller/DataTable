using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置转身速度(配置)(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("根据配置设置转身速度, 单位为每秒x度")]
public class SetRotationSpeedAccordingToConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.hasEntityBlackboard)
			{
				RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId);
				entityWithEntityID.entityBlackboard.var.mDeltaRotationSpeed = config.RotationSpeed;
			}
			output.Call(f);
		});
	}
}
