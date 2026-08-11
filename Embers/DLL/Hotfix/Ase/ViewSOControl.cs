using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ViewSOControl : MonoBehaviour
{
	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private IMessenger messenger;

	public List<ItemSOConfig> configList;

	private Action doSystemOpenAction;

	private void Start()
	{
		if (configList == null)
		{
			return;
		}
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		for (int i = 0; i < configList.Count; i++)
		{
			if (!(configList[i] == null))
			{
				configList[i].Init();
			}
		}
	}

	private void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		for (int i = 0; i < configList.Count; i++)
		{
			if (configList[i] != null)
			{
				configList[i].OnChangeState(messager.serviceId, messager.state);
			}
		}
		doSystemOpenAction?.Invoke();
	}

	public void AddOpenAction(Action action)
	{
		doSystemOpenAction = action;
	}

	public void AddItems(ItemSOConfig item)
	{
		if (configList == null)
		{
			configList = new List<ItemSOConfig>();
		}
		for (int i = 0; i < configList.Count; i++)
		{
			if (configList[i] == item)
			{
				return;
			}
		}
		configList.Add(item);
		item.Init();
	}

	private void OnDestroy()
	{
		messenger = null;
		if (subscription_SONotify != null)
		{
			subscription_SONotify.Dispose();
		}
		if (configList != null)
		{
			configList.Clear();
			configList = null;
		}
		doSystemOpenAction = null;
	}
}
