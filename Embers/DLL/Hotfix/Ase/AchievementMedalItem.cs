using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchievementMedalItem : UGuiView
{
	[SerializeField]
	private Image medalRarity;

	[SerializeField]
	private Image medalIcon;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private UIStarGroup uiStarGroup;

	[SerializeField]
	private TextMeshProUGUI rate;

	[SerializeField]
	private GameObject completeObj;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private Button openBtn;

	[SerializeField]
	private GameObject redPoint;

	private AchievementMedalItemData viewModel;

	public void Init(AchievementMedalItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AchievementMedalItem, AchievementMedalItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(medalRarity).For((Image v) => v.sprite).ToExpression((AchievementMedalItemData vm) => $"achievements_list_item_{vm.MedalRarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(medalIcon).For((Image v) => v.sprite).ToExpression((AchievementMedalItemData vm) => vm.MedalIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(medalIcon).For((Image v) => v.color).To((AchievementMedalItemData vm) => vm.Color);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementMedalItemData vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementMedalItemData vm) => vm.Desc);
		bindingSet.Bind<TextMeshProUGUI>(rate).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AchievementMedalItemData vm) => vm.Rate);
		bindingSet.Bind(completeObj).For((GameObject v) => v.activeSelf).To((AchievementMedalItemData vm) => vm.IsComplete);
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).ToExpression((AchievementMedalItemData vm) => vm.Curstar == 0);
		bindingSet.Bind(openBtn).For((Button v) => v.onClick).To((AchievementMedalItemData vm) => vm.OpenAchievementStageWindow);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((AchievementMedalItemData vm) => vm.ShowRedPoint);
		bindingSet.Build();
		SetStar(viewModel.Curstar, viewModel.MaxStar);
	}

	private void SetStar(int curStar, int maxStar)
	{
		if (viewModel.MaxStar == 1)
		{
			uiStarGroup.GetComponent<Transform>().gameObject.SetActive(value: false);
			return;
		}
		uiStarGroup.GetComponent<Transform>().gameObject.SetActive(value: true);
		uiStarGroup.MaxCount = maxStar;
		uiStarGroup.CurCount = curStar;
	}

	public void RefreshAchievementMedalData(AchievementMedalItemData viewModel)
	{
		this.viewModel = viewModel;
		SetStar(viewModel.Curstar, viewModel.MaxStar);
		this.SetDataContext(viewModel);
	}
}
