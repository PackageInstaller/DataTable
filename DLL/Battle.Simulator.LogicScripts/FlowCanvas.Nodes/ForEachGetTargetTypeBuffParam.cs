using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理所有指定类型buff参数", 0)]
[Category("Logic/Buff")]
[Description("获取buff参数(ID), 下标从0开始")]
public class ForEachGetTargetTypeBuffParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		ValueInput<int> buffClassIDInput = AddValueInput<int>("类型(处理逻辑)ID", "BuffClassID");
		int buffID = 0;
		AddValueOutput("BuffID", () => buffID);
		int buffconfigID = 0;
		AddValueOutput("配置ID", () => buffconfigID);
		SimVar[] simVar = new SimVar[4];
		for (int num = 0; num < 4; num++)
		{
			int index = num;
			AddValueOutput("参数" + num, () => simVar[index]);
		}
		FlowOutput doOut = AddFlowOutput("do");
		FlowOutput doneOut = AddFlowOutput("done");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int value = buffClassIDInput.value;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffClassIDArray[i] == value)
					{
						BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[i];
						buffID = entityWithEntityID.entityBuff.mBuffID[i];
						buffconfigID = entityWithEntityID.entityBuff.mBuffConfigID[i];
						simVar[0] = buffParams.v1;
						simVar[1] = buffParams.v2;
						simVar[2] = buffParams.v3;
						simVar[3] = buffParams.v4;
						f.Call(doOut);
					}
				}
			}
			f.Call(doneOut);
		});
	}
}
