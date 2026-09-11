using Config;
using FlowCanvas;
using ParadoxNotion.Design;
using UnityEngine;

[Name("获取玩家的装备赋能信息", 0)]
[Category("Logic/Equip")]
[Description("获得玩家装备赋能信息是否存在，如果存在，返回等级信息")]
[ExposeAsDefinition]
public class GetEntityEquipSkill : FlowNode
{
	private int mEquipLv;

	private equip_skill config;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "GetEquipSkillInfo_entityIDInput");
		ValueInput<int> equipIDInput = AddValueInput<int>("装备ID", "GetEquipSkillInfo_equipIDInput");
		AddValueOutput("当前等级", () => mEquipLv);
		AddValueOutput("值(等级 x 成长值)", () => mEquipLv * config.Upgrade);
		AddValueOutput("Attribute", () => config.Attribute);
		AddValueOutput("EquipEffectId", () => (config != null) ? config.EquipEffectId : 0);
		AddValueOutput("Upgrade", () => (config != null) ? config.Upgrade : 0);
		AddValueOutput("Lvmax", () => (config != null) ? config.Lvmax : 0);
		AddValueOutput("Percent", () => (config != null) ? config.Percent : 0);
		AddValueOutput("Type", () => (config != null) ? config.Type : 0);
		AddValueOutput("TypeInner", () => (config != null) ? config.TypeInner : 0);
		FlowOutput enableOutput = AddFlowOutput("存在", "GetEquipSkillInfo_enableOutput");
		FlowOutput disableOutput = AddFlowOutput("不存在", "GetEquipSkillInfo_disableOutput");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.entityBlackboard.var.mEquipLv != null && entityWithEntityID.entityBlackboard.var.mEquipLv.TryGetValue(equipIDInput.value, out var value))
			{
				if (value > 0)
				{
					config = ConfigHelper.GetInstance().GetConfig<equip_skill>(equipIDInput.value);
					mEquipLv = value;
					enableOutput.Call(f);
					return;
				}
				Debug.LogError("equipIDInput.value 赋能等级：0级");
			}
			disableOutput.Call(f);
		});
	}
}
