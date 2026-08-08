using System.Collections.Generic;
using UnityEngine;

namespace T0World;

public class T0BathSelectMain : MonoBehaviour
{
	public HorusBathCharacterEnum currentSelectType = HorusBathCharacterEnum.RANDOM;

	public List<T0BathSelectItem> selectList;

	public bool isOpenBath;

	private T0WorldDataContext_Horus horusContext;

	private void Awake()
	{
		InitBathData();
		horusContext = T0WorldScene.Scene.dataContext as T0WorldDataContext_Horus;
		currentSelectType = horusContext.bathSelect;
		UpdateSelectList();
		InitSelectListListener();
	}

	private void InitBathData()
	{
		object[] array = LuaHelper.CallFunction("T0WorldCheckConditionMeet", 1, 121004);
		isOpenBath = array != null && array.Length != 0 && (bool)array[0];
	}

	private int GetToSDKCharacterID(HorusBathCharacterEnum selectType)
	{
		return selectType switch
		{
			HorusBathCharacterEnum.RANDOM => 0, 
			HorusBathCharacterEnum.HORUS => 104402, 
			HorusBathCharacterEnum.KINU => 117001, 
			HorusBathCharacterEnum.OSIRIS => 121102, 
			HorusBathCharacterEnum.WUCHANG => 105401, 
			_ => 0, 
		};
	}

	public void OnClickSelectItem(HorusBathCharacterEnum selectType)
	{
		if (isOpenBath)
		{
			currentSelectType = selectType;
			horusContext.bathSelect = currentSelectType;
			UpdateSelectList();
			int sdkExtraType = 6;
			int toSDKCharacterID = GetToSDKCharacterID(selectType);
			T0SDKSystem.SendSDKData(new T0SDKData
			{
				sdkExtraType = sdkExtraType,
				characterID = toSDKCharacterID,
				sdkType = 9
			});
		}
	}

	public void UpdateSelectList()
	{
		foreach (T0BathSelectItem select in selectList)
		{
			if (select.characterType == currentSelectType && isOpenBath)
			{
				select.SetSelectState(select: true);
			}
			else
			{
				select.SetSelectState(select: false);
			}
			select.UpdateSelectUI();
		}
	}

	public void InitSelectListListener()
	{
		foreach (T0BathSelectItem select in selectList)
		{
			select.SetClickCallback(OnClickSelectItem);
		}
	}
}
