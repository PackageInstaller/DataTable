using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff参数(数组下标)", 0)]
[Category("Logic/Buff/通用")]
[Description("根据输入值，得到对应buff的4个参数")]
public class GetBuffParaInfo : FlowControlNode
{
	private int mOwnerID;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	protected override void RegisterPorts()
	{
		ValueInput<int> EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> indexInput = AddValueInput<int>("数组下标", "index");
		FlowOutput Output = AddFlowOutput("Out");
		FlowOutput DonHasOut = AddFlowOutput("不存在buff");
		FlowOutput ErrorOut = AddFlowOutput("Error");
		AddValueOutput("实体ID", () => mOwnerID);
		AddValueOutput("Buff参数1", () => mBuffParam1);
		AddValueOutput("Buff参数2", () => mBuffParam2);
		AddValueOutput("Buff参数3", () => mBuffParam3);
		AddValueOutput("Buff参数4", () => mBuffParam4);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(EntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				ErrorOut.Call(f);
			}
			else
			{
				int value = indexInput.value;
				if (!entityWithEntityID.hasEntityBuff || value < 0 || value >= entityWithEntityID.entityBuff.mBuffID.Count)
				{
					DonHasOut.Call(f);
				}
				else
				{
					mOwnerID = EntityIDInput.value;
					mBuffParam1 = entityWithEntityID.entityBuff.mBuffParamsArray[value].v1;
					mBuffParam2 = entityWithEntityID.entityBuff.mBuffParamsArray[value].v2;
					mBuffParam3 = entityWithEntityID.entityBuff.mBuffParamsArray[value].v3;
					mBuffParam4 = entityWithEntityID.entityBuff.mBuffParamsArray[value].v4;
					Output.Call(f);
				}
			}
		});
	}
}
