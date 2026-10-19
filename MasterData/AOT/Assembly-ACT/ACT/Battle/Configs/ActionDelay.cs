using System.Collections.Generic;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("延迟延迟", "Action", new string[] { "delay" })]
public class ActionDelay : ConfigAction
{
	public bool cancelAfterDie = true;

	public float delay;

	public ConfigAction[] actions;

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, actions, ab);
	}

	public override void Do(ActionMemory memory)
	{
		Delay(memory).Forget();
	}

	private async UniTaskVoid Delay(ActionMemory memory)
	{
		float time = delay;
		CompTime compTime = memory.owner.GetCompTime();
		while (time > 0f)
		{
			if (memory.owner.IsValid)
			{
				Ability ability = memory.ability;
				if (ability != null)
				{
					ConfigAbility config = ability.config;
					if (config != null && config.timeScale == TimeScale.NoScale)
					{
						time -= Time.fixedDeltaTime;
						goto IL_00b5;
					}
				}
				time -= compTime.fixedDeltaTime;
			}
			else
			{
				time -= Time.fixedDeltaTime;
			}
			goto IL_00b5;
			IL_00b5:
			await UniTask.WaitForFixedUpdate();
		}
		if (cancelAfterDie)
		{
			if (memory.owner.IsValid && !memory.owner.GetCompAbility().GetCancellationTokenOnDie().IsCancellationRequested)
			{
				SystemAbility.DoActions(memory, actions);
			}
		}
		else
		{
			SystemAbility.DoActions(memory, actions);
		}
	}
}
