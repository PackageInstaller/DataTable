using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取tposeID", 0)]
[Category("Logic/Config")]
[Description("根据实体ID获取tposeID")]
public class GetTposeID : CallableFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		return entityWithEntityID.ENTITY_CONFIG_ID;
	}
}
