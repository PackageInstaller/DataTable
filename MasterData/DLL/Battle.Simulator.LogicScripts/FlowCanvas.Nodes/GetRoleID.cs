using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体类型ID", 0)]
[Category("Logic/Config")]
[Description("获取实体ID的角色ID")]
public class GetRoleID : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		return base.parentNode.mSimContext.GetEntityWithEntityID(entityID)?.entityConfig.mId ?? 0;
	}
}
