using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取装备效果数量", 0)]
[Category("Logic/装备")]
[Description("获取装备效果数量 equip_effect 表中的 id 列")]
public class GetEquipEffectNumber : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("数量", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				return 0;
			}
			int num = 2100;
			for (int i = 0; i < 20; i++)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num + i, out var baseValue, out var _, out var _);
				if (baseValue == 0L)
				{
					return i;
				}
			}
			return 20;
		});
	}
}
