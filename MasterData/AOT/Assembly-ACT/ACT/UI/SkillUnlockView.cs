using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Net;
using ACT.RichText;
using ACT.Sound;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent;
using TMPro;
using UI.ViewComponent.CharacterView.SkillUI;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class SkillUnlockView : BaseUIView<SkillUnlockViewInputInputController>
{
	public Image background;

	public GameObject[] skillGroupIcon;

	public LocalizeStringEvent skillGroupTitle;

	public LocalizeStringEvent skillGroupDescription;

	public ActButton leftButton;

	public ActButton rightButton;

	[Header("下部")]
	public GameObject costPartRoot;

	public GameObject costPrefab;

	public RectTransform costContent;

	public CommonCoinComponent coinComponent;

	public CommonCoinComponent skillExpComponent;

	public ActButton confirmButton;

	public LocalizeStringEvent tipText;

	public ScrollRect scrollRect;

	public RightStickScrollSupport RightStickScrollSupport;

	public RectTransform submitPrompt;

	public GameObject rewardPartRoot;

	public BImage rewardItemIcon;

	public TMP_Text rewardItemCount;

	[Header("输入层")]
	public ViewControlLayer baseViewControlLayer;

	public ViewControlLayer iconViewControlLayer;

	public GamePadTipsComp gamePadGroup;

	public CommonCoinGroup coinGroup;

	private ViewControlLayer _coinViewLayer;

	private Character m_Character;

	private SkillGroupData m_GroupData;

	private SkillGroupLevelData m_LevelData;

	private bool m_IsUnlock;

	private int m_GroupID;

	private readonly List<int> _corePassiveSkillGroupIds = new List<int>();

	private int _selectedIndex;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	private bool m_canRightStickScroll = true;

	private SkillUnlockViewData m_data => uiViewData as SkillUnlockViewData;

	private void Awake()
	{
		confirmButton.SetBtnClick(OnConfirmClick);
		confirmButton.OnUnInteractableClick.AddListener(() =>
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Skill_TalentUnlock);
		});
		leftButton.SetBtnClick(OnLeftButtonClick);
		rightButton.SetBtnClick(OnRightButtonClick);
		BindCoinGroupFocus();
	}

	protected override void OnUnityDestroy()
	{
		UnbindCoinGroupFocus();
		base.OnUnityDestroy();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		m_Character = m_data.Character;
		CollectCorePassiveSkillGroupIds();
		int num = _corePassiveSkillGroupIds.IndexOf(m_data.SkillGroupID);
		SelectSkillAt((num >= 0) ? num : 0);
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt(showConfirm: false);
		iconViewControlLayer.UnFocus();
		submitPrompt.gameObject.SetActive(value: true);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		baseViewControlLayer.UnFocus();
		iconViewControlLayer.UnFocus();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void UpdateTopPart()
	{
		RefreshSkillGroupIcons();
		skillGroupTitle.SetTable(LocalizeTable.ShortCommon);
		skillGroupTitle.StringReference.TableEntryReference = m_GroupData.skillSetLocal;
		if (m_IsUnlock)
		{
			EntityCharacterData data = CoreUtils.GetData(m_Character.Id, RuntimeConfigs.data.entityCharacterDatas);
			ColorUtility.TryParseHtmlString(RelativeSkillItem.CharacterTypeColorMap[data.mannerType], out var color);
			background.color = color;
		}
		else
		{
			background.color = Color.white;
		}
	}

	private void UpdateMiddlePart()
	{
		SkillDetailMessageData data = CoreUtils.GetData(m_LevelData.skillDes.FirstOrDefault(), RuntimeConfigs.data.skillDetailMessageDatas);
		if (data != null)
		{
			skillGroupDescription.SetTable(LocalizeTable.LongCommon);
			string text = CustomTagParser.ReplaceSkillMessageText(data.id, "longcommon");
			if (text.Equals("String Not Found!"))
			{
				text = string.Empty;
				Debug.LogWarning($"skillDetailMessageDatas表 {data.id} 对应的技能文本解析失败！");
			}
			text = text.Replace("<name>", string.Empty);
			skillGroupDescription.OnUpdateString?.Invoke(text);
		}
	}

	private void UpdateBottomPart()
	{
		if (m_IsUnlock)
		{
			costPartRoot.SetActive(value: false);
			confirmButton.gameObject.SetActive(value: false);
			tipText.gameObject.SetActive(value: true);
			tipText.SetTable(LocalizeTable.Common);
			tipText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.AlreadyUnlock;
		}
		else
		{
			costPartRoot.SetActive(value: true);
			List<ItemKv> cost = m_LevelData.cost;
			if (cost.Count == 0)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning($"Id为{m_GroupData.id}的技能组升级到{1}级无需任何消耗?");
				}
			}
			else
			{
				int coinItemId = (int)coinComponent.itemId;
				int skillExpItemId = (int)((skillExpComponent != null) ? skillExpComponent.itemId : ((PlayerAttribute)0));
				int costNum = cost.FirstOrDefault((ItemKv x) => x.id == coinItemId)?.count ?? 0;
				coinComponent.Init(costNum);
				coinComponent.dontShowDetail = false;
				int costNum2 = ((skillExpItemId != 0) ? (cost.FirstOrDefault((ItemKv x) => x.id == skillExpItemId)?.count ?? 0) : 0);
				if (skillExpComponent != null)
				{
					skillExpComponent.Init(costNum2);
					skillExpComponent.dontShowDetail = false;
				}
				for (int num = costContent.childCount - 1; num >= 0; num--)
				{
					Transform child = costContent.GetChild(num);
					ItemUIComponentBase component = child.GetComponent<ItemUIComponentBase>();
					if ((bool)component)
					{
						component.Release();
						UnityEngine.Object.Destroy(child.gameObject);
					}
				}
				for (int num2 = 0; num2 < cost.Count; num2++)
				{
					ItemKv itemKv = cost[num2];
					if (!IsDedicatedCostItem(itemKv.id, coinItemId, skillExpItemId))
					{
						GameObject gameObject = UnityEngine.Object.Instantiate(costPrefab, costContent);
						gameObject.SetActive(value: true);
						LiteItemUIComponent componentInChildren = gameObject.GetComponentInChildren<LiteItemUIComponent>();
						ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
						componentInChildren.Station = Station;
						componentInChildren.SetData(item, G.localPlayer.Inventory.GetItemCount(itemKv.id), ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
						componentInChildren.UpdatePerformance();
					}
				}
			}
			GameUtility.CanSkillGroupLevelUp(m_Character, m_GroupData.id, out var reason);
			if (reason == CharacterViewConst.ReasonType.LessCharacterLevel)
			{
				tipText.gameObject.SetActive(value: true);
				confirmButton.gameObject.SetActive(value: false);
				tipText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NeedCharacterLevel;
				tipText.StringReference.GetVariable<int>("0").Value = m_LevelData.requireCharacterLevel;
			}
			else
			{
				tipText.gameObject.SetActive(value: false);
				confirmButton.gameObject.SetActive(value: true);
				confirmButton.Interactable(GameUtility.ItemsIsEnough(m_LevelData.cost));
			}
		}
		submitPrompt.gameObject.SetActive(confirmButton.gameObject.activeSelf && confirmButton.interactable);
	}

	private void UpdateUnlockReward()
	{
		if (m_IsUnlock)
		{
			if (rewardPartRoot != null)
			{
				rewardPartRoot.SetActive(value: false);
			}
			return;
		}
		ItemKv itemKv = null;
		List<ItemKv> list = m_LevelData?.unlockReward;
		if (list != null && list.Count > 0)
		{
			itemKv = list[0];
		}
		ItemData itemData = ((itemKv != null) ? CoreUtils.GetData(itemKv.id, RuntimeConfigs.data.itemDatas) : null);
		bool flag = itemData != null;
		if (rewardPartRoot != null)
		{
			rewardPartRoot.SetActive(flag);
		}
		if (flag)
		{
			if (rewardItemIcon?.icon != null)
			{
				Station.LoadItemIcon(itemData.iconAddress, rewardItemIcon);
			}
			if (rewardItemCount != null)
			{
				rewardItemCount.SetText("{0:0}", itemKv.count);
			}
		}
	}

	private void CollectCorePassiveSkillGroupIds()
	{
		_corePassiveSkillGroupIds.Clear();
		if (m_Character == null)
		{
			return;
		}
		EntityCharacterData data = CoreUtils.GetData(m_Character.Id, RuntimeConfigs.data.entityCharacterDatas);
		if (data?.skillGroupIds == null)
		{
			return;
		}
		int[] skillGroupIds = data.skillGroupIds;
		foreach (int num in skillGroupIds)
		{
			SkillGroupData data2 = CoreUtils.GetData(num, RuntimeConfigs.data.skillGroupDatas);
			if (data2 != null && data2.skillType == 12)
			{
				_corePassiveSkillGroupIds.Add(num);
			}
		}
		if (_corePassiveSkillGroupIds.Count == 0 && m_data.SkillGroupID != 0)
		{
			_corePassiveSkillGroupIds.Add(m_data.SkillGroupID);
		}
	}

	private void SelectSkillAt(int index)
	{
		if (_corePassiveSkillGroupIds.Count != 0)
		{
			_selectedIndex = Mathf.Clamp(index, 0, _corePassiveSkillGroupIds.Count - 1);
			m_GroupID = _corePassiveSkillGroupIds[_selectedIndex];
			m_GroupData = CoreUtils.GetData(m_GroupID, RuntimeConfigs.data.skillGroupDatas);
			m_IsUnlock = m_Character.GetSkillGroupLevel(m_GroupData.id) > 0;
			MPSkill skill = new MPSkill
			{
				id = m_GroupData.id,
				level = 1
			};
			m_LevelData = CoreUtils.GetData(skill.GetSkillIdWithLevel(), RuntimeConfigs.data.skillGroupLevelDatas);
			UpdateTopPart();
			UpdateMiddlePart();
			UpdateBottomPart();
			UpdateUnlockReward();
			RefreshSwitchButtons();
			RefreshRightStickScrollForbid();
		}
	}

	private void RefreshSkillGroupIcons()
	{
		if (skillGroupIcon == null)
		{
			return;
		}
		for (int i = 0; i < skillGroupIcon.Length; i++)
		{
			GameObject gameObject = skillGroupIcon[i];
			if (!(gameObject == null))
			{
				gameObject.SetActive(i == _selectedIndex);
			}
		}
	}

	private void RefreshSwitchButtons()
	{
		int count = _corePassiveSkillGroupIds.Count;
		leftButton.Interactable(_selectedIndex > 0);
		rightButton.Interactable(_selectedIndex < count - 1);
	}

	private void OnLeftButtonClick()
	{
		if (leftButton.IsInteractable() && _selectedIndex > 0)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Check");
			SelectSkillAt(_selectedIndex - 1);
		}
	}

	private void OnRightButtonClick()
	{
		if (rightButton.IsInteractable() && _selectedIndex < _corePassiveSkillGroupIds.Count - 1)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Check");
			SelectSkillAt(_selectedIndex + 1);
		}
	}

	private void OnBagItemChanged(BaseEventContent evt)
	{
		if (gameObject.activeInHierarchy)
		{
			ItemChangeEvt itemChangeEvt = evt as ItemChangeEvt;
			if (itemChangeEvt != null && itemChangeEvt.ItemProxies != null && CurrentSkillCostMatches((int costId) => itemChangeEvt.ItemProxies.Exists((ItemUnifierProxy x) => x.Id == costId)))
			{
				RefreshCostState();
			}
		}
	}

	private void OnPlayerAttributeChanged(BaseEventContent evt)
	{
		if (gameObject.activeInHierarchy)
		{
			PlayerAttributeChangeEvt attributeChangeEvt = evt as PlayerAttributeChangeEvt;
			if (attributeChangeEvt != null && CurrentSkillCostMatches((int costId) => costId == attributeChangeEvt.id))
			{
				RefreshCostState();
			}
		}
	}

	private bool CurrentSkillCostMatches(Func<int, bool> match)
	{
		if (m_IsUnlock || m_LevelData?.cost == null || match == null)
		{
			return false;
		}
		return m_LevelData.cost.Any((ItemKv x) => match(x.id));
	}

	private bool IsDedicatedCostItem(int costId, int coinItemId, int skillExpItemId)
	{
		if (costId != coinItemId)
		{
			if (skillExpItemId != 0)
			{
				return costId == skillExpItemId;
			}
			return false;
		}
		return true;
	}

	private void RefreshCostState()
	{
		UpdateBottomPart();
		RefreshRightStickScrollForbid();
	}

	public void OnConfirmClick()
	{
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Skill_TalentUnlock);
		G.service.SkillLevelUp(m_Character.Id, m_GroupData.id, (bool ack, RepeatedField<UniversalItem> rewards) =>
		{
			if (ack)
			{
				GameUtility.OpenPopReward(rewards);
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Upgrade", new AudioPlayOptions
				{
					attachTarget = transform
				});
				SkillGroupLevelUpEvt evt = Singleton<EventManager>.instance.GetEvt<SkillGroupLevelUpEvt>();
				evt.skillGrouID = m_GroupData.id;
				evt.character = m_Character;
				evt.newLevel = 1;
				evt.rawLevel = 0;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Skill_Change, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_SkillPanel_Refresh, null);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Skill_Refresh, null);
				SkillUpEvt evt2 = EventTrackSolver.Instance.GetEvt<SkillUpEvt>();
				evt2.skillId = m_GroupData.id;
				evt2.skillLevel = 1;
				EventTrackSolver.Instance.Dispatch(evt2);
				m_IsUnlock = true;
				UpdateTopPart();
				UpdateBottomPart();
				UpdateUnlockReward();
			}
		});
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	public void ReBindBtnPrompt(bool showConfirm)
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (showConfirm)
		{
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		}
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}

	private void RefreshRightStickScrollForbid()
	{
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		rightStickScrollSupport.SetTargetScrollRect(scrollRect);
		if (rightStickScrollSupport == null || scrollRect == null)
		{
			m_canRightStickScroll = scrollRect != null && scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (scrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		}
		bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect scrollRect = this.scrollRect;
			if (!(scrollRect == null))
			{
				scrollRect.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
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
			RestoreMainLayerFocus();
		}
	}

	private void RestoreMainLayerFocus()
	{
		SkillUnlockViewInputInputController controller = GetController();
		((controller != null && controller.IsSelectingItems) ? iconViewControlLayer : baseViewControlLayer)?.ReFocus();
	}
}
