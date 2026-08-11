using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankItem : UGuiView
{
	[SerializeField]
	private Image itemBg;

	[SerializeField]
	private Image rankBg;

	[SerializeField]
	private TextMeshProUGUI rankText;

	[SerializeField]
	private TextMeshProUGUI scoreText;

	[SerializeField]
	private List<RankSeatItem> players;

	[SerializeField]
	private List<HeroItem> heroes;

	[SerializeField]
	private Image rankCustomIcon1;

	[SerializeField]
	private Text rankInfo1;

	[SerializeField]
	private TextMeshProUGUI rankInfo2;

	[SerializeField]
	private TextMeshProUGUI rankInfo3;

	[SerializeField]
	private Button btnItem;

	private RankItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<RankItemData>(userData);
		BindingSet<RankItem, RankItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(itemBg).For((Image v) => v.sprite).ToExpression((RankItemData vm) => $"rank_itemBg_{vm.ItemRank}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(((Component)(object)rankText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((RankItemData vm) => vm.ItemRank <= 0);
		bindingSet.Bind<TextMeshProUGUI>(rankText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((RankItemData vm) => (vm.Rank > 0) ? vm.Rank.ToString() : "未上榜");
		bindingSet.Bind<TextMeshProUGUI>(scoreText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankItemData vm) => vm.ScoreText);
		bindingSet.Bind(rankBg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((RankItemData vm) => vm.ItemRank > 0);
		bindingSet.Bind(rankBg).For((Image v) => v.sprite).ToExpression((RankItemData vm) => $"rank_icon_{vm.ItemRank}")
			.WithConversion("ItemIcon");
		if (btnItem != null)
		{
			bindingSet.Bind(btnItem).For((Button v) => v.enabled).To((RankItemData vm) => vm.ItemBtnEnable);
			bindingSet.Bind(btnItem).For((Button v) => v.onClick).To((RankItemData vm) => vm.OnItemClick);
		}
		if (rankCustomIcon1 != null)
		{
			bindingSet.Bind(rankCustomIcon1).For((Image v) => v.sprite).To((RankItemData vm) => vm.CustomIcon1)
				.WithConversion("ItemIcon");
		}
		if (rankInfo1 != null)
		{
			bindingSet.Bind(rankInfo1).For((Text v) => v.text).To((RankItemData vm) => vm.RankInfo1);
		}
		if ((UnityEngine.Object)(object)rankInfo2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(rankInfo2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankItemData vm) => vm.RankInfo2);
		}
		if ((UnityEngine.Object)(object)rankInfo3 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(rankInfo3).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RankItemData vm) => vm.RankInfo3);
		}
		bindingSet.Bind().For((RankItem v) => v.Refresh).To((RankItemData vm) => vm.RefreshRequest);
		bindingSet.Build();
		Refresh();
	}

	private void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		if (players != null)
		{
			for (int i = 0; i < players.Count; i++)
			{
				RankSeatItem rankSeatItem = players[i];
				if (_viewModel.PlayerDatas.Count <= i)
				{
					rankSeatItem.gameObject.SetActive(value: false);
					continue;
				}
				RankSeatItemData rankSeatItemData = _viewModel.PlayerDatas[i];
				if (!rankSeatItem.IsInitHandlerCalled)
				{
					rankSeatItem.Init(rankSeatItemData);
				}
				else
				{
					rankSeatItem.RefreshData(rankSeatItemData);
				}
				rankSeatItem.gameObject.SetActive(value: true);
			}
		}
		if (heroes == null)
		{
			return;
		}
		for (int j = 0; j < heroes.Count; j++)
		{
			HeroItem heroItem = heroes[j];
			if (!_viewModel.ShowHeroes)
			{
				heroItem.gameObject.SetActive(value: false);
				continue;
			}
			HeroItemViewModel heroItemViewModel;
			if (_viewModel.HeroIds.Count <= j)
			{
				heroItemViewModel = new HeroItemViewModel(_viewModel, HeroModel.CreateEmpty());
			}
			else
			{
				heroItemViewModel = new HeroItemViewModel(_viewModel, HeroModel.CreateByConfig(_viewModel.HeroIds[j]));
				heroItemViewModel.ShowCustomTag = _viewModel.PlayerSelectHeroId > 0 && _viewModel.HeroIds[j] == _viewModel.PlayerSelectHeroId;
			}
			if (!heroItem.IsInitHandlerCalled)
			{
				heroItem.Init(heroItemViewModel);
			}
			else
			{
				heroItem.RefreshData(heroItemViewModel);
			}
			heroItem.gameObject.SetActive(value: true);
		}
	}

	public void RefreshData(RankItemData itemData)
	{
		_viewModel = itemData;
		this.SetDataContext(itemData);
		Refresh();
	}
}
