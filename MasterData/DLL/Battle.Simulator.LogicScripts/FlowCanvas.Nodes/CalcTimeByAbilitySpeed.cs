using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据技能速度计算时长", 0)]
[Category("Logic/Abilities")]
[Description("根据技能速度计算时间, 实体为空或者没有技能的话, 会走失败并返回基础时长")]
public class CalcTimeByAbilitySpeed : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> baseTimeInput = AddValueInput<int>("基础时长");
		FlowOutput trueOut = AddFlowOutput("成功");
		FlowOutput falseOut = AddFlowOutput("失败");
		int res = 0;
		AddValueOutput("结果", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			res = baseTimeInput.value;
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
				res = res * 100 / (100 + entityWithEntityID.entityActionAbility.mAbilitySpeed);
				trueOut.Call(f);
			}
		});
	}
}
