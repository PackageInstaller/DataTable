using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class UIRedPoint : MonoBehaviour
{
	[SerializeField]
	private GameObject red;

	[SerializeField]
	private GameObject red2;

	[SerializeField]
	private List<GameObject> reds = new List<GameObject>();

	private bool active;

	private ISubscription<RedPointMessage> _subscription;

	private List<RedPointMessageEnum> myEnums = new List<RedPointMessageEnum>();

	private Func<RedPointMessage, bool> getActiveByMessage;

	public UIRedPoint Init()
	{
		_subscription = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetMessager().Subscribe<RedPointMessage>(OnMessage);
		return this;
	}

	private void OnMessage(RedPointMessage message)
	{
		if (getActiveByMessage == null || !myEnums.Contains(message.Type))
		{
			return;
		}
		bool flag = getActiveByMessage(message);
		if (red != null)
		{
			red.SetActive(flag);
		}
		if (red2 != null)
		{
			red2.SetActive(flag);
		}
		foreach (GameObject red in reds)
		{
			if (red != null)
			{
				red.SetActive(flag);
			}
		}
	}

	public UIRedPoint SetFuncOnMessage(Func<RedPointMessage, bool> func)
	{
		getActiveByMessage = func;
		return this;
	}

	public UIRedPoint Invoke()
	{
		if (getActiveByMessage != null)
		{
			bool flag = getActiveByMessage(null);
			if (red != null)
			{
				red.SetActive(flag);
			}
			if (red2 != null)
			{
				red2.SetActive(flag);
			}
			foreach (GameObject red in reds)
			{
				red.SetActive(flag);
			}
		}
		return this;
	}

	public UIRedPoint AddEnum(RedPointMessageEnum newEnum)
	{
		if (!myEnums.Contains(newEnum))
		{
			myEnums.Add(newEnum);
		}
		return this;
	}

	public UIRedPoint AddEnum(List<RedPointMessageEnum> newEnums)
	{
		if (newEnums != null)
		{
			foreach (RedPointMessageEnum newEnum in newEnums)
			{
				if (!myEnums.Contains(newEnum))
				{
					myEnums.Add(newEnum);
				}
			}
		}
		return this;
	}

	public void Dispose()
	{
		_subscription = null;
		getActiveByMessage = null;
	}
}
