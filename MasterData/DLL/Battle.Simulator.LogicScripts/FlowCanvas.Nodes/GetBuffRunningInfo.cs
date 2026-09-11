using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff运行信息", 0)]
[Category("Logic/Buff/通用")]
[Description("根据输入值，得到对应buff的运行时间信息")]
public class GetBuffRunningInfo : FlowControlNode
{
	private int m_entityID;

	private int m_runTime;

	private int m_during;

	private int m_tick;

	private int m_keepTime;

	private int m_level;

	protected override void RegisterPorts()
	{
		ValueInput<int> EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> indexInput = AddValueInput<int>("数组下标", "index");
		FlowOutput Output = AddFlowOutput("Out");
		FlowOutput DonHasOut = AddFlowOutput("不存在Buff");
		FlowOutput ErrorOut = AddFlowOutput("Error");
		AddValueOutput("实体ID", () => m_entityID);
		AddValueOutput("下次触发剩余时长", () => m_runTime);
		AddValueOutput("总剩余时长", () => m_during);
		AddValueOutput("触发间隔", () => m_tick);
		AddValueOutput("总时长", () => m_keepTime);
		AddValueOutput("Buff等级", () => m_level);
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
					m_entityID = EntityIDInput.value;
					m_runTime = entityWithEntityID.entityBuff.mBuffRuntime[value];
					m_during = entityWithEntityID.entityBuff.mDuringArray[value];
					m_tick = entityWithEntityID.entityBuff.mTickArray[value];
					m_keepTime = entityWithEntityID.entityBuff.mBuffKeepTimeArray[value];
					m_level = entityWithEntityID.entityBuff.mBuffFloor[value];
					Output.Call(f);
				}
			}
		});
	}
}
