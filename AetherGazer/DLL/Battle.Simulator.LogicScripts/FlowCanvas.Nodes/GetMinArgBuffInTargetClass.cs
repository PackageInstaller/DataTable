using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取这类buff参数最小的一个", 0)]
[Category("Logic/Buff")]
[Description("获取这类buff参数最小的一个")]
public class GetMinArgBuffInTargetClass : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("EntityID");
		ValueInput<int> buffClassInput = AddValueInput<int>("buff类型");
		ValueInput<int> argIndex = AddValueInput<int>("参数索引");
		ValueInput<bool> ignoreTragetBuffIDInput = AddValueInput<bool>("忽略指定id");
		ValueInput<int> buffIDInput = AddValueInput<int>("要忽略的Buff唯一ID");
		SimVar simVar = 0;
		int buffID = 0;
		AddValueOutput("值", () => simVar);
		AddValueOutput("BuffID", () => buffID);
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput cantFindOutput = AddFlowOutput("找不到");
		AddFlowInput("In", delegate(Flow f)
		{
			simVar = int.MaxValue;
			buffID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				cantFindOutput.Call(f);
			}
			else
			{
				bool value = ignoreTragetBuffIDInput.value;
				int value2 = buffIDInput.value;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && (!value || value2 != entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == buffClassInput.value)
					{
						int num = int.MinValue;
						switch (argIndex.value)
						{
						case 0:
							num = entityWithEntityID.entityBuff.mBuffParamsArray[i].v1;
							break;
						case 1:
							num = entityWithEntityID.entityBuff.mBuffParamsArray[i].v2;
							break;
						case 2:
							num = entityWithEntityID.entityBuff.mBuffParamsArray[i].v3;
							break;
						case 3:
							num = entityWithEntityID.entityBuff.mBuffParamsArray[i].v4;
							break;
						}
						if (num < (int)simVar)
						{
							simVar = num;
							buffID = entityWithEntityID.entityBuff.mBuffID[i];
						}
					}
				}
				if (simVar == int.MaxValue)
				{
					cantFindOutput.Call(f);
				}
				else
				{
					output.Call(f);
				}
			}
		});
	}
}
