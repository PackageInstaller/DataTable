using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(ID组(后三位)&时间(帧))(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithActionIDsAndFrame : LogicAbilityEventBase
{
	[Name("ID组(后三位)", 0)]
	public List<int> m_actionIDs = new List<int>();

	private ValueInput<int> m_executeFrameInput;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<int>>().Serialize(ref writer, m_actionIDs, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		m_actionIDs = options.Resolver.GetFormatterWithVerify<List<int>>().Deserialize(ref reader, options);
	}

	protected override void AddCustomValueInput()
	{
		m_executeFrameInput = AddValueInput<int>("时间(帧)", "executeFrame");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (!m_actionIDs.Contains(m_actionID))
		{
			return false;
		}
		if (simEntity == null || !simEntity.hasEntityConfig)
		{
			return false;
		}
		return logicTime / CommonProcessor.GetConfigInterval() == m_executeFrameInput.GetValue();
	}
}
