using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体左右偏转量", 0)]
[Category("Logic/PosAndRot")]
[Description("获取实体摇杆输入的X输入量,通过旋转角度和实体朝向计算")]
[ExposeAsDefinition]
public class GetEntityXAxisRoot : FlowNode
{
	private int xAxis;

	private Int3 Dir;

	public int GetAxis(SimEntity entity)
	{
		Int3 mForward = entity.entityPositon.mForward;
		Int3 dir = Dir;
		return (dir.x * mForward.z - mForward.x * dir.z) / mForward.IntMagnitude.i;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueInput<Int3>("摇杆角度").SetDefaultAndSerializedValue(Int3.zero);
		AddValueOutput("xAxis", () => xAxis);
		FlowOutput trueOut = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				xAxis = GetAxis(entityWithEntityID);
				trueOut.Call(f);
			}
		});
	}
}
