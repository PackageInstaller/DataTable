using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑曲线(Buff剩余运行时间)(逻辑)", 0)]
[Category("Logic/Config")]
[Description("将指定实体Buff的总运行剩余时间作为输入值，得到曲线内计算的直线插值。\n适用情况：值变换为超过2段的分段函数时。\n<color=red>注意，曲线随buff运行从右至左。</color>\n实体无buff、实体不存在、buff无法找到时输出Error与0\n不使用毫秒时，输入值为帧数")]
public class LogicInterpolatorDuringTime : LogicInterpolatorBase
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIndexInput = AddValueInput<int>("buff数组下标");
		ValueInput<bool> useTimeMSInput = AddValueInput<bool>("使用毫秒");
		int y = 0;
		AddValueOutput("y", () => y);
		AddFlowInput("", delegate(Flow f)
		{
			y = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int value = buffIndexInput.value;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff || entityWithEntityID.entityBuff.mDuringArray.Count <= value)
			{
				errorOutput.Call(f);
			}
			else
			{
				int num = entityWithEntityID.entityBuff.mDuringArray[value];
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
