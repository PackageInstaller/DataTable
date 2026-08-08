using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能速度", 0)]
[Category("Logic/Abilities")]
[Description("获取当前正在执行的技能的执行速度,百分比")]
public class GetAbilitySpeed : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int res = 0;
		AddValueOutput("百分比", () => res);
		FlowOutput trueOut = AddFlowOutput("成功");
		FlowOutput falseOut = AddFlowOutput("失败");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				falseOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityActionAbility)
			{
				falseOut.Call(f);
			}
			else
			{
				res = entityWithEntityID.entityActionAbility.mAbilitySpeed;
				trueOut.Call(f);
			}
		});
	}
}
