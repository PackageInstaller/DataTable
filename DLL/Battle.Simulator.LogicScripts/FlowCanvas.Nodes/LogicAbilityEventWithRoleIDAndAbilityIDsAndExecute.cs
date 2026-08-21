using System.Collections.Generic;
using MessagePack;
using MessagePack.Formatters;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID&&技能ID组&&执行时间)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithRoleIDAndAbilityIDsAndExecute : LogicAbilityEventBase
{
	[Name("ID组(后三位)", 0)]
	public List<int> m_actionIDs = new List<int>();

	private ValueInput<int> mRoleID;

	private ValueInput<int> mExecuteIDInput;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<int>>().Serialize(ref writer, m_actionIDs, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		IMessagePackFormatter<List<int>> formatterWithVerify = options.Resolver.GetFormatterWithVerify<List<int>>();
		m_actionIDs = formatterWithVerify.Deserialize(ref reader, options);
	}

	protected override void AddCustomValueInput()
	{
		mRoleID = AddValueInput<int>("实体类型ID", "角色ID");
		mExecuteIDInput = AddValueInput<int>("执行时间(帧号)");
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		if (simEntity == null || !simEntity.hasEntityConfig)
		{
			return false;
		}
		int item = abilityID % 1000;
		int value = mExecuteIDInput.value;
		if (mRoleID.value == simEntity.entityConfig.mId && m_actionIDs.Contains(item))
		{
			return logicTime / CommonProcessor.GetConfigInterval() == value;
		}
		return false;
	}
}
