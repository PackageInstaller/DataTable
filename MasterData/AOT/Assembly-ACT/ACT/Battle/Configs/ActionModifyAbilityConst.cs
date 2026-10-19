using System;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改技能常量", "Action", new string[] { "modify", "ability", "const", "skill", "cd" })]
public class ActionModifyAbilityConst : ConfigAction
{
	public string key;

	public ModifyType modifyType;

	public ConfigFunction<float> value;

	protected override AbilityAuth defaultAuth => AbilityAuth.Server;

	public override void Do(ActionMemory memory)
	{
		if (memory.ability != null && !string.IsNullOrEmpty(key))
		{
			float delta = value.Return(memory);
			switch (modifyType)
			{
			case ModifyType.Set:
				memory.ability.SetAbilityConst(key, delta);
				break;
			case ModifyType.Add:
				memory.ability.AddAbilityConst(key, delta);
				break;
			default:
				throw new ArgumentOutOfRangeException();
			}
		}
	}
}
