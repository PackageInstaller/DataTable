using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建抛掷物实体", 0)]
[Category("Logic/抛掷物")]
[Description("发送创建抛掷物实体事件")]
public class SpawnThrown : FlowControlNode
{
	private ValueInput<int> m_casterIDInput;

	private ValueInput<Int3> m_positionInput;

	private ValueInput<Int3> m_forwardInput;

	private ValueInput<int> m_thrownTimelineIDInput;

	private ValueInput<int> m_producerIDInput;

	private ValueInput<int> m_createdRootTimelineID;

	private ValueInput<int> m_attributeIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private int m_thrownID;

	private int m_attributeID;

	protected override void RegisterPorts()
	{
		m_casterIDInput = AddValueInput<int>("释放者实体ID", "casterIDInput");
		m_positionInput = AddValueInput<Int3>("位置", "positionInput");
		m_forwardInput = AddValueInput<Int3>("朝向", "forwardInput").SetDefaultAndSerializedValue(Int3.forward);
		m_thrownTimelineIDInput = AddValueInput<int>("抛掷物TimelineID", "thrownTimelineIDInput");
		m_producerIDInput = AddValueInput<int>("创建者实体ID", "producerIDInput");
		m_createdRootTimelineID = AddValueInput<int>("根源TimelineID", "createdRootTimelineIDInput");
		m_attributeIDInput = AddValueInput<int>("黑板ID", "attributeID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_attributeID = 0;
			if (!INeedSpawnThrown.TryGetAttributeID(base.mSimContext, m_attributeIDInput.GetValue(), m_producerIDInput.GetValue(), out m_attributeID))
			{
				m_error.Call(f);
			}
			else
			{
				m_thrownID = ThrownProcessor.SpawnThrown(base.mSimContext, m_casterIDInput.GetValue(), 0, 0, m_positionInput.GetValue(), m_forwardInput.GetValue(), m_thrownTimelineIDInput.GetValue(), useCommon: true, m_producerIDInput.GetValue(), m_createdRootTimelineID.GetValue(), m_attributeIDInput.GetValue(), out var _);
				m_out.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
	}
}
