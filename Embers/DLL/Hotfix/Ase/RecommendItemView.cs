using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RecommendItemView : UGuiView
{
	public Button btnSelect;

	public Image buffIcon;

	public TextMeshProUGUI buffName;

	public TextMeshProUGUI buffDesc;

	public GameObject selectRoot;

	public CopyTeamItemView heroItemTempl;

	public RectTransform heroRoot;

	private RecommendItemViewModel viewModel;

	private List<CopyTeamItemView> heroItems;

	public new void Init(object userData)
	{
		OnInit(userData);
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<RecommendItemViewModel>(userData);
		BindingSet<RecommendItemView, RecommendItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (btnSelect != null)
		{
			bindingSet.Bind(btnSelect).For((Button v) => v.onClick).To((RecommendItemViewModel vm) => vm.OptCommand)
				.CommandParameter("Select");
		}
		if (buffIcon != null)
		{
			bindingSet.Bind(buffIcon).For((Image v) => v.sprite).To((RecommendItemViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)buffName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RecommendItemViewModel vm) => vm.Name);
		}
		if ((UnityEngine.Object)(object)buffDesc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RecommendItemViewModel vm) => vm.Desc);
		}
		if (selectRoot != null)
		{
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((RecommendItemViewModel vm) => vm.IsSelect);
		}
		bindingSet.Build();
		BuildHeroItems();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<RecommendItemViewModel>(userData);
		this.SetDataContext(viewModel);
		BuildHeroItems();
	}

	private void BuildHeroItems()
	{
		if (heroRoot == null || heroItemTempl == null || viewModel == null)
		{
			return;
		}
		if (heroItems == null)
		{
			heroItems = new List<CopyTeamItemView>();
		}
		heroItemTempl.gameObject.SetActive(value: false);
		for (int i = 0; i < viewModel.HeroItems.Count; i++)
		{
			CopyTeamItemView copyTeamItemView;
			if (heroItems.Count > i)
			{
				copyTeamItemView = heroItems[i];
			}
			else
			{
				copyTeamItemView = UnityEngine.Object.Instantiate(heroItemTempl.gameObject, heroRoot).GetComponent<CopyTeamItemView>();
				heroItems.Add(copyTeamItemView);
			}
			copyTeamItemView.gameObject.SetActive(value: true);
			copyTeamItemView.Init(viewModel.HeroItems[i]);
		}
		for (int j = viewModel.HeroItems.Count; j < heroItems.Count; j++)
		{
			heroItems[j].gameObject.SetActive(value: false);
		}
	}
}
