using System;
using System.Collections;
using TrueSync;

[AdventureEffect(HotfixEnum.effectType.STATE_AMOUNT)]
public class EffectStateAmount : AdventureEffectBase
{
	private int leftTime;

	private int curTime;

	private FP interval;

	private HotfixEnum.stateAttributeType stateAttributeType;

	private CoroutineNode corAuto;

	private FP autoTime;

	public override void InitParams()
	{
		base.InitParams();
		TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue);
		stateAttributeType = (HotfixEnum.stateAttributeType)intValue;
		TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out leftTime);
		TryParseStringParamToFP(effectValueConfig.EffectTypeParam3, out interval);
		curTime = leftTime;
	}

	public override void AddListenerer()
	{
		base.AddListenerer();
		AdventureActor owner = _owner;
		owner.OnBeHitHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Combine(owner.OnBeHitHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnBeHitHandle));
		AdventureActor owner2 = _owner;
		owner2.OnSpecialControlHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Combine(owner2.OnSpecialControlHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnSpecialControlHandle));
		AdventureActor owner3 = _owner;
		owner3.OnStrongControlHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Combine(owner3.OnStrongControlHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnStrongControlHandle));
		AdventureActor owner4 = _owner;
		owner4.OnWeekControlHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Combine(owner4.OnWeekControlHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnWeekControlHandle));
		AdventureActor owner5 = _owner;
		owner5.OnDamageHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Combine(owner5.OnDamageHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnDamageHandle));
		AdventureActor owner6 = _owner;
		owner6.OnBuffHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Combine(owner6.OnBuffHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnBuffHandle));
	}

	public override void RemoveListener()
	{
		base.RemoveListener();
		AdventureActor owner = _owner;
		owner.OnBeHitHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Remove(owner.OnBeHitHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnBeHitHandle));
		AdventureActor owner2 = _owner;
		owner2.OnSpecialControlHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Remove(owner2.OnSpecialControlHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnSpecialControlHandle));
		AdventureActor owner3 = _owner;
		owner3.OnStrongControlHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Remove(owner3.OnStrongControlHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnStrongControlHandle));
		AdventureActor owner4 = _owner;
		owner4.OnWeekControlHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Remove(owner4.OnWeekControlHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnWeekControlHandle));
		AdventureActor owner5 = _owner;
		owner5.OnBuffHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Remove(owner5.OnBuffHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnBuffHandle));
		AdventureActor owner6 = _owner;
		owner6.OnDamageHandle = (Func<HotfixEnum.stateAttributeType, bool>)Delegate.Remove(owner6.OnDamageHandle, new Func<HotfixEnum.stateAttributeType, bool>(OnDamageHandle));
	}

	public override void Execute()
	{
		base.Execute();
		corAuto = _owner.StartLogicCoroutine(AutoCost());
		for (int i = 0; i < leftTime; i++)
		{
			for (int j = 0; j < _targets.Count; j++)
			{
				if (stateAttributeType == HotfixEnum.stateAttributeType.INVINCIBLE)
				{
					_targets.get_Item(j).EnableInvincible();
				}
				else if (stateAttributeType == HotfixEnum.stateAttributeType.IMMUNE_CONTROL)
				{
					_targets.get_Item(j).EnableImmuneControl();
				}
				else if (stateAttributeType == HotfixEnum.stateAttributeType.UNPARALLELED)
				{
					_targets.get_Item(j).EnableUnparalleled();
				}
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (corAuto != null)
		{
			_owner.StopLogicCoroutine(corAuto);
		}
		for (int i = 0; i < leftTime - curTime; i++)
		{
			for (int j = 0; j < _targets.Count; j++)
			{
				if (stateAttributeType == HotfixEnum.stateAttributeType.INVINCIBLE)
				{
					_targets.get_Item(j).DisableInvincible();
				}
				else if (stateAttributeType == HotfixEnum.stateAttributeType.IMMUNE_CONTROL)
				{
					_targets.get_Item(j).DisableImmuneControl();
				}
				else if (stateAttributeType == HotfixEnum.stateAttributeType.UNPARALLELED)
				{
					_targets.get_Item(j).DisableUnparalleled();
				}
			}
		}
	}

	private void ResetAutoTime()
	{
		autoTime = interval;
	}

	public IEnumerator AutoCost()
	{
		autoTime = interval;
		while (true)
		{
			if (autoTime <= 0)
			{
				Cost(stateAttributeType);
				autoTime = interval;
			}
			autoTime -= _owner.LogicDeltaTime;
			yield return null;
		}
	}

	private bool Cost(HotfixEnum.stateAttributeType state)
	{
		if (state != stateAttributeType)
		{
			return false;
		}
		if (curTime > 0)
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				if (stateAttributeType == HotfixEnum.stateAttributeType.INVINCIBLE)
				{
					_targets.get_Item(i).DisableInvincible();
				}
				else if (stateAttributeType == HotfixEnum.stateAttributeType.IMMUNE_CONTROL)
				{
					_targets.get_Item(i).DisableImmuneControl();
				}
				else if (stateAttributeType == HotfixEnum.stateAttributeType.UNPARALLELED)
				{
					_targets.get_Item(i).DisableUnparalleled();
				}
			}
			curTime--;
			return true;
		}
		return false;
	}

	private bool OnBeHitHandle(HotfixEnum.stateAttributeType stateAttr)
	{
		return DoCost(stateAttr);
	}

	private bool OnSpecialControlHandle(HotfixEnum.stateAttributeType stateAttr)
	{
		return DoCost(stateAttr);
	}

	private bool OnStrongControlHandle(HotfixEnum.stateAttributeType stateAttr)
	{
		return DoCost(stateAttr);
	}

	private bool OnWeekControlHandle(HotfixEnum.stateAttributeType stateAttr)
	{
		return DoCost(stateAttr);
	}

	private bool OnDamageHandle(HotfixEnum.stateAttributeType stateAttr)
	{
		return DoCost(stateAttr);
	}

	private bool OnBuffHandle(HotfixEnum.stateAttributeType stateAttr)
	{
		return DoCost(stateAttr);
	}

	private bool DoCost(HotfixEnum.stateAttributeType stateAttr)
	{
		bool flag = Cost(stateAttr);
		if (flag)
		{
			ResetAutoTime();
		}
		return flag;
	}
}
