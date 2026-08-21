using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID&时间)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件\n输入的时间会转换为帧数（33ms一帧），向下取整")]
public class LogicAbilityEventWithRoleIDAndTime : LogicAbilityEventBase
{
	private ValueInput<int> mRoleID;

	private ValueInput<int> executeTime;

	protected override void AddCustomValueInput()
	{
		mRoleID = AddValueInput<int>("实体类型ID", "角色ID");
		executeTime = AddValueInput<int>("executeTime");
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
		if (mRoleID.value == simEntity.entityConfig.mId)
		{
			return executeTime.value / CommonProcessor.GetConfigInterval() == logicTime / CommonProcessor.GetConfigInterval();
		}
		return false;
	}
}
