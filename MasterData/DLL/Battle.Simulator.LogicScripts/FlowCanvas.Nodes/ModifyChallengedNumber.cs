using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置已经挑战的倍数", 0)]
[Category("Logic/Spawn")]
[Description("设置已经挑战的倍数")]
public class ModifyChallengedNumber : FlowNode
{
	public OperationMethod operation;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write((int)operation);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		operation = (OperationMethod)reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> valueInput = AddValueInput<int>("变化值");
		int res = 0;
		AddValueOutput("结果", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			int num = CommonProcessor.GetWorldState().mChallengedNumbe;
			int value = valueInput.value;
			switch (operation)
			{
			case OperationMethod.Add:
				num += value;
				break;
			case OperationMethod.Divide:
				num /= value;
				break;
			case OperationMethod.Multiply:
				num *= value;
				num /= 100;
				break;
			case OperationMethod.Set:
				num = value;
				break;
			case OperationMethod.Subtract:
				num -= value;
				break;
			}
			res = num;
			CommonProcessor.GetWorldState().mChallengedNumbe = res;
			output.Call(f);
		});
	}
}
