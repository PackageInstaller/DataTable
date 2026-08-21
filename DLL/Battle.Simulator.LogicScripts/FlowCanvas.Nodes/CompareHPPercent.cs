using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较当前血量百分比", 0)]
[Category("Logic/Attribute")]
[Description("输出流是有重复的，而且有等号和没等号的情况，使用时需要特别注意\n找不到实体或者实体最大血量为0的走Error")]
public class CompareHPPercent : FlowControlNode
{
	private int entityID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("entityID");
		ValueInput<int> percentInput = AddValueInput<int>("比较百分比", "percent");
		AddValueOutput("entityID", () => entityID);
		FlowOutput highOut = AddFlowOutput("高于(>)", "high");
		FlowOutput notLowOut = AddFlowOutput("不低于(>=)", "notLow");
		FlowOutput notHighOut = AddFlowOutput("不高于(<=)", "notHigh");
		FlowOutput lowOut = AddFlowOutput("低于(<)", "low");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("in", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				long mHP = entityWithEntityID.entityBlackboard.var.mHP;
				long mMaxHP = entityWithEntityID.entityBlackboard.var.mMaxHP;
				if (mMaxHP == 0L)
				{
					errorOut.Call(f);
				}
				else
				{
					long num = mMaxHP * percentInput.value;
					long num2 = mHP * 100;
					if (num == num2)
					{
						notLowOut.Call(f);
						notHighOut.Call(f);
					}
					else if (num2 > num)
					{
						highOut.Call(f);
						notLowOut.Call(f);
					}
					else
					{
						notHighOut.Call(f);
						lowOut.Call(f);
					}
				}
			}
		});
	}
}
