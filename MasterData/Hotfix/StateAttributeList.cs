using System;
using UnityEngine;

public sealed class StateAttributeList
{
	private readonly StateAttribute[] entries = new StateAttribute[42];

	public bool IsActived(HotfixEnum.stateAttributeType type)
	{
		if (type == HotfixEnum.stateAttributeType.NONE || type == HotfixEnum.stateAttributeType.MAX)
		{
			return false;
		}
		return entries[(int)type].referenceCount > 0;
	}

	public bool CanEnable(HotfixEnum.stateAttributeType type)
	{
		if (type == HotfixEnum.stateAttributeType.NONE || type == HotfixEnum.stateAttributeType.MAX)
		{
			return false;
		}
		return entries[(int)type].CanEnable();
	}

	public void AddAction(HotfixEnum.stateAttributeType type, Action<int> enableAction = null, Action<int> disableAction = null, Func<bool> checkAction = null, Action interruptAction = null)
	{
		if (type != HotfixEnum.stateAttributeType.NONE && type != HotfixEnum.stateAttributeType.MAX)
		{
			ref StateAttribute reference = ref entries[(int)type];
			reference.enableAction = enableAction;
			reference.disableAction = disableAction;
			reference.checkAction = checkAction;
			reference.interruptAction = interruptAction;
		}
	}

	public bool Enable(HotfixEnum.stateAttributeType type)
	{
		if (type == HotfixEnum.stateAttributeType.NONE || type == HotfixEnum.stateAttributeType.MAX)
		{
			return false;
		}
		ref StateAttribute reference = ref entries[(int)type];
		if (!reference.CanEnable())
		{
			return false;
		}
		reference.referenceCount++;
		reference.enableAction?.Invoke(reference.referenceCount);
		return true;
	}

	public bool Disable(HotfixEnum.stateAttributeType type)
	{
		if (type == HotfixEnum.stateAttributeType.NONE || type == HotfixEnum.stateAttributeType.MAX)
		{
			return false;
		}
		ref StateAttribute reference = ref entries[(int)type];
		if (reference.referenceCount <= 0)
		{
			return false;
		}
		reference.referenceCount--;
		reference.disableAction?.Invoke(reference.referenceCount);
		if (reference.referenceCount < 0)
		{
			reference.referenceCount = 0;
			Debug.LogWarning($"状态 [{type}] 的 Enable 和 Disable 使用不匹配，请成对使用");
		}
		return true;
	}

	public void Interrupt(HotfixEnum.stateAttributeType type)
	{
		if (type != HotfixEnum.stateAttributeType.NONE && type != HotfixEnum.stateAttributeType.MAX)
		{
			ref StateAttribute reference = ref entries[(int)type];
			if (reference.referenceCount > 0)
			{
				reference.referenceCount = 0;
				reference.disableAction?.Invoke(reference.referenceCount);
			}
			reference.referenceCount = 0;
			reference.interruptAction?.Invoke();
		}
	}

	public void Clear(HotfixEnum.stateAttributeType type)
	{
		if (type != HotfixEnum.stateAttributeType.NONE && type != HotfixEnum.stateAttributeType.MAX)
		{
			entries[(int)type].referenceCount = 0;
		}
	}

	public void Clear()
	{
		for (int i = 1; i < 42; i++)
		{
			entries[i].referenceCount = 0;
		}
	}
}
