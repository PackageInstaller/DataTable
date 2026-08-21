using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体是否有Debuff", 0)]
[Category("Logic/Buff")]
[Description("实体是否有Debuff")]
public class HasDebuff : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				if (entityWithEntityID.hasEntityBuff)
				{
					for (int i = 0; i < entityWithEntityID.entityBuff.mBuffID.Count; i++)
					{
						int id = entityWithEntityID.entityBuff.mBuffClassIDArray[i];
						public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(id);
						if (config != null && "DEBUFF" == config.Type)
						{
							trueOut.Call(f);
							return;
						}
					}
				}
				falseOut.Call(f);
			}
		});
	}
}
