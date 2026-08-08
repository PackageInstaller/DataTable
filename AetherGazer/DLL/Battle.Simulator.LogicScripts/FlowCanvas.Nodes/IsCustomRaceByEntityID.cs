using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否是指定神系(实体ID)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("判断实体是否是指定神系")]
public class IsCustomRaceByEntityID : FlowControlNodeOfLogic
{
	private int _raceID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<RaceType> raceEnumInput = AddValueInput<RaceType>("神系", "raceID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_raceID = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				int id = entityWithEntityID.ENTITY_CONFIG_ID;
				if (!ConfigHelper.GetInstance().TryGetConfig<charactor_param>(id, out var config))
				{
					errorOut.Call(f);
				}
				else
				{
					_raceID = config.RaceID;
					if (config.RaceID == (int)raceEnumInput.value)
					{
						trueOut.Call(f);
					}
					else
					{
						falseOut.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("实体神系ID", "entityRaceID", () => _raceID);
	}
}
