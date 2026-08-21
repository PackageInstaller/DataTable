using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]清除全部技能CD(过时)", 0)]
[Category("Logic/Attribute")]
[Description("重置CD组件")]
public class ClearAllSkillCDWithoutUseCount : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "EntityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput abnormalOutput = AddFlowOutput("异常", "abnormalOutput");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOutput.Call(f);
			}
			else
			{
				CDProcessor.CleanAllCD(entityWithEntityID);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
	}
}
