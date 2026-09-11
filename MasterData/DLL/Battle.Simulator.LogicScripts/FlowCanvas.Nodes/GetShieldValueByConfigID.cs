using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前角色指定护盾的护盾值(配置ID)", 0)]
[Category("Logic/Attribute")]
[Description("获取当前角色指定护盾的护盾值")]
public class GetShieldValueByConfigID : PureFunctionNode<int, int, int>
{
	public override int Invoke(int entityID, int configID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		for (int i = 0; i < entityWithEntityID.entityBuff.mBuffCasterArray.Count; i++)
		{
			if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && configID == entityWithEntityID.entityBuff.mBuffConfigID[i])
			{
				return entityWithEntityID.entityBuff.mBuffParamsArray[i].v2.intVar;
			}
		}
		return 0;
	}
}
