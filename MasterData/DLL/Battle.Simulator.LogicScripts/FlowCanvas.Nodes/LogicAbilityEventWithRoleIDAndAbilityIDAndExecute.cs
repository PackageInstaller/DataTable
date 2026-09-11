using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID&&技能ID&&执行时间)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithRoleIDAndAbilityIDAndExecute : LogicAbilityEventBase
{
	private ValueInput<int> mRoleID;

	private ValueInput<int> mAbilityIDInput;

	private ValueInput<int> mExecuteIDInput;

	protected override void AddCustomValueInput()
	{
		mRoleID = AddValueInput<int>("实体类型ID", "角色ID");
		mAbilityIDInput = AddValueInput<int>("技能ID（后三位）");
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
		int num = abilityID % 1000;
		int value = mExecuteIDInput.value;
		if (mRoleID.value == simEntity.entityConfig.mId && mAbilityIDInput.value == num)
		{
			return logicTime / CommonProcessor.GetConfigInterval() == value;
		}
		return false;
	}
}
