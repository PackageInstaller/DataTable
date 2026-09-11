using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放出场中", 0)]
[Category("Logic/AI")]
[Description("播放出场中")]
public class AIPlayingAppear : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null)
			{
				f.Call(errorOut);
			}
			else if (!entityWithEntityID.hasEntityActionAbility)
			{
				f.Call(falseOut);
			}
			else if (ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID).Appear == entityWithEntityID.entityActionAbility.mAbilityID)
			{
				f.Call(trueOut);
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
