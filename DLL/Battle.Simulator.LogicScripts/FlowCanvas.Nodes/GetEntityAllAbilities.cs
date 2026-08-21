using System.Collections.Generic;
using Config;
using Google.Protobuf.Collections;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取角色所有技能(包括子技能)", 0)]
[Category("Logic/Abilities")]
[Description("获取角色所有技能(包括子技能), 数组里包括一技能、二技能、三技能以及他们的子技能（211、212、213这种）")]
public class GetEntityAllAbilities : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		List<int> skillList = new List<int>();
		AddValueOutput("技能列表", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			RepeatedField<int> allSkills = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId).AllSkills;
			skillList.Clear();
			for (int i = 0; i < allSkills.Count; i++)
			{
				skillList.Add(allSkills.get_Item(i));
			}
			return skillList;
		});
	}
}
