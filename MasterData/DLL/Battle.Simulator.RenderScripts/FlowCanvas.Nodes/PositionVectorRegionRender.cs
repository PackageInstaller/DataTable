using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("相对位置向量的角度区间(渲染)", 0)]
[Description("相对位置向量角度区间, 出错的话, 也走false, 起始角度不能大于360")]
[Category("Render/PosAndRot")]
public class PositionVectorRegionRender : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Vector3> baseEntityIDInput = AddValueInput<Vector3>("基础实体位置");
		AddValueOutput("基础实体位置", () => baseEntityIDInput.value);
		ValueInput<Vector3> targetEntityIDInput = AddValueInput<Vector3>("目标实体位置");
		AddValueOutput("目标实体位置", () => targetEntityIDInput.value);
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> deltaAngleInput = AddValueInput<Int>("区间大小");
		FlowOutput trueOutput = AddFlowOutput("true");
		FlowOutput falseOutput = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			Int obj = IntMath.AngleOfVector((Int3)(targetEntityIDInput.value - baseEntityIDInput.value));
			Int value = startAngleInput.value;
			Int obj2 = value + deltaAngleInput.value;
			bool flag = false;
			if ((obj2.i <= 360000) ? (obj >= value && obj < obj2) : (obj >= value || obj < obj2.i % 360000))
			{
				trueOutput.Call(f);
			}
			else
			{
				falseOutput.Call(f);
			}
		});
	}
}
