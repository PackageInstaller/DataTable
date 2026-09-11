using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("格式化文本(多参数)", 0)]
[Category("Common/Control")]
[Description("格式化文本")]
public class FormatString2 : FlowControlNodeOfCommon
{
	[MinValue(1)]
	[GatherPortsCallback]
	[DelayedField]
	public int Count = 1;

	private ValueInput<string>[] valueInputArr;

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
		ValueInput<string> formatInput = AddValueInput<string>("格式", "format");
		valueInputArr = new ValueInput<string>[Count];
		for (int i = 0; i < Count; i++)
		{
			valueInputArr[i] = AddValueInput<string>("输入值" + i);
		}
		FlowOutput output = AddFlowOutput("Out", "output");
		string[] strArr = new string[Count];
		string result = string.Empty;
		AddFlowInput("In", "input", delegate(Flow f)
		{
			result = string.Empty;
			for (int j = 0; j < valueInputArr.Length; j++)
			{
				strArr[j] = valueInputArr[j].value;
			}
			string value = formatInput.value;
			object[] args = strArr;
			result = string.Format(value, args);
			output.Call(f);
		});
		AddValueOutput("结果", "result", () => result);
	}
}
