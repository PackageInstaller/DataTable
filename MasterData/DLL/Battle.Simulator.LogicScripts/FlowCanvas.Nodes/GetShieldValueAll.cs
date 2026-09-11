using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得护盾值", 0)]
[Category("Logic/Attribute")]
[Description("获取当前角色身上护盾的护盾值，无护盾时返回0")]
public class GetShieldValueAll : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		for (int i = 0; i < entityWithEntityID.entityBuff.mBuffCasterArray.Count; i++)
		{
			if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && (102 == entityWithEntityID.entityBuff.mBuffClassIDArray[i] || 108 == entityWithEntityID.entityBuff.mBuffClassIDArray[i]))
			{
				return entityWithEntityID.entityBuff.mBuffParamsArray[i].v2.intVar;
			}
		}
		return 0;
	}
}
