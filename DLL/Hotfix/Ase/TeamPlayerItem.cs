using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeamPlayerItem : MonoBehaviour
{
	[SerializeField]
	private new Text name;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI advLevel;

	[SerializeField]
	private GameObject noPlayer;

	[SerializeField]
	private GameObject hasPlayer;

	public void Init(TeamPlayerItemData viewModel)
	{
		BindingSet<TeamPlayerItem, TeamPlayerItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(name).For((Text v) => v.text).ToExpression((TeamPlayerItemData vm) => vm.PlayerName);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((TeamPlayerItemData vm) => $"UserHead{vm.Icon}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(advLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TeamPlayerItemData vm) => $"{vm.AdvLevel}");
		bindingSet.Bind(noPlayer).For((GameObject v) => v.activeSelf).ToExpression((TeamPlayerItemData vm) => !vm.HasPlayer);
		bindingSet.Bind(hasPlayer).For((GameObject v) => v.activeSelf).ToExpression((TeamPlayerItemData vm) => vm.HasPlayer);
		bindingSet.Build();
	}

	public void RefreshData(TeamPlayerItemData viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
