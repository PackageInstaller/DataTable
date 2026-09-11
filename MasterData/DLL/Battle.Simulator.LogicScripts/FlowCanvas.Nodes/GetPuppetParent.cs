using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取宿主", 0)]
[Category("Logic/Puppet")]
[Description("获取宿主")]
public class GetPuppetParent : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		return base.parentNode.mSimContext.GetEntityWithEntityID(entityID)?.entityPuppet.mParent ?? 0;
	}
}
