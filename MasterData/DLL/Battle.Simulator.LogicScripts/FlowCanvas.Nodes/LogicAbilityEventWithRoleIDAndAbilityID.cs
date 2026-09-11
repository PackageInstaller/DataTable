using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID&技能ID)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithRoleIDAndAbilityID : LogicAbilityEventBase
{
	private ValueInput<int> input;

	private ValueInput<int> mRoleID;

	protected override void AddCustomValueInput()
	{
		input = AddValueInput<int>("abilityID");
		mRoleID = AddValueInput<int>("实体类型ID", "角色ID");
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
			return input.value == abilityID;
		}
		return false;
	}
}
