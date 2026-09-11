using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定位置是否在范围内(矩形)", 0)]
[Category("Logic/PosAndRot")]
[Description("由起始位置和朝向确定矩形，判断目标位置是否在矩形内")]
public class TargetInRect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> startPos = AddValueInput<Int3>("起始位置", "startPos");
		ValueInput<Int3> forward = AddValueInput<Int3>("朝向", "forward");
		ValueInput<int> length = AddValueInput<int>("长", "length");
		ValueInput<int> width = AddValueInput<int>("宽", "width");
		ValueInput<Int3> targetPos = AddValueInput<Int3>("目标位置", "targetPos");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			try
			{
				if (IsInRect(startPos.value, forward.value, targetPos.value, length.value, width.value))
				{
					f.Call(trueOut);
				}
				else
				{
					f.Call(falseOut);
				}
			}
			catch
			{
				f.Call(falseOut);
			}
		});
	}

	private bool IsInRect(Int3 startPos, Int3 forward, Int3 targetPos, int length, int width)
	{
		if (length < 0 || width < 0)
		{
			return false;
		}
		long num = SqrMagnitudeXZ(forward);
		if (num == 0L)
		{
			return false;
		}
		Int3 w = targetPos - startPos;
		long num2 = DotXZ(forward, w);
		if (num2 < 0)
		{
			return false;
		}
		if (num2 * num2 > (long)length * (long)length * num)
		{
			return false;
		}
		long num3 = CrossXZ(forward, w);
		return 4 * num3 * num3 <= (long)width * (long)width * num;
	}

	private long SqrMagnitudeXZ(Int3 v)
	{
		return (long)v.x * (long)v.x + (long)v.z * (long)v.z;
	}

	private long DotXZ(Int3 v, Int3 w)
	{
		return (long)v.x * (long)w.x + (long)v.z * (long)w.z;
	}

	private long CrossXZ(Int3 v, Int3 w)
	{
		return (long)v.x * (long)w.z - (long)v.z * (long)w.x;
	}
}
