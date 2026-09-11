using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI模拟点击按钮", 0)]
[Category("Logic/AI")]
[Description("AI模拟点击按钮")]
public class AITouchButton : FlowNode
{
	private void RunMelee(SimEntity simEntity, bool mIsPressing, ButtonType buttonType)
	{
		if ((simEntity != null) & mIsPressing)
		{
			if (simEntity.hasEntityActionManualInput)
			{
				simEntity.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, (int)buttonType, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
			else
			{
				simEntity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, (int)buttonType, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
		}
		if (simEntity != null && simEntity.hasEntityActionAbility)
		{
			simEntity.entityActionAbility.mIsPressing = mIsPressing;
		}
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<ButtonType> buttonIDInput = AddValueInput<ButtonType>("按钮类型");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			AIProcessor.RunMelee(entityWithEntityID, mIsPressing: true, (int)buttonIDInput.value);
			AIProcessor.RunMelee(entityWithEntityID, mIsPressing: false, (int)buttonIDInput.value);
			output.Call(f);
		});
	}
}
