using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("权重随机", 0)]
[Category("Logic/Random")]
[Description("权重随机, 如果权重全是0的话, 就会报错")]
public class SwitchRandom : FlowControlNode
{
	public int _portCount = 4;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.WriteInt32(_portCount);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int>[] inputs = new ValueInput<int>[_portCount];
		FlowOutput[] cases = new FlowOutput[_portCount];
		for (int i = 0; i < cases.Length; i++)
		{
			string text = i.ToString();
			inputs[i] = AddValueInput<int>(text);
			cases[i] = AddFlowOutput(text);
		}
		AddFlowInput("", delegate(Flow f)
		{
			int num = 0;
			for (int j = 0; j < _portCount; j++)
			{
				num += inputs[j].value;
			}
			int num2 = (int)DRandom.Random((uint)num);
			num = 0;
			for (int k = 0; k < _portCount; k++)
			{
				num += inputs[k].value;
				if (num > num2)
				{
					cases[k].Call(f);
					break;
				}
			}
		});
	}
}
