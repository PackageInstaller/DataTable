using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("禁用普攻(过时)", 0)]
[Category("Logic/Buff/效果/普攻")]
[Description("禁止全部普攻释放")]
public class DisableAttack : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null)
			{
				List<int> mMeleesSlots = entityWithEntityID.entityBlackboard.var.mMeleesSlots;
				for (int i = 0; i < mMeleesSlots.Count; i++)
				{
					entityWithEntityID.entityBlackboard.var.EnableAbility(mMeleesSlots[i], isEnable: false);
				}
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
