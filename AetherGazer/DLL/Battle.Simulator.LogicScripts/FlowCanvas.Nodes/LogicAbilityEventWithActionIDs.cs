using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(ID组(后三位))(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithActionIDs : LogicAbilityEventBase
{
	[Name("ID组(后三位)", 0)]
	public List<int> m_actionIDs = new List<int>();

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
	}

	protected override void AddCustionValueOutput()
	{
		AddValueOutput("实体ID(过时)", "entityID", () => m_entityID);
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (!m_actionIDs.Contains(actionID))
		{
			return false;
		}
		if (simEntity == null || !simEntity.hasEntityConfig)
		{
			return false;
		}
		return true;
	}
}
