using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkinPreViewWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private TextMeshProUGUI skinName;

	[SerializeField]
	private TextMeshProUGUI skinDesc;

	[SerializeField]
	private RectTransform heroSpineRect;

	[SerializeField]
	private Image skinTagIcon;

	[SerializeField]
	private GameObject isUsing;

	[SerializeField]
	private GameObject pressButtonObj;

	[SerializeField]
	private Button pressButton;

	[SerializeField]
	private TextMeshProUGUI pressButtonText;

	[SerializeField]
	private TextMeshProUGUI skinStateText;

	[SerializeField]
	private LoopListView2 heroSkinList;

	[SerializeField]
	private ScrollRect scrollRect;

	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private float offset;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private Button showHeroBtn;

	[SerializeField]
	private Button hideHeroBtn;

	private HeroSkinPreViewViewModel viewModel;

	private GameObject heroSpine;

	private string skinPathCache;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HeroSkinPreViewViewModel>();
		BindingSet<HeroSkinPreViewWindow, HeroSkinPreViewViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HeroSkinPreViewWindow v) => v.OpenUguiWindow).To((HeroSkinPreViewViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((HeroSkinPreViewWindow v) => v.OnDismissRequest).To((HeroSkinPreViewViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HeroSkinPreViewViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPreViewViewModel vm) => vm.HeroName);
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPreViewViewModel vm) => vm.SkinName);
		bindingSet.Bind<TextMeshProUGUI>(skinDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPreViewViewModel vm) => vm.SkinDesc);
		bindingSet.Bind(isUsing).For((GameObject v) => v.activeSelf).To((HeroSkinPreViewViewModel vm) => vm.IsUsingCurrentSkin);
		bindingSet.Bind(pressButton).For((Button v) => v.onClick).To((HeroSkinPreViewViewModel vm) => vm.PressBtnCmd);
		bindingSet.Bind<TextMeshProUGUI>(pressButtonText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPreViewViewModel vm) => vm.PressButtonText);
		bindingSet.Bind(pressButtonObj).For((GameObject v) => v.activeSelf).To((HeroSkinPreViewViewModel vm) => vm.ShowPressButton);
		bindingSet.Bind(((Component)(object)skinStateText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinPreViewViewModel vm) => !string.IsNullOrEmpty(vm.SkinStateText));
		bindingSet.Bind<TextMeshProUGUI>(skinStateText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkinPreViewViewModel vm) => vm.SkinStateText);
		if (skinTagIcon != null)
		{
			bindingSet.Bind(skinTagIcon).For((Image v) => v.sprite).To((HeroSkinPreViewViewModel vm) => vm.SkinTagIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(skinTagIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSkinPreViewViewModel vm) => !string.IsNullOrEmpty(vm.SkinTagIcon));
		}
		bindingSet.Bind(this).For((HeroSkinPreViewWindow v) => v.SetSelectItemRequest).To((HeroSkinPreViewViewModel vm) => vm.SwitchHeroSkinRequest);
		bindingSet.Build();
		heroSkinList.InitListView(viewModel.HeroSkinItemList.Count, OnGetHeroSkinItemByIndex);
		LoadHeroSpine();
		heroSkinList.mOnBeginDragAction = HideSelectObj;
		heroSkinList.mOnEndDragAction = SetSelectItem;
		heroSkinList.MovePanelToItemIndex(viewModel.CurHeroSkinData.Sort, offset);
		ShowSelectObj();
		showHeroBtn.onClick.AddListener(delegate
		{
			PlayAnimation(2);
		});
		hideHeroBtn.onClick.AddListener(delegate
		{
			PlayAnimation(3);
		});
		if (viewModel.HeroSkinItemList.Count == 3)
		{
			scrollRect.horizontal = false;
		}
	}

	private void PlayAnimation(int index)
	{
		switch (index)
		{
		case 1:
			animator.SetTrigger(Animator.StringToHash("change"));
			break;
		case 2:
			animator.SetTrigger(Animator.StringToHash("showUI"));
			break;
		case 3:
			animator.SetTrigger(Animator.StringToHash("hideUI"));
			break;
		}
	}

	private void PlayHeroAnimation(object sender = null, InteractionEventArgs args = null)
	{
		if (heroSpine == null)
		{
			return;
		}
		SkeletonGraphic heroSkeletonGraphic = heroSpine.GetComponent<SkeletonGraphic>();
		if (!((UnityEngine.Object)(object)heroSkeletonGraphic == null) && (UnityEngine.Object)(object)heroSkeletonGraphic != null)
		{
			heroSkeletonGraphic.AnimationState.SetAnimation(0, "HomeLand_SailLight_Fly", loop: false);
			heroSkeletonGraphic.AnimationState.Complete += delegate
			{
				heroSkeletonGraphic.AnimationState.SetAnimation(0, "HomeLand_SailLight", loop: false);
			};
		}
	}

	private void StopHeroAnimation(object sender, InteractionEventArgs args)
	{
		if (!(heroSpine == null))
		{
			SkeletonGraphic component = heroSpine.GetComponent<SkeletonGraphic>();
			if (!((UnityEngine.Object)(object)component == null))
			{
				component.AnimationState.SetAnimation(0, "HomeLand_SailLight", loop: false);
			}
		}
	}

	private async void LoadHeroSpine(object sender = null, InteractionEventArgs e = null)
	{
		if (heroSpine != null)
		{
			ClearHeroSpine();
		}
		skinPathCache = AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(viewModel.SkinAssetPath));
		GameObject gameObject = await InstantiateAsync(skinPathCache, heroSpineRect);
		if (!(gameObject == null))
		{
			heroSpine = gameObject;
			UIUtilly.SpineMatchRectHelper(heroSpine, heroSpineRect, overwrite: false);
			StreamerMode.ApplySpineSkin(gameObject);
			PlayHeroAnimation();
		}
	}

	private void ClearHeroSpine()
	{
		if (!(heroSpine == null))
		{
			UnityEngine.Object.Destroy(heroSpine);
		}
	}

	private LoopListViewItem2 OnGetHeroSkinItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroSkinItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = ((viewModel.HeroSkinItemList[index].Sort == 0 || viewModel.HeroSkinItemList[index].Sort == 999) ? listView2.NewListViewItem("HeroSkinItemEmpty") : listView2.NewListViewItem("HeroSkinItem"));
		if (loopListViewItem != null)
		{
			HeroSkinItem component = loopListViewItem.GetComponent<HeroSkinItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroSkinItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroSkinItemList[index]);
			}
		}
		return loopListViewItem;
	}

	private void SetSelectItemRequest(object sender, InteractionEventArgs e)
	{
		SetSelectItem((int)e.Context);
		PlayAnimation(1);
	}

	private void SetSelectItem(int index)
	{
		if (index == 0)
		{
			index = 1;
		}
		else if (index >= viewModel.HeroSkinItemList.Count - 2)
		{
			index = viewModel.HeroSkinItemList.Count - 2;
		}
		heroSkinList.MovePanelToItemIndex(index, offset);
		if (viewModel.CurHeroSkinData.Sort != index)
		{
			viewModel.SelectSkinItem(index);
			LoadHeroSpine();
		}
		ShowSelectObj();
	}

	private void SetSelectItem()
	{
		int selectItem = (int)Mathf.Round(heroSkinList.ScrollRect.horizontalScrollbar.value * (float)viewModel.HeroSkinItemList.Count);
		SetSelectItem(selectItem);
	}

	private void HideSelectObj()
	{
		if (viewModel.HeroSkinItemList.Count != 3)
		{
			selectObj.SetActive(value: false);
		}
	}

	private void ShowSelectObj()
	{
		selectObj.SetActive(value: true);
	}

	protected override void OnDismiss()
	{
		base.OnDismiss();
		ClearHeroSpine();
	}
}
