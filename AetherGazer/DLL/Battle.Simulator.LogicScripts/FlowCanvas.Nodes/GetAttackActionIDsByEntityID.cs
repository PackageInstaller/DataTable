using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取攻击动作(根据实体ID)", 0)]
[Category("Logic/Config")]
[Description("根据实体ID获取威吓动作列表")]
public class GetAttackActionIDsByEntityID : PureFunctionNode<List<int>, int>
{
	public override List<int> Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return null;
		}
		SimVar eNTITY_CONFIG_ID = entityWithEntityID.ENTITY_CONFIG_ID;
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(eNTITY_CONFIG_ID);
		List<int> list = new List<int>();
		foreach (int melee in config.Melees)
		{
			list.Add(melee);
		}
		foreach (int item in config.Ability)
		{
			list.Add(item);
		}
		return list;
	}
}
