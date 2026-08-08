using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

public class T0BedInteractAreaMgr
{
	private Transform content;

	private GameObject bodyInstantiateGo;

	private Action<BedPosEnum> clickCallback;

	private List<T0BedInteractAreaItem> areaItemList = new List<T0BedInteractAreaItem>();

	private GameObject handleInstantiateGo;

	public void Init()
	{
		content = T0WorldScene.Scene.agentManager.CharacteraAgent.transform;
		InitBody();
		InitHandle();
	}

	public void Dispose()
	{
		DisposeBody();
		DisposeHandle();
	}

	public void SetClickCallback(Action<BedPosEnum> _clickCallback)
	{
		clickCallback = _clickCallback;
	}

	private GameObject GetBodyInstantiate()
	{
		return Asset.Load<GameObject>("T0World/Common/Interaction/BedClickEffect");
	}

	private void InitBody()
	{
		bodyInstantiateGo = GetBodyInstantiate();
		if (areaItemList == null)
		{
			areaItemList = new List<T0BedInteractAreaItem>();
		}
		areaItemList.Clear();
	}

	public void HideAllArea()
	{
		foreach (T0BedInteractAreaItem areaItem in areaItemList)
		{
			areaItem.Show(isShow: false);
		}
	}

	public void UpdateAreaList(BedGamePropSelectData propData)
	{
		List<BedInteractPosGameData> interactPosDataList = propData.interactPosDataList;
		HideAllArea();
		for (int i = 0; i < interactPosDataList.Count; i++)
		{
			BedInteractPosGameData bedInteractPosGameData = interactPosDataList[i];
			T0BedInteractAreaItem t0BedInteractAreaItem = null;
			if (i < areaItemList.Count)
			{
				t0BedInteractAreaItem = areaItemList[i];
				t0BedInteractAreaItem.Show(isShow: true);
			}
			else
			{
				t0BedInteractAreaItem = UnityEngine.Object.Instantiate(bodyInstantiateGo, content).GetComponent<T0BedInteractAreaItem>();
				t0BedInteractAreaItem.SetClickCallback(clickCallback);
				areaItemList.Add(t0BedInteractAreaItem);
			}
			t0BedInteractAreaItem.SetData(bedInteractPosGameData.posType);
			t0BedInteractAreaItem.transform.localPosition = bedInteractPosGameData.interactShowPos;
		}
	}

	public void DisposeBody()
	{
		if ((bool)bodyInstantiateGo)
		{
			bodyInstantiateGo = null;
		}
		for (int i = 0; i < areaItemList.Count; i++)
		{
			areaItemList[i].Dispose();
			UnityEngine.Object.Destroy(areaItemList[i].gameObject);
		}
		areaItemList.Clear();
		areaItemList = null;
	}

	private GameObject GetHandleInstantiate()
	{
		return Asset.Instantiate("T0World/Common/Interaction/BedInvokeHandleArea");
	}

	private void InitHandle()
	{
		handleInstantiateGo = GetHandleInstantiate();
		handleInstantiateGo.transform.SetParent(content);
	}

	public void HideHandleArea()
	{
		handleInstantiateGo.SetActive(value: false);
	}

	public void SetHandleAreaPos(Vector3 pos)
	{
		handleInstantiateGo.SetActive(value: true);
		handleInstantiateGo.transform.localPosition = pos;
	}

	private void DisposeHandle()
	{
		if ((bool)handleInstantiateGo)
		{
			UnityEngine.Object.Destroy(handleInstantiateGo);
			handleInstantiateGo = null;
		}
	}
}
