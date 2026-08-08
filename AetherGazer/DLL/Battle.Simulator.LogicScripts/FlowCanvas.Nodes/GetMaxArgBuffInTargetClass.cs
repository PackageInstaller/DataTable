using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取这类buff参数最大的一个", 0)]
[Category("Logic/Buff")]
[Description("获取这类buff参数最大的一个, 如果要忽略自身的话, 就要多传一个唯一id, 否则唯一id'不是必要的")]
public class GetMaxArgBuffInTargetClass : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffClassInput = AddValueInput<int>("BuffClassID");
		ValueInput<int> argIndexInput = AddValueInput<int>("参数索引");
		ValueInput<bool> ignoreTragetBuffIDInput = AddValueInput<bool>("忽略指定id");
		ValueInput<int> buffIDInput = AddValueInput<int>("要忽略的Buff唯一ID");
		int buffID = 0;
		AddValueOutput("结果buff的唯一id", () => buffID);
		int buffIndex = 0;
		AddValueOutput("结果buff的下标", () => buffIndex);
		SimVar simVar = 0;
		AddValueOutput("结果值", () => simVar.intVar);
		FlowOutput output = AddFlowOutput("");
		AddFlowOutput("NotFound");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			simVar = int.MinValue;
			buffID = 0;
			buffIndex = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = argIndexInput.value;
				bool value2 = ignoreTragetBuffIDInput.value;
				int value3 = buffIDInput.value;
				int value4 = buffClassInput.value;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && (!value2 || value3 != entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == value4)
					{
						int num = int.MinValue;
						switch (value)
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
						if (num > (int)simVar)
						{
							simVar = num;
							buffID = entityWithEntityID.entityBuff.mBuffID[i];
							buffIndex = i;
						}
					}
				}
				output.Call(f);
			}
		});
	}
}
