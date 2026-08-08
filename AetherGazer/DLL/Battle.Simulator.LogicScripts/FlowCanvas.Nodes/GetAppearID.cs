using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取出场动作ID", 0)]
[Category("Logic/Config")]
[Description("根据实体ID获取出场动作ID")]
public class GetAppearID : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		return ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID).Appear;
	}
}
