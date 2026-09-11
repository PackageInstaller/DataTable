using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断方向", 0)]
[Category("Logic/PosAndRot")]
[Description("判断方向, 判断指定位置是否在实体朝向的起始角度和结束角度内, 角度要在(-180, 180), 结束角度一定要比起始角度大")]
public class IsPositionInTargetDirection : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<Int3> targetPositionInput = AddValueInput<Int3>("指定位置");
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> endAngleInput = AddValueInput<Int>("结束角度");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			Int obj = IntMath.AngleOfVector(targetPositionInput.value - entityWithEntityID.entityPositon.mPosition);
			Int obj2 = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
			if (obj2 - obj > 180000)
			{
				obj += (Int)360000;
			}
			else if (obj2 - obj < -180000)
			{
				obj2 += (Int)360000;
			}
			if (obj <= obj2 - startAngleInput.value && obj >= obj2 - endAngleInput.value)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
