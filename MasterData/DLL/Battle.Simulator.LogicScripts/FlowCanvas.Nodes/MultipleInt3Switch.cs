using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("多选一(Int3)", 0)]
[Category("Common/Math")]
[Description("根据输入控制流，决定本次控制流输入使用哪一个值输出\n输入控制流N时，输出控制流OutN，输出值端口会选择第N个值")]
public class MultipleInt3Switch : FlowControlNode
{
	[MinValue(1)]
	[GatherPortsCallback]
	[DelayedField]
	public int Count = 1;

	private ValueInput<Int3>[] vIn;

	private FlowInput[] fIn;

	private Int3 returnValue;

	private FlowOutput[] fOut;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(Count);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		Count = reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		vIn = new ValueInput<Int3>[Count];
		fIn = new FlowInput[Count];
		fOut = new FlowOutput[Count];
		for (int i = 0; i < Count; i++)
		{
			int pos = i;
			vIn[i] = AddValueInput<Int3>("输入值" + i);
			fOut[i] = AddFlowOutput("Out" + i);
			fIn[i] = AddFlowInput(i.ToString(), delegate(Flow f)
			{
				returnValue = vIn[pos].value;
				fOut[pos].Call(f);
			});
		}
		AddValueOutput("输出值", () => returnValue);
	}
}
