using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取机制值类型", 0)]
[Category("Logic/Config")]
[Description("获取机制值类型")]
public class GetEnergyTypeByEntityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		int energyType = 0;
		AddValueOutput("类型", () => energyType);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.hasEntityBlackboard)
			{
				charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
				energyType = config.EnergyType;
			}
			output.Call(f);
		});
	}
}
