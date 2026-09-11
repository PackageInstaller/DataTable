using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取死亡动作ID(过时)", 0)]
[Category("Logic/Config")]
[Description("根据实体ID获取死亡动作ID")]
public class GetDeathID : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		return ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID).Death;
	}
}
