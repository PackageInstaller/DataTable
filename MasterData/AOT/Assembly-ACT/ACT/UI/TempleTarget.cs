using System.Linq;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TempleTarget : MonoBehaviour
{
	public LocalizeStringEvent targetDes;

	public GameObject normalState;

	public GameObject hideState;

	private bool _isComplate;

	public bool IsComplate => _isComplate;

	public void Init(int index, TempleData data)
	{
		switch (index)
		{
		case 0:
			targetDes.OnUpdateString.Invoke(LocalizationUtility.GetLocalizeString("longcommon", data.staticData.collection1Text));
			break;
		case 1:
			targetDes.OnUpdateString.Invoke(LocalizationUtility.GetLocalizeString("longcommon", data.staticData.collection2Text));
			break;
		case 2:
			targetDes.OnUpdateString.Invoke(LocalizationUtility.GetLocalizeString("longcommon", data.staticData.collection3Text));
			break;
		}
		if (index == 0)
		{
			normalState.SetActive(data.isComplate);
			hideState.SetActive(!data.isComplate);
			return;
		}
		int num = data.gotStars.Count((bool s) => s) - (data.isComplate ? 1 : 0);
		normalState.SetActive(num >= index);
		hideState.SetActive(num < index);
		_isComplate = normalState.gameObject.activeSelf;
	}

	public void UpdateState(int index, int areaId, bool isComplete)
	{
		_isComplate = isComplete;
		normalState.SetActive(isComplete);
		hideState.SetActive(!isComplete);
		AddAreaStartCountEvt evt = Singleton<EventManager>.instance.GetEvt<AddAreaStartCountEvt>();
		evt.AreaId = areaId;
		evt.AddStarCount = 1;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UpdateAreaStarCount, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
