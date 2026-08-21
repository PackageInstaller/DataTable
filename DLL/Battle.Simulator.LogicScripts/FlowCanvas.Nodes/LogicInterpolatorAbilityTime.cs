using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑曲线(实体动作时间)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("将实体当前动作时间作为输入值，得到曲线内计算的直线插值。\n适用情况：值变换为超过2段的分段函数时。\n实体无动作或不存在时输出Error与0\n不使用毫秒时，输入值为帧数")]
public class LogicInterpolatorAbilityTime : LogicInterpolatorBase
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<bool> useTimeMSInput = AddValueInput<bool>("使用毫秒");
		int y = 0;
		AddValueOutput("y", () => y);
		AddFlowInput("", delegate(Flow f)
		{
			y = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityActionAbility)
			{
				errorOutput.Call(f);
			}
			else
			{
				int num = entityWithEntityID.entityActionAbility.mLogicTime;
				if (!useTimeMSInput.value)
				{
					num /= CommonProcessor.GetConfigInterval();
				}
				y = intCurve.Evaluate(num);
				output.Call(f);
			}
		});
	}
}
