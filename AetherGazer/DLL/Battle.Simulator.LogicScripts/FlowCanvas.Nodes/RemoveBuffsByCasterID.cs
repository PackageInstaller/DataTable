using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff(释放者实体ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("移除【实体ID】身上由【释放者实体ID】释放的Buff")]
public class RemoveBuffsByCasterID : FlowControlNode
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<int> m_casterIDInput;

	private ValueInput<int> m_buffClassIDInput;

	private FlowOutput m_out;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_casterIDInput = AddValueInput<int>("释放者实体ID", "casterID");
		m_buffClassIDInput = AddValueInput<int>("类型(处理逻辑)ID(可选)", "buffClassID");
		m_out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_entityIDInput.GetValue());
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				EntityBuff entityBuff = entityWithEntityID.entityBuff;
				int value = m_casterIDInput.GetValue();
				for (int i = 0; i < entityBuff.mBuffCasterArray.Count; i++)
				{
					if (entityBuff.mBuffCasterArray[i] == value)
					{
						int value2 = m_buffClassIDInput.GetValue();
						if (value2 != 0)
						{
							if (entityBuff.mBuffClassIDArray[i] == value2)
							{
								BuffProcessor.RemoveBuffByListIndex(entityWithEntityID, i);
							}
						}
						else
						{
							BuffProcessor.RemoveBuffByListIndex(entityWithEntityID, i);
						}
					}
				}
			}
			m_out.Call(f);
		});
	}
}
