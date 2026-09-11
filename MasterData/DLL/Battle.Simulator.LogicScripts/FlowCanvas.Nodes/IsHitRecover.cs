using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否受击中", 0)]
[Category("Logic/Attribute")]
[Description("判断是否受击中")]
public class IsHitRecover : FlowControlNode
{
	public static bool Check(SimEntity attacker)
	{
		return attacker?.hasEntityHitRecover ?? false;
	}

	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> entityInput = AddValueInput<int>("entityID");
		AddValueOutput("受击状态", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityInput.value);
			return Check(entityWithEntityID) ? entityWithEntityID.entityHitRecover.mHitRecoverStatus : E_HitRecoverStatus.None;
		});
		AddFlowInput("In", delegate(Flow f)
		{
			if (Check(base.mSimContext.GetEntityWithEntityID(entityInput.value)))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
