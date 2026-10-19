using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

[RequireComponent(typeof(LayoutElement))]
[RequireComponent(typeof(BetterAnimation))]
public abstract class ItemUIComponentBase : ActToggle, ILoopScrollDataSource, IItemDetailRayCast, ILayoutCalculationIgnorer
{
	[Serializable]
	protected struct QualityStyle
	{
		public GameObject styleRoot;
	}

	public enum InitType
	{
		BagWeapon = 1,
		BagChip = 2,
		BagItem = 3,
		TeamViewBagCharacter = 4,
		CharacterViewBagCharacter = 23,
		SelectMaterialItem = 5,
		CookItem = 6,
		NoneItem = 7,
		LittleItem = 8,
		BagEquip = 9,
		BagGem = 10,
		BloodBottle = 31,
		BloodBottleMaterial = 32,
		BloodBottleMaterialInCangePanel = 33,
		RewardWeapon = 11,
		RewardChip = 12,
		RewardItem = 13,
		RewardItemReceived = 14,
		WorldSettlementRewardItem = 15,
		NeedCountContrastItem = 21,
		SelectedCountContrastItem = 22,
		ItemNeedCountContrastItem = CharacterViewBagCharacter,
		CharacterOverViewEquipSlot = 24,
		CharacterEquipSubviewEquipSlot = 25,
		EquipDissolveStyle = 26,
		FavorabilityGift = 27
	}

	public enum ItemCountShowType
	{
		Hide,
		OneSide,
		Both,
		ShowWithRandom
	}

	private ImageAssetStation m_Station;

	[FormerlySerializedAs("qualityStyles")]
	[SerializeField]
	protected QualityStyle[] m_QualityStyles;

	[SerializeField]
	protected BImage m_MainIcon;

	[SerializeField]
	protected BetterAnimation m_Animation;

	[FormerlySerializedAs("m_SelectedObject")]
	[SerializeField]
	protected GameObject m_ChosenObject;

	[SerializeField]
	protected GameObject m_DisabledObject;

	[SerializeField]
	protected GameObject m_GrayObject;

	[SerializeField]
	protected GameObject m_HighLightObject;

	[SerializeField]
	protected GameObject m_HighLightHandleObject;

	[SerializeField]
	protected GameObject m_HoverObject;

	[SerializeField]
	protected GameObject m_CompleteObject;

	[SerializeField]
	protected GameObject m_EmptyObject;

	[SerializeField]
	protected GameObject m_DisuseObject;

	[SerializeField]
	protected GameObject m_LimitTimeObject;

	[FormerlySerializedAs("itemCountRoot")]
	[SerializeField]
	protected GameObject m_ItemCountRoot;

	[FormerlySerializedAs("numberComponent")]
	[SerializeField]
	protected CommonNumberComponent m_NumberComponent;

	[SerializeField]
	protected TMP_Text m_LevelPrefixText;

	[SerializeField]
	protected GameObject m_ItemNameRoot;

	[SerializeField]
	protected LocalizeStringEvent m_ItemName;

	[SerializeField]
	protected RedDotItem m_redPointObject;

	[SerializeField]
	protected GameObject m_FreeTagObject;

	public bool showDetailPanel;

	public bool closeDetailChosen;

	public ItemUIGroup group;

	protected ItemUnifierProxy m_ItemUnifier;

	protected InitType m_InitType;

	protected ItemCountShowType m_ItemCountType;

	protected QualityStyle m_ActiveStyle;

	private CanvasGroup m_CanvasGroup;

	private bool m_CanvasGroupCached;

	private LayoutElement m_LayoutElement;

	private bool m_LayoutElementCached;

	private int m_ActiveQualityStyleIndex = -1;

	private bool m_QualityStyleInitialized;

	private List<RectTransform> m_QualityStyleRects;

	private List<Vector2> m_QualityStylePositions;

	private bool m_QualityStyleRectsCached;

	protected long m_LeftCount;

	private bool m_IsChosen;

	private bool m_IsHighLight;

	private bool m_IsDisabled;

	private bool m_IsGray;

	private bool m_IsComplete;

	protected string m_RedPointPath;

	protected RedDotType m_RedDotType;

	[NonSerialized]
	public ItemUnifierProxy TransiteItemUnifier;

	public UnityAction<ItemUIComponentBase> OnItemClick;

	public UnityAction<ItemUIComponentBase> OnInvertSelect;

	private bool m_AutoReleaseDataWhenDestroy;

	private bool m_UseBagCount;

	private Looper m_LimitTimeLooper;

	private int m_UpdateVersion;

	public float holdTime = 0.5f;

	public UnityEvent holdEvent = new UnityEvent();

	private bool isPointerDown;

	private float pointerDownTimer;

	public bool holding;

	public ImageAssetStation Station
	{
		get
		{
			if (m_Station == null)
			{
				m_Station = this.GetImageStation();
			}
			return m_Station;
		}
		set
		{
			m_Station = value;
		}
	}

	public CommonNumberComponent NumberComponent => m_NumberComponent;

	public new int Index { get; private set; }

	public bool IsChosen
	{
		get
		{
			return m_IsChosen;
		}
		set
		{
			if (!IsDisabled && m_IsChosen != value)
			{
				m_IsChosen = value;
				SetSelect();
			}
		}
	}

	public Func<bool> CanChosen { get; set; }

	public bool IsHighLight
	{
		get
		{
			return m_IsHighLight;
		}
		set
		{
			m_IsHighLight = value;
			if ((bool)Group && IsHighLight)
			{
				Group.SetToggleOn(this);
			}
			else if (IsOn == m_IsHighLight)
			{
				EnsureHighLight();
			}
			else
			{
				SetIsOn(value);
			}
		}
	}

	public bool IsDisabled
	{
		get
		{
			return m_IsDisabled;
		}
		set
		{
			if (IsDisabled != value)
			{
				if (value)
				{
					IsChosen = false;
				}
				m_IsDisabled = value;
				SetDisabled();
			}
		}
	}

	public bool IsGray
	{
		get
		{
			return m_IsGray;
		}
		set
		{
			if (IsGray != value)
			{
				m_IsGray = value;
				SetGrey();
			}
		}
	}

	public bool IsComplete
	{
		get
		{
			return m_IsComplete;
		}
		set
		{
			if (m_IsComplete != value)
			{
				m_IsComplete = value;
				SetComplete();
			}
		}
	}

	public string RedPointPath
	{
		get
		{
			return m_RedPointPath;
		}
		set
		{
			m_RedPointPath = value;
			UpdateRedPoint();
		}
	}

	public RedDotType RedDotType
	{
		get
		{
			return m_RedDotType;
		}
		set
		{
			if (m_RedDotType != value)
			{
				m_RedDotType = value;
				UpdateRedPoint();
			}
		}
	}

	public bool IsFirstComplete { get; set; }

	public int Quality => m_ItemUnifier?.Quality ?? 1;

	public InitType ItemType => m_InitType;

	public string AnimationName { get; set; } = "ItemShow";

	public ItemUnifierProxy ItemUnifier => m_ItemUnifier;

	private CanvasGroup CachedCanvasGroup
	{
		get
		{
			if (!m_CanvasGroupCached)
			{
				TryGetComponent<CanvasGroup>(out m_CanvasGroup);
				m_CanvasGroupCached = true;
			}
			return m_CanvasGroup;
		}
	}

	private LayoutElement CachedLayoutElement
	{
		get
		{
			if (!m_LayoutElementCached)
			{
				TryGetComponent<LayoutElement>(out m_LayoutElement);
				m_LayoutElementCached = true;
			}
			return m_LayoutElement;
		}
	}

	public bool IgnoreLayoutCalculation
	{
		get
		{
			LayoutElement cachedLayoutElement = CachedLayoutElement;
			if ((bool)cachedLayoutElement)
			{
				return cachedLayoutElement.ignoreLayout;
			}
			return true;
		}
	}

	public void SetHighLightVisualOnly(bool value)
	{
		m_IsHighLight = value;
		if ((bool)m_HighLightObject)
		{
			SetActiveIfChanged(m_HighLightObject, value);
		}
		if ((bool)m_HighLightHandleObject)
		{
			SetActiveIfChanged(m_HighLightHandleObject, value && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}

	protected override void Awake()
	{
		OnGameObjectAwake();
	}

	protected virtual void OnGameObjectAwake()
	{
		OnNormal();
		onToggleClick.AddListener(OnClick);
		onToggleOff.AddListener(OnNormal);
		onToggleOn.AddListener(OnHighLight);
	}

	protected override void OnDestroy()
	{
		m_UpdateVersion++;
		OnGameObjectDestroy();
	}

	protected virtual void OnGameObjectDestroy()
	{
		onToggleClick.RemoveListener(OnClick);
		onToggleOff.RemoveListener(OnNormal);
		onToggleOn.RemoveListener(OnHighLight);
		if (m_ItemUnifier != null)
		{
			m_ItemUnifier.Context = null;
			UnLoadMainIcon();
		}
		if (m_AutoReleaseDataWhenDestroy)
		{
			Release();
		}
		if (m_AutoReleaseDataWhenDestroy && m_ItemUnifier != null)
		{
			_ = LuminApplication.LogEnabled;
		}
		if (m_LimitTimeLooper.IsValid())
		{
			m_LimitTimeLooper.Cancel();
		}
		if (m_QualityStyleRects != null)
		{
			ListPool<RectTransform>.Release(m_QualityStyleRects);
			m_QualityStyleRects = null;
		}
		if (m_QualityStylePositions != null)
		{
			ListPool<Vector2>.Release(m_QualityStylePositions);
			m_QualityStylePositions = null;
		}
		m_QualityStyleRectsCached = false;
	}

	public void SetData(IBagItem item, long leftCount = 0L, InitType initType = InitType.BagItem, ItemCountShowType itemCountShowType = ItemCountShowType.Hide, bool autoReleaseData = false)
	{
		m_AutoReleaseDataWhenDestroy = true;
		SetData(ItemUnifierProxy.ItemUnifierPool.Get(item), leftCount, initType, itemCountShowType, autoReleaseData);
	}

	public void SetData(ItemUnifierProxy from, ItemUnifierProxy to, long leftCount = long.MinValue, InitType initType = InitType.BagItem, ItemCountShowType itemCountShowType = ItemCountShowType.Hide, bool autoReleaseData = false)
	{
		SetData(from, leftCount, initType, itemCountShowType, autoReleaseData);
		TransiteItemUnifier = to;
	}

	public virtual void SetData(ItemUnifierProxy item, long leftCount = long.MinValue, InitType initType = InitType.BagItem, ItemCountShowType itemCountShowType = ItemCountShowType.Hide, bool autoReleaseData = false)
	{
		m_UpdateVersion++;
		if (m_ItemUnifier != null)
		{
			ItemUnifier.Context = null;
			ItemUnifierProxy itemUnifier = ItemUnifier;
			itemUnifier.OnValueChanged = (Action<ItemUnifierProxy>)Delegate.Remove(itemUnifier.OnValueChanged, new Action<ItemUnifierProxy>(OnItemValueChanged));
		}
		m_ItemUnifier = item;
		if (m_ItemUnifier != null)
		{
			m_ItemUnifier.Context = this;
			ItemUnifierProxy itemUnifier2 = m_ItemUnifier;
			itemUnifier2.OnValueChanged = (Action<ItemUnifierProxy>)Delegate.Combine(itemUnifier2.OnValueChanged, new Action<ItemUnifierProxy>(OnItemValueChanged));
		}
		m_InitType = initType;
		if (m_ItemUnifier != null && leftCount == long.MinValue)
		{
			m_LeftCount = GetCount();
			m_UseBagCount = true;
		}
		else
		{
			m_LeftCount = leftCount;
			m_UseBagCount = false;
		}
		m_ItemCountType = itemCountShowType;
		m_AutoReleaseDataWhenDestroy = autoReleaseData;
	}

	public virtual void UpdatePerformance()
	{
		try
		{
			m_UpdateVersion++;
			SetQualityBg();
			LoadMainIcon();
			SetSelect();
			SetComplete();
			UpdateItemCount();
			UpdateName();
			UpdateRedPoint();
			SetDisabled();
			SetGrey();
			UpdateUniversalItemTag();
			UpdateDisuse();
			UpdateLimitTime();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}

	protected virtual void UpdateUniversalItemTag()
	{
	}

	protected virtual long GetCount()
	{
		return G.localPlayer.Inventory.GetItemCount(m_ItemUnifier.Id);
	}

	protected void SetUniversalItemExtraTag(GameObject tagRoot)
	{
		if (!(tagRoot == null))
		{
			bool active = m_ItemUnifier != null && m_ItemUnifier.RewardTag == UniversalItemTag.Extra;
			SetActiveIfChanged(tagRoot, active);
		}
	}

	public void Release()
	{
		m_UpdateVersion++;
		if (m_ItemUnifier != null)
		{
			if (m_AutoReleaseDataWhenDestroy)
			{
				ItemUnifierProxy.ItemUnifierPool.Release(ref m_ItemUnifier);
			}
			m_ItemUnifier = null;
		}
		if (TransiteItemUnifier != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(ref TransiteItemUnifier);
			TransiteItemUnifier = null;
		}
		m_UseBagCount = false;
		if (m_LimitTimeLooper.IsValid())
		{
			m_LimitTimeLooper.Cancel();
		}
	}

	public void SwitchItemUnifier()
	{
		SetData(TransiteItemUnifier, m_LeftCount, m_InitType, m_ItemCountType, m_AutoReleaseDataWhenDestroy);
		TransiteItemUnifier = null;
		UpdatePerformance();
	}

	protected virtual void SetQualityBg()
	{
		if (m_QualityStyles == null || m_QualityStyles.Length == 0)
		{
			m_ActiveStyle = default;
			m_ActiveQualityStyleIndex = -1;
			m_QualityStyleInitialized = true;
			return;
		}
		int num = -1;
		if (m_ItemUnifier != null && !m_ItemUnifier.Equals(ItemUnifierProxy.Empty))
		{
			num = m_ItemUnifier.Quality - 1;
		}
		if (!m_QualityStyleInitialized)
		{
			EnsureQualityStyleRects();
			for (int i = 0; i < m_QualityStyles.Length; i++)
			{
				SetQualityStyleVisible(i, i == num);
			}
			m_ActiveQualityStyleIndex = num;
			m_QualityStyleInitialized = true;
			m_ActiveStyle = (IsValidQualityStyleIndex(num) ? m_QualityStyles[num] : default(QualityStyle));
		}
		else if (m_ActiveQualityStyleIndex != num)
		{
			if (IsValidQualityStyleIndex(m_ActiveQualityStyleIndex))
			{
				SetQualityStyleVisible(m_ActiveQualityStyleIndex, visible: false);
			}
			if (IsValidQualityStyleIndex(num))
			{
				SetQualityStyleVisible(num, visible: true);
				m_ActiveStyle = m_QualityStyles[num];
			}
			else
			{
				m_ActiveStyle = default;
			}
			m_ActiveQualityStyleIndex = num;
		}
	}

	private bool IsValidQualityStyleIndex(int index)
	{
		if (index >= 0)
		{
			return index < m_QualityStyles.Length;
		}
		return false;
	}

	private void EnsureQualityStyleRects()
	{
		if (m_QualityStyles == null || m_QualityStyles.Length == 0)
		{
			m_QualityStyleRectsCached = true;
			if (m_QualityStyleRects != null)
			{
				m_QualityStyleRects.Clear();
			}
			if (m_QualityStylePositions != null)
			{
				m_QualityStylePositions.Clear();
			}
		}
		else if (!m_QualityStyleRectsCached || m_QualityStyleRects == null || m_QualityStylePositions == null || m_QualityStyleRects.Count != m_QualityStyles.Length || m_QualityStylePositions.Count != m_QualityStyles.Length)
		{
			m_QualityStyleRectsCached = true;
			if (m_QualityStyleRects == null)
			{
				m_QualityStyleRects = ListPool<RectTransform>.Get();
			}
			if (m_QualityStylePositions == null)
			{
				m_QualityStylePositions = ListPool<Vector2>.Get();
			}
			m_QualityStyleRects.Clear();
			m_QualityStylePositions.Clear();
			for (int i = 0; i < m_QualityStyles.Length; i++)
			{
				GameObject styleRoot = m_QualityStyles[i].styleRoot;
				RectTransform rectTransform = (styleRoot ? (styleRoot.transform as RectTransform) : null);
				m_QualityStyleRects.Add(rectTransform);
				m_QualityStylePositions.Add(rectTransform ? rectTransform.anchoredPosition : default(Vector2));
			}
		}
	}

	private void SetQualityStyleVisible(int index, bool visible)
	{
		if (!IsValidQualityStyleIndex(index))
		{
			return;
		}
		GameObject styleRoot = m_QualityStyles[index].styleRoot;
		if (!styleRoot)
		{
			return;
		}
		EnsureQualityStyleRects();
		RectTransform rectTransform = m_QualityStyleRects[index];
		if ((bool)rectTransform)
		{
			if (!styleRoot.activeSelf)
			{
				styleRoot.SetActive(value: true);
			}
			Vector2 vector = m_QualityStylePositions[index];
			rectTransform.anchoredPosition = (visible ? vector : (vector + new Vector2(100000f, 100000f)));
		}
		else
		{
			SetActiveIfChanged(styleRoot, visible);
		}
	}

	private static void SetActiveIfChanged(GameObject go, bool active)
	{
		if ((bool)go && go.activeSelf != active)
		{
			go.SetActive(active);
		}
	}

	protected virtual void LoadMainIcon()
	{
		bool flag = m_ItemUnifier?.Source != null;
		if ((bool)m_EmptyObject)
		{
			SetActiveIfChanged(m_EmptyObject, !flag);
			if (!flag)
			{
				UnLoadMainIcon();
			}
		}
		SetActiveIfChanged(m_MainIcon.icon.gameObject, flag);
		if (flag)
		{
			BImage mainIcon = m_MainIcon;
			if (mainIcon != null)
			{
				LoadMainIconDeferred(m_UpdateVersion, m_ItemUnifier, ItemType, mainIcon).Forget();
			}
		}
	}

	private async UniTaskVoid LoadMainIconDeferred(int version, ItemUnifierProxy itemUnifier, InitType itemType, BImage bImage)
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		if (!IsValidMainIconLoadRequest(version, itemUnifier, bImage))
		{
			return;
		}
		RuntimeConfigs.data.itemDatas.TryGetValue(itemUnifier.Id, out var _);
		if (m_Station == null)
		{
			m_Station = GetComponentInParent<IBaseUIView>()?.Station;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("没有为ItemCell设置Station?");
			}
		}
		if (m_Station != null)
		{
			LoadMainIconImage(itemUnifier, itemType, bImage);
		}
	}

	protected virtual void LoadMainIconImage(ItemUnifierProxy itemUnifier, InitType itemType, BImage bImage)
	{
		switch (itemType)
		{
		case InitType.TeamViewBagCharacter:
		case InitType.CharacterViewBagCharacter:
			m_Station.LoadImageAsync(103, itemUnifier.As<Character>().GetCharacterSkinId(), bImage).Forget();
			break;
		case InitType.NoneItem:
			if (itemUnifier.As<Item>().itemType != 5)
			{
				m_Station.LoadImageAsync(103, itemUnifier.ItemData.iconAddress, bImage).Forget();
			}
			else
			{
				m_Station.LoadItemIconAsync(itemUnifier.ItemData.iconAddress, bImage).Forget();
			}
			break;
		default:
			if (((itemUnifier.ItemData != null) ? itemUnifier.ItemData.type : 0) == 12)
			{
				Station.LoadImageAsync(241, itemUnifier.ItemData.iconAddress, bImage).Forget();
			}
			else
			{
				m_Station.LoadItemIconAsync(itemUnifier.ItemData.iconAddress, bImage).Forget();
			}
			break;
		}
	}

	private bool IsValidMainIconLoadRequest(int version, ItemUnifierProxy itemUnifier, BImage bImage)
	{
		if (version == m_UpdateVersion && (bool)this && m_ItemUnifier == itemUnifier && itemUnifier?.Source != null && bImage != null)
		{
			return bImage.icon != null;
		}
		return false;
	}

	public virtual void UnLoadMainIcon()
	{
		BImage mainIcon = m_MainIcon;
		if (mainIcon == null)
		{
			return;
		}
		if (m_Station == null)
		{
			m_Station = GetComponentInParent<IBaseUIView>().Station;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("没有为ItemCell设置Station?");
			}
		}
		m_Station?.UnloadImageAsync(mainIcon);
	}

	protected virtual void SetSelect()
	{
		if ((bool)m_ChosenObject)
		{
			SetActiveIfChanged(m_ChosenObject, m_ItemUnifier?.Source != null && IsChosen);
		}
	}

	protected virtual void SetDisabled()
	{
		if ((bool)m_DisabledObject)
		{
			SetActiveIfChanged(m_DisabledObject, IsDisabled);
		}
	}

	protected virtual void SetGrey()
	{
		if ((bool)m_GrayObject)
		{
			SetActiveIfChanged(m_GrayObject, m_IsGray);
		}
	}

	protected virtual void SetComplete()
	{
		if ((bool)m_CompleteObject)
		{
			SetActiveIfChanged(m_CompleteObject, IsComplete || m_InitType == InitType.RewardItemReceived);
		}
	}

	protected virtual void UpdateDisuse()
	{
		if ((bool)m_DisuseObject)
		{
			if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
			{
				SetActiveIfChanged(m_DisuseObject, active: false);
			}
			else if (!(m_ItemUnifier.Source is Item item) || !item.IsLimitTimeItem())
			{
				SetActiveIfChanged(m_DisuseObject, active: false);
			}
			else
			{
				SetActiveIfChanged(m_DisuseObject, item.IsDisuse());
			}
		}
	}

	protected virtual void UpdateLimitTime()
	{
		if (!m_LimitTimeObject)
		{
			return;
		}
		if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
		{
			SetActiveIfChanged(m_LimitTimeObject, active: false);
			return;
		}
		IBagItem source = m_ItemUnifier.Source;
		Item item = source as Item;
		if (item == null || !item.IsLimitTimeItem() || item.IsDisuse())
		{
			SetActiveIfChanged(m_LimitTimeObject, active: false);
			return;
		}
		SetActiveIfChanged(m_LimitTimeObject, active: true);
		if (m_LimitTimeLooper.IsValid())
		{
			m_LimitTimeLooper.Cancel();
		}
		if (item.IsDisuse())
		{
			return;
		}
		m_LimitTimeLooper = UpdateTimer.Default.LoopMs(1000, () =>
		{
			if (item.IsDisuse())
			{
				m_LimitTimeLooper.Cancel();
				UpdateDisuse();
			}
		});
	}

	protected virtual void UpdateItemCount()
	{
		if (!m_ItemCountRoot || !m_NumberComponent)
		{
			return;
		}
		if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
		{
			SetActiveIfChanged(m_ItemCountRoot, active: false);
			return;
		}
		switch (m_ItemCountType)
		{
		case ItemCountShowType.Hide:
			SetActiveIfChanged(m_ItemCountRoot, active: false);
			break;
		case ItemCountShowType.OneSide:
			SetActiveIfChanged(m_ItemCountRoot, active: true);
			m_NumberComponent.UpdateNumber(m_ItemUnifier.Count);
			SetActiveIfChanged(m_NumberComponent.numberText?.gameObject, active: true);
			SetActiveIfChanged(m_NumberComponent.slashText?.gameObject, active: false);
			SetActiveIfChanged(m_NumberComponent.totalText?.gameObject, active: false);
			break;
		case ItemCountShowType.Both:
			SetActiveIfChanged(m_ItemCountRoot, active: true);
			if (m_UseBagCount)
			{
				m_LeftCount = G.localPlayer.Inventory.GetItemCount(m_ItemUnifier.Id);
			}
			m_NumberComponent.UpdateNumber(m_LeftCount, m_ItemUnifier.Count);
			SetActiveIfChanged(m_NumberComponent.numberText?.gameObject, active: true);
			SetActiveIfChanged(m_NumberComponent.slashText?.gameObject, active: true);
			SetActiveIfChanged(m_NumberComponent.totalText?.gameObject, active: true);
			break;
		case ItemCountShowType.ShowWithRandom:
		{
			SetActiveIfChanged(m_ItemCountRoot, active: true);
			if (m_UseBagCount)
			{
				m_LeftCount = G.localPlayer.Inventory.GetItemCount(m_ItemUnifier.Id);
			}
			Item item = m_ItemUnifier.As<Item>();
			m_NumberComponent.UpdateNumberWithRandom(m_LeftCount, m_ItemUnifier.Count, item.haveRandom);
			SetActiveIfChanged(m_NumberComponent.numberText?.gameObject, active: true);
			SetActiveIfChanged(m_NumberComponent.slashText?.gameObject, active: false);
			SetActiveIfChanged(m_NumberComponent.totalText?.gameObject, active: false);
			break;
		}
		}
	}

	protected virtual void UpdateName()
	{
		if ((bool)m_ItemNameRoot && (bool)m_ItemName)
		{
			if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty || ItemUnifier.Name == 0)
			{
				SetActiveIfChanged(m_ItemNameRoot, active: false);
			}
			else
			{
				m_ItemName.StringReference.TableEntryReference = ItemUnifier.Name;
			}
		}
	}

	protected virtual void UpdateRedPoint()
	{
		if (!m_redPointObject || string.IsNullOrEmpty(m_RedPointPath))
		{
			return;
		}
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(m_RedPointPath))
		{
			m_redPointObject.InitRedDot(m_RedPointPath, m_RedDotType);
		}
		if (m_ItemUnifier == null || m_ItemUnifier == ItemUnifierProxy.Empty)
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(m_RedPointPath, active: false);
			return;
		}
		bool value = false;
		IBagItem source = ItemUnifier.Source;
		if (!(source is Item) && !(source is GiftPackage) && !(source is BloodBottleData) && !(source is BloodBottleMaterial))
		{
			if (!(source is Equip equip))
			{
				if (source is Gem gem)
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(m_RedPointPath, G.localPlayer.redPoints.Gems.TryGetValue(gem.Uid, out value) & value);
				}
			}
			else
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(m_RedPointPath, G.localPlayer.redPoints.Equips.TryGetValue(equip.Uid, out value) & value);
			}
		}
		else
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(m_RedPointPath, G.localPlayer.redPoints.Items.TryGetValue(ItemUnifier.Id, out value) & value);
		}
		if (!string.IsNullOrEmpty(m_RedPointPath))
		{
			m_redPointObject.fullPath = m_RedPointPath.Split("|").ToList();
			m_redPointObject.redDotType = m_RedDotType;
			m_redPointObject.BindTrieNode();
			m_redPointObject.UpdateDisplay();
		}
	}

	protected virtual void OnClick()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Item_Click");
		if (!ItemUnifierProxy.Empty.Equals(m_ItemUnifier))
		{
			IsHighLight = true;
			OnItemClick?.Invoke(this);
			ShowDetailPanel();
		}
	}

	protected virtual void OnNormal()
	{
		if ((bool)m_HighLightObject)
		{
			SetActiveIfChanged(m_HighLightObject, active: false);
		}
		if ((bool)m_HighLightHandleObject)
		{
			SetActiveIfChanged(m_HighLightHandleObject, active: false);
		}
		if (EventSystemHelper.Available && !EventSystemHelper.Shared.alreadySelecting && EventSystemHelper.CurrentSelected == gameObject)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
		m_IsHighLight = false;
	}

	protected virtual void OnHighLight()
	{
		if ((bool)m_HighLightObject)
		{
			SetActiveIfChanged(m_HighLightObject, active: true);
		}
		if ((bool)m_HighLightHandleObject)
		{
			SetActiveIfChanged(m_HighLightHandleObject, MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
		if (EventSystemHelper.Available && !EventSystemHelper.Shared.alreadySelecting && EventSystemHelper.CurrentSelected != gameObject)
		{
			try
			{
				EventSystemHelper.SetSelectedGameObject(gameObject);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
		m_IsHighLight = true;
	}

	protected virtual void OnEnterHover()
	{
		if ((bool)m_HoverObject)
		{
			SetActiveIfChanged(m_HoverObject, active: true);
		}
	}

	protected virtual void OnExitHover()
	{
		if ((bool)m_HoverObject)
		{
			SetActiveIfChanged(m_HoverObject, active: false);
		}
	}

	public virtual void OnInvertClick()
	{
		OnInvertSelect?.Invoke(this);
	}

	protected virtual void ShowDetailPanel()
	{
		if (showDetailPanel && m_ItemUnifier?.Source != null && !m_ItemUnifier.Equals(ItemUnifierProxy.Empty))
		{
			ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(m_ItemUnifier.Id, G.localPlayer.Inventory.GetItemCount(m_ItemUnifier.Id));
			if (m_ItemUnifier.Source is Item item)
			{
				((Item)itemUnifierProxy.Source).Uid = item.Uid;
				((Item)itemUnifierProxy.Source).ExpireTime = item.ExpireTime;
			}
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, itemUnifierProxy);
			if (group != null)
			{
				group.SetSelected(this);
			}
		}
	}

	public void CloseChosen()
	{
		if (closeDetailChosen)
		{
			IsChosen = false;
		}
		if ((bool)group)
		{
			group.CloseLast();
		}
	}

	public virtual void OnDrag()
	{
	}

	private void Update()
	{
		if (isPointerDown)
		{
			pointerDownTimer += Time.deltaTime;
			if (pointerDownTimer >= holdTime)
			{
				holding = true;
				holdEvent?.Invoke();
				HoldReset();
			}
		}
	}

	private void EnsureHighLight()
	{
		if (IsOn)
		{
			OnHighLight();
		}
		else
		{
			OnNormal();
		}
	}

	private void HoldReset()
	{
		isPointerDown = false;
		pointerDownTimer = 0f;
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		holding = false;
		isPointerDown = true;
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		HoldReset();
	}

	public virtual void ScrollCellIndex(int idx)
	{
		Index = idx;
	}

	public virtual void OnLoad(int idx)
	{
	}

	public virtual void OnShow()
	{
		CanvasGroup cachedCanvasGroup = CachedCanvasGroup;
		if ((bool)cachedCanvasGroup)
		{
			cachedCanvasGroup.alpha = 1f;
			cachedCanvasGroup.interactable = true;
			cachedCanvasGroup.blocksRaycasts = true;
			SetActiveIfChanged(gameObject, active: true);
		}
		else
		{
			SetActiveIfChanged(gameObject, active: true);
		}
	}

	public virtual void OnHide()
	{
		m_UpdateVersion++;
		CanvasGroup cachedCanvasGroup = CachedCanvasGroup;
		if ((bool)cachedCanvasGroup)
		{
			cachedCanvasGroup.alpha = 0f;
			cachedCanvasGroup.interactable = false;
			cachedCanvasGroup.blocksRaycasts = false;
		}
		else
		{
			SetActiveIfChanged(gameObject, active: false);
		}
		if (m_ItemUnifier != null)
		{
			m_ItemUnifier.Context = null;
			m_ItemUnifier = null;
		}
		if ((bool)m_Animation)
		{
			m_Animation.StopAnimation();
		}
		if (m_MainIcon != null)
		{
			if ((bool)m_MainIcon.icon)
			{
				m_MainIcon.icon.sprite = null;
			}
			if ((bool)m_MainIcon.rawIcon)
			{
				m_MainIcon.rawIcon.texture = null;
			}
		}
	}

	public virtual void OnUnLoad()
	{
	}

	public virtual void PlayCustomAnimation(float delaySecond)
	{
		PlayAnimation(delaySecond);
	}

	public void PlayAnimation(float delaySecond, string animationName = "", Action action = null)
	{
		if ((bool)m_Animation)
		{
			if (string.IsNullOrEmpty(animationName))
			{
				animationName = AnimationName;
			}
			m_Animation.GetSequence(animationName)?.Goto(0f).SetDelay(delaySecond).OnComplete((AnimationBuilder _) =>
			{
				action?.Invoke();
			})
				.Play();
		}
	}

	public int GetIndex()
	{
		return Index;
	}

	private void OnItemValueChanged(ItemUnifierProxy x)
	{
		if (!this)
		{
			x.OnValueChanged = (Action<ItemUnifierProxy>)Delegate.Remove(x.OnValueChanged, new Action<ItemUnifierProxy>(OnItemValueChanged));
		}
		else
		{
			UpdatePerformance();
		}
	}

	public void SetNumColor(string _color)
	{
		RichTagConfig value = m_NumberComponent.equalConfig.frontFontConfig[0];
		value.ColorValue = ColorParseUtility.HexToColor(_color);
		m_NumberComponent.equalConfig.frontFontConfig[0] = value;
	}

	public override void OnSelect(BaseEventData baseEventData)
	{
		base.OnSelect(baseEventData);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			OnHighLight();
		}
	}

	public override void OnDeselect(BaseEventData baseEventData)
	{
		base.OnDeselect(baseEventData);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			OnNormal();
		}
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		base.OnPointerEnter(eventData);
		OnEnterHover();
	}

	public override void OnPointerExit(PointerEventData eventData)
	{
		base.OnPointerExit(eventData);
		OnExitHover();
	}

	public void SetFreeTag(bool value)
	{
		m_FreeTagObject?.SetActive(value);
	}
}
