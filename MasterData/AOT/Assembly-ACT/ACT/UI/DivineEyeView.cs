using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.LocalizationExtension;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class DivineEyeView : BaseUIView<DivineEyeInputController>
{
	public ActButton backButton;

	public ActButton systemDesButton;

	public ActButton leftButton;

	public ActButton rightButton;

	public ActButton rewardButton;

	public LocalizeStringEvent rewardBtnLocalizeString;

	public TextMeshProUGUI rewardBtnText;

	public CommonScrollBagComponent ScrollBag;

	public CommonCoinComponent needCost;

	public Slider progressSlider;

	public LocalizeTMP_Dropdown dropdown;

	public BImage icon;

	public LocalizeStringEvent needCostText;

	public TextMeshProUGUI needCostNum;

	public TextMeshProUGUI progressCount;

	public GameObject alreadyReward;

	public GameObject unlockAfterLastLevel;

	public RedDotItem dropDownRedDot;

	public GameObject rewardBtnRedDot;

	[SerializeField]
	private bool needBlurBackground;

	[SerializeField]
	public List<UIEffectRendering> uiEffects;

	public ViewControlLayer rewardListLayer;

	public ViewControlLayer dropDownLayer;

	public GamePadTipsComp bottomBtnPrompt;

	public List<OperateBtnPrompt> allInputPrompt;

	public OperateBtnPrompt leftBtnPrompt;

	public OperateBtnPrompt rightBtnPrompt;

	private DivineEyeViewData m_data;

	private StringBuilder _sb;

	private List<LocalizeTMP_Dropdown.OptionData> m_options;

	private List<ItemUnifierProxy> _rewardFillData;

	private DivinePupil _curAreaPupilData;

	private DivinePupil _selectAreaPupilData;

	private int _curExploreArea;

	private int _curSelectLevel;

	private Dictionary<int, int> _dropDownIndexToExploreDataMap;

	private const int COSTNEEDDES = 2224;

	private const int SUBMITDES = 2228;

	private const int BACKTOCURLEVEL = 2230;

	private const int SYSTEMDES = 2221;

	private const int SYSTEMTITLEDES = 2220;

	public Color normalColor;

	public Color disableColor;

	private Dictionary<string, GamePadTipsAction> _bottomInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private bool NeedBlurBackground
	{
		get
		{
			if (UILayer == UI_LAYER.NORMAL || UILayer == UI_LAYER.POPUP)
			{
				return needBlurBackground;
			}
			return false;
		}
	}

	private void OnValidate()
	{
		EnsureBlurEffect();
	}

	public void EnsureBlurEffect()
	{
		if (needBlurBackground)
		{
			List<UIEffectRendering> list = uiEffects;
			if (list == null || list.Count <= 0)
			{
				uiEffects = new List<UIEffectRendering>();
				uiEffects.Add(new UIEffectRendering
				{
					Intensity = 1f,
					RenderDirectly = true,
					rendererList = new List<AbstractUIEffectRenderer>
					{
						new BlurUIEffectRenderer
						{
							setting = new BlurUIEffect
							{
								BlurRadius = 5f
							}
						}
					}
				});
			}
		}
	}

	private void AddUIEffect()
	{
		if (!NeedBlurBackground)
		{
			return;
		}
		List<UIEffectRendering> list = uiEffects;
		if (list == null || list.Count <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("当前界面 " + gameObject.name + " 开启模糊效果,但是没有相应配置。");
			}
			EnsureBlurEffect();
		}
		foreach (UIEffectRendering uiEffect in uiEffects)
		{
			uiEffect.layer = SortingLayer - 1;
		}
		Singleton<NewUIManager>.instance.PushUIEffectRenderingList(UIController, uiEffects);
	}

	private void RemoveUIEffect()
	{
		Singleton<NewUIManager>.instance.PopUIEffectRenderingList(UIController);
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		systemDesButton.SetBtnClick(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				titleTextId = 2220,
				titleStringType = "Common",
				descTextId = 2221,
				localizedStringType = "Common"
			});
		});
		backButton.SetBtnClick(Close);
		leftButton.SetBtnClick(LeftBtnClick, "event:/UI/Interface/DivineEye/Click");
		rightButton.SetBtnClick(RightBtnClick, "event:/UI/Interface/DivineEye/Click");
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		_sb = new StringBuilder();
		m_options = ListPool<LocalizeTMP_Dropdown.OptionData>.Get();
		_dropDownIndexToExploreDataMap = DictionaryPool<int, int>.Get();
		_rewardFillData = ListPool<ItemUnifierProxy>.Get();
		_bottomInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_tipsActions = ListPool<GamePadTipsAction>.Get();
		_bottomInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_bottomInputPrompt["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		};
		_curExploreArea = FindCurExploreArea(Singleton<GameManager>.instance.worldManager.ActiveMapId).id;
		G.localPlayer.pupils.TryGetValue(_curExploreArea, out _curAreaPupilData);
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		if (_curAreaPupilData == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		InitDropDown();
		AddUIEffect();
		UpdateBtnPromptActive();
	}

	private void InitDropDown()
	{
		m_options.Clear();
		_dropDownIndexToExploreDataMap.Clear();
		dropdown.options.Clear();
		int num = 0;
		int num2 = 0;
		dropDownRedDot?.InitRedDot(RedDotPathDefine.DivineExplore);
		foreach (ExploreType value in RuntimeConfigs.data.exploreTypes.Values)
		{
			_dropDownIndexToExploreDataMap[num2] = value.id;
			try
			{
				m_options.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("shortcommon", value.name), Model<DivineEyeModel>.Interface.redDotMap[value.id]));
			}
			catch (Exception)
			{
				_ = LuminApplication.LogEnabled;
				m_options.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("shortcommon", value.name)));
			}
			MapArea data = CoreUtils.GetData(Singleton<GameManager>.instance.worldManager.ActiveMapId, RuntimeConfigs.data.mapAreas);
			if (data != null && data.exploreType == value.id)
			{
				num = num2;
			}
			num2++;
		}
		dropdown.AddOptions(m_options);
		dropdown.value = num;
		SelectAreaOption(num);
		dropdown.onValueChanged.AddListener(SelectAreaOption);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DivineEye/Open");
		betterAnimation?.GetSequence("ShowIn").Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	private void SelectAreaOption(int index)
	{
		if (!_dropDownIndexToExploreDataMap.TryGetValue(index, out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("dropdown选项和神瞳区域数据对不上了");
			}
		}
		else if (G.localPlayer.pupils.TryGetValue(value, out _curAreaPupilData))
		{
			_curExploreArea = value;
			if (Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap.TryGetValue(_curExploreArea, out var value2))
			{
				List<MapExploreAwardData> list = value2;
				int level = list[list.Count - 1].level;
				_curSelectLevel = ((_curAreaPupilData.CurLv < level) ? _curAreaPupilData.CurLv : level);
			}
			RefreshDisplay(_curSelectLevel);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private void RefreshSlider(int selectLevel, MapExploreAwardData rewardData)
	{
		if (rewardData != null)
		{
			progressSlider.maxValue = rewardData.number;
			if (_curAreaPupilData.CurLv > selectLevel)
			{
				progressSlider.value = rewardData.number;
			}
			else if (_curAreaPupilData.CurLv == selectLevel)
			{
				progressSlider.value = _curAreaPupilData.CurExp;
			}
			else
			{
				progressSlider.value = 0f;
			}
			_sb.Clear();
			string text = _sb.Append(progressSlider.value).Append("/").Append(progressSlider.maxValue)
				.ToString();
			needCostNum.text = text;
		}
	}

	private void FillRewardScroll(int curSelectLevel, MapExploreAwardData rewardData)
	{
		ItemUnifierProxy.ItemUnifierPool.Release(_rewardFillData);
		_rewardFillData.Clear();
		List<ItemKv> certain = CoreUtils.GetData(rewardData.award, RuntimeConfigs.data.collections).certain;
		if (certain != null && certain.Count > 0)
		{
			foreach (ItemKv item2 in certain)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
				_rewardFillData.Add(item);
			}
			_rewardFillData.Sort(SortUtility.ItemUnifierQuality);
		}
		ScrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		ScrollBag.AnimName = "Show";
		ScrollBag.ItemSource = _rewardFillData;
		ScrollBag.Station = Station;
		ScrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		ScrollBag.ItemShowType = ItemUIComponentBase.InitType.BloodBottleMaterialInCangePanel;
		ScrollBag.OnItemShow = null;
		CommonScrollBagComponent scrollBag = ScrollBag;
		scrollBag.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(scrollBag.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			l.IsComplete = _curAreaPupilData.CurLv > curSelectLevel || LevelRewardIsCompleted(curSelectLevel, rewardData);
		}));
	}

	private bool LevelRewardIsCompleted(int selectLevel, MapExploreAwardData rewardData)
	{
		if (rewardData == null || _curAreaPupilData.CurExp < rewardData.number)
		{
			return false;
		}
		if (Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap.TryGetValue(_curExploreArea, out var value) && value != null && value.Count > 0)
		{
			List<MapExploreAwardData> list = value;
			return selectLevel == list[list.Count - 1].level;
		}
		return false;
	}

	private void RefreshRewardBtn(int selectLevel, MapExploreAwardData rewardData)
	{
		unlockAfterLastLevel.SetActive(value: false);
		if (LevelRewardIsCompleted(selectLevel, rewardData))
		{
			alreadyReward.SetActive(value: true);
			rewardButton.gameObject.SetActive(value: false);
			if (rewardBtnRedDot != null)
			{
				rewardBtnRedDot.SetActive(value: false);
			}
		}
		else if (_curAreaPupilData.CurLv == selectLevel)
		{
			alreadyReward.SetActive(value: false);
			rewardButton.gameObject.SetActive(value: true);
			if (rewardBtnRedDot != null)
			{
				rewardBtnRedDot.SetActive(value: false);
			}
			rewardBtnLocalizeString.StringReference.TableEntryReference = 2228L;
			int itemId = CoreUtils.GetData(_curExploreArea, RuntimeConfigs.data.exploreTypes).itemId;
			int haveCount = G.localPlayer.Inventory.GetItemCount(itemId);
			if (haveCount == 0)
			{
				rewardButton.Interactable(active: false);
				rewardBtnText.color = disableColor;
				return;
			}
			rewardButton.Interactable(active: true);
			rewardBtnText.color = normalColor;
			rewardButton.SetBtnClick(() =>
			{
				G.service.SubmitDivineEye(_curExploreArea, haveCount, (bool b, List<UniversalItem> rewards) =>
				{
					if (b)
					{
						if (G.localPlayer.pupils.TryGetValue(_curExploreArea, out _curAreaPupilData))
						{
							if (Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap.TryGetValue(_curExploreArea, out var value))
							{
								List<MapExploreAwardData> list = value;
								int level = list[list.Count - 1].level;
								_curSelectLevel = ((_curAreaPupilData.CurLv < level) ? _curAreaPupilData.CurLv : level);
							}
							RefreshDisplay(_curSelectLevel);
							if (rewards != null && rewards.Count > 0)
							{
								GameUtility.OpenPopReward(rewards);
							}
						}
						else
						{
							RefreshDisplay(selectLevel);
						}
					}
				});
			});
		}
		else if (_curAreaPupilData.CurLv < selectLevel)
		{
			rewardButton.Interactable(active: true);
			rewardBtnText.color = normalColor;
			unlockAfterLastLevel.SetActive(value: true);
			alreadyReward.SetActive(value: false);
			rewardBtnLocalizeString.StringReference.TableEntryReference = 2230L;
			if (rewardBtnRedDot != null)
			{
				rewardBtnRedDot.SetActive(value: false);
			}
			rewardButton.SetBtnClick(() =>
			{
				if (Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap.TryGetValue(_curExploreArea, out var value))
				{
					List<MapExploreAwardData> list = value;
					int level = list[list.Count - 1].level;
					_curSelectLevel = ((_curAreaPupilData.CurLv < level) ? _curAreaPupilData.CurLv : level);
					RefreshDisplay(_curSelectLevel);
				}
			});
		}
		else
		{
			alreadyReward.SetActive(value: true);
			rewardButton.gameObject.SetActive(value: false);
			unlockAfterLastLevel.SetActive(value: false);
			if (rewardBtnRedDot != null)
			{
				rewardBtnRedDot.SetActive(value: false);
			}
		}
	}

	private void LeftBtnClick()
	{
		_curSelectLevel--;
		if (_curSelectLevel < 0)
		{
			_curSelectLevel = Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap[_curExploreArea].Count - 1;
		}
		RefreshDisplay(_curSelectLevel);
	}

	private void RightBtnClick()
	{
		_curSelectLevel++;
		if (_curSelectLevel > Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap[_curExploreArea].Count - 1)
		{
			_curSelectLevel = 0;
		}
		RefreshDisplay(_curSelectLevel);
	}

	private void RefreshDisplay(int selectLevel)
	{
		if (_curAreaPupilData == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		betterAnimation?.GetSequence("Change").Play();
		if (Model<DivineEyeModel>.Interface.exploreAreaAwardDataMap.TryGetValue(_curExploreArea, out var value) && value != null && value.Count > 0)
		{
			int level = value[0].level;
			List<MapExploreAwardData> list = value;
			int level2 = list[list.Count - 1].level;
			leftButton.gameObject.SetActive(selectLevel != level);
			rightButton.gameObject.SetActive(selectLevel != level2);
			UpdateBtnPromptActive();
		}
		int itemId = CoreUtils.GetData(_curExploreArea, RuntimeConfigs.data.exploreTypes).itemId;
		int itemCount = G.localPlayer.Inventory.GetItemCount(itemId);
		needCost.Station = Station;
		needCost.InitData(itemId, isBagItem: true);
		needCost.Init(itemCount);
		needCostText.StringReference.TableEntryReference = 2224L;
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		needCostText.GetVariable<string>("0").Value = LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal);
		progressCount.SetText(selectLevel.FastToString());
		MapExploreAwardData rewardData = Model<DivineEyeModel>.Interface.FindExploreRewardData(_curExploreArea, selectLevel);
		RefreshSlider(selectLevel, rewardData);
		FillRewardScroll(selectLevel, rewardData);
		RefreshRewardBtn(selectLevel, rewardData);
	}

	private ExploreType FindCurExploreArea(int mapAreaId)
	{
		MapArea data = CoreUtils.GetData(mapAreaId, RuntimeConfigs.data.mapAreas);
		if (data == null || data.exploreType == 0)
		{
			return null;
		}
		foreach (ExploreType value in RuntimeConfigs.data.exploreTypes.Values)
		{
			if (value.id == data.exploreType)
			{
				return value;
			}
		}
		return null;
	}

	protected override void UnInit()
	{
		_curExploreArea = 0;
		_curSelectLevel = 0;
		_curAreaPupilData = null;
		ListPool<LocalizeTMP_Dropdown.OptionData>.Release(m_options);
		DictionaryPool<int, int>.Release(_dropDownIndexToExploreDataMap);
		ItemUnifierProxy.ItemUnifierPool.Release(_rewardFillData);
		ListPool<ItemUnifierProxy>.Release(_rewardFillData);
		_bottomInputPrompt.Clear();
		_bottomInputPrompt = null;
		ListPool<GamePadTipsAction>.Release(_tipsActions);
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DivineEye/Close");
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
		RemoveUIEffect();
	}

	protected override void OnSetSortingLayer(int layer)
	{
		base.OnSetSortingLayer(layer);
		foreach (UIEffectRendering uiEffect in uiEffects)
		{
			uiEffect.layer = layer;
		}
	}

	public override void Close()
	{
		base.Close();
	}

	private void UpdateChangePageBtnPromptActive(bool active)
	{
		bool flag = MonoECS.instance.IsGamePadMode();
		leftButton.image.color = new Color(leftButton.image.color.r, leftButton.image.color.g, leftButton.image.color.b, flag ? 0f : 1f);
		rightButton.image.color = new Color(rightButton.image.color.r, rightButton.image.color.g, rightButton.image.color.b, flag ? 0f : 1f);
		leftBtnPrompt?.SetVisible(active && leftButton.gameObject.activeInHierarchy);
		rightBtnPrompt?.SetVisible(active && rightButton.gameObject.activeInHierarchy);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (UIController.State == UIState.Opened)
		{
			UpdateBtnPromptActive();
		}
	}

	public void UpdateBtnPromptActive()
	{
		bottomBtnPrompt?.ClearAllPrompts();
		_tipsActions?.Clear();
		DivineEyeInputController controller = GetController();
		bool flag = controller != null && (controller.isFocusDropDown || controller.isFocusRewardList);
		bool flag2 = MonoECS.instance.IsGamePadMode();
		bool flag3 = !flag & flag2;
		List<OperateBtnPrompt> list = allInputPrompt;
		if (list != null && list.Count > 0)
		{
			foreach (OperateBtnPrompt item in allInputPrompt)
			{
				item?.SetVisible(flag3);
			}
		}
		UpdateChangePageBtnPromptActive(flag3);
		if (flag2)
		{
			_tipsActions?.Add(_bottomInputPrompt["UI/Back"]);
			if (flag)
			{
				_tipsActions?.Add(_bottomInputPrompt["UI/Confirm"]);
			}
			bottomBtnPrompt?.RegisterInputActions(_tipsActions);
		}
	}
}
