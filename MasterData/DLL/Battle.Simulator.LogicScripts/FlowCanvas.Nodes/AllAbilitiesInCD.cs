using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]判断是否所有技能都在cd", 0)]
[Category("Logic/Attribute")]
[Description("判断是否所有在技能槽里面的技能都在cd, 这里指技能一在cd, 技能2在cd, 技能3在cd中,奥义在cd中(如果没有过滤奥义), 如果出错或者技能在CD中, 走false")]
public class AllAbilitiesInCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<bool> noUniqueSkillInput = AddValueInput<bool>("过滤奥义", "NoUniqueSkill");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				f.Call(falseOut);
			}
			else
			{
				UniqueSkill config = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID);
				for (int i = 0; i < entityWithEntityID.entityBlackboard.var.mAbilitySlots.Length; i++)
				{
					if ((!noUniqueSkillInput.value || config == null || !config.AbilityId.Contains(entityWithEntityID.entityBlackboard.var.mAbilitySlots[i])) && !CDProcessor.InCD(entityWithEntityID, entityWithEntityID.entityBlackboard.var.mAbilitySlots[i]))
					{
						f.Call(falseOut);
						return;
					}
				}
				f.Call(trueOut);
			}
		});
	}
}
