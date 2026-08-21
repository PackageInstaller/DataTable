using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体向目标位置平移(速度绝对值)", 0)]
[Category("Logic/PosAndRot")]
[Description("实体向目标点平移,没有动作,就是设置一下位移")]
public class MoveEntityToTargetPosBySpeed : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<Int3> targetPosInput = AddValueInput<Int3>("目标位置");
		ValueInput<int> speedInput = AddValueInput<int>("速度");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			Int3 mPosition = entityWithEntityID.entityPositon.mPosition;
			Int3 @int = targetPosInput.value - mPosition;
			int value = speedInput.value;
			Int3 delta = ((@int.sqrMagnitudeLong2D >= value * value) ? @int.NormalizeTo(value) : @int);
			MovementProcessor.PathfindingMove(entityWithEntityID, delta);
			f.Call(output);
		});
	}
}
