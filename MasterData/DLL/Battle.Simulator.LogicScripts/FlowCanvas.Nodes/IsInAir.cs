using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否在空中", 0)]
[Category("Logic/Attribute")]
[Description("是否在空中")]
public class IsInAir : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("entityID");
		FlowOutput yes = AddFlowOutput("是");
		FlowOutput no = AddFlowOutput("否");
		AddFlowInput("In", delegate(Flow f)
		{
			bool flag = false;
			int value = abilityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityHitRecover)
			{
				flag = entityWithEntityID.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.HitAir || entityWithEntityID.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.FloatUp || entityWithEntityID.entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.FloatDown;
			}
			if (flag)
			{
				yes.Call(f);
			}
			else
			{
				no.Call(f);
			}
		});
	}
}
