using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID)", 0)]
[Category("Logic/Abilities")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEventWithRoleID : LogicAbilityEventBase
{
	private FlowOutput logicTickEventOutput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<int> mRoleID;

	protected override void AddCustomValueInput()
	{
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
		return mRoleID.value == simEntity.entityConfig.mId;
	}
}
