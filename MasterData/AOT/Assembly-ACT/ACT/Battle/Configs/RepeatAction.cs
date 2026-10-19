using System;
using System.Collections.Generic;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("重复重复", "Action", new string[] { "repeat" })]
public class RepeatAction : ConfigAction
{
	public ConfigFunction<int> times;

	public ConfigAction[] actions;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}

	public override void Do(ActionMemory memory)
	{
		int num = times.Return(memory);
		for (int i = 0; i < num; i++)
		{
			SystemAbility.DoActions(memory, actions);
		}
	}
}
