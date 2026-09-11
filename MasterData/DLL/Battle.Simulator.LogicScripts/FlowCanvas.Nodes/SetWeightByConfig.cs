using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("根据配置修改重量", 0)]
[Category("Logic/Attribute")]
[Description("根据配置修改重量")]
public class SetWeightByConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig)
			{
				int weight = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId).Weight;
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
			output.Call(f);
		});
	}
}
