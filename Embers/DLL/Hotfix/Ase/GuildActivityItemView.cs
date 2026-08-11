#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildActivityItemView : UGuiView
{
	public string lackCountColor = "#ff8a7a";

	public int modeType;

	public ShowInfoItem showInfoItem;

	public Button btnOpen;

	public List<TextMeshProUGUI> openTimeList;

	public GameObject open;

	public GameObject unOpen;

	private string openTimes;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI score;

	public TextMeshProUGUI copyName;

	public TextMeshProUGUI challengeCount;

	public TextMeshProUGUI leftTime;

	private GuildActivityItemViewModel viewModel;

	public GuildActivityItemViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
				return;
			}
			viewModel = value;
			this.SetDataContext(viewModel);
		}
	}

	public string OpenTimes
	{
		get
		{
			return openTimes;
		}
		set
		{
			openTimes = value;
			SetOpenTimes(openTimes);
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			viewModel = GetUserData<GuildActivityItemViewModel>(userData);
			this.SetDataContext(viewModel);
			return;
		}
		base.OnInit(userData);
		viewModel = GetUserData<GuildActivityItemViewModel>(userData);
		BindingSet<GuildActivityItemView, GuildActivityItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (modeType == 1)
		{
			bindingSet.Bind(btnOpen).For((Button v) => v.onClick).To((GuildActivityItemViewModel vm) => vm.OpenActivity);
			bindingSet.Bind(open).For((GameObject v) => v.activeSelf).ToExpression((GuildActivityItemViewModel vm) => !vm.Data.IsLock);
			bindingSet.Bind(unOpen).For((GameObject v) => v.activeSelf).To((GuildActivityItemViewModel vm) => vm.Data.IsLock);
			bindingSet.Bind<TextMeshProUGUI>(copyName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildActivityItemViewModel vm) => vm.Data.CurCopyName);
			bindingSet.Bind(this).For((GuildActivityItemView v) => v.OpenTimes).To((GuildActivityItemViewModel vm) => vm.Data.OpenTimeString);
		}
		if (modeType == 0)
		{
			bindingSet.Bind<TextMeshProUGUI>(score).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildActivityItemViewModel vm) => vm.Data.FinalScore);
		}
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildActivityItemViewModel vm) => vm.Data.Name);
		bindingSet.Bind<TextMeshProUGUI>(challengeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildActivityItemViewModel vm) => (vm.Data.CurChallengeCount <= 0) ? $"<color={lackCountColor}>{vm.Data.CurChallengeCount}</color>/{vm.Data.MaxChallengeCount}" : $"{vm.Data.CurChallengeCount}/{vm.Data.MaxChallengeCount}");
		bindingSet.Bind<TextMeshProUGUI>(leftTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildActivityItemViewModel vm) => vm.Data.LeftTime);
		bindingSet.Build();
		if (showInfoItem != null)
		{
			showInfoItem.Init();
		}
		GetComponent<UIRedPoint>()?.Dispose();
		GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildActivityUnread).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GuildActivityUnread)
			.Invoke();
	}

	private void SetOpenTimes(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return;
			}
			if (openTimeList == null || openTimeList.Count == 0)
			{
				Log.Error("预制体开放时间配置异常！");
				return;
			}
			string[] array = value.Split('|');
			int num = 0;
			for (int i = 0; i < array.Length; i++)
			{
				if (openTimeList.Count <= num)
				{
					continue;
				}
				for (int j = num; j < openTimeList.Count; j++)
				{
					if (!((UnityEngine.Object)(object)openTimeList[j] == null))
					{
						((TMP_Text)openTimeList[j]).text = array[i];
						num = j + 1;
						break;
					}
				}
			}
			for (int k = num; k < openTimeList.Count; k++)
			{
				if ((UnityEngine.Object)(object)openTimeList[k] != null)
				{
					((TMP_Text)openTimeList[k]).text = "";
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("处理时间字段发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
	}
}
