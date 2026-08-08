using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff剩余时长(数组下标)(逻辑)", 0)]
[Category("Logic/Buff/通用")]
[Description("得到实体身上指定数组下表对应的buff剩余调用时长,由于一个类型的buff可能有多个,故而需要用list来存放")]
public class GetBuffClassRuntime2 : FlowControlNode
{
	private ValueInput<int> m_buffListIndex;

	private int m_cd;

	private int m_during;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "实体ID");
		m_buffListIndex = AddValueInput<int>("数组下标", "buffListIndex");
		AddFlowInput("In", delegate(Flow f)
		{
			m_cd = 0;
			m_during = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				output.Call(f);
			}
			else
			{
				if (m_buffListIndex.GetValue() >= entityWithEntityID.entityBuff.mBuffRuntime.Count)
				{
					abnormalOut.Call(f);
				}
				m_cd = entityWithEntityID.entityBuff.mBuffRuntime[m_buffListIndex.GetValue()];
				m_during = entityWithEntityID.entityBuff.mDuringArray[m_buffListIndex.GetValue()];
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "实体ID", () => entityIDVar.value);
		AddValueOutput("下次调用剩余时长", "tickRuntime", () => m_cd);
		AddValueOutput("总剩余时长", "during", () => m_during);
	}
}
