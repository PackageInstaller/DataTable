using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff参数(类型(处理逻辑)ID)", 0)]
[Category("Logic/Buff/通用")]
[Description("根据输入值，返回第一个得到的buff的4个参数")]
public class GetBuffParaInfo2 : FlowControlNode
{
	private int mOwnerID;

	private int mCasterID;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	private int mIndex = -1;

	protected override void RegisterPorts()
	{
		ValueInput<int> EntityIDInput = AddValueInput<int>("持有者实体ID", "entityID");
		ValueInput<int> classIDInput = AddValueInput<int>("类型(处理逻辑)ID", "classID");
		FlowOutput Output = AddFlowOutput("Out");
		FlowOutput DonHasOut = AddFlowOutput("不存在buff");
		FlowOutput ErrorOut = AddFlowOutput("Error");
		AddValueOutput("持有者实体ID", "实体ID", () => mOwnerID);
		AddValueOutput("释放者实体ID", "casterID", () => mCasterID);
		AddValueOutput("Buff参数1", () => mBuffParam1);
		AddValueOutput("Buff参数2", () => mBuffParam2);
		AddValueOutput("Buff参数3", () => mBuffParam3);
		AddValueOutput("Buff参数4", () => mBuffParam4);
		AddValueOutput("数组下标", "buffListIndex", () => mIndex);
		AddFlowInput("In", delegate(Flow f)
		{
			mOwnerID = EntityIDInput.value;
			mCasterID = 0;
			mBuffParam1 = default(SimVar);
			mBuffParam2 = default(SimVar);
			mBuffParam3 = default(SimVar);
			mBuffParam4 = default(SimVar);
			mIndex = -1;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(EntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				ErrorOut.Call(f);
			}
			else
			{
				int buffOfClassID = BuffProcessor.GetBuffOfClassID(entityWithEntityID, classIDInput.value);
				if (!entityWithEntityID.hasEntityBuff || buffOfClassID < 0 || buffOfClassID >= entityWithEntityID.entityBuff.mBuffID.Count)
				{
					DonHasOut.Call(f);
				}
				else
				{
					mCasterID = entityWithEntityID.entityBuff.mBuffCasterArray[buffOfClassID];
					mBuffParam1 = entityWithEntityID.entityBuff.mBuffParamsArray[buffOfClassID].v1;
					mBuffParam2 = entityWithEntityID.entityBuff.mBuffParamsArray[buffOfClassID].v2;
					mBuffParam3 = entityWithEntityID.entityBuff.mBuffParamsArray[buffOfClassID].v3;
					mBuffParam4 = entityWithEntityID.entityBuff.mBuffParamsArray[buffOfClassID].v4;
					mIndex = buffOfClassID;
					Output.Call(f);
				}
			}
		});
	}
}
