using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否长按了按钮(已过时)", 0)]
[Category("Logic/Control")]
[Description("判断指定角色正在执行的技能是不是被按住了")]
public class IsPressing : PureFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID.hasEntityActionAbility)
		{
			return entityWithEntityID.entityActionAbility.mIsPressing;
		}
		return false;
	}
}
