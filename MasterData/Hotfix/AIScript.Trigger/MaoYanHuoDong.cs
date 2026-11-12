using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Trigger;

public class MaoYanHuoDong : AIBase
{
	private readonly int buffId_BaoShai = 312010100;

	private readonly int buffId_BaoShaiFx_Orange = 312010200;

	private readonly int buffId_BaoShaiFx_Red = 312010300;

	private readonly int buffId_DropHp = 312010400;

	private readonly int buffId_AtkDefDown = 312010500;

	private readonly FP addInterval = 0.5;

	private readonly int addNum = 1;

	private readonly int maxBaoShaiStack = 100;

	private readonly int dropHpStepStack = 25;

	private int destroyMutongID = 3120002;

	private int destroyMuXiangID = 3120001;

	private readonly int dropItemId_ShuiPing = 132;

	private readonly int dropItemId_ShuiHu = 133;

	private readonly int reduceStack_ShuiPing = 30;

	private readonly int reduceStack_ShuiHu = 50;

	private readonly Dictionary<long, int> _dropReduceMap = new Dictionary<long, int>();

	private PlayerAdventureActor mainActor;

	private FP _addTimer;

	public void OnEnable()
	{
		if (mainActor == null)
		{
			mainActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		}
		_addTimer = 0;
		_dropReduceMap.Clear();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("DESTRUCTIBLEOBJECT_DIE", OnDestructibleDie);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DESTRUCTIBLEOBJECT_DIE", OnDestructibleDie);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		_dropReduceMap.Clear();
		ClearAllBuffs();
		mainActor = null;
	}

	private void OnDestructibleDie(IEvent evt)
	{
		if (!(evt is DestructibleObjectBeDestoryEvent destructibleObjectBeDestoryEvent))
		{
			return;
		}
		int num = 0;
		int value = 0;
		if (destroyMutongID > 0 && destructibleObjectBeDestoryEvent.configID == destroyMutongID)
		{
			num = dropItemId_ShuiPing;
			value = reduceStack_ShuiPing;
		}
		else if (destroyMuXiangID > 0 && destructibleObjectBeDestoryEvent.configID == destroyMuXiangID)
		{
			num = dropItemId_ShuiHu;
			value = reduceStack_ShuiHu;
		}
		if (num == 0)
		{
			return;
		}
		AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (!(adventureActor == null))
		{
			long num2 = SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(adventureActor, num, destructibleObjectBeDestoryEvent.pos);
			if (num2 > 0)
			{
				_dropReduceMap.set_Item(num2, value);
			}
		}
	}

	private void OnDropFinish(IEvent evt)
	{
		if (!(evt is AdventureDropFinishEvent adventureDropFinishEvent) || !_dropReduceMap.TryGetValue(adventureDropFinishEvent.entityID, out var value))
		{
			return;
		}
		_dropReduceMap.Remove(adventureDropFinishEvent.entityID);
		if (!adventureDropFinishEvent.isPickUp || value <= 0)
		{
			return;
		}
		if (mainActor == null)
		{
			mainActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		}
		if (!(mainActor == null) && mainActor.actorHealthInfo != null && mainActor.actorHealthInfo.isAlive)
		{
			int buffNumByID = mainActor.buffComponent.GetBuffNumByID(buffId_BaoShai);
			int num = Math.Min(value, buffNumByID - 1);
			if (num > 0)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShai, num);
			}
		}
	}

	public void OnUpdate()
	{
		if (mainActor == null || !mainActor.actorHealthInfo.isAlive)
		{
			mainActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (mainActor == null || !mainActor.actorHealthInfo.isAlive)
			{
				return;
			}
		}
		_addTimer += LockStepManager.deltaTime;
		if (_addTimer >= addInterval)
		{
			_addTimer -= addInterval;
			mainActor.buffComponent.AddBuffNum(buffId_BaoShai, addNum, mainActor);
		}
		SyncDependentBuffs();
	}

	private void SyncDependentBuffs()
	{
		int buffNumByID = mainActor.buffComponent.GetBuffNumByID(buffId_BaoShai);
		bool isFull = buffNumByID >= maxBaoShaiStack;
		SyncDropHpBuff(buffNumByID);
		SyncFxBuff(buffNumByID, isFull);
		SyncAtkDefDownBuff(isFull);
	}

	private void SyncDropHpBuff(int curStack)
	{
		int num = curStack / dropHpStepStack;
		int buffNumByID = mainActor.buffComponent.GetBuffNumByID(buffId_DropHp);
		if (num > buffNumByID)
		{
			mainActor.buffComponent.AddBuffNum(buffId_DropHp, num - buffNumByID, mainActor);
		}
		else if (num < buffNumByID)
		{
			if (num <= 0)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_DropHp);
			}
			else
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_DropHp, buffNumByID - num);
			}
		}
	}

	private void SyncFxBuff(int curStack, bool isFull)
	{
		bool flag = mainActor.buffComponent.CheckBuffByBuffID(buffId_BaoShaiFx_Orange);
		bool flag2 = mainActor.buffComponent.CheckBuffByBuffID(buffId_BaoShaiFx_Red);
		if (isFull)
		{
			if (flag)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Orange);
			}
			if (!flag2)
			{
				mainActor.buffComponent.AddBuff(buffId_BaoShaiFx_Red, mainActor);
			}
		}
		else if (curStack > 0)
		{
			if (flag2)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Red);
			}
			int buffNumByID = mainActor.buffComponent.GetBuffNumByID(buffId_BaoShaiFx_Orange);
			if (curStack > buffNumByID)
			{
				mainActor.buffComponent.AddBuffNum(buffId_BaoShaiFx_Orange, curStack - buffNumByID, mainActor);
			}
			else if (curStack < buffNumByID)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Orange, buffNumByID - curStack);
			}
		}
		else
		{
			if (flag2)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Red);
			}
			if (flag)
			{
				mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Orange);
			}
		}
	}

	private void SyncAtkDefDownBuff(bool isFull)
	{
		bool flag = mainActor.buffComponent.CheckBuffByBuffID(buffId_AtkDefDown);
		if (isFull && !flag)
		{
			mainActor.buffComponent.AddBuff(buffId_AtkDefDown, mainActor);
		}
		else if (!isFull & flag)
		{
			mainActor.buffComponent.RemoveBuffByBuffId(buffId_AtkDefDown);
		}
	}

	private void ClearAllBuffs()
	{
		if (!(mainActor == null) && !(mainActor.buffComponent == null))
		{
			mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShai);
			mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Orange);
			mainActor.buffComponent.RemoveBuffByBuffId(buffId_BaoShaiFx_Red);
			mainActor.buffComponent.RemoveBuffByBuffId(buffId_DropHp);
			mainActor.buffComponent.RemoveBuffByBuffId(buffId_AtkDefDown);
		}
	}
}
