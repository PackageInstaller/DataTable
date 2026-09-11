using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Int3")]
[Name("Int3RotateAny", 0)]
[Description("旋转任意向量。deg单位为毫度\nnormal为旋转轴向量，normal指向眼睛时，顺时针为正数。")]
public class Int3RotateAny : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> xInput = AddValueInput<Int3>("a");
		ValueInput<Int3> yInput = AddValueInput<Int3>("normal").SetDefaultAndSerializedValue(new Int3(0, 1000, 0));
		ValueInput<int> degInput = AddValueInput<int>("deg");
		AddValueOutput("Int3", delegate
		{
			Int3 value = xInput.value;
			Int3 @int = yInput.value.NormalizeTo(1000);
			int value2 = degInput.value;
			IntMath.sincos(out var s, out var c, 31416L * (long)value2, 1800000000L);
			long num = IntMath.Divide(@int.x * value.x, 1000000L) + IntMath.Divide(@int.y * value.y, 1000000L) + IntMath.Divide(@int.z * value.z, 1000000L);
			return value * c + Int3.Cross(@int, value) * s + @int * num * (VFactor.one - c);
		});
	}
}
