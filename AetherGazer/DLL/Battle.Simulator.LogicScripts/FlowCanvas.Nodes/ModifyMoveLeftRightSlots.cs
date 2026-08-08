using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改左右移动槽", 0)]
[Category("Logic/Abilities")]
[Description("修改左右移动槽, 一般左右移动用与AI执行对峙, 填0的话, 就不替换. 或者可以填原本的值, 如果你知道的话")]
public class ModifyMoveLeftRightSlots : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> runLeftIDInput = AddValueInput<int>("左移动ID");
		ValueInput<int> runRightIDInput = AddValueInput<int>("右移动ID");
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
				int value = runLeftIDInput.value;
				if (value != 0)
				{
					entityWithEntityID.entityBlackboard.var.mRunLeftIDSlot = value;
				}
				int value2 = runRightIDInput.value;
				if (value2 != 0)
				{
					entityWithEntityID.entityBlackboard.var.mRunRightIDSlot = value2;
				}
				output.Call(f);
			}
		});
	}
}
