using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能是否施放结束", 0)]
[Category("Logic/Abilities")]
[Description("检查技能是否施放结束, 如果实体为空或者没有技能,或者没配置, 走true\n判断指定ID的实体当前正在执行的ability的时间是不是大于等于总时间\nsimEntityID : 要判断的实体的ID\n")]
public class AbilityIsOverWithCallback : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				trueOut.Call(f);
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (config != null && entityWithEntityID.entityActionAbility.mLogicTime >= config.Duration)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
