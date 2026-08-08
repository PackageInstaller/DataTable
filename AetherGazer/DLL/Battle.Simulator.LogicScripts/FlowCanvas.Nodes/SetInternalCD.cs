using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置内置CD", 0)]
[Category("Logic/Buff")]
[Description("设置内置CD,本质使用的就是计时器,故而编号与计时器等价")]
public class SetInternalCD : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_keyInput;

	private ValueInput<int> m_keepTimeInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_keyInput = AddValueInput<int>("编号(=计时器编号)", "key");
		m_keepTimeInput = AddValueInput<int>("持续总长", "keepTime");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID == null)
			{
				m_error.Call(f);
			}
			else
			{
				if (!entityWithEntityID.hasEntityTimer)
				{
					entityWithEntityID.AddEntityTimer(FrameListPool<EntityTimerStruct>.Claim());
				}
				int num = -1;
				for (int i = 0; i < entityWithEntityID.entityTimer.entityTimers.Count; i++)
				{
					if (entityWithEntityID.entityTimer.entityTimers[i].name == m_keyInput.GetValue())
					{
						num = i;
						break;
					}
				}
				if (num != -1)
				{
					EntityTimerStruct value = entityWithEntityID.entityTimer.entityTimers[num];
					value.duringTime = m_keepTimeInput.GetValue();
					value.runningTime = int.MaxValue;
					value.intervalTime = int.MaxValue;
					entityWithEntityID.entityTimer.entityTimers[num] = value;
				}
				else
				{
					BuffProcessor.TryAddTimer(entityWithEntityID.creationIndex, m_keyInput.GetValue(), int.MaxValue, m_keepTimeInput.GetValue(), int.MaxValue);
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
