using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff(配置ID)(逻辑)(过时)", 0)]
[Category("Logic/Buff")]
[Description("添加buff(通过buff表里的ID),类型(处理逻辑)ID为-1即使用表中配置的处理逻辑")]
public class AddBuffByID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID", "作用对象");
		AddValueOutput("目标实体ID", "作用对象", () => targetIDInput.value);
		ValueInput<int> casterIDInput = AddValueInput<int>("释放者实体ID", "添加者");
		AddValueOutput("释放者实体ID", "添加者", () => casterIDInput.value);
		ValueInput<int> buffIDInput = AddValueInput<int>("配置ID", "buffID");
		AddValueOutput("配置ID", "buffID", () => buffIDInput.value);
		ValueInput<int> buffClassInput = AddValueInput<int>("类型(处理逻辑)ID", "处理逻辑").SetDefaultAndSerializedValue(-1);
		ValueInput<int> intervalInput = AddValueInput<int>("触发间隔时长(毫秒)", "触发间隔");
		ValueInput<int> delayInput = AddValueInput<int>("延迟时长(毫秒)", "延迟触发");
		ValueInput<int> levelInput = AddValueInput<int>("等级").SetDefaultAndSerializedValue(1);
		ValueInput<SimVar> param1Input = AddValueInput<SimVar>("参数1", "buff参数1");
		ValueInput<SimVar> param2Input = AddValueInput<SimVar>("参数2", "buff参数2");
		ValueInput<SimVar> param3Input = AddValueInput<SimVar>("参数3", "buff参数3");
		ValueInput<SimVar> param4Input = AddValueInput<SimVar>("参数4", "buff参数4");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AddBuff.AddBuffWithConfigID(base.mSimContext, casterIDInput.GetValue(), targetIDInput.GetValue(), buffIDInput.GetValue(), buffClassInput.GetValue(), delayInput.GetValue(), intervalInput.GetValue(), levelInput.GetValue(), param1Input.GetValue(), param2Input.GetValue(), param3Input.GetValue(), param4Input.GetValue());
			output.Call(f);
		});
	}
}
