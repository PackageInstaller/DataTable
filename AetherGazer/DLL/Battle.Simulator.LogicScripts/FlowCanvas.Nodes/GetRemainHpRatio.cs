using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取剩余血量百分比", 0)]
[Category("Logic/Attribute")]
[Description("获取剩余血量百分比\n默认向下取整，roundUp为True时向上取整")]
public class GetRemainHpRatio : CallableFunctionNode<int, int, bool>
{
	public override int Invoke(int entityID, bool roundUp)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return 0;
		}
		long mHP = entityWithEntityID.entityBlackboard.var.mHP;
		long mMaxHP = entityWithEntityID.entityBlackboard.var.mMaxHP;
		if (mMaxHP <= 0)
		{
			return 0;
		}
		if (!roundUp)
		{
			return (int)(mHP * 100 / mMaxHP);
		}
		return 100 - (int)((mMaxHP - mHP) * 100 / mMaxHP);
	}
}
