using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取援护CD", 0)]
[Category("Logic/援护")]
[Description("获取援护CD")]
public class GetActivityStrikeSystemSkillCD : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput outputTrue = AddFlowOutput("成功");
		FlowOutput outputFalse = AddFlowOutput("失败");
		ValueInput<int> enttiyIDInput = AddValueInput<int>("实体ID");
		int cd = 0;
		AddValueOutput("CD", () => cd);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(enttiyIDInput.value);
			ActivityStrikeSystem config;
			if (entityWithEntityID == null)
			{
				outputFalse.Call(f);
			}
			else if (!entityWithEntityID.hasEntityConfig)
			{
				outputFalse.Call(f);
			}
			else if (ConfigHelper.GetInstance().TryGetConfig<ActivityStrikeSystem>(entityWithEntityID.entityConfig.mId, out config))
			{
				cd = config.CD;
				outputTrue.Call(f);
			}
			else
			{
				outputFalse.Call(f);
			}
		});
	}
}
