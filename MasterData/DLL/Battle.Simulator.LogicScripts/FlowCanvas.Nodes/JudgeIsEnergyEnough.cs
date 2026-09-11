using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断机制值是否足够(已过时)", 0)]
[Category("Logic/Config")]
[Description("判断机制值是否足够")]
public class JudgeIsEnergyEnough : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID(后三位)");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput output = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.hasEntityBlackboard)
			{
				int id = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
				public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(id);
				int num = -config.EnergyChange;
				if (AttributeProcessor.GetPowerValue(entityID) >= num)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
			output.Call(f);
		});
	}
}
