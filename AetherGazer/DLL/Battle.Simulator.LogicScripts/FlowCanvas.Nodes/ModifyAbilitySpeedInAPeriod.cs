using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改技能速度(持续调用)", 0)]
[Category("Logic/Abilities")]
[Description("修改技能速度, 在技能执行事件内每帧调用才行,大于等于起始帧时会把速度设为参数值,等于结束帧时会把速度设为100")]
public class ModifyAbilitySpeedInAPeriod : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> percentInput = AddValueInput<int>("速度百分比");
		ValueInput<int> startFrameInput = AddValueInput<int>("起始帧数");
		ValueInput<int> endFrameInput = AddValueInput<int>("结束帧数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityActionAbility)
			{
				int num = entityWithEntityID.entityActionAbility.mLogicTime / CommonProcessor.GetConfigInterval();
				if (num >= startFrameInput.value && num < endFrameInput.value && entityWithEntityID.entityActionAbility.mAbilitySpeed != percentInput.value)
				{
					entityWithEntityID.entityActionAbility.mAbilitySpeed = percentInput.value;
				}
				else if (num == endFrameInput.value)
				{
					entityWithEntityID.entityActionAbility.mAbilitySpeed = 100;
				}
			}
			output.Call(f);
		});
	}
}
