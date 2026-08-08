using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改敌人属性", 0)]
[Category("Logic/Attribute")]
[Description("修改敌人属性,攻防血,按比例变化,比例1000为1倍")]
public class ModifyEnemyAttribute : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<List<int>> enemyListInput = AddValueInput<List<int>>("敌人列表");
		ValueInput<int> attackFactorInput = AddValueInput<int>("攻击因子");
		ValueInput<int> defendFactorInput = AddValueInput<int>("防御因子");
		ValueInput<int> hpFactorInput = AddValueInput<int>("血量因子");
		AddFlowInput("In", delegate(Flow f)
		{
			List<int> allEnemy = SpawnProcessor.GetAllEnemy();
			List<int> value = enemyListInput.value;
			for (int i = 0; i < allEnemy.Count; i++)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(allEnemy[i]);
				if (value.Contains(entityWithEntityID.entityBlackboard.var.mAIID))
				{
					entityWithEntityID.entityBlackboard.var.mHP = entityWithEntityID.entityBlackboard.var.mHP * hpFactorInput.value / 1000;
					entityWithEntityID.entityBlackboard.var.mMaxHP = entityWithEntityID.entityBlackboard.var.mMaxHP * hpFactorInput.value / 1000;
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 1, out var baseValue, out var plusValue, out var tempPlusValue);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 1, baseValue * attackFactorInput.value / 1000, plusValue, tempPlusValue);
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2, out baseValue, out plusValue, out tempPlusValue);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2, baseValue * defendFactorInput.value / 1000, plusValue, tempPlusValue);
				}
			}
			output.Call(f);
		});
	}
}
