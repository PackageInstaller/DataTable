using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改移动槽", 0)]
[Category("Logic/Abilities")]
[Description("修改移动槽, 其实刹车算是技能,替换同时会拷贝技能可用性, 填0的话, 就不替换. 或者可以填原本的值, 如果你知道的话")]
public class ModifyMoveSlots : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> runStartIDInput = AddValueInput<int>("起跑ID");
		ValueInput<int> nearStopIDInput = AddValueInput<int>("小刹车ID");
		ValueInput<int> rushIDInput = AddValueInput<int>("冲刺ID");
		ValueInput<int> rushStopIDInput = AddValueInput<int>("冲刺刹车ID");
		ValueInput<int> runIDInput = AddValueInput<int>("跑步ID");
		ValueInput<int> stopIDInput = AddValueInput<int>("刹车ID");
		ValueInput<int> battleIDRecoverIDInput = AddValueInput<int>("战斗待机恢复ID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = runStartIDInput.value;
				if (value != 0)
				{
					entityWithEntityID.entityBlackboard.var.mRunStartSlot = value;
				}
				int value2 = nearStopIDInput.value;
				if (value2 != 0)
				{
					if (entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(entityWithEntityID.entityBlackboard.var.mNearStopSlot, out var value3))
					{
						entityWithEntityID.entityBlackboard.var.mAbilityEnable[value2] = value3;
					}
					entityWithEntityID.entityBlackboard.var.mNearStopSlot = value2;
				}
				int value4 = rushIDInput.value;
				if (value4 != 0)
				{
					entityWithEntityID.entityBlackboard.var.mRushIDSlot = value4;
				}
				int value5 = rushStopIDInput.value;
				if (value5 != 0)
				{
					if (entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(entityWithEntityID.entityBlackboard.var.mRushStopIDSlot, out var value6))
					{
						entityWithEntityID.entityBlackboard.var.mAbilityEnable[value5] = value6;
					}
					entityWithEntityID.entityBlackboard.var.mRushStopIDSlot = value5;
				}
				int value7 = runIDInput.value;
				if (value7 != 0)
				{
					entityWithEntityID.entityBlackboard.var.mRunSlot = value7;
				}
				int value8 = stopIDInput.value;
				if (value8 != 0)
				{
					if (entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(entityWithEntityID.entityBlackboard.var.mMovementStopSlot, out var value9))
					{
						entityWithEntityID.entityBlackboard.var.mAbilityEnable[value8] = value9;
					}
					entityWithEntityID.entityBlackboard.var.mMovementStopSlot = value8;
				}
				int value10 = battleIDRecoverIDInput.value;
				if (value10 != 0)
				{
					if (entityWithEntityID.entityBlackboard.var.mAbilityEnable.TryGetValue(entityWithEntityID.entityBlackboard.var.mBattleIldeRecoverSlot, out var value11))
					{
						entityWithEntityID.entityBlackboard.var.mAbilityEnable[value10] = value11;
					}
					entityWithEntityID.entityBlackboard.var.mBattleIldeRecoverSlot = value10;
				}
				output.Call(f);
			}
		});
	}
}
