using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断主属性(元素属性)", 0)]
[Category("Logic/Config")]
[Description("判断实体配置的主属性, 如果读表取到的主属性是254(Config.SkillDamageType.Random)的话, 就去取ENTITY_ATTR_MAIN_DAMAGE_TYPE\n实体类型ID的输出会根据实体ID查找并返回对应的值")]
public class SwitchMainDamageType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID(过时)", "RoleID");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		Dictionary<SkillDamageType, FlowOutput> dict = new Dictionary<SkillDamageType, FlowOutput>();
		foreach (SkillDamageType value2 in Enum.GetValues(typeof(SkillDamageType)))
		{
			dict[value2] = AddFlowOutput(value2.ToString());
		}
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		int roleID = roleIDInput.value;
		AddFlowInput("", delegate(Flow f)
		{
			roleID = roleIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig)
			{
				roleID = entityWithEntityID.entityConfig.mId;
			}
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleID, out var config))
			{
				errorOut.Call(f);
			}
			else
			{
				SkillDamageType skillDamageType = config.MainDamageType;
				if (skillDamageType == SkillDamageType.Random)
				{
					AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2222, out var baseValue, out var _, out var _);
					skillDamageType = (SkillDamageType)baseValue;
				}
				if (dict.TryGetValue(skillDamageType, out var value))
				{
					value.Call(f);
				}
			}
		});
		AddValueOutput("实体类型ID", "RoleID", () => roleID);
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
