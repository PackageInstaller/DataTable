using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[隐藏]实体是否隐藏(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("判断实体是否处于隐藏状态")]
public class EnityIsHideNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID", "对象");
		FlowOutput hideOut = AddFlowOutput("实体隐藏");
		FlowOutput normalOut = AddFlowOutput("实体正常");
		FlowOutput errorOut = AddFlowOutput("实体不存在");
		AddFlowInput("", delegate(Flow f)
		{
			int value = targetIDInput.GetValue();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else if (entityWithEntityID.hasEntityHide)
			{
				hideOut.Call(f);
			}
			else
			{
				normalOut.Call(f);
			}
		});
	}
}
