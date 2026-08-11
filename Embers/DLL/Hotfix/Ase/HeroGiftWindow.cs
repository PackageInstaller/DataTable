using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroGiftWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Transform spineRoot;

	[SerializeField]
	private GameObject voiceTextGo;

	[SerializeField]
	private TextMeshProUGUI voiceText;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private TextMeshProUGUI expText;

	[SerializeField]
	private Image trueExp;

	[SerializeField]
	private Image preExp;

	[SerializeField]
	private GameObject maxFeelingIcon;

	[SerializeField]
	private Image feelingProgress;

	[SerializeField]
	private TextMeshProUGUI feelingLevelText;

	[SerializeField]
	private TextMeshProUGUI feelingLevelDesc;

	[SerializeField]
	private LoopListView2 giftScrollView;

	[SerializeField]
	private GameObject noGift;

	[SerializeField]
	private Button btnSend;

	[SerializeField]
	private GameObject windowMask;

	[SerializeField]
	private float levelUpTweenDuration = 2f;

	[SerializeField]
	private float tipsTime = 3f;

	private HeroGiftViewModel _viewModel;

	private GameObject _heroSpine;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroGiftViewModel>();
		_viewModel.LevelUpTweenDuration = levelUpTweenDuration;
		_viewModel.TipsTime = tipsTime;
		BindingSet<HeroGiftWindow, HeroGiftViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((HeroGiftWindow v) => v.OpenUguiWindow).To((HeroGiftViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroGiftWindow v) => v.OnDismissRequest).To((HeroGiftViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HeroGiftViewModel vm) => vm.Close);
		bindingSet.Bind(voiceTextGo).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => !string.IsNullOrEmpty(vm.VoiceText));
		bindingSet.Bind<TextMeshProUGUI>(voiceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGiftViewModel vm) => vm.VoiceText);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGiftViewModel vm) => vm.HeroName);
		bindingSet.Bind<TextMeshProUGUI>(expText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroGiftViewModel vm) => $"{vm.ExpDisplay}/{vm.ExpMaxDisplay}");
		bindingSet.Bind(trueExp.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => vm.IsTweening || vm.LevelCurrent.Equals(vm.LevelDisplay));
		bindingSet.Bind(trueExp).For((Image v) => v.fillAmount).ToExpression((HeroGiftViewModel vm) => (float)vm.ExpCurrent / (float)vm.ExpMax);
		bindingSet.Bind(preExp.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => !vm.IsTweening && (!vm.LevelCurrent.Equals(vm.LevelDisplay) || !vm.ExpCurrent.Equals(vm.ExpDisplay)));
		bindingSet.Bind(preExp).For((Image v) => v.fillAmount).ToExpression((HeroGiftViewModel vm) => (float)vm.ExpDisplay / (float)vm.ExpMaxDisplay);
		bindingSet.Bind(maxFeelingIcon).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => vm.LevelDisplay.Equals(vm.LevelMax));
		bindingSet.Bind(feelingProgress.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => !vm.LevelDisplay.Equals(vm.LevelMax));
		bindingSet.Bind(feelingProgress).For((Image v) => v.fillAmount).ToExpression((HeroGiftViewModel vm) => (float)vm.ExpDisplay / (float)vm.ExpMaxDisplay);
		bindingSet.Bind(((Component)(object)feelingLevelText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => !vm.LevelDisplay.Equals(vm.LevelMax));
		bindingSet.Bind<TextMeshProUGUI>(feelingLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGiftViewModel vm) => vm.LevelDisplay);
		bindingSet.Bind<TextMeshProUGUI>(feelingLevelDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGiftViewModel vm) => vm.LevelDescDisplay);
		bindingSet.Bind(btnSend).For((Button v) => v.onClick).To((HeroGiftViewModel vm) => vm.SendGiftCmd);
		bindingSet.Bind().For((HeroGiftWindow v) => v.OnGiftItemListChanged).To((HeroGiftViewModel vm) => vm.GiftItemListChanged);
		bindingSet.Bind(windowMask).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftViewModel vm) => vm.WindowMaskLeftTime > 0f);
		bindingSet.Build();
		InitHeroSpine();
		giftScrollView.InitListView(_viewModel.GiftDatas.Count, OnGetGiftItemByIndex);
		giftScrollView.gameObject.SetActive(_viewModel.GiftDatas.Count > 0);
		noGift.SetActive(_viewModel.GiftDatas.Count <= 0);
	}

	private void Update()
	{
		if (!(_viewModel.WindowMaskLeftTime <= 0f))
		{
			_viewModel.WindowMaskLeftTime -= Time.deltaTime;
		}
	}

	private async void InitHeroSpine()
	{
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(_viewModel.HeroModel.Original), spineRoot);
		if (gameObject == null)
		{
			Toast.ShowError("找不到" + _viewModel.HeroModel.Original + "文件");
			return;
		}
		_heroSpine = gameObject;
		UIUtilly.SpineMatchRectHelper(_heroSpine, spineRoot, overwrite: false);
		StreamerMode.ApplySpineSkin(gameObject);
	}

	private LoopListViewItem2 OnGetGiftItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.GiftDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("HeroGiftItem");
		if (loopListViewItem != null)
		{
			HeroGiftItem component = loopListViewItem.GetComponent<HeroGiftItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.GiftDatas[index]);
			}
			else
			{
				component.RefreshData(_viewModel.GiftDatas[index]);
			}
		}
		return loopListViewItem;
	}

	private void OnGiftItemListChanged(object sender, InteractionEventArgs e)
	{
		giftScrollView.SetListItemCount(_viewModel.GiftDatas.Count);
		giftScrollView.RefreshAllShownItem();
		giftScrollView.gameObject.SetActive(_viewModel.GiftDatas.Count > 0);
		noGift.SetActive(_viewModel.GiftDatas.Count <= 0);
	}

	protected override void OnDestroy()
	{
		if (_heroSpine != null)
		{
			UnityEngine.Object.Destroy(_heroSpine);
			_heroSpine = null;
		}
		base.OnDestroy();
	}
}
