using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能配置的元素属性", 0)]
[Category("Logic/Config")]
[Description("获取技能配置的元素属性, 如果读表取到的技能属性是254(Config.SkillDamageType.Random)的话, 就去取ENTITY_ATTR_MAIN_DAMAGE_TYPE")]
public class GetSkillDamageType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("枚举值", delegate
		{
			SkillDamageType skillDamageType = (SkillDamageType)ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.value).SkillDamageType;
			if (skillDamageType == SkillDamageType.Random)
			{
				AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2222, out var baseValue, out var _, out var _);
				skillDamageType = (SkillDamageType)baseValue;
			}
			return skillDamageType;
		});
	}

	public static SkillDamageType Invoke(int simEntityID, int abilityID)
	{
		SkillDamageType skillDamageType = (SkillDamageType)ConfigHelper.GetInstance().GetConfig<public_skill>(abilityID).SkillDamageType;
		if (skillDamageType == SkillDamageType.Random)
		{
			AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(simEntityID), 2222, out var baseValue, out var _, out var _);
			skillDamageType = (SkillDamageType)baseValue;
		}
		return skillDamageType;
	}
}
