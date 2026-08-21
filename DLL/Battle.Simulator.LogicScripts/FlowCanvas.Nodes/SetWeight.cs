using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改重量", 0)]
[Category("Logic/Attribute")]
[Description("修改重量")]
public class SetWeight : CallableActionNode<int, int>
{
	public override void Invoke(int simEntityID, int weight)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		if (entityWithEntityID.hasEntityShape)
		{
			entityWithEntityID.entityShape.mWeight = weight;
		}
		if (entityWithEntityID.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			for (int i = 0; i < children.Count; i++)
			{
				children[i].entityShape.mWeight = weight;
			}
		}
	}
}
