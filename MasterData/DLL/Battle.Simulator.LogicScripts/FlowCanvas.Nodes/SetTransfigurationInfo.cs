using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置变身实体类型ID", 0)]
[Category("Logic/Abilities")]
[Description("该节点用于存储实体变身前后的实体类型ID，变身角色需要在绘制实体事件后使用该节点进行初始化")]
public class SetTransfigurationInfo : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> roleID1Input = AddValueInput<int>("变身前实体类型ID");
		ValueInput<int> roleID2Input = AddValueInput<int>("变身后实体类型ID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOutput = AddFlowOutput("Error");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOutput.Call(f);
			}
			else
			{
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2220, roleID1Input.value, 0L, 0L);
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2221, roleID2Input.value, 0L, 0L);
				output.Call(f);
			}
		});
	}
}
