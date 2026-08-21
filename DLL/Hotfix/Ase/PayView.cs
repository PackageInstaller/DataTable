using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PayView : UGuiView
{
	[SerializeField]
	private GameObject leftDayRoot;

	[SerializeField]
	private TextMeshProUGUI leftRewardDay;

	[SerializeField]
	private GameObject todayAlreadyGet;

	[SerializeField]
	private Button btnBuy;

	[SerializeField]
	private List<Image> rewardIcons;

	[SerializeField]
	private List<TextMeshProUGUI> rewardCounts;

	[SerializeField]
	private List<Image> dailyRewardIcons;

	[SerializeField]
	private TextMeshProUGUI dailyRewardCount;

	[SerializeField]
	private TextMeshProUGUI dailyRewardTotalCount;

	[SerializeField]
	private TextMeshProUGUI btnText;

	private PayViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<PayViewModel>(userData);
		BindingSet<PayView, PayViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(leftRewardDay).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PayViewModel vm) => (vm.LeftRewardDay < 5) ? $"剩余领取天数：<color=red>{vm.LeftRewardDay}</color>" : $"剩余领取天数：{vm.LeftRewardDay}");
		bindingSet.Bind(leftDayRoot).For((GameObject v) => v.activeSelf).ToExpression((PayViewModel vm) => vm.LeftRewardDay > 0);
		bindingSet.Bind(todayAlreadyGet).For((GameObject v) => v.activeSelf).To((PayViewModel vm) => vm.TodayAlreadyGet);
		if (rewardIcons != null)
		{
			foreach (Image rewardIcon in rewardIcons)
			{
				if (!(rewardIcon == null))
				{
					bindingSet.Bind(rewardIcon).For((Image v) => v.sprite).To((PayViewModel vm) => vm.RewardIcon)
						.WithConversion("ItemIcon");
				}
			}
		}
		if (rewardCounts != null)
		{
			foreach (TextMeshProUGUI rewardCount in rewardCounts)
			{
				if (!((UnityEngine.Object)(object)rewardCount == null))
				{
					bindingSet.Bind<TextMeshProUGUI>(rewardCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PayViewModel vm) => vm.RewardCount);
				}
			}
		}
		if (dailyRewardIcons != null)
		{
			foreach (Image dailyRewardIcon in dailyRewardIcons)
			{
				if (!(dailyRewardIcon == null))
				{
					bindingSet.Bind(dailyRewardIcon).For((Image v) => v.sprite).To((PayViewModel vm) => vm.DailyRewardIcon)
						.WithConversion("ItemIcon");
				}
			}
		}
		bindingSet.Bind<TextMeshProUGUI>(dailyRewardCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PayViewModel vm) => vm.DailyRewardCount);
		bindingSet.Bind<TextMeshProUGUI>(dailyRewardTotalCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PayViewModel vm) => vm.DailyRewardCount * 30);
		bindingSet.Bind(btnBuy).For((Button v) => v.onClick).To((PayViewModel vm) => vm.BuyCmd);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PayViewModel vm) => vm.BtnText);
		bindingSet.Build();
	}
}
