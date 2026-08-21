using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要抛掷物(释放者位置)", 0)]
[Category("Logic/抛掷物/事件")]
[Description("创建抛掷物,【技能释放者】是玩家,【创建者】可能是抛掷物,【根源TimelineID】指的是源于哪个普攻技能")]
public class INeedSpawnThrown2 : FlowControlNode
{
	private FlowOutput output;

	private FlowOutput abnormal;

	private ValueInput<int> m_casterIDVar;

	private ValueInput<int> m_thrownTimelineIDVar;

	private ValueInput<bool> m_useCommonVar;

	private ValueInput<int> m_producerIDVar;

	private ValueInput<int> m_creatdRootTimelineIDVar;

	private ValueInput<int> m_attributeIDInput;

	private Int3 m_position = Int3.zero;

	private Int3 m_forward = Int3.forward;

	private int m_attributeID;

	private int m_thrownID;

	protected override void RegisterPorts()
	{
		m_casterIDVar = AddValueInput<int>("技能释放者", "casterID");
		m_thrownTimelineIDVar = AddValueInput<int>("抛掷物TimelineID", "thrownTimelineID");
		m_useCommonVar = AddValueInput<bool>("通用处理", "useCommon").SetDefaultAndSerializedValue(v: true);
		m_producerIDVar = AddValueInput<int>("创建者", "producerID");
		m_creatdRootTimelineIDVar = AddValueInput<int>("根源TimelineID", "creatdRootTimelineID");
		m_attributeIDInput = AddValueInput<int>("黑板ID", "attribute");
		output = AddFlowOutput("Out", "Out");
		abnormal = AddFlowOutput("异常", "abnormal");
		AddFlowInput("In", "In", delegate(Flow f)
		{
			if (m_casterIDVar.GetValue() > 0)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(m_casterIDVar.GetValue());
				if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon)
				{
					abnormal.Call(f);
				}
				else
				{
					m_position = entityWithEntityID.entityPositon.mPosition;
					m_forward = entityWithEntityID.entityPositon.mForward;
					m_attributeID = 0;
					if (!INeedSpawnThrown.TryGetAttributeID(base.mSimContext, m_attributeIDInput.GetValue(), m_producerIDVar.GetValue(), out m_attributeID))
					{
						abnormal.Call(f);
					}
					else
					{
						m_thrownID = ThrownProcessor.SpawnThrown(base.mSimContext, m_casterIDVar.GetValue(), 0, 0, m_position, m_forward, m_thrownTimelineIDVar.GetValue(), m_useCommonVar.GetValue(), m_producerIDVar.GetValue(), m_creatdRootTimelineIDVar.GetValue(), m_attributeID, out var _);
						output.Call(f);
					}
				}
			}
			else
			{
				abnormal.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
	}
}
