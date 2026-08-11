using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Ase;

public class GameSettingWindow : UGuiWindow
{
	private const int MaxFixItemCount = 8;

	public float blockItemAlpha = 0.5f;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabToggle skillTab;

	[SerializeField]
	private TabToggle manualTab;

	[SerializeField]
	private TabToggle statusTab;

	[SerializeField]
	private TabToggle graphicsTab;

	[SerializeField]
	private TabToggle audioTab;

	[SerializeField]
	private TabToggle keySettingTab;

	[SerializeField]
	private TabToggle battleTab;

	[SerializeField]
	private TabToggle otherTab;

	[SerializeField]
	private TabToggle accountTab;

	[SerializeField]
	private SkillSettingView skillView;

	[SerializeField]
	private TeachingManualView manualView;

	[SerializeField]
	private StatusSettingView statusView;

	[SerializeField]
	private CanvasGroup graphicsView;

	[SerializeField]
	private ScrollRect graphicsScrollRect;

	[SerializeField]
	private CanvasGroup audioView;

	[SerializeField]
	private ScrollRect audioScrollRect;

	[SerializeField]
	private KeySettingView keySettingView;

	[SerializeField]
	private CanvasGroup battleView;

	[SerializeField]
	private ScrollRect battleScrollRect;

	[SerializeField]
	private CanvasGroup otherView;

	[SerializeField]
	private ScrollRect otherScrollRect;

	[SerializeField]
	private CanvasGroup accountView;

	[SerializeField]
	private Button btnLogout;

	[SerializeField]
	private TMP_Dropdown_New languageDropdown;

	[SerializeField]
	private GameObject codeExchangeItem;

	[SerializeField]
	private Button codeExchangeBtn;

	[SerializeField]
	private Button resetBtn;

	[SerializeField]
	private Button exitBattleBtn;

	[SerializeField]
	private TextMeshProUGUI exitBattleBtnText;

	[SerializeField]
	private Button exitCaveBtn;

	[SerializeField]
	private GameObject customerSerGo;

	[SerializeField]
	private Button customerSerBtn;

	[SerializeField]
	private GameObject writeOffGo;

	[SerializeField]
	private Button writeOffBtn;

	[SerializeField]
	private Button openProtoWebBtn;

	[SerializeField]
	private TextMeshProUGUI version;

	[SerializeField]
	private Animator animator;

	private List<GameSettingItem> settingItemList;

	private GameSettingViewModel _viewModel;

	private int curTab = -1;

	[SerializeField]
	private GameObject streamerModeItem;

	[SerializeField]
	private Toggle streamerModeOff;

	[SerializeField]
	private Toggle streamerModeOn;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GameSettingViewModel>();
		InitSpecialViews();
		InitTabs();
		InitItems();
		BindingSet<GameSettingWindow, GameSettingViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GameSettingWindow v) => v.OnDismissRequest).To((GameSettingViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GameSettingWindow v) => v.OpenUguiWindow).To((GameSettingViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameSettingViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(resetBtn.gameObject).For((GameObject v) => v.activeSelf).To((GameSettingViewModel vm) => vm.ShowResetButton);
		bindingSet.Bind(resetBtn).For((Button v) => v.onClick).To((GameSettingViewModel vm) => vm.TryReset2Default);
		bindingSet.Bind(btnLogout).For((Button v) => v.onClick).To((GameSettingViewModel vm) => vm.LogoutConfirm);
		bindingSet.Bind(codeExchangeBtn).For((Button v) => v.onClick).To((GameSettingViewModel vm) => vm.OpenCodeExchangeWindow);
		bindingSet.Bind(exitBattleBtn.gameObject).For((GameObject v) => v.activeSelf).To((GameSettingViewModel vm) => vm.ShowFuncBtn);
		bindingSet.Bind(exitBattleBtn).For((Button v) => v.onClick).To((GameSettingViewModel vm) => vm.FuncCmd)
			.CommandParameter("ExitBattle");
		bindingSet.Bind<TextMeshProUGUI>(exitBattleBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameSettingViewModel vm) => vm.ExitBattleBtnText);
		exitCaveBtn.gameObject.SetActive(value: false);
		bindingSet.Bind(exitBattleBtn).For((Button v) => v.onClick).To((GameSettingViewModel vm) => vm.FuncCmd)
			.CommandParameter("ExitCaves");
		bindingSet.Bind<TextMeshProUGUI>(version).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameSettingViewModel vm) => vm.VersionInfo);
		bindingSet.Build();
		((Component)(object)accountView).gameObject.SetActive(!_viewModel.InBattle);
		InitKeySetting();
		InitLanguageDropdown();
		bool flag = Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.IfShowCustomerServiceBtn() ?? false;
		customerSerGo.SetActive(flag);
		if (flag)
		{
			customerSerBtn.onClick.AddListener(OnCustomerSerBtnClick);
		}
		bool flag2 = Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.IfShowWriteOffBtn() ?? false;
		writeOffGo.SetActive(flag2);
		if (flag2)
		{
			writeOffBtn.onClick.AddListener(OnWriteOffBtnClick);
		}
		openProtoWebBtn.onClick.AddListener(OpenProtoWeb);
		if (GameEntry.BuiltinData.GameVersion.app_review)
		{
			codeExchangeItem.SetActive(value: false);
		}
		InitStreamerMode();
	}

	private void OnCustomerSerBtnClick()
	{
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.CustomerSer();
	}

	private void OnWriteOffBtnClick()
	{
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.WriteOff();
	}

	private void OpenProtoWeb()
	{
		string text = GameEntry.Web.OpenWebViewWithUid("https://kiifstudio.com/private.html", ((Component)(object)GameEntry.UI.Canvas).GetComponent<RectTransform>(), useToolBar: true, null, null);
		if (!string.IsNullOrEmpty(text))
		{
			Toast.ShowInfo(text);
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		if (_viewModel.BattleWorldMode != BattleWorldMode.SyncBattle)
		{
			_viewModel.GamePause();
		}
	}

	private void InitKeySetting()
	{
		keySettingTab.gameObject.SetActive(value: false);
	}

	private void InitLanguageDropdown()
	{
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Expected O, but got Unknown
		((UnityEvent<int>)(object)((TMP_Dropdown)languageDropdown).onValueChanged).AddListener((UnityAction<int>)OnDropdownClick);
		List<OptionData> list = new List<OptionData>();
		int valueWithoutNotify = 0;
		foreach (AudioLanguageEnum value in Enum.GetValues(typeof(AudioLanguageEnum)))
		{
			list.Add(new OptionData(value.GetDescription()));
			if (value == Singleton<AudioSystem>.Instance.AudioLanguage)
			{
				valueWithoutNotify = list.Count - 1;
			}
		}
		((TMP_Dropdown)languageDropdown).options = list;
		((TMP_Dropdown)languageDropdown).SetValueWithoutNotify(valueWithoutNotify);
	}

	private async void OnDropdownClick(int index)
	{
		if (index != 1)
		{
			SetLanguage((AudioLanguageEnum)index);
		}
		else
		{
			SetLanguage((AudioLanguageEnum)index);
		}
	}

	private async void SetLanguage(AudioLanguageEnum newLanguage)
	{
		Loading loading = await Loading.Show();
		await Task.Delay(1000);
		await Singleton<AudioSystem>.Instance.SetLanguage(newLanguage, localSave: true);
		loading?.Dispose();
	}

	private void InitSpecialViews()
	{
		if (_viewModel.InBattle)
		{
			skillView.Init(_viewModel.SettingViewModel);
			manualView.Init(_viewModel.ManualViewModel);
			statusView.Init(_viewModel.StatusViewModel);
		}
	}

	private void InitTabs()
	{
		if (_viewModel.InBattle)
		{
			skillTab.gameObject.SetActive(value: true);
			manualTab.gameObject.SetActive(value: true);
			statusTab.gameObject.SetActive(value: true);
			skillTab.AddSelectedAction(OnTabClick);
			skillTab.AllowRepeatClick = false;
			manualTab.AddSelectedAction(OnTabClick);
			manualTab.AllowRepeatClick = false;
			statusTab.AddSelectedAction(OnTabClick);
			statusTab.AllowRepeatClick = false;
			accountTab.gameObject.SetActive(value: false);
		}
		else
		{
			skillTab.gameObject.SetActive(value: false);
			manualTab.gameObject.SetActive(value: false);
			statusTab.gameObject.SetActive(value: false);
			accountTab.gameObject.SetActive(value: true);
		}
		skillTab.AddSelectedAction(OnTabClick);
		skillTab.AllowRepeatClick = false;
		manualTab.AddSelectedAction(OnTabClick);
		manualTab.AllowRepeatClick = false;
		graphicsTab.AddSelectedAction(OnTabClick);
		graphicsTab.AllowRepeatClick = false;
		audioTab.AddSelectedAction(OnTabClick);
		audioTab.AllowRepeatClick = false;
		keySettingTab.AddSelectedAction(OnTabClick);
		keySettingTab.AllowRepeatClick = false;
		battleTab.AddSelectedAction(OnTabClick);
		battleTab.AllowRepeatClick = false;
		otherTab.AddSelectedAction(OnTabClick);
		otherTab.AllowRepeatClick = false;
		accountTab.AddSelectedAction(OnTabClick);
		accountTab.AllowRepeatClick = false;
		_viewModel.InitIndex(skillTab.enumId, statusTab.enumId, graphicsTab.enumId, audioTab.enumId, keySettingTab.enumId, battleTab.enumId, otherTab.enumId);
	}

	private void InitItems()
	{
		settingItemList = new List<GameSettingItem>();
		InitItemsInScroll(graphicsScrollRect);
		InitItemsInScroll(audioScrollRect);
		InitItemsInScroll(battleScrollRect);
		InitItemsInScroll(otherScrollRect);
	}

	private void InitItemsInScroll(ScrollRect scrollRect)
	{
		int num = 0;
		for (int i = 0; i < scrollRect.content.childCount; i++)
		{
			GameSettingItem component = scrollRect.content.GetChild(i).GetComponent<GameSettingItem>();
			if (!(component == null))
			{
				component.SetBlockAlpha(blockItemAlpha);
				if (HideSpecialItem(component.Key))
				{
					component.gameObject.SetActive(value: false);
				}
				else if (component.gameObject.activeSelf && _viewModel.SettingViewModels.ContainsKey(component.Key))
				{
					component.Init(_viewModel.SettingViewModels[component.Key]);
					num++;
				}
				else
				{
					component.gameObject.SetActive(value: false);
				}
				settingItemList.Add(component);
			}
		}
		scrollRect.vertical = num > 8;
	}

	private bool HideSpecialItem(string itemKey)
	{
		return false;
	}

	private void OnTabClick(int index)
	{
		CancelInvoke("DoChangeTab");
		CancelInvoke("PlayShowTabAnimation");
		float num = 0f;
		if (curTab > 0 && (UnityEngine.Object)(object)animator != null)
		{
			AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
			foreach (AnimationClip val in animationClips)
			{
				if (((UnityEngine.Object)(object)val).name.Equals("hideTab"))
				{
					num = val.length;
					break;
				}
			}
		}
		curTab = index;
		_viewModel.ChangeTab(index);
		if (num > 0f)
		{
			animator.SetTrigger("hideTab");
			Invoke("DoChangeTab", num);
			Invoke("PlayShowTabAnimation", num);
		}
		else
		{
			DoChangeTab();
		}
	}

	private void DoChangeTab()
	{
		skillView.CanvasGroup.alpha = ((curTab == skillTab.enumId) ? 1 : 0);
		skillView.CanvasGroup.blocksRaycasts = curTab == skillTab.enumId;
		manualView.CanvasGroup.alpha = ((curTab == manualTab.enumId) ? 1 : 0);
		manualView.CanvasGroup.blocksRaycasts = curTab == manualTab.enumId;
		bool flag = curTab == statusTab.enumId;
		statusView.CanvasGroup.alpha = (flag ? 1 : 0);
		statusView.CanvasGroup.blocksRaycasts = flag;
		if (flag)
		{
			statusView.ResetScrollToTop();
		}
		graphicsView.alpha = ((curTab == graphicsTab.enumId) ? 1 : 0);
		graphicsView.blocksRaycasts = curTab == graphicsTab.enumId;
		audioView.alpha = ((curTab == audioTab.enumId) ? 1 : 0);
		audioView.blocksRaycasts = curTab == audioTab.enumId;
		keySettingView.Alpha = ((curTab == keySettingTab.enumId) ? 1 : 0);
		keySettingView.CanvasGroup.blocksRaycasts = curTab == keySettingTab.enumId;
		battleView.alpha = ((curTab == battleTab.enumId) ? 1 : 0);
		battleView.blocksRaycasts = curTab == battleTab.enumId;
		otherView.alpha = ((curTab == otherTab.enumId) ? 1 : 0);
		otherView.blocksRaycasts = curTab == otherTab.enumId;
		accountView.alpha = ((curTab == accountTab.enumId) ? 1 : 0);
		accountView.blocksRaycasts = curTab == accountTab.enumId;
	}

	private void PlayShowTabAnimation()
	{
		if ((UnityEngine.Object)(object)animator != null)
		{
			animator.SetTrigger("showTab");
		}
	}

	public void SetStatusHeroes(List<StatusSettingViewModel.StatusHeroSnapshot> heroes, Dictionary<int, StatusSettingViewModel.StatusBattleSnapshot> battleDataMap)
	{
		StatusSettingViewModel statusViewModel = _viewModel.StatusViewModel;
		statusView?.Init(statusViewModel);
		statusViewModel.SetHeroes(heroes, battleDataMap);
	}

	private void InitStreamerMode()
	{
		if (!StreamerMode.ShowStreamerModeUi())
		{
			streamerModeItem.SetActive(value: false);
			return;
		}
		streamerModeItem.SetActive(value: true);
		bool streamerModeSet = StreamerMode.StreamerModeSet;
		streamerModeOff.SetIsOnWithoutNotify(!streamerModeSet);
		streamerModeOn.SetIsOnWithoutNotify(streamerModeSet);
		streamerModeOff.onValueChanged.AddListener(OnStreamerModeOffChange);
		streamerModeOn.onValueChanged.AddListener(OnStreamerModeOnChange);
	}

	private void OnStreamerModeOffChange(bool value)
	{
		bool flag = !value;
		streamerModeOn.SetIsOnWithoutNotify(flag);
		settingItemList?.Find((GameSettingItem p) => p.Key.Equals("幻衣特殊转场"))?.gameObject.SetActive(!flag);
		StreamerMode.SaveLocalSetting(flag);
	}

	private void OnStreamerModeOnChange(bool value)
	{
		bool flag = value;
		streamerModeOff.SetIsOnWithoutNotify(!flag);
		settingItemList?.Find((GameSettingItem p) => p.Key.Equals("幻衣特殊转场"))?.gameObject.SetActive(!flag);
		StreamerMode.SaveLocalSetting(flag);
	}
}
