using System.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class TriggerDelayTimeWhenBattleStart : TriggerConditionBase
{
	private FP _delayTimeFP;

	private Coroutine delayCoroutine;

	public override void DisableTrigger()
	{
		base.DisableTrigger();
		HotfixEnum.worldLevelType levelType = ModuleController<AdventureModuleController>.Instance.levelType;
		if (levelType == HotfixEnum.worldLevelType.RegionBoss || levelType == HotfixEnum.worldLevelType.WeeklyCopies)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
			if (delayCoroutine != null)
			{
				StopCoroutine(delayCoroutine);
				delayCoroutine = null;
			}
		}
	}

	public override void ToActive()
	{
		base.ToActive();
		switch (ModuleController<AdventureModuleController>.Instance.levelType)
		{
		case HotfixEnum.worldLevelType.RegionBoss:
		{
			RegionBossLevel regionBossLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.regionBossLevel;
			if (regionBossLevel == null)
			{
				Debug.LogError("[RegionBossLevel]表数据为空!");
				break;
			}
			_delayTimeFP = FP.FromConfigFloat(regionBossLevel.BossShowTime);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
			break;
		}
		case HotfixEnum.worldLevelType.WeeklyCopies:
			_delayTimeFP = FP.FromConfigFloat(ModuleController<AdventureModuleController>.Instance.levelLoadParams.dynamicParam);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
			break;
		}
	}

	private void OnBattleStart(IEvent ievent)
	{
		if (delayCoroutine != null)
		{
			StopCoroutine(delayCoroutine);
			delayCoroutine = null;
		}
		delayCoroutine = StartCoroutine(DoDelayAction());
	}

	private IEnumerator DoDelayAction()
	{
		yield return new WaitForSeconds((float)_delayTimeFP);
		OnTrigger();
	}
}
