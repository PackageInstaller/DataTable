using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("属性转模(Pure)", 0)]
[Category("Logic/Attribute")]
[Description("Value = (属性值 - N) / A * B\n【X属性】每比【阈值N】高【A】，【Y属性】提高【B】")]
public class AtributeConvert : PureFunctionNode<long, int, int, int, int, int>
{
	public override long Invoke(int entityID, int AttributeID, int N, int A = 1, int B = 1)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			if (A == 0)
			{
				Debug.LogError($"图{base.parentNode.graph.name}的属性转模节点{base.parentNode.ID}的除数为0");
				return 0L;
			}
			return (AttributeProcessor.GetFinalAttributeByAttributeID(entityWithEntityID.entityBlackboard.var.mAttributeID, AttributeID, AttributeCalcType.Add) - N) / A * B;
		}
		return 0L;
	}
}
