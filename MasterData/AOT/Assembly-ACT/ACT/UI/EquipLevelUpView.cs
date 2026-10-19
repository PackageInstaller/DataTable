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
using ACT.Sound;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;

namespace ACT.UI;

public class EquipLevelUpView : BaseUIView<EquipLevelUpViewInputController>
{
	private struct LevelUp : IComparable<LevelUp>
	{
		public int styleIndex;

		public float from;

		public float to;

		public int weight;

		public int contextData;

		public int CompareTo(LevelUp other)
		{
			int num = other.styleIndex.CompareTo(styleIndex);
			if (num == 0)
			{
				return other.weight.CompareTo(weight);
			}
			return num;
		}
	}

	[Serializable]
	private struct LevelUpTabStyle
	{
		public GameObject styleRoot;

		[Header("上侧")]
		public CommonCoinComponent coinComponent;

		public CommonCoinComponent strengthComponent;

		[Space]
		public CommonNumberComponent equipLevel;

		public GameObject addLevelRoot;

		public TMP_Text addLevelText;

		public GameObject maxLevelTip;

		[Space]
		public LevelUpOSA levelUpOSA;

		public GameObject OSAMaxLevelRoot;

		public TMP_Text OSAMaxLevelText;

		public ActButton OSAMaxLevelBtn;

		public GameObject leftArrow;

		public GameObject rightArrow;

		[Space]
		public GameObject costBagRoot;

		public CommonScrollBagComponent costBag;

		[Space]
		public EquipPropertyCell equipPropertyCellTemplate;

		public Transform equipPropertyCellParent;

		[Header("下侧")]
		public GameObject costBottomRoot;

		public CommonCoinComponent coinComponentBottom;

		public CommonCoinComponent strengthComponentBottom;

		public ActButton levelUpButton;

		public LocalizeStringEvent levelUpButtonText;

		public GameObject cannotLevelUpRoot;

		public LocalizeStringEvent cannotLevelUpText;

		[SerializeField]
		public float propertyStartDelay;
	}

	private const int LevelUpInfoCapacity = 9;

	private const int MaxLevelAttributeInfoCapacity = 3;

	private const int StyleGemSlot = 1;

	private const int StyleFeature = 2;

	private const int StyleAttribute = 3;

	private const int StyleMainAttribute = 4;

	private const string UpgradeSound = "event:/UI/Interface/Equip/Upgrade";

	[Header("左侧")]
	[SerializeField]
	private EquipItem m_EquipItem;

	[Header("右侧")]
	[SerializeField]
	private LocalizeStringEvent m_EquipName;

	[SerializeField]
	private GameObject[] m_QualityBg;

	[SerializeField]
	private BImage m_EquipIcon;

	[SerializeField]
	private LocalizeStringEvent m_EquipType;

	[Space]
	[SerializeField]
	private LevelUpTabStyle m_LevelUpTabConfig;

	public GamePadTipsComp gamePadGroup;

	[SerializeField]
	private List<GameObject> m_HideWhenResourceChooseObjects = new List<GameObject>();

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private Stack<EquipPropertyCell> m_PropertyPool = new Stack<EquipPropertyCell>();

	private Equip m_Equip;

	private bool m_CanUpgrade;

	private bool m_CanExchangeMaterial;

	private bool m_HasCostMaterial;

	private bool m_SelectMaterialActionDisabledByView;

	private EquipData m_EquipData;

	private EquipMaterialData m_CurEquipMaterialData;

	private int m_PreviewLevel;

	private int m_MaxCanLevelUp;

	private int _requireCoin;

	private int _requireStrengthenMat;

	private bool _isResourceChoose;

	[FormerlySerializedAs("layer")]
	public ViewControlLayer layerResouce;

	public ViewControlLayer layerMaterial;

	public ViewControlRoot root;

	private ContinuousNavigateData curNavigateState;

	private ViewControlLayer m_CurrentResourceChooseLayer;

	private EquipLevelUpViewData m_data => uiViewData as EquipLevelUpViewData;

	private int m_MaxLevel => RuntimeConfigs.data.game.equipRareLevel[m_Equip.GetQuality() - 1];

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	private void Awake()
	{
		m_LevelUpTabConfig.levelUpButton.SetBtnClick(OnLevelUp);
		m_LevelUpTabConfig.levelUpButton.OnLongPressUpdate.AddListener(OnLevelUp);
		m_LevelUpTabConfig.OSAMaxLevelBtn.SetBtnClick(ScrollToMaxAllowedLevel);
		m_LevelUpTabConfig.levelUpOSA.PassingAudioEventName = "event:/UI/Common/Upgrade_Slide";
	}

	protected override void OnUnityDestroy()
	{
		m_LevelUpTabConfig.levelUpButton.OnClick.RemoveListener(OnLevelUp);
		m_LevelUpTabConfig.levelUpButton.OnLongPressUpdate.RemoveListener(OnLevelUp);
		m_LevelUpTabConfig.OSAMaxLevelBtn.OnClick.RemoveListener(ScrollToMaxAllowedLevel);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, UpdateEquip);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
	}

	private void UpdateEquip(BaseEventContent evt)
	{
		if (m_Equip != null)
		{
			m_EquipItem.Init(m_Equip);
			RefreshLevelUpByCostChange();
		}
	}

	private void OnPlayerAttributeChanged(BaseEventContent evt)
	{
		if (evt is PlayerAttributeChangeEvt playerAttributeChangeEvt && (playerAttributeChangeEvt.id == (int)m_LevelUpTabConfig.coinComponentBottom.itemId || playerAttributeChangeEvt.id == (int)m_LevelUpTabConfig.strengthComponentBottom.itemId))
		{
			RefreshLevelUpByCostChange();
		}
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, UpdateEquip);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
	}

	protected override void Init()
	{
		base.Init();
		m_Equip = G.localPlayer.Inventory.GetEquip(m_data.TargetEquipUid);
		m_EquipData = CoreUtils.GetData(m_Equip.Id, RuntimeConfigs.data.equipDatas);
		ItemData data = CoreUtils.GetData(m_Equip.Id, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			m_CurEquipMaterialData = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_Equip.Level), RuntimeConfigs.data.equipMaterialDatas);
			Station.LoadImage(135, m_Equip.TypeIndex, m_EquipIcon);
			m_EquipItem.Init(m_Equip);
			m_EquipItem.gemSlots.OnSlotClick = null;
			GemHoleItems gemSlots = m_EquipItem.gemSlots;
			gemSlots.OnSlotClick = (Action<EquipGemSlot>)Delegate.Combine(gemSlots.OnSlotClick, new Action<EquipGemSlot>(OnSlotClick));
			m_EquipName.StringReference.TableEntryReference = data.nameLocal;
			LocalizedString stringReference = m_EquipType.StringReference;
			stringReference.TableEntryReference = m_EquipData.equipType switch
			{
				1 => LocalizationCommonData.CommonString.Power, 
				2 => LocalizationCommonData.CommonString.Move, 
				3 => LocalizationCommonData.CommonString.Can, 
				4 => LocalizationCommonData.CommonString.Assist, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			for (int i = 0; i < m_QualityBg.Length; i++)
			{
				m_QualityBg[i].SetActive(i == m_EquipData.quality - 1);
			}
			SwitchToLevelUpTab();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Enhance/Animation", new AudioPlayOptions
			{
				attachTarget = transform
			});
			OnGamePadInit();
			ReBindBtnPrompt();
		}
	}

	private void OnSlotClick(EquipGemSlot obj)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPGEM, new EquipGemViewData
		{
			Equip = m_Equip,
			GemIndex = m_EquipItem.gemSlots.levelHoles.IndexOf(obj)
		});
	}

	private void SwitchToLevelUpTab()
	{
		CommonCoinComponent coinComponent = m_LevelUpTabConfig.coinComponent;
		CommonCoinComponent strengthComponent = m_LevelUpTabConfig.strengthComponent;
		CommonCoinComponent coinComponentBottom = m_LevelUpTabConfig.coinComponentBottom;
		ImageAssetStation imageAssetStation = (m_LevelUpTabConfig.strengthComponentBottom.Station = Station);
		ImageAssetStation imageAssetStation2 = (coinComponentBottom.Station = imageAssetStation);
		ImageAssetStation station2 = (strengthComponent.Station = imageAssetStation2);
		coinComponent.Station = station2;
		m_LevelUpTabConfig.styleRoot.SetActive(value: true);
		m_LevelUpTabConfig.coinComponent.Initialize();
		m_LevelUpTabConfig.strengthComponent.Initialize();
		m_LevelUpTabConfig.equipLevel.UpdateNumber(m_Equip.Level, m_MaxLevel);
		int previewLevel = ((m_Equip.Level >= m_MaxLevel) ? m_MaxLevel : (m_Equip.Level + 1));
		m_MaxCanLevelUp = GetCanLevelUp();
		m_LevelUpTabConfig.levelUpOSA.Unload();
		m_LevelUpTabConfig.levelUpOSA.Reload(0, m_MaxLevel, m_Equip.Level, 1, OnSelectLevel, 0, m_MaxCanLevelUp);
		OnSelectLevel(previewLevel);
		UpdatePreviewLevel();
		UpdatePropertyCells();
		m_CanUpgrade = UpdateCostBag();
		m_CanUpgrade &= UpdateMoney();
		m_CanUpgrade &= UpdateWorldLevel();
		m_CanExchangeMaterial = UpdateCanExchangeMaterial();
		UpdateButton();
		m_LevelUpTabConfig.maxLevelTip.SetActive(m_Equip.Level >= m_MaxLevel);
	}

	private void OnSelectLevel(int previewLevel)
	{
		m_PreviewLevel = previewLevel;
		UpdatePropertyCells();
		UpdatePreviewLevel();
		m_CanUpgrade = UpdateMoney();
		m_CanUpgrade &= UpdateCostBag();
		m_CanUpgrade &= UpdateWorldLevel();
		m_CanExchangeMaterial = UpdateCanExchangeMaterial();
		RefreshOsaMaxLevelJump(previewLevel);
		UpdateButton();
		UpdateLevelArrow();
		ReBindBtnPrompt();
	}

	private void RefreshLevelUpByCostChange()
	{
		if (m_Equip != null && m_EquipData != null && m_LevelUpTabConfig.styleRoot.activeInHierarchy)
		{
			m_CurEquipMaterialData = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_Equip.Level), RuntimeConfigs.data.equipMaterialDatas);
			m_MaxCanLevelUp = GetCanLevelUp();
			m_LevelUpTabConfig.levelUpOSA.RefreshItemEnoughLevel(m_MaxCanLevelUp);
			RefreshOsaMaxLevelJump(m_PreviewLevel);
			m_CanUpgrade = UpdateMoney();
			m_CanUpgrade &= UpdateCostBag();
			m_CanUpgrade &= UpdateWorldLevel();
			m_CanExchangeMaterial = UpdateCanExchangeMaterial();
			UpdateButton();
			UpdateLevelArrow();
			ReBindBtnPrompt();
		}
	}

	private bool CanJumpToMaxAllowedLevel()
	{
		if (m_MaxCanLevelUp > m_Equip.Level)
		{
			return m_MaxCanLevelUp <= m_MaxLevel;
		}
		return false;
	}

	private void RefreshOsaMaxLevelJump(int previewLevel)
	{
		bool flag = CanJumpToMaxAllowedLevel();
		m_LevelUpTabConfig.OSAMaxLevelRoot.SetActive(flag && previewLevel != m_MaxCanLevelUp && previewLevel <= m_MaxLevel);
		if (flag)
		{
			m_LevelUpTabConfig.OSAMaxLevelText.SetText(m_MaxCanLevelUp.FastToString());
		}
	}

	private void UpdateLevelArrow()
	{
		if ((m_PreviewLevel == m_MaxLevel || m_PreviewLevel == m_MaxCanLevelUp) && m_MaxCanLevelUp != 0 && m_MaxCanLevelUp >= m_MaxLevel)
		{
			m_LevelUpTabConfig.leftArrow.SetActive(value: false);
			m_LevelUpTabConfig.rightArrow.SetActive(value: false);
		}
		else if (m_PreviewLevel < m_MaxCanLevelUp)
		{
			m_LevelUpTabConfig.leftArrow.SetActive(value: false);
			m_LevelUpTabConfig.rightArrow.SetActive(value: true);
		}
		else
		{
			m_LevelUpTabConfig.leftArrow.SetActive(value: true);
			m_LevelUpTabConfig.rightArrow.SetActive(value: false);
		}
	}

	private int GetCanLevelUp()
	{
		for (int i = m_Equip.Level + 1; i <= m_MaxLevel; i++)
		{
			EquipMaterialData data = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(i), RuntimeConfigs.data.equipMaterialDatas);
			if (data == null || m_CurEquipMaterialData == null)
			{
				continue;
			}
			if (data.worldLevel > Model<WorldLevelModel>.Interface.GetCurWorldLevel())
			{
				return i - 1;
			}
			if (data.totalCoinRequired - m_CurEquipMaterialData.totalCoinRequired > G.TryGetAttribute((int)m_LevelUpTabConfig.coinComponentBottom.itemId) || data.xpItem.count - m_CurEquipMaterialData.xpItem.count > G.TryGetAttribute((int)m_LevelUpTabConfig.strengthComponentBottom.itemId))
			{
				return i - 1;
			}
			List<ItemKv> itemAllLv = data.itemAllLv;
			if (itemAllLv == null || itemAllLv.Count <= 0)
			{
				continue;
			}
			foreach (ItemKv item in data.itemAllLv)
			{
				ItemKv itemKv = m_CurEquipMaterialData.itemAllLv.FirstOrDefault((ItemKv x) => x.id == item.id);
				if (itemKv != null)
				{
					int num = item.count - itemKv.count;
					if (num > 0 && G.localPlayer.Inventory.GetItemCount(item.id) < num)
					{
						return i - 1;
					}
				}
				else if (G.localPlayer.Inventory.GetItemCount(item.id) < item.count)
				{
					return i - 1;
				}
			}
		}
		return m_MaxLevel;
	}

	private void OnLevelUp()
	{
		if (!CanSubmitLevelUp())
		{
			OpenQuickPowerExchangeItemView();
			return;
		}
		G.service.EquipEnhance(m_Equip.Uid, m_PreviewLevel, (bool result) =>
		{
			if (result)
			{
				m_CurEquipMaterialData = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_Equip.Level), RuntimeConfigs.data.equipMaterialDatas);
				m_MaxCanLevelUp = GetCanLevelUp();
				m_LevelUpTabConfig.equipLevel.UpdateNumber(m_Equip.Level, m_MaxLevel);
				m_LevelUpTabConfig.levelUpOSA.Unload();
				int previewLevel = ((m_Equip.Level >= m_MaxLevel) ? m_MaxLevel : (m_Equip.Level + 1));
				m_LevelUpTabConfig.levelUpOSA.Reload(0, m_MaxLevel, m_Equip.Level, 1, OnSelectLevel, 0, m_MaxCanLevelUp);
				OnSelectLevel(previewLevel);
				UpdateButton();
				m_LevelUpTabConfig.maxLevelTip.SetActive(m_Equip.Level >= m_MaxLevel);
				m_EquipItem.Init(m_Equip);
				UpdatePropertyCells(fromLevelUp: true);
			}
		});
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.EquipLevelUp);
	}

	private void OpenQuickPowerExchangeItemView()
	{
		if (CanOpenQuickPowerExchangeItemView() && TryGetQuickPowerExchangeItemViewData(out var viewData))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_QUICKPOWEREXCHANGEITEM, viewData);
		}
	}

	private bool TryGetQuickPowerExchangeItemViewData(out QuickPowerExchangeItemViewData viewData)
	{
		viewData = new QuickPowerExchangeItemViewData();
		int itemId = (int)m_LevelUpTabConfig.coinComponentBottom.itemId;
		int num = Math.Max(0, _requireCoin - G.localPlayer.Inventory.GetItemCount(itemId));
		int powerConvertItemId;
		long exchangeCount;
		long exchangePowerCost;
		long requiredPowerCost;
		if (num > 0)
		{
			if (!Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(itemId) || !Model<PowerModel>.Interface.TryGetPowerExchangePreview(itemId, num, out powerConvertItemId, out exchangeCount, out exchangePowerCost, out requiredPowerCost))
			{
				return false;
			}
			viewData.NeedItemId = itemId;
			viewData.NeedItemCount = num;
			return true;
		}
		int itemId2 = (int)m_LevelUpTabConfig.strengthComponentBottom.itemId;
		int num2 = Math.Max(0, _requireStrengthenMat - G.localPlayer.Inventory.GetItemCount(itemId2));
		if (num2 <= 0 || !Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(itemId2) || !Model<PowerModel>.Interface.TryGetPowerExchangePreview(itemId2, num2, out powerConvertItemId, out requiredPowerCost, out exchangePowerCost, out exchangeCount))
		{
			return false;
		}
		viewData.NeedItemId = itemId2;
		viewData.NeedItemCount = num2;
		return true;
	}

	private bool CanOpenQuickPowerExchangeItemView()
	{
		if (m_Equip != null && m_EquipData != null && m_Equip.Level < m_MaxLevel && m_PreviewLevel > m_Equip.Level && m_PreviewLevel <= m_MaxLevel && !m_CanUpgrade && m_CanExchangeMaterial)
		{
			return UpdateWorldLevel();
		}
		return false;
	}

	private bool CanSubmitLevelUp()
	{
		if (m_Equip != null && m_EquipData != null && m_Equip.Level < m_MaxLevel && m_PreviewLevel > m_Equip.Level && m_PreviewLevel <= m_MaxLevel && m_CanUpgrade)
		{
			return UpdateWorldLevel();
		}
		return false;
	}

	private EquipPropertyCell GetObject()
	{
		EquipPropertyCell equipPropertyCell = ((m_PropertyPool.Count > 0) ? m_PropertyPool.Pop() : UnityEngine.Object.Instantiate(m_LevelUpTabConfig.equipPropertyCellTemplate));
		equipPropertyCell.transform.SetParent(m_LevelUpTabConfig.equipPropertyCellParent, worldPositionStays: false);
		equipPropertyCell.gameObject.SetActive(value: true);
		return equipPropertyCell;
	}

	private void ReturnObject(EquipPropertyCell cell)
	{
		m_PropertyPool.Push(cell);
		cell.transform.SetParent(m_LevelUpTabConfig.equipPropertyCellParent.parent, worldPositionStays: false);
		cell.gameObject.SetActive(value: false);
	}

	private int[] GetGemSlots(EquipStrengthenListData strengthenListData, int decLevel)
	{
		return decLevel switch
		{
			0 => strengthenListData.equipHoleList0, 
			1 => strengthenListData.equipHoleList10, 
			2 => strengthenListData.equipHoleList20, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	private List<ItemKv> GetFeatures(EquipStrengthenListData strengthenListData, int decLevel)
	{
		return decLevel switch
		{
			0 => strengthenListData.equipFeature0, 
			1 => strengthenListData.equipFeature10, 
			2 => strengthenListData.equipFeature20, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	private bool IsMainAttribute(int attributeIndex)
	{
		if (attributeIndex == 0)
		{
			return m_EquipData.fixEquipAttrId == m_Equip.Attributes[attributeIndex].Id;
		}
		return false;
	}

	private bool IsAttributeStyle(int styleIndex)
	{
		if (styleIndex != 3)
		{
			return styleIndex == 4;
		}
		return true;
	}

	private LevelUp CreateAttributeLevelUp(int attributeIndex, EquipAttrData targetAttributeData, int fromLevel, int toLevel)
	{
		bool flag = IsMainAttribute(attributeIndex);
		EquipAttr equipAttr = m_Equip.Attributes[attributeIndex];
		float to = equipAttr.Value + targetAttributeData.attrList[toLevel] - targetAttributeData.attrList[fromLevel];
		return new LevelUp
		{
			styleIndex = (flag ? 4 : 3),
			from = equipAttr.Value,
			to = to,
			weight = (flag ? int.MaxValue : (m_Equip.Attributes.Count - attributeIndex)),
			contextData = equipAttr.Id
		};
	}

	private void AppendGemSlotLevelUps(Span<LevelUp> levelUpInfos, ref int startPtr, int[] currentGemSlots, int[] previewGemSlots)
	{
		for (int i = 0; i < currentGemSlots.Length; i++)
		{
			if (previewGemSlots[i] > currentGemSlots[i])
			{
				levelUpInfos[startPtr++] = new LevelUp
				{
					styleIndex = 1,
					from = currentGemSlots[i],
					to = previewGemSlots[i],
					weight = currentGemSlots.Length - i,
					contextData = i
				};
			}
		}
	}

	private void AppendFeatureLevelUps(Span<LevelUp> levelUpInfos, ref int startPtr, List<ItemKv> currentLevelFeature, List<ItemKv> previewLevelFeature)
	{
		for (int i = 0; i < previewLevelFeature.Count; i++)
		{
			ItemKv preFeature = previewLevelFeature[i];
			ItemKv itemKv = currentLevelFeature.FirstOrDefault((ItemKv x) => x.id == preFeature.id);
			if (itemKv == null || preFeature.count < itemKv.count)
			{
				int featureData = m_Equip.GetFeatureData(preFeature.id);
				levelUpInfos[startPtr++] = new LevelUp
				{
					styleIndex = 2,
					from = featureData,
					to = featureData + preFeature.count,
					weight = previewLevelFeature.Count - i,
					contextData = preFeature.id
				};
			}
		}
	}

	private void AppendAttributeLevelUps(Span<LevelUp> levelUpInfos, ref int startPtr, int fromLevel, int toLevel, bool onlyChanged)
	{
		for (int i = 0; i < m_Equip.Attributes.Count; i++)
		{
			EquipAttrData data = CoreUtils.GetData(m_Equip.Attributes[i].Id, RuntimeConfigs.data.equipAttrDatas);
			if (data != null)
			{
				float num = data.attrList[toLevel] - data.attrList[fromLevel];
				if (!onlyChanged || !(num <= 0f))
				{
					levelUpInfos[startPtr++] = CreateAttributeLevelUp(i, data, fromLevel, toLevel);
				}
			}
		}
	}

	private void UpdatePropertyCells(bool fromLevelUp = false)
	{
		int decLevel = m_Equip.Level / 10;
		int decLevel2 = m_PreviewLevel / 10;
		int startPtr = 0;
		EquipStrengthenListData data = CoreUtils.GetData(m_EquipData.strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
		if (m_Equip.Level < m_MaxLevel)
		{
			Span<LevelUp> span = stackalloc LevelUp[9];
			AppendGemSlotLevelUps(span, ref startPtr, GetGemSlots(data, decLevel), GetGemSlots(data, decLevel2));
			AppendFeatureLevelUps(span, ref startPtr, GetFeatures(data, decLevel), GetFeatures(data, decLevel2));
			AppendAttributeLevelUps(span, ref startPtr, m_Equip.Level, m_PreviewLevel, onlyChanged: true);
			span.QuickSort();
			ApplyLevelUpDatas(span, fromLevelUp);
		}
		else
		{
			Span<LevelUp> span2 = stackalloc LevelUp[3];
			AppendAttributeLevelUps(span2, ref startPtr, m_Equip.Level, m_Equip.Level, onlyChanged: false);
			span2.QuickSort();
			ApplyLevelUpDatas(span2, fromLevelUp);
		}
	}

	private int GetActualLevelUpCount(Span<LevelUp> levelUpInfos)
	{
		for (int i = 0; i < levelUpInfos.Length; i++)
		{
			if (levelUpInfos[i].styleIndex == 0)
			{
				return i;
			}
		}
		return levelUpInfos.Length;
	}

	private void EnsurePropertyCellCount(int count)
	{
		Transform equipPropertyCellParent = m_LevelUpTabConfig.equipPropertyCellParent;
		while (equipPropertyCellParent.childCount < count)
		{
			GetObject();
		}
		while (equipPropertyCellParent.childCount > count)
		{
			ReturnObject(equipPropertyCellParent.GetChild(equipPropertyCellParent.childCount - 1).GetComponent<EquipPropertyCell>());
		}
	}

	private void ApplyLevelUpDatas(Span<LevelUp> levelUpInfos, bool fromLevelUp = false)
	{
		int actualLevelUpCount = GetActualLevelUpCount(levelUpInfos);
		EnsurePropertyCellCount(actualLevelUpCount);
		for (int i = 0; i < actualLevelUpCount; i++)
		{
			EquipPropertyCell component = m_LevelUpTabConfig.equipPropertyCellParent.GetChild(i).GetComponent<EquipPropertyCell>();
			component.Station = Station;
			switch (levelUpInfos[i].styleIndex)
			{
			case 4:
				component.SetAttributeStyle(levelUpInfos[i].from, levelUpInfos[i].to, levelUpInfos[i].contextData, isMain: true);
				break;
			case 3:
				component.SetAttributeStyle(levelUpInfos[i].from, levelUpInfos[i].to, levelUpInfos[i].contextData, isMain: false);
				break;
			case 2:
				component.SetEquipFeatureStyle((int)levelUpInfos[i].from, (int)levelUpInfos[i].to, levelUpInfos[i].contextData);
				break;
			case 1:
				component.SetGemSlotStyle((int)levelUpInfos[i].from, (int)levelUpInfos[i].to, levelUpInfos[i].contextData);
				break;
			}
			if (fromLevelUp)
			{
				component.PlayAnimation((float)i * m_LevelUpTabConfig.propertyStartDelay, IsAttributeStyle(levelUpInfos[i].styleIndex) ? "LevelUp" : "New");
			}
		}
		if (fromLevelUp)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Equip/Upgrade");
		}
	}

	private void UpdatePreviewLevel()
	{
		if (m_PreviewLevel > m_Equip.Level)
		{
			m_LevelUpTabConfig.addLevelRoot.SetActive(value: true);
			m_LevelUpTabConfig.addLevelText.SetText((m_PreviewLevel - m_Equip.Level).FastToString());
		}
		else
		{
			m_LevelUpTabConfig.addLevelRoot.SetActive(value: false);
		}
	}

	private bool UpdateCostBag()
	{
		if (m_MaxLevel <= m_Equip.Level)
		{
			m_LevelUpTabConfig.costBagRoot.SetActive(value: false);
			m_HasCostMaterial = false;
			SetSelectMaterialActionDisabled(disabled: true);
			return false;
		}
		m_CanUpgrade = true;
		EquipMaterialData data = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_PreviewLevel), RuntimeConfigs.data.equipMaterialDatas);
		if (data != null && m_CurEquipMaterialData != null)
		{
			List<ItemUnifierProxy> list = m_LevelUpTabConfig.costBag.ItemSource as List<ItemUnifierProxy>;
			if (list == null)
			{
				list = ListPool<ItemUnifierProxy>.Get();
			}
			else
			{
				ItemUnifierProxy.ItemUnifierPool.Release(list);
			}
			List<ItemKv> itemAllLv = data.itemAllLv;
			if (itemAllLv != null && itemAllLv.Count > 0)
			{
				list.Clear();
				foreach (ItemKv item in data.itemAllLv)
				{
					ItemKv itemKv = m_CurEquipMaterialData.itemAllLv.FirstOrDefault((ItemKv x) => x.id == item.id);
					if (itemKv != null)
					{
						int num = item.count - itemKv.count;
						if (num > 0)
						{
							list.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, num));
						}
					}
					else
					{
						list.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
					}
				}
				m_HasCostMaterial = list.Count > 0;
				SetSelectMaterialActionDisabled(!m_HasCostMaterial);
				m_LevelUpTabConfig.costBagRoot.SetActive(m_HasCostMaterial);
				m_LevelUpTabConfig.costBag.Station = Station;
				m_LevelUpTabConfig.costBag.ItemSource = list;
				return GameUtility.ItemsIsEnough(list);
			}
			m_LevelUpTabConfig.costBagRoot.SetActive(value: false);
			m_HasCostMaterial = false;
			SetSelectMaterialActionDisabled(disabled: true);
			return true;
		}
		m_HasCostMaterial = false;
		SetSelectMaterialActionDisabled(disabled: true);
		return true;
	}

	private bool UpdateMoney()
	{
		if (m_Equip.Level < m_MaxLevel)
		{
			EquipMaterialData data = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_PreviewLevel), RuntimeConfigs.data.equipMaterialDatas);
			EquipMaterialData data2 = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_Equip.Level), RuntimeConfigs.data.equipMaterialDatas);
			m_LevelUpTabConfig.costBottomRoot.SetActive(value: true);
			_requireCoin = data.totalCoinRequired - data2.totalCoinRequired;
			_requireStrengthenMat = data.xpItem.count - data2.xpItem.count;
			m_LevelUpTabConfig.coinComponentBottom.Init(_requireCoin);
			m_LevelUpTabConfig.strengthComponentBottom.Init(_requireStrengthenMat);
			if (m_LevelUpTabConfig.coinComponentBottom.IsEnough)
			{
				return m_LevelUpTabConfig.strengthComponentBottom.IsEnough;
			}
			return false;
		}
		m_LevelUpTabConfig.costBottomRoot.SetActive(value: false);
		return true;
	}

	private bool UpdateWorldLevel()
	{
		return CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_PreviewLevel), RuntimeConfigs.data.equipMaterialDatas).worldLevel <= Model<WorldLevelModel>.Interface.GetCurWorldLevel();
	}

	private bool UpdateCanExchangeMaterial()
	{
		QuickPowerExchangeItemViewData viewData;
		return TryGetQuickPowerExchangeItemViewData(out viewData);
	}

	private void UpdateButton()
	{
		bool flag = _isResourceChoose || CanSubmitLevelUp() || CanOpenQuickPowerExchangeItemView();
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(GetInputBindingController(), "UI/Confirm", !flag);
		if (m_Equip.Level < m_MaxLevel)
		{
			m_LevelUpTabConfig.levelUpButton.gameObject.SetActive(value: true);
			m_LevelUpTabConfig.cannotLevelUpRoot.SetActive(value: false);
			bool flag2 = !m_CanUpgrade && m_CanExchangeMaterial;
			m_LevelUpTabConfig.levelUpButton.Interactable(m_CanUpgrade | flag2);
			m_LevelUpTabConfig.levelUpButtonText.SetTable(LocalizeTable.Common);
			m_LevelUpTabConfig.levelUpButtonText.StringReference.TableEntryReference = (flag2 ? LocalizationCommonData.CommonString.ExchangeMaterial : LocalizationCommonData.CommonString.Strengthen);
			EquipMaterialData data = CoreUtils.GetData(m_EquipData.GetLevelMaterialId(m_PreviewLevel), RuntimeConfigs.data.equipMaterialDatas);
			if (data.worldLevel > Model<WorldLevelModel>.Interface.GetCurWorldLevel())
			{
				m_LevelUpTabConfig.levelUpButton.gameObject.SetActive(value: false);
				m_LevelUpTabConfig.cannotLevelUpRoot.SetActive(value: true);
				m_LevelUpTabConfig.cannotLevelUpText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NeedWorldLevel;
				m_LevelUpTabConfig.cannotLevelUpText.StringReference.GetVariable<int>("0").Value = data.worldLevel;
			}
		}
		else
		{
			m_LevelUpTabConfig.levelUpButton.gameObject.SetActive(value: false);
			m_LevelUpTabConfig.cannotLevelUpRoot.SetActive(value: true);
			m_LevelUpTabConfig.cannotLevelUpText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.EquipmentLevelMax;
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void OnMoveToShow()
	{
		base.OnMoveToShow();
		RestoreResourceChooseFocus();
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, UpdateEquip);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnPlayerAttributeChanged);
		m_LevelUpTabConfig.levelUpOSA.Unload();
		m_PreviewLevel = 0;
		base.UnInit();
		m_data?.closeAction?.Invoke();
		curNavigateState?.Reset();
		SetSelectMaterialActionDisabled(disabled: false);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if ((bool)betterAnimation)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public override void BackToBattleMain()
	{
		base.BackToBattleMain();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/Confirm"] = new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadGroup == null) && _allInputPrompt != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			if (_isResourceChoose)
			{
				_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			}
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			gamePadGroup.RegisterInputActions(_tipsActions);
			RefreshResourceChooseHiddenObjects();
		}
	}

	private void RefreshResourceChooseHiddenObjects()
	{
		if (m_HideWhenResourceChooseObjects == null)
		{
			return;
		}
		foreach (GameObject hideWhenResourceChooseObject in m_HideWhenResourceChooseObjects)
		{
			if (!(hideWhenResourceChooseObject == null))
			{
				hideWhenResourceChooseObject.SetActive(!_isResourceChoose);
			}
		}
	}

	public void OnConfirm()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void OnCancle()
	{
		if (_isResourceChoose)
		{
			_isResourceChoose = false;
			ReBindBtnPrompt();
			if (m_CurrentResourceChooseLayer != null)
			{
				m_CurrentResourceChooseLayer.UnFocus();
				m_CurrentResourceChooseLayer = null;
				return;
			}
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (currentSelected != null)
			{
				ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (IDeselectHandler handler, BaseEventData data) =>
				{
					handler?.OnDeselect(data);
				});
			}
		}
		else
		{
			Close();
		}
	}

	public void ActionLevelUp()
	{
		if (!_isResourceChoose && m_Equip.Level < m_MaxLevel)
		{
			OnLevelUp();
		}
	}

	public void OnPageUp()
	{
		if (!_isResourceChoose && m_PreviewLevel < m_MaxLevel)
		{
			m_LevelUpTabConfig.levelUpOSA.ScrollToLevel(m_PreviewLevel + 1);
		}
	}

	public void OnPageDown()
	{
		if (!_isResourceChoose && m_PreviewLevel > m_Equip.Level + 1)
		{
			m_LevelUpTabConfig.levelUpOSA.ScrollToLevel(m_PreviewLevel - 1);
		}
	}

	public void ScrollToMaxAllowedLevel()
	{
		if (!_isResourceChoose && m_Equip.Level < m_MaxLevel)
		{
			m_MaxCanLevelUp = GetCanLevelUp();
			if (CanJumpToMaxAllowedLevel())
			{
				m_LevelUpTabConfig.levelUpOSA.ScrollToLevel(m_MaxCanLevelUp);
			}
		}
	}

	public void OnShowCoinDetail()
	{
		EnterResourceChoose(layerResouce);
	}

	public void OnGamePadSelectMaterialList()
	{
		if (m_HasCostMaterial)
		{
			EnterResourceChoose(layerMaterial);
		}
	}

	private void SetSelectMaterialActionDisabled(bool disabled)
	{
		if (disabled || m_SelectMaterialActionDisabledByView)
		{
			Singleton<GameInputActionManager>.instance.SetActionDisabled("UI/UISpecial5", disabled);
			m_SelectMaterialActionDisabledByView = disabled;
		}
	}

	private void EnterResourceChoose(ViewControlLayer targetLayer)
	{
		if (!_isResourceChoose)
		{
			_isResourceChoose = true;
			m_CurrentResourceChooseLayer = targetLayer;
			ReBindBtnPrompt();
			targetLayer?.Focus();
		}
	}

	private void RestoreResourceChooseFocus()
	{
		if (_isResourceChoose)
		{
			if (m_CurrentResourceChooseLayer != null)
			{
				m_CurrentResourceChooseLayer.ReFocus();
			}
			else if (root == null || !root.ReFocus())
			{
				layerResouce?.ReFocus();
			}
		}
	}

	public void OnNavigate(Vector2 value)
	{
		if (_isResourceChoose)
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, OnNavigateSelect);
			}
			else if (root == null || !root.ReFocus())
			{
				m_CurrentResourceChooseLayer?.Focus();
			}
		}
	}

	private void OnNavigateSelect(MoveDirection moveDirection)
	{
		if (!(root == null))
		{
			switch (moveDirection)
			{
			case MoveDirection.Down:
				root.SelectDown();
				break;
			case MoveDirection.Left:
				root.SelectLeft();
				break;
			case MoveDirection.Up:
				root.SelectUp();
				break;
			case MoveDirection.Right:
				root.SelectRight();
				break;
			}
		}
	}
}
