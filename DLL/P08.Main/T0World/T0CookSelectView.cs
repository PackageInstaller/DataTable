using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0CookSelectView : MonoBehaviour
{
	private static T0CookSelectView mCookGame;

	public Button sureBtn_;

	public Button exitBtn_;

	public List<T0CookSelectItem> cookSelectItemList;

	private List<T0InterationCookCheckHandle> runInterationList;

	public static T0CookSelectView cookGame => mCookGame;

	private void Awake()
	{
		mCookGame = this;
		AddListener();
		foreach (T0CookSelectItem cookSelectItem in cookSelectItemList)
		{
			cookSelectItem.SetClickCallback(OnClickSelectItem);
		}
	}

	public void Dispose()
	{
		ClearRunEvent();
		mCookGame = this;
		Object.Destroy(base.gameObject);
	}

	private void AddListener()
	{
		sureBtn_?.onClick.AddListener(OnSureBtnClick);
		exitBtn_?.onClick.AddListener(OnExitBtnClick);
	}

	private void OnSureBtnClick()
	{
		(T0WorldScene.Scene.dataContext as T0WorldDataContext_Horus).cookSelectType = GetCookSelectType();
		InvokeSelectCallback(T0CookViewHandleType.CLICK_SURE);
		Dispose();
	}

	private void OnExitBtnClick()
	{
		InvokeSelectCallback(T0CookViewHandleType.CLICK_EXIT);
		Dispose();
	}

	public void OnClickSelectItem(HorusCookSelectEnum selectType)
	{
		T0CookSelectItem cookSelectItem = GetCookSelectItem(selectType);
		bool selectState = cookSelectItem.GetSelectState();
		foreach (T0CookSelectItem cookSelectItem2 in cookSelectItemList)
		{
			cookSelectItem2.SetSelectState(select_: false);
		}
		if (!selectState)
		{
			cookSelectItem = GetCookSelectItem(selectType);
			if (cookSelectItem != null)
			{
				cookSelectItem.SetSelectState(select_: true);
			}
		}
		UpdateSelectList();
	}

	private HorusCookSelectEnum GetCookSelectType()
	{
		foreach (T0CookSelectItem cookSelectItem in cookSelectItemList)
		{
			if (cookSelectItem.GetSelectState())
			{
				return cookSelectItem.GetSelectType();
			}
		}
		return HorusCookSelectEnum.NONE;
	}

	private void UpdateSelectList()
	{
		foreach (T0CookSelectItem cookSelectItem in cookSelectItemList)
		{
			cookSelectItem.RefreshUI();
		}
	}

	private T0CookSelectItem GetCookSelectItem(HorusCookSelectEnum selectType)
	{
		foreach (T0CookSelectItem cookSelectItem in cookSelectItemList)
		{
			if (cookSelectItem.GetSelectType() == selectType)
			{
				return cookSelectItem;
			}
		}
		return null;
	}

	public void RegisterInteration(T0InterationCookCheckHandle eventData)
	{
		if (runInterationList == null)
		{
			runInterationList = new List<T0InterationCookCheckHandle>();
		}
		runInterationList.Add(eventData);
	}

	public void ClearRunEvent()
	{
		if (runInterationList != null)
		{
			runInterationList.Clear();
		}
	}

	public void InvokeSelectCallback(T0CookViewHandleType handleType)
	{
		if (runInterationList == null)
		{
			return;
		}
		foreach (T0InterationCookCheckHandle runInteration in runInterationList)
		{
			runInteration.CheckCookHandleFinish(handleType);
		}
	}
}
