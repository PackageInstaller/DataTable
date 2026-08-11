using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildRankItem : GuildItem
{
	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private Image rankIcon;

	[SerializeField]
	private GameObject rankPart;

	[SerializeField]
	private GameObject noRankPart;

	private GuildRankItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildRankItemData>(userData);
		BindingSet<GuildRankItem, GuildRankItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRankItemData vm) => vm.Rank);
		bindingSet.Bind(rankIcon).For((Image v) => v.sprite).To((GuildRankItemData vm) => vm.RankIcon)
			.WithConversion("ItemIcon");
		if (rankPart != null)
		{
			bindingSet.Bind(rankPart).For((GameObject v) => v.activeSelf).ToExpression((GuildRankItemData vm) => !vm.NoRank);
		}
		if (noRankPart != null)
		{
			bindingSet.Bind(noRankPart).For((GameObject v) => v.activeSelf).To((GuildRankItemData vm) => vm.NoRank);
		}
		bindingSet.Build();
	}

	public void RefreshData(GuildRankItemData newData)
	{
		_viewModel = newData;
		_viewModel.SetTextColor(textColorNormal, textColorSelected);
		this.SetDataContext(newData);
	}
}
