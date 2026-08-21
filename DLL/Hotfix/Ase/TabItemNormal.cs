using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TabItemNormal : UGuiView
{
	[SerializeField]
	private GameObject selfObj;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image icon2;

	[SerializeField]
	private LoadUISpriteInGameMapNPC icon3;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private TextMeshProUGUI text2;

	[SerializeField]
	private GameObject exSelectedObj;

	[SerializeField]
	private GameObject cantOnClickObj;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private GameObject redPoint2;

	[SerializeField]
	private Image rarityNormal;

	[SerializeField]
	private Image raritySelect;

	[SerializeField]
	private Image color;

	[SerializeField]
	private Image color2;

	[SerializeField]
	private RectTransform assetRect;

	private string path;

	private GameObject loadAsset;

	private TabItemNormalData viewModel;

	private string assetPath;

	public void Init(TabItemNormalData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<TabItemNormal, TabItemNormalData> bindingSet = this.CreateBindingSet(viewModel);
		if (selfObj != null)
		{
			bindingSet.Bind(selfObj).For((GameObject v) => v.activeSelf).To((TabItemNormalData vm) => vm.IsShow);
		}
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((TabItemNormalData vm) => !vm.IsSelected && vm.CanOnClick);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).ToExpression((TabItemNormalData vm) => vm.IsSelected && vm.CanOnClick);
		}
		if (redPoint != null)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).ToExpression((TabItemNormalData vm) => vm.RedPoint);
		}
		if (redPoint2 != null)
		{
			bindingSet.Bind(redPoint2).For((GameObject v) => v.activeSelf).ToExpression((TabItemNormalData vm) => vm.RedPoint);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((TabItemNormalData vm) => vm.Img)
				.WithConversion("ItemIcon");
		}
		if (icon2 != null)
		{
			bindingSet.Bind(icon2).For((Image v) => v.sprite).To((TabItemNormalData vm) => vm.Img)
				.WithConversion("ItemIcon");
		}
		if (icon3 != null)
		{
			bindingSet.Bind(icon3).For((LoadUISpriteInGameMapNPC v) => v.Path).ToExpression((TabItemNormalData vm) => $"{vm.Img}.png");
		}
		if (exSelectedObj != null)
		{
			bindingSet.Bind(exSelectedObj).For((GameObject v) => v.activeSelf).To((TabItemNormalData vm) => vm.IsSelected);
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((TabItemNormalData vm) => vm.ItemOnclick);
		}
		if ((UnityEngine.Object)(object)text != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(text).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TabItemNormalData vm) => vm.Text);
		}
		if ((UnityEngine.Object)(object)text2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(text2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TabItemNormalData vm) => vm.Text);
		}
		if (cantOnClickObj != null)
		{
			bindingSet.Bind(cantOnClickObj).For((GameObject v) => v.activeSelf).ToExpression((TabItemNormalData vm) => !vm.CanOnClick);
		}
		if (rarityNormal != null)
		{
			bindingSet.Bind(rarityNormal).For((Image v) => v.sprite).To((TabItemNormalData vm) => vm.RarityImg)
				.WithConversion("ItemIcon");
		}
		if (raritySelect != null)
		{
			bindingSet.Bind(raritySelect).For((Image v) => v.sprite).To((TabItemNormalData vm) => vm.RarityImg)
				.WithConversion("ItemIcon");
		}
		if (color != null)
		{
			bindingSet.Bind(color).For((Image v) => v.color).To((TabItemNormalData vm) => vm.Color);
		}
		if (color2 != null)
		{
			bindingSet.Bind(color2).For((Image v) => v.color).To((TabItemNormalData vm) => vm.Color);
		}
		bindingSet.Build();
		LoadGameObject();
	}

	private async void LoadGameObject()
	{
		if (!(assetRect == null))
		{
			if (loadAsset != null)
			{
				UnityEngine.Object.Destroy(loadAsset);
			}
			assetPath = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.Img);
			GameObject gameObject = await InstantiateAsync(assetPath, assetRect);
			if (!(gameObject == null))
			{
				loadAsset = gameObject;
			}
		}
	}

	public void RefreshData(TabItemNormalData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
