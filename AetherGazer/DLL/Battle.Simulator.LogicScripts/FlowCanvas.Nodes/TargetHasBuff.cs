using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体buff数量", 0)]
[Category("Logic/Buff")]
[Description("实体是否有buff, 这里是指正面buff, 和debuff相对")]
public class TargetHasBuff : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int buffCount = 0;
		int debuffCount = 0;
		AddValueOutput("buff数量", () => buffCount);
		AddValueOutput("debuff数量", () => debuffCount);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				buffCount = 0;
				debuffCount = 0;
				f.Call(output);
			}
			else
			{
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffConfigID.Count; i++)
				{
					int num = entityWithEntityID.entityBuff.mBuffConfigID[i];
					if (num != 0)
					{
						if (ConfigHelper.GetInstance().GetConfig<public_buff>(num).Type == "DEBUFF")
						{
							debuffCount++;
						}
						else
						{
							buffCount++;
						}
					}
				}
				f.Call(output);
			}
		});
	}
}
