using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加耐力组件", 0)]
[Category("Logic/Attribute")]
[Description("添加耐力组件")]
public class AddEnduranceComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.ENTITY_CONFIG_ID);
			entityWithEntityID.AddEntityEndurance(config.MaxEnduranceValue * 1000, config.MaxEnduranceValue * 1000, config.ResumeEnduranceSpeed * 1000, config.ConsumeEnduranceValue * 1000, newState: true);
			f.Call(output);
		});
	}
}
