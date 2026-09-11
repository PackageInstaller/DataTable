using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("我要抛掷物(后三位)", 0)]
[Category("Logic/抛掷物/事件")]
[Description("创建抛掷物,【技能释放者】是玩家,【创建者】可能是抛掷物,【根源TimelineID】指的是源于哪个普攻技能")]
public class INeedSpawnThrownAbilitySuffix : FlowControlNode
{
	private FlowOutput output;

	private FlowOutput m_error;

	private ValueInput<int> m_casterIDVar;

	private ValueInput<int> m_thrownTimelineIDVar;

	private ValueInput<Int3> m_positionVar;

	private ValueInput<Int3> m_forwardVar;

	private ValueInput<bool> m_useCommonVar;

	private ValueInput<int> m_producerIDVar;

	private ValueInput<int> m_creatdRootTimelineIDVar;

	private ValueInput<int> m_attributeIDInput;

	private int m_thrownID;

	private int m_attributeID;

	protected override void RegisterPorts()
	{
		m_casterIDVar = AddValueInput<int>("技能释放者", "casterID");
		m_thrownTimelineIDVar = AddValueInput<int>("抛掷物(后三位)", "thrownTimelineID");
		m_positionVar = AddValueInput<Int3>("坐标", "position");
		m_forwardVar = AddValueInput<Int3>("朝向", "forward").SetDefaultAndSerializedValue(Int3.forward);
		m_useCommonVar = AddValueInput<bool>("通用处理", "useCommon").SetDefaultAndSerializedValue(v: true);
		m_producerIDVar = AddValueInput<int>("创建者", "producerID");
		m_creatdRootTimelineIDVar = AddValueInput<int>("根源TimelineID", "creatdRootTimelineID");
		m_attributeIDInput = AddValueInput<int>("属性ID", "attributeID");
		output = AddFlowOutput("Out", "Out");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "In", delegate(Flow f)
		{
			int thrownTimelineID = (base.mSimContext.GetEntityWithEntityID(m_casterIDVar.GetValue()).entityConfig.mConfig as RoleConfig).ID * 1000 + m_thrownTimelineIDVar.GetValue();
			m_attributeID = 0;
			if (!INeedSpawnThrown.TryGetAttributeID(base.mSimContext, m_attributeIDInput.GetValue(), m_producerIDVar.GetValue(), out m_attributeID))
			{
				m_error.Call(f);
			}
			else
			{
				m_thrownID = ThrownProcessor.SpawnThrown(base.mSimContext, m_casterIDVar.GetValue(), 0, 0, m_positionVar.GetValue(), m_forwardVar.GetValue(), thrownTimelineID, m_useCommonVar.GetValue(), m_producerIDVar.GetValue(), m_creatdRootTimelineIDVar.GetValue(), m_attributeID, out var _);
				f.Call(output);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
	}
}
