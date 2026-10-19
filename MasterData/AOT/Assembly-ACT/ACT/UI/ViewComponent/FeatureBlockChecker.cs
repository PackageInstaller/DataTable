using System;
using ACT.Game.Data;
using Fundamental;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT.UI.ViewComponent;

public class FeatureBlockChecker : MonoBehaviour
{
	public SystemType systemType;

	public int subType;

	public void Awake()
	{
		SystemBlockManager instance = Singleton<SystemBlockManager>.instance;
		instance.OnBlockStatusChanged = (Action<SystemStatus>)Delegate.Combine(instance.OnBlockStatusChanged, new Action<SystemStatus>(OnBlockStatusChanged));
		if (Singleton<SystemBlockManager>.instance.IsBlocked(systemType))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("Button disabled by GM. System id " + systemType);
			}
			gameObject.SetActive(value: false);
		}
	}

	private void OnDestroy()
	{
		SystemBlockManager instance = Singleton<SystemBlockManager>.instance;
		instance.OnBlockStatusChanged = (Action<SystemStatus>)Delegate.Remove(instance.OnBlockStatusChanged, new Action<SystemStatus>(OnBlockStatusChanged));
	}

	private void OnBlockStatusChanged(SystemStatus obj)
	{
		if (obj.MainID == (int)systemType && obj.SubID == subType)
		{
			gameObject.SetActive(!obj.Disabled);
		}
	}
}
