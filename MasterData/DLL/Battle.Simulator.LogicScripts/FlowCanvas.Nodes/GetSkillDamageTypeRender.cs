using Config;
using Google.Protobuf.Collections;
using NetProcol;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能配置的元素属性(渲染)", 0)]
[Category("Render/Config")]
[Description("获取技能配置的元素属性, 如果读表取到的技能属性是254(Config.SkillDamageType.Random)的话, 就去取传进来的值")]
public class GetSkillDamageTypeRender : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		ValueInput<int> entityIDInput = AddValueInput<int>("AgentID");
		AddValueOutput("枚举值", delegate
		{
			SkillDamageType skillDamageType = (SkillDamageType)ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.value).SkillDamageType;
			if (skillDamageType == SkillDamageType.Random)
			{
				MemberPosition memberPositionByAgentID = AgentManager.GetAgentManager().GetMemberPositionByAgentID(entityIDInput.value);
				RepeatedField<RoleDataForExchangeInfo> roleDataInLua = ((BattleScene)NScene.GetCurrentScene()).ready.SceneDataForExcehange.RoleDataInLua;
				if (memberPositionByAgentID != MemberPosition.None && roleDataInLua.Count > (int)memberPositionByAgentID)
				{
					RoleDataForExchangeInfo roleDataForExchangeInfo = roleDataInLua.get_Item((int)memberPositionByAgentID);
					int num = roleDataForExchangeInfo.AttributeID.IndexOf(2222);
					if (roleDataForExchangeInfo.AttributeValue.Count > num && num >= 0)
					{
						skillDamageType = (SkillDamageType)roleDataForExchangeInfo.AttributeValue.get_Item(num);
					}
				}
			}
			return skillDamageType;
		});
	}
}
