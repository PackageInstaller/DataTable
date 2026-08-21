using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameHeroInfoItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private Button button;

	[SerializeField]
	private GameObject normalObj;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private TextMeshProUGUI lockText;

	[SerializeField]
	private GameObject redPoint;

	private GameHeroInfoItemData viewModel;

	public void Init(GameHeroInfoItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<GameHeroInfoItem, GameHeroInfoItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((GameHeroInfoItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)title != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameHeroInfoItemData vm) => vm.Title);
		}
		if ((UnityEngine.Object)(object)desc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameHeroInfoItemData vm) => vm.Desc);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((GameHeroInfoItemData vm) => vm.OnClick);
		}
		if (lockObj != null)
		{
			bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((GameHeroInfoItemData vm) => vm.IsLock);
		}
		if (normalObj != null)
		{
			bindingSet.Bind(normalObj).For((GameObject v) => v.activeSelf).ToExpression((GameHeroInfoItemData vm) => !vm.IsLock);
		}
		if ((UnityEngine.Object)(object)lockText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(lockText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameHeroInfoItemData vm) => vm.LockText);
		}
		bindingSet.Build();
	}

	public void RefreshInfoData(GameHeroInfoItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
