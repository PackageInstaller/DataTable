using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardSingleWindow : UGuiWindow
{
	[SerializeField]
	private Button finalBtn;

	[SerializeField]
	private Button nextBtn;

	[SerializeField]
	private Image rarityImg;

	[SerializeField]
	private GameObject roleRoot;

	[SerializeField]
	private Transform roleImgPos;

	[SerializeField]
	private TextMeshProUGUI roleName;

	[SerializeField]
	private TextMeshProUGUI roleTitle;

	[SerializeField]
	private Image roleAttribute;

	[SerializeField]
	private Image roleRarity;

	[SerializeField]
	private TextMeshProUGUI painter;

	[SerializeField]
	private GameObject weaponRoot;

	[SerializeField]
	private Transform weaponPos;

	[SerializeField]
	private TextMeshProUGUI weaponName;

	[SerializeField]
	private Image weaponRarity;

	[SerializeField]
	private TextMeshProUGUI weaponEnum;

	[SerializeField]
	private GameObject newResult;

	[SerializeField]
	private LoopListView2 resultList;

	[SerializeField]
	private GameObject repeatObj;

	[SerializeField]
	private TextMeshProUGUI repeatTitle;

	[SerializeField]
	private TextMeshProUGUI copyWritingText;

	private DrawCardSingleViewModel viewModel;

	private GameObject createObj;

	private string heroOriPath;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardSingleViewModel>();
		BindingSet<DrawCardSingleWindow, DrawCardSingleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DrawCardSingleWindow v) => v.CloseWindow).To((DrawCardSingleViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(finalBtn).For((Button v) => v.onClick).To((DrawCardSingleViewModel vm) => vm.OpenFinal);
		bindingSet.Bind(nextBtn).For((Button v) => v.onClick).To((DrawCardSingleViewModel vm) => vm.Next);
		bindingSet.Bind(rarityImg).For((Image v) => v.sprite).ToExpression((DrawCardSingleViewModel vm) => $"Hero/HeroGrowRarity/SeatIcon{vm.Rarity}_1104")
			.WithConversion("ItemIcon");
		if (viewModel.IsHero)
		{
			bindingSet.Bind(roleRoot).For((GameObject v) => v.activeSelf).To((DrawCardSingleViewModel vm) => vm.IsHero);
			bindingSet.Bind<TextMeshProUGUI>(roleName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardSingleViewModel vm) => vm.HeroModel.Name);
			bindingSet.Bind(roleAttribute).For((Image v) => v.sprite).ToExpression((DrawCardSingleViewModel vm) => $"hero_attr_{(int)vm.HeroModel.Attribute}")
				.WithConversion("ItemIcon");
			bindingSet.Bind(roleRarity).For((Image v) => v.sprite).ToExpression((DrawCardSingleViewModel vm) => $"Hero_Seat_{vm.Rarity}")
				.WithConversion("ItemIcon");
			bindingSet.Bind<TextMeshProUGUI>(roleTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardSingleViewModel vm) => vm.HeroModel.Title);
			bindingSet.Bind<TextMeshProUGUI>(painter).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DrawCardSingleViewModel vm) => $"画师:{vm.HeroModel.PainterName}");
			LoadHeroResult();
		}
		else
		{
			bindingSet.Bind(weaponRoot).For((GameObject v) => v.activeSelf).ToExpression((DrawCardSingleViewModel vm) => !vm.IsHero);
			bindingSet.Bind<TextMeshProUGUI>(weaponName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardSingleViewModel vm) => vm.WeaponData.Name);
			bindingSet.Bind(weaponRarity).For((Image v) => v.sprite).ToExpression((DrawCardSingleViewModel vm) => $"Hero_Seat_{vm.Rarity}")
				.WithConversion("ItemIcon");
			bindingSet.Bind<TextMeshProUGUI>(weaponEnum).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardSingleViewModel vm) => vm.WeaponEnumName);
			LoadWeaponResult();
		}
		bindingSet.Bind<TextMeshProUGUI>(copyWritingText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardSingleViewModel vm) => vm.CopyWritingText);
		bindingSet.Bind(newResult).For((GameObject v) => v.activeSelf).To((DrawCardSingleViewModel vm) => vm.IsNew);
		bindingSet.Build();
		LoadImg();
		resultList.InitListView(viewModel.KnapsackItemViewModels.Count, GetKnapsackPropByIndex);
		repeatObj.SetActive(viewModel.KnapsackItemViewModels.Count > 0);
		finalBtn.gameObject.SetActive(viewModel.IsShowFinal);
	}

	public void PlayAudio()
	{
		viewModel.PlayAudio();
	}

	private async void LoadHeroResult()
	{
		heroOriPath = AssetUtility.GetUIItemAsset(viewModel.HeroModel.Original);
		GameObject gameObject = (createObj = await InstantiateAsync(heroOriPath, roleImgPos));
		UIUtilly.SpineMatchRectHelper(createObj, roleImgPos, overwrite: false);
		StreamerMode.ApplySpineSkin(gameObject);
		((TMP_Text)repeatTitle).text = (viewModel.IsNew ? "额外获得" : "重复角色将转化为");
	}

	private async void LoadWeaponResult()
	{
		string uIItemAsset = AssetUtility.GetUIItemAsset("WeaponPrefabs/" + viewModel.WeaponData.Icon);
		createObj = await InstantiateAsync(uIItemAsset, weaponPos);
		UIStarGroup componentInChildren = createObj.GetComponentInChildren<UIStarGroup>();
		if (componentInChildren != null)
		{
			componentInChildren.CurCount = 1;
		}
		((TMP_Text)repeatTitle).text = "额外获得";
	}

	private async void LoadImg()
	{
		string textureAsset = AssetUtility.GetTextureAsset($"Hero/HeroGrowRarity/SeatIcon{viewModel.Rarity}_1104");
		Image image = rarityImg;
		image.sprite = await LoadSpriteAsync(textureAsset);
	}

	private LoopListViewItem2 GetKnapsackPropByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.KnapsackItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.KnapsackItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.KnapsackItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (createObj != null)
		{
			UnityEngine.Object.Destroy(createObj);
		}
		Dismiss();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
