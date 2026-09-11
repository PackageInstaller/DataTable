using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("随机移动", 0)]
[Category("Logic/PosAndRot")]
[Description("随机移动, 移动时朝着移动方向")]
public class RandomMove : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> speedFactorInput = AddValueInput<int>("速度百分比");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.hasEntityPositon)
			{
				entityWithEntityID.entityBlackboard.var.mIsLookatAimTarget = false;
				Int3 @int = IntMath.VectorOfAngle((int)(DRandom.Random(360u) * 1000));
				Int3 targetPosition = entityWithEntityID.entityPositon.mPosition + @int;
				AIProcessor.MoveAIDirection(entityWithEntityID.creationIndex, targetPosition, new VFactor(speedFactorInput.value, 100L));
			}
			f.Call(output);
		});
	}
}
