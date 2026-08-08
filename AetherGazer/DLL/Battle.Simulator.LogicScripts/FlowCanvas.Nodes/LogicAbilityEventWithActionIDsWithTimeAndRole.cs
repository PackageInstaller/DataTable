using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(ID组,时间,实体类型)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithActionIDsWithTimeAndRole : LogicAbilityEventBase
{
	[Name("ID组(后三位)", 0)]
	public List<int> m_actionIDs = new List<int>();

	private ValueInput<int> _roleIDInput;

	private ValueInput<int> _executeTimeInput;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		m_actionIDs = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, m_actionIDs, options);
	}

	protected override void AddCustomValueInput()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		_executeTimeInput = AddValueInput<int>("执行时间(帧号)");
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
		if (!simEntity.hasEntityActionAbility)
		{
			return false;
		}
		if ((simEntity.entityConfig.mConfig as RoleConfig).ID == _roleIDInput.value)
		{
			return logicTime / CommonProcessor.GetConfigInterval() == _executeTimeInput.value;
		}
		return false;
	}
}
