using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要抛掷物(指定目标)", 0)]
[Category("Logic/抛掷物/事件")]
[Description("创建抛掷物,【技能释放者】是玩家,【创建者】可能是抛掷物,【根源TimelineID】指的是源于哪个普攻技能;\n创建的位置是目标位置;\n朝向是创建者指向目标;")]
public class INeedSpawnThrown4 : FlowControlNode
{
	private FlowOutput m_succeed;

	private FlowOutput m_failed;

	private ValueInput<int> m_casterIDVar;

	private ValueInput<int> m_thrownTimelineIDVar;

	private ValueInput<bool> m_useCommonVar;

	private ValueInput<int> m_producerIDVar;

	private ValueInput<int> m_creatdRootTimelineIDVar;

	private ValueInput<int> m_targetIDVar;

	private ValueInput<int> m_attributeIDInput;

	private int m_thrownID;

	private int m_attributeID;

	protected override void RegisterPorts()
	{
		m_casterIDVar = AddValueInput<int>("技能释放者", "casterID");
		m_thrownTimelineIDVar = AddValueInput<int>("抛掷物TimelineID", "thrownTimelineID");
		m_useCommonVar = AddValueInput<bool>("通用处理", "useCommon").SetDefaultAndSerializedValue(v: true);
		m_producerIDVar = AddValueInput<int>("创建者", "producerID");
		m_creatdRootTimelineIDVar = AddValueInput<int>("根源TimelineID", "creatdRootTimelineID");
		m_targetIDVar = AddValueInput<int>("目标ID", "targetID").SetDefaultAndSerializedValue(0);
		m_attributeIDInput = AddValueInput<int>("黑板ID", "attributeID");
		m_succeed = AddFlowOutput("Succeed", "succeed");
		m_failed = AddFlowOutput("Failed", "failed");
		AddFlowInput("In", "In", delegate(Flow f)
		{
			SimEntity simEntity = null;
			Int3 position;
			Int3 forward;
			Int3 position2;
			Int3 forward2;
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_targetIDVar.GetValue(), out simEntity))
			{
				m_failed.Call(f);
			}
			else if (!CommonProcessor.TryGetPosition(base.mSimContext, m_producerIDVar.GetValue(), out position, out forward))
			{
				m_failed.Call(f);
			}
			else if (!CommonProcessor.TryGetPosition(base.mSimContext, m_targetIDVar.GetValue(), out position2, out forward2))
			{
				m_failed.Call(f);
			}
			else
			{
				Int3 @int = (position2 - position).NormalizeTo(1000);
				if (@int == Int3.zero)
				{
					@int = Int3.forward;
				}
				m_attributeID = 0;
				if (!INeedSpawnThrown.TryGetAttributeID(base.mSimContext, m_attributeIDInput.GetValue(), m_producerIDVar.GetValue(), out m_attributeID))
				{
					m_failed.Call(f);
				}
				else
				{
					m_thrownID = ThrownProcessor.SpawnThrown(base.mSimContext, m_casterIDVar.GetValue(), 0, 0, position2, @int, m_thrownTimelineIDVar.GetValue(), m_useCommonVar.GetValue(), m_producerIDVar.GetValue(), m_creatdRootTimelineIDVar.GetValue(), m_attributeID, out var thrownState);
					if (thrownState != null)
					{
						thrownState.mTargetID = m_targetIDVar.value;
					}
					m_succeed.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
	}
}
