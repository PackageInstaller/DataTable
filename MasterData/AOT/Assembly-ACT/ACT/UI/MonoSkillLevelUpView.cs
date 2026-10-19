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
using ACT.MultiPlayer;
using ACT.Sound;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.UI.CommonComponent;
using Runtime.UI.ViewComponent.CharacterViewV3.SkillUI;
using Sirenix.Serialization;
using TMPro;
using UI.ViewComponent.CharacterView.SkillUI;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoSkillLevelUpView : BaseUIView<SkillLevelUpViewController>
{
	[Header("特殊加成")]
	public Color specialAddColor;

	[Header("属性")]
	public GameObject propertyPrefab;

	public RectTransform propertyContent;

	public Color promoteColor;

	[Header("消耗品")]
	public GameObject costPrefab;

	public GameObject costRoot;

	[Header("组件")]
	public RectTransform costContent;

	public CommonCoinComponent coinComponent;

	public CommonCoinComponent skillExpComponent;

	public RectTransform propertyView;

	public ActButton upgradeButton;

	public ActButton confirmButton;

	[Header("无法升级提示")]
	public GameObject warningRoot;

	public LocalizeStringEvent warning;

	[Header("动画")]
	[SerializeField]
	private float m_PropertyStartDelay = 0.1f;

	[Header("样式")]
	public GameObject normalStyleRoot;

	public GameObject rootFrom;

	public GameObject rootSpecialTipFrom;

	public TextMeshProUGUI from;

	public GameObject arrow;

	public GameObject rootTo;

	public GameObject rootSpecialTipTo;

	public TextMeshProUGUI to;

	public TextMeshProUGUI to2;

	public GameObject maxStyleRoot;

	public TextMeshProUGUI maxLvText;

	public ScrollRect scrollRect;

	public RightStickScrollSupport rightStickScroll;

	public GameObject scrollPrompt;

	public GameObject upGradePrompt;

	[OdinSerialize]
	public Dictionary<SkillSubviewInputState, ViewControlLayer> ViewControlLayers;

	[OdinSerialize]
	public Dictionary<SkillSubviewInputState, List<GameObject>> ViewControlPrompt;

	public CommonCoinGroup coinGroup;

	private SkillGroupLevelData m_LevelData;

	private SkillGroupData m_GroupData;

	private AbilityItem m_SkillItem;

	private Character m_Character;

	private int m_CurrentLevel;

	private Stack<GameObject> m_PropertyCellPool = new Stack<GameObject>();

	private int m_ExtraLevel => m_SkillItem.currentLevel - m_SkillItem.baseLevel;

	private void Awake()
	{
		if ((bool)upgradeButton)
		{
			upgradeButton.OnClick.AddListener(SendUpGradeMessage);
		}
		if ((bool)confirmButton)
		{
			confirmButton.OnClick.AddListener(Close);
		}
	}

	protected override void OnUnityDestroy()
	{
		if ((bool)upgradeButton)
		{
			upgradeButton.OnClick.RemoveListener(SendUpGradeMessage);
		}
		if ((bool)confirmButton)
		{
			confirmButton.OnClick.RemoveListener(Close);
		}
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Window");
		LevelUpData levelUpData = (LevelUpData)uiViewData;
		m_SkillItem = levelUpData.skillItem as AbilityItem;
		m_GroupData = levelUpData.skillItem.SkillGroupData;
		m_Character = levelUpData.character;
		UpdateLevelData();
		ShowNormalMainPanel();
		UpdateTopLevelInfo();
		RefreshLayout();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		GetController().InputState = SkillSubviewInputState.SkillMain;
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void RefreshLayout()
	{
		if (scrollRect != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(propertyContent);
			LayoutRebuilder.ForceRebuildLayoutImmediate(propertyView);
		}
	}

	private void UpdateLevelData()
	{
		m_CurrentLevel = m_Character.GetSkillGroupEventualLevel(m_GroupData.id);
		m_LevelData = m_SkillItem.GetSkillGroupNextLvData();
	}

	private void UpdateTopLevelInfo()
	{
		from.text = m_CurrentLevel.ToString();
		to.text = (m_CurrentLevel + 1).ToString();
		if (m_ExtraLevel > 0)
		{
			from.color = specialAddColor;
			to.color = specialAddColor;
		}
	}

	private void UpdateFailInfo()
	{
		warningRoot.SetActive(value: false);
		upgradeButton.gameObject.SetActive(value: false);
		switch (m_SkillItem.LockReason)
		{
		case CharacterViewConst.ReasonType.LessBreakLevel:
		{
			int baseLevel = m_SkillItem.baseLevel;
			int skillIdWithLevel = new MPSkill
			{
				id = m_GroupData.id,
				level = (byte)(baseLevel + 1)
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
		case CharacterViewConst.ReasonType.LackCoin:
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = 2273L;
			break;
		case CharacterViewConst.ReasonType.LackMaterial:
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = 81L;
			break;
		case CharacterViewConst.ReasonType.IsTalent:
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = 41000004L;
			break;
		case CharacterViewConst.ReasonType.LessCharacterLevel:
		{
			SkillGroupLevelData skillGroupNextLvData = m_SkillItem.GetSkillGroupNextLvData();
			warningRoot.SetActive(value: true);
			warning.StringReference.TableEntryReference = 41000003L;
			warning.StringReference.GetVariable<int>("0").Value = skillGroupNextLvData.requireCharacterLevel;
			break;
		}
		case CharacterViewConst.ReasonType.ReachMaxLevel:
			warningRoot.SetActive(value: true);
			confirmButton.gameObject.SetActive(value: false);
			warning.StringReference.TableEntryReference = 41000002L;
			break;
		default:
			upgradeButton.gameObject.SetActive(value: true);
			break;
		}
	}

	private void ShowNormalMainPanel(bool fromLevelUp = false)
	{
		costRoot.SetActive(value: true);
		rootFrom.SetActive(value: true);
		rootTo.SetActive(value: true);
		arrow.SetActive(value: true);
		rootSpecialTipFrom.SetActive(m_ExtraLevel > 0);
		rootSpecialTipTo.SetActive(m_ExtraLevel > 0);
		confirmButton.gameObject.SetActive(value: false);
		maxStyleRoot.SetActive(value: false);
		normalStyleRoot.SetActive(value: true);
		RefreshLockReason();
		UpdateFailInfo();
		upgradeButton.Interactable(CheckEnable());
		RefreshCostInfo();
		for (int num = propertyContent.childCount - 1; num >= 0; num--)
		{
			Transform child = propertyContent.GetChild(num);
			if ((bool)child.GetComponent<SkillLevelUpPropertyCell>())
			{
				ReturnSkillSheet(child.gameObject);
			}
		}
		SkillGroupLevelData data = CoreUtils.GetData(m_GroupData.GetSkillGroupLevelId(m_CurrentLevel), RuntimeConfigs.data.skillGroupLevelDatas);
		int num2 = 0;
		for (int i = 0; i < data.skillDes.Length; i++)
		{
			SkillLevelUpPropertyCell propertyCell = GetPropertyCell();
			propertyCell.transform.SetSiblingIndex(num2++);
			propertyCell.Init(data.skillDes[i], m_CurrentLevel, m_CurrentLevel + 1);
			try
			{
				if (fromLevelUp)
				{
					propertyCell.animation.GetSequence("LvUpNormal").SetDelay(m_PropertyStartDelay * (float)i).Play();
				}
			}
			catch (Exception)
			{
			}
		}
	}

	private void RefreshCostInfo()
	{
		if (m_LevelData == null)
		{
			return;
		}
		List<ItemKv> cost = m_LevelData.cost;
		for (int num = costContent.childCount - 1; num >= 0; num--)
		{
			Transform child = costContent.GetChild(num);
			ItemUIComponentBase component = child.GetComponent<ItemUIComponentBase>();
			if ((bool)component)
			{
				ItemUnifierProxy item = component.ItemUnifier;
				ItemUnifierProxy.ItemUnifierPool.Release(ref item);
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
		if (cost.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"Id为{m_GroupData.id}的技能组升级到{m_CurrentLevel + 1}无需任何消耗?");
			}
			return;
		}
		int coinItemId = (int)coinComponent.itemId;
		int skillExpItemId = (int)skillExpComponent.itemId;
		int costNum = cost.FirstOrDefault((ItemKv x) => x.id == coinItemId)?.count ?? 0;
		coinComponent.Init(costNum);
		coinComponent.dontShowDetail = false;
		int costNum2 = cost.FirstOrDefault((ItemKv x) => x.id == skillExpItemId)?.count ?? 0;
		skillExpComponent.Init(costNum2);
		skillExpComponent.dontShowDetail = false;
		for (int num2 = 0; num2 < cost.Count; num2++)
		{
			ItemKv itemKv = cost[num2];
			if (itemKv.id != coinItemId && itemKv.id != skillExpItemId)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(costPrefab, costContent);
				gameObject.SetActive(value: true);
				LiteItemUIComponent componentInChildren = gameObject.GetComponentInChildren<LiteItemUIComponent>();
				ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
				componentInChildren.SetData(item2, G.localPlayer.Inventory.GetItemCount(itemKv.id), ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
				componentInChildren.UpdatePerformance();
			}
		}
	}

	private void RefreshLevelUpState()
	{
		if (m_LevelData != null && !(normalStyleRoot == null) && normalStyleRoot.activeInHierarchy)
		{
			if (m_SkillItem != null)
			{
				RefreshLockReason();
			}
			UpdateFailInfo();
			upgradeButton.Interactable(CheckEnable());
			RefreshCostInfo();
		}
	}

	private void OnBagItemChanged(BaseEventContent evt)
	{
		if (!(evt is ItemChangeEvt { ItemProxies: not null } itemChangeEvt) || m_LevelData?.cost == null)
		{
			return;
		}
		List<ItemKv> cost = m_LevelData.cost;
		for (int i = 0; i < itemChangeEvt.ItemProxies.Count; i++)
		{
			ItemUnifierProxy itemUnifierProxy = itemChangeEvt.ItemProxies[i];
			if (itemUnifierProxy == null)
			{
				continue;
			}
			for (int j = 0; j < cost.Count; j++)
			{
				if (itemUnifierProxy.Id == cost[j].id)
				{
					RefreshLevelUpState();
					return;
				}
			}
		}
	}

	private void OnPlayerAttributeChanged(BaseEventContent evt)
	{
		PlayerAttributeChangeEvt attributeChangeEvt = evt as PlayerAttributeChangeEvt;
		if (attributeChangeEvt != null && m_LevelData?.cost != null && m_LevelData.cost.Any((ItemKv x) => x.id == attributeChangeEvt.id))
		{
			RefreshLevelUpState();
		}
	}

	private void RefreshLockReason()
	{
		if (m_SkillItem == null)
		{
			return;
		}
		if (m_CurrentLevel >= m_GroupData.levelUpLimit + m_ExtraLevel || m_LevelData == null)
		{
			m_SkillItem.LockReason = CharacterViewConst.ReasonType.ReachMaxLevel;
			return;
		}
		GameUtility.CanSkillGroupLevelUp(m_Character, m_GroupData.id, out var reason);
		if (reason == CharacterViewConst.ReasonType.None && !GameUtility.ItemsIsEnough(m_LevelData.cost))
		{
			reason = (IsCoinEnough() ? CharacterViewConst.ReasonType.LackMaterial : CharacterViewConst.ReasonType.LackCoin);
		}
		m_SkillItem.LockReason = reason;
	}

	private bool IsCoinEnough()
	{
		if (m_LevelData?.cost == null)
		{
			return true;
		}
		ItemKv itemKv = m_LevelData.cost.FirstOrDefault((ItemKv x) => x.id == 2);
		if (itemKv != null)
		{
			if (G.detailUserInfo.Attributes.TryGetValue(2, out var value))
			{
				return value >= itemKv.count;
			}
			return false;
		}
		return true;
	}

	private void ReturnSkillSheet(GameObject go)
	{
		go.transform.SetParent(transform);
		go.SetActive(value: false);
		m_PropertyCellPool.Push(go);
	}

	private SkillLevelUpPropertyCell GetPropertyCell()
	{
		SkillLevelUpPropertyCell skillLevelUpPropertyCell = ((m_PropertyCellPool.Count > 0) ? m_PropertyCellPool.Pop().GetComponent<SkillLevelUpPropertyCell>() : UnityEngine.Object.Instantiate(propertyPrefab, propertyContent).GetComponent<SkillLevelUpPropertyCell>());
		skillLevelUpPropertyCell.transform.SetParent(propertyContent);
		skillLevelUpPropertyCell.gameObject.SetActive(value: true);
		return skillLevelUpPropertyCell;
	}

	private void ShowMaxMainPanel()
	{
		m_CurrentLevel = m_Character.GetSkillGroupEventualLevel(m_GroupData.id);
		rootFrom.SetActive(value: false);
		rootTo.SetActive(value: true);
		arrow.SetActive(value: false);
		costRoot.SetActive(value: false);
		rootSpecialTipTo.SetActive(m_ExtraLevel > 0);
		confirmButton.gameObject.SetActive(value: true);
		upgradeButton.gameObject.SetActive(value: false);
		maxStyleRoot.SetActive(value: true);
		normalStyleRoot.SetActive(value: false);
		warningRoot.SetActive(value: false);
		for (int i = 0; i < propertyContent.childCount; i++)
		{
			SkillLevelUpPropertyCell component = propertyContent.GetChild(i).GetComponent<SkillLevelUpPropertyCell>();
			component.Init(m_CurrentLevel);
			try
			{
				component.animation.GetSequence("LvUpMax").SetDelay(m_PropertyStartDelay * (float)i).Play();
			}
			catch (Exception)
			{
			}
		}
		propertyView.anchorMin = Vector2.zero;
		propertyView.anchorMax = Vector2.one;
		propertyView.offsetMin = Vector2.zero;
		propertyView.offsetMax = Vector2.zero;
		maxLvText.SetText(m_CurrentLevel.FastToString());
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		try
		{
			betterAnimation.GetSequence("LvUp")?.Goto(0f);
			betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			OpenEffectFinishNew();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		try
		{
			betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			CloseEffectFinishNew();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	private bool CheckEnable()
	{
		if (m_LevelData == null)
		{
			return false;
		}
		if (GameUtility.CanSkillGroupLevelUp(m_Character, m_GroupData.id, out var _))
		{
			return GameUtility.ItemsIsEnough(m_LevelData.cost);
		}
		return false;
	}

	protected override void UnInit()
	{
		base.UnInit();
		for (int num = costContent.childCount - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(costContent.GetChild(num).gameObject);
		}
		for (int num2 = propertyContent.childCount - 1; num2 >= 0; num2--)
		{
			UnityEngine.Object.Destroy(propertyContent.GetChild(num2).gameObject);
		}
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
	}

	public void SendUpGradeMessage()
	{
		G.service.SkillLevelUp(m_Character.Id, m_GroupData.id, (bool ack, RepeatedField<UniversalItem> rewards) =>
		{
			if (ack)
			{
				GameUtility.OpenPopReward(rewards);
				SkillGroupLevelUpEvt evt = Singleton<EventManager>.instance.GetEvt<SkillGroupLevelUpEvt>();
				evt.skillGrouID = m_GroupData.id;
				evt.character = m_Character;
				evt.newLevel = m_CurrentLevel + 1;
				evt.rawLevel = m_CurrentLevel;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Skill_Change, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_SkillPanel_Refresh, null);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Skill_Refresh, null);
				SkillUpEvt evt2 = EventTrackSolver.Instance.GetEvt<SkillUpEvt>();
				evt2.skillId = m_GroupData.id;
				evt2.skillLevel = m_CurrentLevel + 1;
				EventTrackSolver.Instance.Dispatch(evt2);
				UpdateLevelData();
				to2.SetText(m_CurrentLevel.ToString());
				UpdateTopLevelInfo();
				bool flag = m_CurrentLevel >= m_GroupData.levelUpLimit + m_ExtraLevel;
				try
				{
					UpdateLevelData();
					if (flag)
					{
						betterAnimation.GetSequence("LvUpMax").Play();
						ShowMaxMainPanel();
						Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Upgrade_Slide", new AudioPlayOptions
						{
							attachTarget = transform
						});
					}
					else
					{
						AnimationBuilder sequence = betterAnimation.GetSequence("LvUp");
						sequence.ClearAllEvent();
						sequence.InsertCallback(sequence.Duration() / 2f, UpdateTopLevelInfo);
						sequence.Play();
						ShowNormalMainPanel(fromLevelUp: true);
						Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Upgrade", new AudioPlayOptions
						{
							attachTarget = transform
						});
					}
				}
				catch (Exception)
				{
					if (flag)
					{
						ShowMaxMainPanel();
					}
					else
					{
						ShowNormalMainPanel(fromLevelUp: true);
					}
				}
			}
		});
	}

	public void OpenCostCoinDetail()
	{
		coinComponent?.OnClick?.Invoke();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		SkillLevelUpViewController controller = GetController();
		if (controller != null && active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && ViewControlLayers.TryGetValue(controller.InputState, out var value))
		{
			value?.Focus();
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.InputState);
			}
		}
	}

	public void ChangeToGamePadInputState(SkillSubviewInputState type, bool needReFocusLayer = false)
	{
		SkillLevelUpViewController controller = GetController();
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
				item2.SetActive(value: false);
			}
		}
		if (ViewControlPrompt.TryGetValue(subController, out var value))
		{
			foreach (GameObject item3 in value)
			{
				item3.SetActive(value: true);
			}
		}
		bool flag = scrollRect != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScroll?.SetForbidScroll(subController == SkillSubviewInputState.SkillSelectItem);
		scrollPrompt?.SetActive(flag && subController == SkillSubviewInputState.SkillMain);
		upGradePrompt?.SetActive(subController == SkillSubviewInputState.SkillMain && CheckEnable());
	}

	public void HandleCommonSelectInput(SkillSubviewInputState subController)
	{
		switch (subController)
		{
		case SkillSubviewInputState.SkillMain:
			if (upgradeButton.gameObject.activeSelf && upgradeButton.interactable)
			{
				upgradeButton.OnClick?.Invoke();
			}
			else if (confirmButton.gameObject.activeSelf && confirmButton.interactable)
			{
				confirmButton.OnClick?.Invoke();
			}
			break;
		case SkillSubviewInputState.SkillSelectItem:
			GetController().CommonSelect();
			break;
		}
	}

	public void HandleCommonBackInput(SkillSubviewInputState subController)
	{
		switch (subController)
		{
		case SkillSubviewInputState.SkillMain:
			Close();
			break;
		case SkillSubviewInputState.SkillSelectItem:
			ChangeToGamePadInputState(SkillSubviewInputState.SkillMain, needReFocusLayer: true);
			break;
		}
	}
}
