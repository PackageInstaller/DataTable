using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Periodic", "Action", new string[] { "do", "periodic" })]
public class DoPeriodicAction : ConfigAction
{
	public ConfigFunction<bool> needWait;

	public ConfigFunction<float> reCount;

	public ConfigFunction<float> delayList;

	public ConfigAction[] actions;

	public float delay;

	public int count;

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
		if (needWait == null || !needWait.Return(memory))
		{
			SystemAbility.DoActions(memory, actions);
		}
		if (reCount != null && delayList != null)
		{
			count = (int)reCount.Return(memory);
			delay = delayList.Return(memory);
		}
		for (int i = 0; i < count; i++)
		{
			await UniTask.Delay(TimeSpan.FromSeconds(delay));
			SystemAbility.DoActions(memory, actions);
		}
	}
}
