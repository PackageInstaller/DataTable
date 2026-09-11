using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有Buff(配置ID)", 0)]
[Category("Logic/Buff")]
[Description("指定BuffID是否存在;Buff表ID 对应的是 public_buff 中的 ID\n实体死掉的话, 走error")]
public class HasTargetConfigIDBuff : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("持有者实体ID", "实体ID");
		AddValueOutput("持有者实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffIDInput = AddValueInput<int>("配置ID", "BuffID");
		int casterID = 0;
		AddValueOutput("释放者实体ID", "添加者ID", () => casterID);
		int buffListIndex = -1;
		AddValueOutput("数组下标", "buffListIndex", () => buffListIndex);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			buffListIndex = -1;
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else if (entityWithEntityID.hasEntityBuff)
			{
				int buffConfigIDIndex = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(buffIDInput.value);
				if (buffConfigIDIndex == -1)
				{
					falseOut.Call(f);
				}
				else
				{
					buffListIndex = buffConfigIDIndex;
					casterID = entityWithEntityID.entityBuff.mBuffCasterArray[buffConfigIDIndex];
					trueOut.Call(f);
				}
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
