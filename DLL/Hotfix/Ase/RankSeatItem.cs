using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankSeatItem : PlayerItemBase
{
	[SerializeField]
	private Image heroIcon;

	[SerializeField]
	private GameObject empty;

	[SerializeField]
	private List<GameObject> validGos;

	[SerializeField]
	private List<GameObject> unValidGos;

	[SerializeField]
	private Button btnPlayerInfo;

	private RankSeatItemData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<RankSeatItemData>(userData);
		BindingSet<RankSeatItem, RankSeatItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (heroIcon != null)
		{
			bindingSet.Bind(heroIcon).For((Image v) => v.sprite).To((RankSeatItemData vm) => vm.HeroIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(heroIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((RankSeatItemData vm) => !vm.Empty);
		}
		if (title != null)
		{
			bindingSet.Bind(title.gameObject).For((GameObject v) => v.activeSelf).ToExpression((RankSeatItemData vm) => !vm.Empty && vm.TitleId > 0);
		}
		if (empty != null)
		{
			bindingSet.Bind(empty).For((GameObject v) => v.activeSelf).To((RankSeatItemData vm) => vm.Empty);
		}
		if (validGos != null)
		{
			foreach (GameObject validGo in validGos)
			{
				if (validGo != null)
				{
					bindingSet.Bind(validGo).For((GameObject v) => v.activeSelf).To((RankSeatItemData vm) => vm.Valid);
				}
			}
		}
		if (unValidGos != null)
		{
			foreach (GameObject unValidGo in unValidGos)
			{
				if (unValidGo != null)
				{
					bindingSet.Bind(unValidGo).For((GameObject v) => v.activeSelf).ToExpression((RankSeatItemData vm) => !vm.Valid);
				}
			}
		}
		if (btnPlayerInfo != null)
		{
			bindingSet.Bind(btnPlayerInfo).For((Button v) => v.enabled).To((RankSeatItemData vm) => vm.BtnEnable);
			bindingSet.Bind(btnPlayerInfo).For((Button v) => v.onClick).To((RankSeatItemData vm) => vm.OnItemClick);
		}
		bindingSet.Build();
	}

	public void RefreshData(RankSeatItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
		base.TitleId = _viewModel.TitleId;
	}
}
