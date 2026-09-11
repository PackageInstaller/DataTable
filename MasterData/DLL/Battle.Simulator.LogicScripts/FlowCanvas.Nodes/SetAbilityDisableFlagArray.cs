using System.Collections.Generic;
using MessagePack;
using MessagePack.Formatters;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用或关闭技能(组)(标志位)", 0)]
[Category("Logic/Abilities")]
[Description("需要自行定义每个标志位的意义, 非计数")]
public class SetAbilityDisableFlagArray : FlowControlNodeOfLogic
{
	[Name("TimelineID", 0)]
	public List<int> m_timelineIDs = new List<int>();

	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _indexInput;

	private ValueInput<bool> _enableInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<int>>().Serialize(ref writer, m_timelineIDs, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<List<int>> formatterWithVerify = options.Resolver.GetFormatterWithVerify<List<int>>();
		m_timelineIDs = formatterWithVerify.Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_indexInput = AddValueInput<int>("标志位(0-31)", "index");
		_enableInput = AddValueInput<bool>("启用", "disable");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				_errorOut.Call(f);
			}
			else if (_indexInput.value < 0 || _indexInput.value > 31)
			{
				_errorOut.Call(f);
			}
			else
			{
				for (int i = 0; i < m_timelineIDs.Count; i++)
				{
					entityWithEntityID.entityBlackboard.var.SetAbilityDisableFlag(m_timelineIDs[i], _indexInput.value, !_enableInput.value);
				}
				_output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
	}
}
