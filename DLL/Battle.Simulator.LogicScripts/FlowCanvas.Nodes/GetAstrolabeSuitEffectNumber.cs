using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取星盘效果数量", 0)]
[Category("Logic/装备")]
[Description("获取星盘效果数量")]
public class GetAstrolabeSuitEffectNumber : FlowNode
{
	public const int MaxEffectNumber = 27;

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
			int num = 2023;
			for (int i = 0; i < 27; i++)
			{
				AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, num + i, out var baseValue, out var _, out var _);
				if (baseValue == 0L)
				{
					return i;
				}
			}
			return 27;
		});
	}
}
