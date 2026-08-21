using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断技能配置的元素属性", 0)]
[Category("Logic/Config")]
[Description("判断技能配置的元素属性, 如果读表取到的技能属性是254(Config.SkillDamageType.Random)的话, 就去取ENTITY_ATTR_MAIN_DAMAGE_TYPE")]
public class SwitchSkillDamageType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		Dictionary<SkillDamageType, FlowOutput> dict = new Dictionary<SkillDamageType, FlowOutput>();
		foreach (SkillDamageType value2 in Enum.GetValues(typeof(SkillDamageType)))
		{
			dict[value2] = AddFlowOutput(value2.ToString());
		}
		AddFlowInput("", delegate(Flow f)
		{
			SkillDamageType skillDamageType = (SkillDamageType)ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.value).SkillDamageType;
			if (skillDamageType == SkillDamageType.Random)
			{
				AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2222, out var baseValue, out var _, out var _);
				skillDamageType = (SkillDamageType)baseValue;
			}
			if (dict.TryGetValue(skillDamageType, out var value))
			{
				value.Call(f);
			}
		});
	}
}
