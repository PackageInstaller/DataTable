using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("在范围内(越界监控)(Key)", 0)]
[Category("Common/Control")]
[Description("监控输入值并将其保存，判断新值是否出入了指定范围，仅在出入时输出一次。范围包含上下界\n在需要监控多个值时使用，例如词缀图\nKey：标识监听的槽，每个监听槽独立监听，独立运行\n详细用法见wiki\n\n进入范围内：输入值从范围外进入范围内时\n离开范围：输入值从范围内离开时\n\nReset：输入时，会将内置值的比较值重置为DefaultValue，不会输出控制流\n不可在自定义函数内使用")]
public class IsInRangeMonitorWithKey : FlowControlNode
{
	public int DefaultValue;

	private Dictionary<int, int> savedValues = new Dictionary<int, int>();

	private ValueInput<int> vInFloor;

	private ValueInput<int> vInCeil;

	private ValueInput<int> vInValue;

	private ValueInput<int> vInKey;

	private ValueOutput<int> vOutKey;

	private FlowOutput fInRange;

	private FlowOutput fOutOfRange;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		savedValues.Clear();
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		DefaultValue = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(DefaultValue);
	}

	protected override void RegisterPorts()
	{
		fInRange = AddFlowOutput("进入范围内");
		fOutOfRange = AddFlowOutput("离开范围");
		vInKey = AddValueInput<int>("Key");
		vInCeil = AddValueInput<int>("上界(含)");
		vInValue = AddValueInput<int>("监控值");
		vInFloor = AddValueInput<int>("下界(含)");
		vOutKey = AddValueOutput("Key", () => vInKey.value);
		AddFlowInput("In", delegate(Flow f)
		{
			int value = vInFloor.value;
			int value2 = vInCeil.value;
			int value3 = vInValue.value;
			int value4 = DefaultValue;
			savedValues.TryGetValue(vInKey.value, out value4);
			savedValues[vInKey.value] = value3;
			bool flag = value <= value4 && value4 <= value2;
			bool flag2 = value <= value3 && value3 <= value2;
			if (flag && !flag2)
			{
				f.Call(fOutOfRange);
			}
			else if (!flag & flag2)
			{
				f.Call(fInRange);
			}
		});
		AddFlowInput("Reset", delegate
		{
			savedValues.Clear();
		});
	}
}
