using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否禁锢中", 0)]
[Category("Logic/Buff/禁锢")]
[Description("判断EntityID实体是否持有禁锢debuff")]
public class HasStopDebuff : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput abnormalOut = AddFlowOutput("无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				falseOut.Call(f);
			}
			else if (entityWithEntityID.entityBuff.Contain(6))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
