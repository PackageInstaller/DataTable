using System;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TimeAndDesItem : MonoBehaviour
{
	public ActButton desBtn;

	public LocalizeStringEvent nameText;

	public LocalizeStringEvent desText;

	public CommonTimerComponent timer;

	private ActivityCenterData _activityCenterData;

	private long endTime = -1L;

	public void Init(ActivityCenterData activityCenterData, long endTime = -1L)
	{
		if (_activityCenterData != null)
		{
			ActivityCenterData activityCenterData2 = _activityCenterData;
			activityCenterData2.OnUpdateData = (Action)Delegate.Remove(activityCenterData2.OnUpdateData, new Action(OnActivityCenterDataUpdate));
		}
		_activityCenterData = activityCenterData;
		if (_activityCenterData != null)
		{
			ActivityCenterData activityCenterData3 = _activityCenterData;
			activityCenterData3.OnUpdateData = (Action)Delegate.Remove(activityCenterData3.OnUpdateData, new Action(OnActivityCenterDataUpdate));
			ActivityCenterData activityCenterData4 = _activityCenterData;
			activityCenterData4.OnUpdateData = (Action)Delegate.Combine(activityCenterData4.OnUpdateData, new Action(OnActivityCenterDataUpdate));
			this.endTime = endTime;
			Refresh();
		}
	}

	private void Refresh()
	{
		if (_activityCenterData?.ServerActivityData == null || _activityCenterData.StaticActivityData == null)
		{
			return;
		}
		if (timer != null)
		{
			endTime = ((endTime > 0) ? endTime : _activityCenterData.ServerActivityData.EndTime);
			long num = endTime - TimeManager.ServerTime.NowTimestamp;
			if (num * 10000 >= 3153600000000000L)
			{
				CommonTimerComponent commonTimerComponent = timer;
				DateTime minValue = DateTime.MinValue;
				commonTimerComponent.Time = minValue.Add(TimeSpan.FromMilliseconds(num));
			}
			else
			{
				CommonTimerComponent commonTimerComponent2 = timer;
				DateTime minValue = DateTime.MinValue;
				commonTimerComponent2.Time = minValue.Add(TimeSpan.FromMilliseconds(num));
				timer.IsCountDown = true;
			}
		}
		if (nameText != null)
		{
			nameText.StringReference.TableEntryReference = _activityCenterData.StaticActivityData.activityName;
		}
		if (desText != null)
		{
			desText.gameObject.SetActive(_activityCenterData.StaticActivityData.activityIntroduction != 0);
			desText.StringReference.TableEntryReference = _activityCenterData.StaticActivityData.activityIntroduction;
		}
		if (desBtn != null)
		{
			desBtn.SetBtnClick(OnClickActivityDetailButtonHandle, "event:/UI/Interface/Activity/Explain");
		}
	}

	public async void OnClickActivityDetailButtonHandle()
	{
		if (_activityCenterData?.StaticActivityData != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				descTextId = _activityCenterData.StaticActivityData.activityDesc,
				iconId = 3001,
				titleTextId = _activityCenterData.StaticActivityData.activityName
			});
		}
	}

	private void OnActivityCenterDataUpdate()
	{
		Refresh();
	}

	private void OnDestroy()
	{
		if (_activityCenterData != null)
		{
			ActivityCenterData activityCenterData = _activityCenterData;
			activityCenterData.OnUpdateData = (Action)Delegate.Remove(activityCenterData.OnUpdateData, new Action(OnActivityCenterDataUpdate));
		}
	}
}
