using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("判断向量方位", 0)]
[Description("以向量a为准，判断b向量在a的顺时针或逆时针侧。\nnormal为旋转轴向量，作为判定标准。normal指向眼睛时判断顺时针或逆时针。")]
public class Int3RotateDirection : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> xInput = AddValueInput<Int3>("a");
		ValueInput<Int3> zInput = AddValueInput<Int3>("b");
		ValueInput<Int3> yInput = AddValueInput<Int3>("normal").SetDefaultAndSerializedValue(new Int3(0, 1000, 0));
		FlowOutput outClockwise = AddFlowOutput("顺时针");
		FlowOutput outAnticlockwise = AddFlowOutput("逆时针");
		FlowOutput parallel = AddFlowOutput("平行");
		AddFlowInput("", delegate(Flow f)
		{
			Int3 lhs = xInput.value.NormalizeTo(1000);
			Int3 rhs = yInput.value.NormalizeTo(1000);
			Int3 rhs2 = zInput.value.NormalizeTo(1000);
			int num = Int3.Dot(Int3.Cross(lhs, rhs2), rhs);
			if (num > 0)
			{
				outClockwise.Call(f);
			}
			else if (num < 0)
			{
				outAnticlockwise.Call(f);
			}
			else
			{
				parallel.Call(f);
			}
		});
	}
}
