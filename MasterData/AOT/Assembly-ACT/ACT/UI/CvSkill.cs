using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.DataProxy;
using ACT.UI.View.SkillUI;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Sirenix.Serialization;
using UI.ViewComponent.CharacterView.SkillUI;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;
using UnityEngine.UIElements;

namespace ACT.UI;

public class CvSkill : SubUIView<CvSkillSubController>, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	[Serializable]
	public class CustomSkillConfig
	{
		public int characterId;

		public YooAssetReference skillPanelAssetID;
	}

	private class CurrentGo
	{
		public YooAssetReference currentReferrenceAssetID;

		public AssetLoadHandle handler;

		public SkillPanelBase comp;

		public Vector3 initContentPosition;

		public Vector3 initScale;

		public bool needRelease;
	}

	[SerializeField]
	public List<CustomSkillConfig> skillPanelConfigs;

	public YooAssetReference fallBackAssetID;

	public AnimateToggle animateToggle;

	[Header("生成技能树配置")]
	public Transform skillPanelRoot;

	[Header("简略描述配置")]
	public Transform briefDescRoot;

	[FormerlySerializedAs("content")]
	public RectTransform briefDescRootContent;

	[FormerlySerializedAs("skillItemPrefab")]
	public SkillGroupCell briefDescRootSkillItemPrefab;

	[Header("详细描述配置")]
	public Transform detailDescRoot;

	public RectTransform detailDescRootContent;

	public SkillGroupDetailCell detailDescRootSkillItemPrefab;

	public GameObject mainTitleRoot;

	public LocalizeStringEvent mainTitle;

	public GameObject maxTip;

	public GameObject rootConstellationTag;

	public LocalizeStringEvent constellationTag;

	public GameObject rootElitocracyTag;

	public LocalizeStringEvent elitocracyTag;

	public GameObject subTitleRoot;

	public CommonNumberComponent subTitle;

	public GameObject levelTip;

	public GameObject warningRoot;

	public LocalizeStringEvent warning;

	public GameObject confirmButtonRoot;

	public ActButton confirmButton;

	public LocalizeStringEvent confirmButtonText;

	public GameObject nodeTypeTipRoot;

	public LocalizeStringEvent nodeTypeTip;

	public GameObject previewRoot;

	public ActButton previewButton;

	public GameObject costRoot;

	public CommonCoinComponent coinComponent;

	public CommonCoinComponent skillExpComponent;

	public CommonScrollBagComponent resourceScrollBag;

	public CommonCoinComponent staticCoinComponent;

	[Header("动画")]
	[SerializeField]
	private BetterAnimation m_Animation;

	[OdinSerialize]
	public Dictionary<SkillSubviewInputState, ViewControlLayer> ViewControlLayers;

	[OdinSerialize]
	public Dictionary<SkillSubviewInputState, List<GameObject>> ViewControlPrompt;

	public GamePadTipsComp gamePadTips;

	public RightStickScrollSupport scrollSupport;

	public CommonCoinGroup coinGroup;

	private ViewControlLayer _coinViewLayer;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private CurrentGo m_CurrentGo;

	private ScrollRect _briefScrollRect;

	private ScrollRect _detailScrollRect;

	private bool _showDetailDescPanel;

	private SkillItemBase m_SelectedSkillItem;

	private List<ItemUnifierProxy> m_ComsumeItems;

	private Character m_Character;

	private bool m_CanExchangeMaterial;

	private const string _detailSwitch = "DetailSwitch";

	private Dictionary<int, CurrentGo> m_SkillTreeCache = new Dictionary<int, CurrentGo>();

	private ImageAssetStation m_ImageAssetStation;

	private bool _afterAnimation;

	private Stack<SkillGroupCell> m_BriefPool = new Stack<SkillGroupCell>();

	private Stack<SkillGroupDetailCell> m_DetailPool = new Stack<SkillGroupDetailCell>();

	public CharacterView CharacterView { get; private set; }

	private SkillPanelBase m_SkillPanel => m_CurrentGo?.comp;

	private ScrollRect ActiveDescScrollRect
	{
		get
		{
			if (!_showDetailDescPanel)
			{
				return _briefScrollRect;
			}
			return _detailScrollRect;
		}
	}

	private int m_SkillGroupId => m_SelectedSkillItem?.skillGroupId ?? 0;

	private IBaseUIController m_UiController => ((CharacterView)Context).UIController;

	public int Depth => 1;

	public ICharacterSubView lastSubView { get; set; }

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.Skill;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public bool NeedBlur => true;

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_SkillPanel_Refresh, OnUpdateSkillPanel);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		confirmButton.SetBtnClick(ShowLevelUpView);
		previewButton.SetBtnClick(ShowLevelUpPreviewView);
		InitGameTipsDic();
		BindCoinGroupFocus();
		_briefScrollRect = ((briefDescRootContent != null) ? briefDescRootContent.GetComponentInParent<ScrollRect>() : null);
		_detailScrollRect = ((detailDescRootContent != null) ? detailDescRootContent.GetComponentInParent<ScrollRect>() : null);
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("UI/RSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		});
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_SkillPanel_Refresh, OnUpdateSkillPanel);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		coinComponent.RemoveListener();
		skillExpComponent.RemoveListener();
		animateToggle.onValueChanged.RemoveListener(OnToggleChanged);
		UnbindCoinGroupFocus();
		m_SkillTreeCache.Clear();
		m_CurrentGo = null;
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		AfterAnimation = false;
		try
		{
			CharacterViewScene.Default.ModelVisibility = Visibility.Visible;
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		m_Character = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
		gameObject.SetActive(value: true);
		m_ImageAssetStation = station;
		Init();
		GetController().InputState = SkillSubviewInputState.SkillMain;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		m_Animation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			AfterAnimation = true;
		}).Play();
		if ((bool)CharacterView)
		{
			scrollSupport?.SetUiView(CharacterView);
		}
	}

	public void Hide()
	{
		try
		{
			CharacterViewScene.Default.ModelVisibility = Visibility.Visible;
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		gameObject.SetActive(value: false);
		ReleaseGo(m_Character.Id);
		AfterAnimation = false;
		m_Animation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
		{
			AfterAnimation = false;
		}).Play();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Out");
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		if (!characterSource.Equals(m_Character))
		{
			ReleaseGo(m_Character.Id);
			m_Character = CharacterDataHelper.GetCharacterByCharacterSource(characterSource);
			InitIcons();
		}
	}

	private void Init()
	{
		InitIcons();
		coinComponent.Initialize();
		coinComponent.RemoveListener();
		coinComponent.AddListener();
		skillExpComponent.Initialize();
		skillExpComponent.RemoveListener();
		skillExpComponent.AddListener();
		if (m_ComsumeItems != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(m_ComsumeItems);
			ListPool<ItemUnifierProxy>.Release(m_ComsumeItems);
		}
		m_ComsumeItems = ListPool<ItemUnifierProxy>.Get();
		if (animateToggle != null)
		{
			animateToggle.onValueChanged.RemoveListener(OnToggleChanged);
			animateToggle.onValueChanged.AddListener(OnToggleChanged);
			animateToggle.isOn = GamePlayerPrefs.GetInt("DetailSwitch") == 1;
		}
	}

	private void OnUpdateSkillPanel(BaseEventContent evt)
	{
		RefreshSkillTreeItemStates();
		OnSkillGroupSelected(m_SelectedSkillItem, forceUpdate: true);
	}

	private void OnBagItemChanged(BaseEventContent evt)
	{
		if (gameObject.activeInHierarchy)
		{
			ItemChangeEvt itemChangeEvt = evt as ItemChangeEvt;
			if (itemChangeEvt != null && itemChangeEvt.ItemProxies != null && CurrentSelectedSkillCostMatches((int costId) => itemChangeEvt.ItemProxies.Any((ItemUnifierProxy item) => item != null && item.Id == costId)))
			{
				RefreshCurrentSkillPanelState();
			}
		}
	}

	private void OnPlayerAttributeChanged(BaseEventContent evt)
	{
		if (gameObject.activeInHierarchy)
		{
			PlayerAttributeChangeEvt attributeChangeEvt = evt as PlayerAttributeChangeEvt;
			if (attributeChangeEvt != null && CurrentSelectedSkillCostMatches((int costId) => costId == attributeChangeEvt.id))
			{
				RefreshCurrentSkillPanelState();
			}
		}
	}

	private void RefreshCurrentSkillPanelState()
	{
		RefreshSkillTreeItemStates();
		OnSkillGroupSelected(m_SelectedSkillItem, forceUpdate: true);
	}

	private void RefreshSkillTreeItemStates()
	{
		if (m_SkillPanel?.toggles == null)
		{
			return;
		}
		foreach (SkillItemBase toggle in m_SkillPanel.toggles)
		{
			if (!(toggle == null) && toggle.Character != null)
			{
				GameUtility.CanSkillGroupLevelUp(toggle.Character, toggle.skillGroupId, out var reason);
				toggle.LockReason = reason;
				toggle.UpdatePerformance();
			}
		}
	}

	private bool CurrentSelectedSkillCostMatches(Func<int, bool> match)
	{
		if (m_SelectedSkillItem == null || match == null)
		{
			return false;
		}
		SkillGroupLevelData skillGroupNextLvData = m_SelectedSkillItem.GetSkillGroupNextLvData();
		if (skillGroupNextLvData?.cost == null)
		{
			return false;
		}
		for (int i = 0; i < skillGroupNextLvData.cost.Count; i++)
		{
			if (match(skillGroupNextLvData.cost[i].id))
			{
				return true;
			}
		}
		return false;
	}

	private bool TryGetCachedSkillTree(int characterId, out CurrentGo cached)
	{
		if (!m_SkillTreeCache.TryGetValue(characterId, out cached) || cached == null)
		{
			cached = null;
			return false;
		}
		if (cached.comp != null)
		{
			return true;
		}
		if (cached.handler.IsValid && cached.handler.State == LoadState.Loading)
		{
			return true;
		}
		m_SkillTreeCache.Remove(characterId);
		cached = null;
		return false;
	}

	private void CacheSkillTree(int characterId, CurrentGo currentGo)
	{
		m_SkillTreeCache[characterId] = currentGo;
	}

	private void ReleaseGo(int characterId)
	{
		CurrentGo currentGo = m_CurrentGo;
		m_CurrentGo = null;
		if (currentGo != null)
		{
			CacheSkillTree(characterId, currentGo);
			if (currentGo.comp != null)
			{
				currentGo.comp.HidePanel();
			}
		}
	}

	private void InitIcons()
	{
		foreach (CustomSkillConfig skillPanelConfig in skillPanelConfigs)
		{
			if (skillPanelConfig.characterId == m_Character.Id)
			{
				try
				{
					DoAsyncCreate(skillPanelConfig.skillPanelAssetID);
					return;
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
					return;
				}
			}
		}
		DoAsyncCreate(fallBackAssetID);
		void DoAsyncCreate(YooAssetReference reference)
		{
			int id = m_Character.Id;
			if (TryGetCachedSkillTree(id, out var cached))
			{
				m_CurrentGo = cached;
				if (cached.comp != null)
				{
					InitSkillPanel();
				}
			}
			else
			{
				CurrentGo created = new CurrentGo();
				m_CurrentGo = created;
				CacheSkillTree(id, created);
				created.handler = m_ImageAssetStation.InstantiateAsync(reference, skillPanelRoot, instantiateInWorldSpace: false, (AssetLoadHandle result) =>
				{
					SkillPanelBase component = result.AsGameObject().GetComponent<SkillPanelBase>();
					created.comp = component;
					if (!(component == null))
					{
						if (m_CurrentGo != created)
						{
							component.HidePanel();
						}
						else
						{
							InitSkillPanel();
						}
					}
				});
			}
		}
	}

	private void OnSkillGroupSelected(SkillItemBase skillItem, bool forceUpdate = false)
	{
		if (m_SelectedSkillItem == skillItem && !forceUpdate)
		{
			return;
		}
		m_SelectedSkillItem = skillItem;
		SkillGroupData skillGroupData = RuntimeConfigs.data.skillGroupDatas[m_SkillGroupId];
		mainTitle.SetTable("shortcommon");
		mainTitle.StringReference.TableEntryReference = skillGroupData.skillSetLocal;
		nodeTypeTip.SetTable("Common");
		LocalizedString stringReference = nodeTypeTip.StringReference;
		stringReference.TableEntryReference = m_SelectedSkillItem.SkillGroupData.skillType switch
		{
			1 => 41000001, 
			2 => 1273, 
			3 => 41000006, 
			4 => 41000005, 
			5 => 10015, 
			12 => 2280, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		UpdateFailLog();
		SkillItemBase selectedSkillItem = m_SelectedSkillItem;
		if (!(selectedSkillItem is AbilityItem abilityItem))
		{
			if (!(selectedSkillItem is NegativeEffectItem) && !(selectedSkillItem is PropertyItem) && !(selectedSkillItem is RelativeSkillItem))
			{
				throw new NotImplementedException("Unknown type");
			}
			subTitle.frontPostProcessor = null;
			subTitle.behindTextPostProcessor = null;
			subTitle.UpdateNumber(1L, 1L);
			rootConstellationTag.SetActive(value: false);
		}
		else if (abilityItem.hasExternalModified)
		{
			subTitle.frontPostProcessor = abilityItem.SetExtraLevelStyle;
			subTitle.UpdateNumber(abilityItem.currentLevel, abilityItem.maxBaseLevel);
			if (abilityItem.externalModifyData[0] != 0)
			{
				rootConstellationTag.SetActive(value: true);
				constellationTag.GetVariable<int>("0").Value = abilityItem.externalModifyData[0];
			}
		}
		else
		{
			subTitle.frontPostProcessor = null;
			subTitle.behindTextPostProcessor = null;
			subTitle.UpdateNumber(abilityItem.currentLevel, abilityItem.maxLevel);
		}
		if (skillGroupData.isNeedHiddenValues == 1 && HasCurrentSkillDetailDescription(skillGroupData))
		{
			animateToggle.isOn = true;
		}
		UpdateSkillInfosPanel();
		if (AfterAnimation)
		{
			m_Animation.GetSequence(_showDetailDescPanel ? "Right_Switch_Detail" : "Right_Switch_Brief")?.Play();
		}
	}

	private async UniTaskVoid RefreshGamePadTipsDelayed()
	{
		await UniTask.NextFrame();
		RefreshGamePadTips();
	}

	public void RefreshGamePadTips()
	{
		bool flag = ActiveDescScrollRect != null && ActiveDescScrollRect.content.rect.height > ActiveDescScrollRect.viewport.rect.height;
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		CvSkillSubController controller = GetController();
		if (controller != null && controller.InputState == SkillSubviewInputState.SkillMain)
		{
			gamePadTips.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(actionDic["UI/Back"]);
			if (flag)
			{
				_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
		}
	}

	private void UpdateFailLog()
	{
		CharacterViewConst.ReasonType lockReason = m_SelectedSkillItem.LockReason;
		SkillGroupLevelData skillGroupLevelData = null;
		m_CanExchangeMaterial = false;
		bool isTrailCharacter = m_Character.IsTrailCharacter;
		staticCoinComponent.gameObject.SetActive(!isTrailCharacter);
		warningRoot.SetActive(value: false);
		confirmButtonRoot.SetActive(value: false);
		levelTip.SetActive(value: true);
		maxTip.SetActive(value: false);
		previewRoot.SetActive(m_SelectedSkillItem.ShowPreview && lockReason != CharacterViewConst.ReasonType.ReachMaxLevel);
		costRoot.SetActive(value: false);
		subTitleRoot.SetActive(value: true);
		rootConstellationTag.SetActive(value: false);
		rootElitocracyTag.SetActive(value: false);
		switch (lockReason)
		{
		case CharacterViewConst.ReasonType.LessBreakLevel:
		{
			SkillItemBase selectedSkillItem = m_SelectedSkillItem;
			int num;
			if (!(selectedSkillItem is AbilityItem abilityItem))
			{
				if (!(selectedSkillItem is NegativeEffectItem negativeEffectItem))
				{
					if (!(selectedSkillItem is PropertyItem))
					{
						throw new NotImplementedException("Unknown Type" + m_SelectedSkillItem);
					}
					num = 0;
				}
				else
				{
					num = negativeEffectItem.baseLevel;
				}
			}
			else
			{
				num = abilityItem.baseLevel;
			}
			int num2 = num;
			int skillIdWithLevel = new MPSkill
			{
				id = m_SelectedSkillItem.skillGroupId,
				level = (byte)(num2 + 1)
			}.GetSkillIdWithLevel();
			if (RuntimeConfigs.data.skillGroupLevelDatas.TryGetValue(skillIdWithLevel, out var value))
			{
				warning.StringReference.GetVariable<int>("0").Value = value.stageBreakLevel;
				warningRoot.SetActive(value: true);
				warning.StringReference.TableEntryReference = 511L;
				warning.StringReference.RefreshString();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"skillGroupLevelDatas表中找不到{skillIdWithLevel}。已经到达最大等级？");
			}
			break;
		}
		case CharacterViewConst.ReasonType.None:
		case CharacterViewConst.ReasonType.LackMaterial:
		case CharacterViewConst.ReasonType.LackCoin:
		{
			confirmButtonRoot.SetActive(value: true);
			costRoot.SetActive(value: true);
			skillGroupLevelData = m_SelectedSkillItem.GetSkillGroupNextLvData();
			bool flag = IsSkillCostEnough(skillGroupLevelData.cost);
			m_CanExchangeMaterial = !flag && TryGetQuickPowerExchangeItemViewData(skillGroupLevelData.cost, out var _, out var _);
			bool flag2 = !flag && m_CanExchangeMaterial;
			confirmButton.Interactable(flag | flag2);
			confirmButtonText.SetTable(LocalizeTable.Common);
			LocalizedString stringReference = confirmButtonText.StringReference;
			LocalizationCommonData.CommonString commonString;
			if (flag2)
			{
				commonString = LocalizationCommonData.CommonString.ExchangeMaterial;
			}
			else
			{
				commonString = (m_SelectedSkillItem.IsUnLock ? LocalizationCommonData.CommonString.LevelUp : LocalizationCommonData.CommonString.UnLock);
			}
			stringReference.TableEntryReference = commonString;
			int coinItemId = (int)coinComponent.itemId;
			int skillExpItemId = (int)skillExpComponent.itemId;
			ItemKv itemKv = skillGroupLevelData.cost.FirstOrDefault((ItemKv x) => x.id == coinItemId);
			coinComponent.Init(itemKv?.count ?? (-1));
			ItemKv itemKv2 = skillGroupLevelData.cost.FirstOrDefault((ItemKv x) => x.id == skillExpItemId);
			skillExpComponent.Init(itemKv2?.count ?? (-1));
			IEnumerable<ItemKv> enumerable = skillGroupLevelData.cost.Where((ItemKv x) => x.id != coinItemId && x.id != skillExpItemId);
			m_ComsumeItems.Clear();
			foreach (ItemKv item in enumerable)
			{
				m_ComsumeItems.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
			}
			resourceScrollBag.Station = m_ImageAssetStation;
			resourceScrollBag.ItemSource = m_ComsumeItems;
			resourceScrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
			break;
		}
		case CharacterViewConst.ReasonType.IsTalent:
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = 41000004L;
			break;
		case CharacterViewConst.ReasonType.LessCharacterLevel:
			skillGroupLevelData = m_SelectedSkillItem.GetSkillGroupNextLvData();
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = 41000003L;
			warning.StringReference.GetVariable<int>("0").Value = skillGroupLevelData.requireCharacterLevel;
			break;
		case CharacterViewConst.ReasonType.ReachMaxLevel:
			maxTip.SetActive(!(m_SelectedSkillItem is RelativeSkillItem));
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = ((m_SelectedSkillItem is RelativeSkillItem) ? LocalizationCommonData.CommonString.AlreadyUnlock : LocalizationCommonData.CommonString.CannotLevelUpMaxLevel);
			break;
		default:
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色Id为 {m_Character.Id} 缺少技能组 {m_SelectedSkillItem.skillGroupId} 或 该技能组配置有问题");
			}
			break;
		}
		if (isTrailCharacter)
		{
			warningRoot.SetActive(value: false);
			costRoot.SetActive(value: false);
			confirmButtonRoot.SetActive(value: false);
		}
	}

	private bool IsSkillCostEnough(List<ItemKv> cost)
	{
		if (cost == null)
		{
			return false;
		}
		for (int i = 0; i < cost.Count; i++)
		{
			ItemKv itemKv = cost[i];
			if (GetSkillCostOwnedCount(itemKv.id) < itemKv.count)
			{
				return false;
			}
		}
		return true;
	}

	private long GetSkillCostOwnedCount(int costId)
	{
		if (IsDedicatedCostItem(costId))
		{
			return G.TryGetAttribute(costId);
		}
		return G.localPlayer.Inventory.GetItemCount(costId);
	}

	private bool IsDedicatedCostItem(int costId)
	{
		if (costId != (int)coinComponent.itemId)
		{
			return costId == (int)skillExpComponent.itemId;
		}
		return true;
	}

	private bool TryGetQuickPowerExchangeItemViewData(List<ItemKv> cost, out QuickPowerExchangeItemViewData viewData, out long totalPowerCost)
	{
		viewData = new QuickPowerExchangeItemViewData();
		totalPowerCost = 0L;
		if (cost == null)
		{
			return false;
		}
		int itemId = (int)coinComponent.itemId;
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		for (int i = 0; i < cost.Count; i++)
		{
			ItemKv itemKv = cost[i];
			long skillCostOwnedCount = GetSkillCostOwnedCount(itemKv.id);
			int num4 = (int)Math.Max(0L, itemKv.count - skillCostOwnedCount);
			if (num4 > 0)
			{
				if (itemKv.id == itemId)
				{
					num += num4;
				}
				else if (num2 == 0 || num2 == itemKv.id)
				{
					num2 = itemKv.id;
					num3 += num4;
				}
			}
		}
		int num5 = ((num > 0) ? itemId : num2);
		int num6 = ((num > 0) ? num : num3);
		if (num5 <= 0 || num6 <= 0 || !Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(num5))
		{
			return false;
		}
		long requirePowerCount = Model<PowerModel>.Interface.GetRequirePowerCount(num5, num6);
		if (requirePowerCount <= 0)
		{
			return false;
		}
		viewData.NeedItemId = num5;
		viewData.NeedItemCount = num6;
		totalPowerCost = requirePowerCount;
		return totalPowerCost > 0;
	}

	private void OpenQuickPowerExchangeItemView()
	{
		SkillGroupLevelData skillGroupLevelData = m_SelectedSkillItem?.GetSkillGroupNextLvData();
		if (m_CanExchangeMaterial && skillGroupLevelData?.cost != null && TryGetQuickPowerExchangeItemViewData(skillGroupLevelData.cost, out var viewData, out var _))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_QUICKPOWEREXCHANGEITEM, viewData);
		}
	}

	private SkillGroupCell GetObject()
	{
		SkillGroupCell skillGroupCell;
		if (m_BriefPool.Count == 0)
		{
			skillGroupCell = UnityEngine.Object.Instantiate(briefDescRootSkillItemPrefab, briefDescRootContent);
		}
		else
		{
			skillGroupCell = m_BriefPool.Pop();
			skillGroupCell.transform.SetParent(briefDescRootContent);
		}
		skillGroupCell.gameObject.SetActive(value: true);
		return skillGroupCell;
	}

	private SkillGroupDetailCell GetDetailObject()
	{
		SkillGroupDetailCell skillGroupDetailCell;
		if (m_DetailPool.Count == 0)
		{
			skillGroupDetailCell = UnityEngine.Object.Instantiate(detailDescRootSkillItemPrefab, detailDescRootContent);
		}
		else
		{
			skillGroupDetailCell = m_DetailPool.Pop();
			skillGroupDetailCell.transform.SetParent(detailDescRootContent);
		}
		skillGroupDetailCell.gameObject.SetActive(value: true);
		return skillGroupDetailCell;
	}

	private void ReturnObject(SkillGroupCell go)
	{
		go.transform.SetParent(briefDescRootContent.parent);
		go.gameObject.SetActive(value: false);
		go.UnInit();
		m_BriefPool.Push(go);
	}

	private void ReturnObject(SkillGroupDetailCell go)
	{
		go.transform.SetParent(detailDescRootContent.parent);
		go.gameObject.SetActive(value: false);
		m_DetailPool.Push(go);
	}

	private void OnToggleChanged(bool isOn)
	{
		UpdateSkillInfosPanel();
		GamePlayerPrefs.SetInt("DetailSwitch", isOn ? 1 : 0);
		m_Animation.GetSequence(_showDetailDescPanel ? "Right_Switch_Detail" : "Right_Switch_Brief")?.Play();
	}

	private void UpdateSkillInfosPanel()
	{
		if (m_SelectedSkillItem == null)
		{
			_showDetailDescPanel = false;
			briefDescRoot.gameObject.SetActive(value: true);
			detailDescRoot.gameObject.SetActive(value: false);
			for (int num = briefDescRootContent.childCount - 1; num >= 0; num--)
			{
				SkillGroupCell component = briefDescRootContent.GetChild(num).GetComponent<SkillGroupCell>();
				ReturnObject(component);
			}
			for (int num2 = detailDescRootContent.childCount - 1; num2 >= 0; num2--)
			{
				ReturnObject(detailDescRootContent.GetChild(num2).GetComponent<SkillGroupDetailCell>());
			}
			return;
		}
		SkillGroupData data = CoreUtils.GetData(m_SkillGroupId, RuntimeConfigs.data.skillGroupDatas);
		if (data == null)
		{
			return;
		}
		int num3 = m_Character.GetSkillGroupEventualLevel(m_SkillGroupId);
		if (num3 == 0)
		{
			if (!(m_SelectedSkillItem is RelativeSkillItem))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"技能组 {m_SkillGroupId} 找不到？");
				}
				return;
			}
			num3 = 1;
		}
		SkillGroupLevelData data2 = CoreUtils.GetData(data.GetSkillGroupLevelId(num3), RuntimeConfigs.data.skillGroupLevelDatas);
		if (data2 == null)
		{
			return;
		}
		bool flag = HasDetailDescription(data2);
		if (animateToggle != null)
		{
			animateToggle.gameObject.SetActive(flag);
		}
		_showDetailDescPanel = flag && animateToggle != null && animateToggle.isOn;
		briefDescRoot.gameObject.SetActive(!_showDetailDescPanel);
		detailDescRoot.gameObject.SetActive(_showDetailDescPanel);
		for (int num4 = briefDescRootContent.childCount - 1; num4 >= data2.skillDes.Length; num4--)
		{
			ReturnObject(briefDescRootContent.GetChild(num4).GetComponent<SkillGroupCell>());
		}
		int num5 = (flag ? data2.skillDes.Length : 0);
		for (int num6 = detailDescRootContent.childCount - 1; num6 >= num5; num6--)
		{
			ReturnObject(detailDescRootContent.GetChild(num6).GetComponent<SkillGroupDetailCell>());
		}
		for (int i = 0; i < data2.skillDes.Length; i++)
		{
			((i >= briefDescRootContent.childCount) ? GetObject() : briefDescRootContent.GetChild(i).GetComponent<SkillGroupCell>()).Init(skillMessageId: CoreUtils.GetData(data2.skillDes[i], RuntimeConfigs.data.skillDetailMessageDatas), skillGroupId: m_SkillGroupId, curLevel: num3, isDetail: false);
			if (flag)
			{
				((i >= detailDescRootContent.childCount) ? GetDetailObject() : detailDescRootContent.GetChild(i).GetComponent<SkillGroupDetailCell>()).Init(data2.skillDes[i], num3);
			}
		}
		briefDescRootContent.anchoredPosition = Vector3.zero;
		detailDescRootContent.anchoredPosition = Vector3.zero;
		if (ActiveDescScrollRect != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(ActiveDescScrollRect.transform.GetComponent<RectTransform>());
			LayoutRebuilder.ForceRebuildLayoutImmediate(ActiveDescScrollRect.content.transform.GetComponent<RectTransform>());
			LayoutRebuilder.ForceRebuildLayoutImmediate(ActiveDescScrollRect.viewport.transform.GetComponent<RectTransform>());
		}
		RefreshGamePadTipsDelayed().Forget();
	}

	private bool HasDetailDescription(SkillGroupLevelData skillGroupLevelData)
	{
		int[] array = skillGroupLevelData?.skillDes;
		if (array == null || array.Length <= 0)
		{
			return false;
		}
		for (int i = 0; i < skillGroupLevelData.skillDes.Length; i++)
		{
			SkillDetailMessageData data = CoreUtils.GetData(skillGroupLevelData.skillDes[i], RuntimeConfigs.data.skillDetailMessageDatas);
			if (data != null && data.detailDescLocal != 0)
			{
				return true;
			}
		}
		return false;
	}

	private bool HasCurrentSkillDetailDescription(SkillGroupData skillGroupData)
	{
		byte b = m_Character.GetSkillGroupEventualLevel(m_SkillGroupId);
		if (b == 0)
		{
			if (!(m_SelectedSkillItem is RelativeSkillItem))
			{
				return false;
			}
			b = 1;
		}
		SkillGroupLevelData data = CoreUtils.GetData(skillGroupData.GetSkillGroupLevelId(b), RuntimeConfigs.data.skillGroupLevelDatas);
		return HasDetailDescription(data);
	}

	private void InitSkillPanel()
	{
		UnityAction openDestiny = ((CharacterView != null) ? new UnityAction(CharacterView.OpenDestiny) : null);
		m_CurrentGo.comp.ShowPanel(m_Character, m_ImageAssetStation, openDestiny, m_Character.IsTrailCharacter);
		foreach (SkillItemBase skillItemBase in m_CurrentGo.comp.toggles)
		{
			SkillItemBase skillItemBase2 = skillItemBase;
			skillItemBase2.OnSelectedCallBack = (UnityAction)Delegate.Combine(skillItemBase2.OnSelectedCallBack, (UnityAction)(() =>
			{
				OnSkillGroupSelected(skillItemBase);
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Check");
			}));
		}
		OnSkillGroupSelected(m_SkillPanel.ActiveItem, forceUpdate: true);
		ViewControlLayers[SkillSubviewInputState.SkillMain] = m_SkillPanel.GetComponentInChildren<ViewControlLayer>();
		ViewControlLayers[SkillSubviewInputState.SkillMain].SetDefaultSelect(m_SkillPanel.ActiveItem.GetComponent<ACT.ViewControl.SelectableEx>());
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	public void ShowLevelUpView()
	{
		if (m_CanExchangeMaterial)
		{
			OpenQuickPowerExchangeItemView();
		}
		else if (!(confirmButton == null) && confirmButton.interactable)
		{
			if (!(m_SelectedSkillItem is RelativeSkillItem))
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SKILLLEVELUP, new LevelUpData
				{
					skillItem = m_SelectedSkillItem,
					character = m_Character
				}).Forget();
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SKILLUNLOCK, new SkillUnlockViewData
				{
					Character = m_Character,
					SkillGroupID = m_SkillGroupId
				}).Forget();
			}
		}
	}

	public void ShowLevelUpPreviewView()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPPREVIEWSKILLGROUP, new PopupPreviewSkillGroupBaseViewData
		{
			skillGroupId = m_SkillGroupId,
			character = m_Character
		}).Forget();
	}

	public void ToggleDescriptionMode()
	{
		if (animateToggle != null && animateToggle.gameObject.activeInHierarchy)
		{
			animateToggle.isOn = !animateToggle.isOn;
		}
	}

	public void ShowSelectedCostMaterialDetail()
	{
		if (!costRoot.activeSelf)
		{
			return;
		}
		ItemUnifierProxy itemUnifierProxy = resourceScrollBag?.SelectedModels?.FirstOrDefault() ?? m_ComsumeItems?.FirstOrDefault();
		if (itemUnifierProxy != null)
		{
			Item item = itemUnifierProxy.As<Item>();
			if (item != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, item);
			}
		}
	}

	public void ShowCurrencyDetail()
	{
		staticCoinComponent?.OnClick.Invoke();
	}

	public void OnScrollbarNavigate(Vector2 value)
	{
		ScrollRect activeDescScrollRect = ActiveDescScrollRect;
		if (!(activeDescScrollRect == null))
		{
			activeDescScrollRect.velocity = new Vector2(0f, value.y * ActiveDescScrollRect.scrollSensitivity * 50f);
		}
	}

	private void BindCoinGroupFocus()
	{
		if (!(coinGroup == null))
		{
			_coinViewLayer = coinGroup.GetComponentInChildren<ViewControlLayer>(includeInactive: true);
			_coinViewLayer?.OnFocusChanged.AddListener(OnCoinGroupFocusChanged);
		}
	}

	private void UnbindCoinGroupFocus()
	{
		_coinViewLayer?.OnFocusChanged.RemoveListener(OnCoinGroupFocusChanged);
		_coinViewLayer = null;
	}

	private void OnCoinGroupFocusChanged(bool focused)
	{
		if (!focused && isActiveAndEnabled && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			RestoreSkillLayerFocus();
		}
	}

	private void RestoreSkillLayerFocus()
	{
		CvSkillSubController controller = GetController();
		if (controller != null && ViewControlLayers.TryGetValue(controller.InputState, out var value) && !(value == null))
		{
			ChangeToGamePadInputState(controller.InputState, needReFocusLayer: true);
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		CvSkillSubController controller = GetController();
		if (controller != null && active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && ViewControlLayers.TryGetValue(controller.InputState, out var value))
		{
			value?.ReFocus();
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.InputState);
			}
		}
	}

	public void ChangeToGamePadInputState(SkillSubviewInputState type, bool needReFocusLayer = false)
	{
		CvSkillSubController controller = GetController();
		if (controller == null)
		{
			return;
		}
		controller.InputState = type;
		if (ViewControlLayers.TryGetValue(type, out var value))
		{
			if (needReFocusLayer)
			{
				value.ReFocus();
			}
			else
			{
				value.Focus();
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.InputState);
			}
		}
	}

	public void GamePadTipsStatusChange(SkillSubviewInputState subController)
	{
		foreach (KeyValuePair<SkillSubviewInputState, List<GameObject>> item in ViewControlPrompt)
		{
			foreach (GameObject item2 in item.Value)
			{
				item2.GetComponent<OperateBtnPrompt>()?.SetVisible(vis: false);
			}
		}
		if (ViewControlPrompt.TryGetValue(subController, out var value))
		{
			foreach (GameObject item3 in value)
			{
				item3.GetComponent<OperateBtnPrompt>()?.SetVisible(vis: true);
			}
		}
		gamePadTips.ClearAllPrompts();
		_tipsActions.Clear();
		bool flag = ActiveDescScrollRect != null && ActiveDescScrollRect.content.rect.height > ActiveDescScrollRect.viewport.rect.height;
		switch (subController)
		{
		case SkillSubviewInputState.SkillSelectItem:
			_tipsActions.Add(actionDic["UI/Confirm"]);
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case SkillSubviewInputState.SkillMain:
			_tipsActions.Add(actionDic["UI/Back"]);
			if (flag)
			{
				_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
	}

	public void OnClickView()
	{
		ShowLevelUpPreviewView();
	}

	public void OnLeftStickPress()
	{
		if (costRoot.activeSelf)
		{
			ChangeToGamePadInputState(SkillSubviewInputState.SkillSelectItem);
		}
	}
}
