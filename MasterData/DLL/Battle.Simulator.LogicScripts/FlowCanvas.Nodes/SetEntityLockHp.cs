using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体锁血", 0)]
[Category("Logic/Attribute")]
[Description("设置实体锁血, 【目标血量千分比】默认为-1，此时锁血血量按不会低于1计算，否则按输入的值计算要锁的血量")]
public class SetEntityLockHp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<bool> lockHpInput = AddValueInput<bool>("锁血");
		ValueInput<int> targetHpPercentInput = AddValueInput<int>("目标血量千分比").SetDefaultAndSerializedValue(-1);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOutput.Call(f);
			}
			else
			{
				if (lockHpInput.value)
				{
					long num = entityWithEntityID.entityBlackboard.var.mMaxHP * targetHpPercentInput.value / 1000;
					if (num <= 0)
					{
						num = 1L;
					}
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2180, num, 0L, 0L);
				}
				else
				{
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2180, 0L, 0L, 0L);
				}
				output.Call(f);
			}
		});
	}
}
