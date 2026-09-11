using System.Collections.Generic;
using CriWare;
using UnityEngine;

public class CriMonoBehaviourManager : MonoBehaviour
{
	private static CriMonoBehaviourManager _instance = null;

	private static List<CriMonoBehaviour> criMonoBehaviourList = new List<CriMonoBehaviour>();

	public static CriMonoBehaviourManager instance
	{
		get
		{
			CreateInstance();
			return _instance;
		}
	}

	public static void CreateInstance()
	{
		if (_instance == null)
		{
			Common.managerObject.AddComponent<CriMonoBehaviourManager>();
		}
	}

	private static int GetIndex(CriMonoBehaviour criMonoBehaviour)
	{
		for (int i = 0; i < criMonoBehaviourList.Count; i++)
		{
			if (criMonoBehaviourList[i].guid == criMonoBehaviour.guid)
			{
				return i;
			}
		}
		return -1;
	}

	public bool Register(CriMonoBehaviour criMonoBehaviour)
	{
		lock (criMonoBehaviourList)
		{
			if (GetIndex(criMonoBehaviour) >= 0)
			{
				Debug.LogWarning("[CRIWARE] Internal: Duplicated CriMonoBehaviour GUID");
				return false;
			}
			criMonoBehaviourList.Add(criMonoBehaviour);
		}
		return true;
	}

	public static bool UnRegister(CriMonoBehaviour criMonoBehaviour)
	{
		lock (criMonoBehaviourList)
		{
			int index = GetIndex(criMonoBehaviour);
			if (index < 0)
			{
				return false;
			}
			criMonoBehaviourList.RemoveAt(index);
		}
		return true;
	}

	private void Awake()
	{
		if (_instance == null)
		{
			_instance = this;
		}
		else
		{
			Object.Destroy(this);
		}
	}

	private void Update()
	{
		lock (criMonoBehaviourList)
		{
			for (int i = 0; i < criMonoBehaviourList.Count; i++)
			{
				criMonoBehaviourList[i].CriInternalUpdate();
			}
		}
	}

	private void LateUpdate()
	{
		lock (criMonoBehaviourList)
		{
			for (int i = 0; i < criMonoBehaviourList.Count; i++)
			{
				criMonoBehaviourList[i].CriInternalLateUpdate();
			}
		}
	}
}
