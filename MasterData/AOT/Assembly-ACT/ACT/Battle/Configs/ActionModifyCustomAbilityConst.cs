using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改自定义技能常量", "Action", new string[] { "modify", "custom", "ability", "const", "skill", "cd" })]
public class ActionModifyCustomAbilityConst : ConfigAction
{
	public string abilityName;

	public string key;

	public ModifyType modifyType;

	public ConfigFunction<float> value;

	protected override AbilityAuth defaultAuth => AbilityAuth.Server;

	public override void Do(ActionMemory memory)
	{
		if (string.IsNullOrEmpty(key) || string.IsNullOrEmpty(abilityName))
		{
			return;
		}
		float delta = value.Return(memory);
		Ability abilityByName = memory.target.entity.GetCompAbility().GetAbilityByName(abilityName);
		if (abilityByName != null)
		{
			switch (modifyType)
			{
			case ModifyType.Set:
				abilityByName.SetAbilityConst(key, delta);
				break;
			case ModifyType.Add:
				abilityByName.AddAbilityConst(key, delta);
				break;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
	}
}
