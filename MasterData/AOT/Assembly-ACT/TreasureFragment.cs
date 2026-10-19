using System;
using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using ACT.World;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Sirenix.Utilities;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;

public class TreasureFragment : TreasureTypePrefabBase
{
	[SerializeField]
	private TextMeshProUGUI NameText;

	[SerializeField]
	private TextMeshProUGUI StaticTitles_Special;

	[SerializeField]
	private TextMeshProUGUI StaticTitles_Detail;

	[SerializeField]
	private TextMeshProUGUI StaticTitles_GetTime;

	[SerializeField]
	private TextMeshProUGUI Unfind_detail;

	[SerializeField]
	private BetterAnimation Anim;

	[SerializeField]
	private BImage ItemImg;

	[SerializeField]
	private GameObject HasfundGroup;

	[SerializeField]
	private GameObject NotfundGroup;

	[SerializeField]
	private GameObject middleImgGroup;

	[SerializeField]
	private GameObject notFoundImage;

	[SerializeField]
	private GameObject specialDesGroup;

	[SerializeField]
	private GameObject NotfundSpecialDesGroup;

	[SerializeField]
	private TextMeshProUGUI NotfundStaticTitles_Special;

	[SerializeField]
	private RectTransform scrollRect;

	[SerializeField]
	private CommonCharacterHead characterHead;

	[SerializeField]
	private CommonScrollBagComponent m_TreasureLoopScrollBag;

	[SerializeField]
	private GameObject treasureItemPrefab;

	[SerializeField]
	private TreasureDiskItemDetail diskItemDetail;

	[SerializeField]
	public ActButton _btnTutorial;

	[SerializeField]
	private RectTransform TabContent;

	private List<ItemUnifierProxy> m_Treasures;

	private Dictionary<int, AttributeTab> _AttributeTabsDic;

	public GameObject AttributeGroup;

	public AttributeTab AttributeTab;

	public ViewControlLayer ViewControlLayer;

	public RightStickScrollSupport RightStickScrollSupport;

	private int CurrentSelectedTreasureId = -1;

	private int _treasureType;

	private int _pendingSelectTreasureId = -1;

	private bool _hasPendingSelection;

	private ImageAssetStation _station;

	private GameObject _boundItemPrefab;

	private int _refreshVersion;

	public ImageAssetStation Station
	{
		get
		{
			GetImageStation();
			return _station;
		}
	}

	private void Awake()
	{
		m_Treasures = ListPool<ItemUnifierProxy>.Get();
		_AttributeTabsDic = new Dictionary<int, AttributeTab>();
	}

	private void OnDestroy()
	{
		_refreshVersion++;
		ItemUnifierProxy.ItemUnifierPool.Release(m_Treasures);
		ListPool<ItemUnifierProxy>.Release(m_Treasures);
		m_Treasures = null;
	}

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void SetTypeId(int type)
	{
		_treasureType = type;
	}

	public override async void RefreshPanel()
	{
		int refreshVersion = ++_refreshVersion;
		await InitBagView(refreshVersion);
		if (!(this == null) && refreshVersion == _refreshVersion)
		{
			RefreshCurrentItemPanel();
			if (_hasPendingSelection)
			{
				ExecutePendingSelection();
			}
		}
	}

	private async UniTask InitBagView(int refreshVersion)
	{
		m_TreasureLoopScrollBag.ClearBag();
		BindItemTemplate();
		ItemUnifierProxy.ItemUnifierPool.Release(m_Treasures);
		if (IsDiskTab())
		{
			ItemUnifierProxy.ItemUnifierPool.GetList(Model<TreasureModel>.Interface.GetAllDisks(), m_Treasures);
		}
		else
		{
			foreach (Treasure item in Model<TreasureModel>.Interface.GetAllTreasuresByType((TreasureType)_treasureType))
			{
				m_Treasures.Add(ItemUnifierProxy.ItemUnifierPool.Get(item));
			}
		}
		m_Treasures.Sort((ItemUnifierProxy left, ItemUnifierProxy right) => left.Id.CompareTo(right.Id));
		m_TreasureLoopScrollBag.gameObject.SetActive(value: true);
		m_TreasureLoopScrollBag.Station = Station;
		m_TreasureLoopScrollBag.SelectedModels.Clear();
		m_TreasureLoopScrollBag.ItemSource = m_Treasures;
		m_TreasureLoopScrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		m_TreasureLoopScrollBag.OnItemShow = null;
		m_TreasureLoopScrollBag.OnItemSelect = null;
		m_TreasureLoopScrollBag.OnItemUnSelect = null;
		CommonScrollBagComponent treasureLoopScrollBag = m_TreasureLoopScrollBag;
		treasureLoopScrollBag.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(treasureLoopScrollBag.OnItemSelect, new Action<ItemUIComponentBase>(SelectItem));
		CommonScrollBagComponent treasureLoopScrollBag2 = m_TreasureLoopScrollBag;
		treasureLoopScrollBag2.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(treasureLoopScrollBag2.OnItemShow, new Action<ItemUIComponentBase>(ShowItem));
		if (!m_Treasures.IsNullOrEmpty())
		{
			CurrentSelectedTreasureId = m_Treasures[0].Id;
			m_TreasureLoopScrollBag.SelectedModels.Add(m_Treasures[0]);
		}
		else
		{
			CurrentSelectedTreasureId = -1;
		}
		m_TreasureLoopScrollBag.ForceUpdatePerformance();
		await UniTask.DelayFrame(1);
		if (!(this == null) && refreshVersion == _refreshVersion && !_hasPendingSelection)
		{
			ViewControlLayer.DefaultSelect = null;
			ViewControlLayer.Focus();
		}
	}

	public void ShowItem(ItemUIComponentBase item)
	{
		item?.UpdatePerformance();
	}

	public void SelectItem(ItemUIComponentBase item)
	{
		if (item?.ItemUnifier != null)
		{
			CurrentSelectedTreasureId = item.ItemUnifier.Id;
			RefreshCurrentItemPanel();
		}
	}

	private void BindItemTemplate()
	{
		GameObject gameObject = treasureItemPrefab;
		if (!(gameObject == null) && !(gameObject == _boundItemPrefab))
		{
			m_TreasureLoopScrollBag.BindTemplate(gameObject);
			_boundItemPrefab = gameObject;
		}
	}

	private bool IsDiskTab()
	{
		return _treasureType == 2;
	}

	private void RefreshCurrentItemPanel()
	{
		if (IsDiskTab())
		{
			RefreshDiskPanel();
			UpdateRedDot();
		}
		else
		{
			diskItemDetail?.Hide();
			RefreshRightPanel();
			UpdateRedDot();
		}
	}

	private void RefreshDiskPanel()
	{
		TreasureDisk disk = Model<TreasureModel>.Interface.GetDisk(CurrentSelectedTreasureId);
		diskItemDetail?.Refresh(disk?.CollectedGem);
		if (disk == null || !disk.IsCollected)
		{
			ClearTreasureDetailPanel();
			middleImgGroup.SetActive(value: true);
			ItemImg.icon.gameObject.SetActive(value: false);
			notFoundImage.gameObject.SetActive(value: true);
			return;
		}
		ItemTreasureData data = CoreUtils.GetData(disk.TreasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (((data == null) ? null : CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas)) == null)
		{
			ClearTreasureDetailPanel();
			return;
		}
		HasfundGroup.SetActive(value: true);
		NotfundGroup.SetActive(value: false);
		middleImgGroup.SetActive(value: true);
		NameText.gameObject.SetActive(value: false);
		scrollRect.gameObject.SetActive(value: false);
		characterHead?.SetActive(active: false);
		AttributeGroup.SetActive(value: false);
		specialDesGroup.SetActive(value: false);
		NotfundSpecialDesGroup.SetActive(value: false);
		_btnTutorial.gameObject.SetActive(value: false);
		notFoundImage.gameObject.SetActive(value: false);
		ItemImg.icon.gameObject.SetActive(value: true);
		ItemData data2 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas);
		Station.LoadItemIconAsync(data2.iconAddress, ItemImg).Forget();
	}

	private void ClearTreasureDetailPanel()
	{
		HasfundGroup.SetActive(value: false);
		NotfundGroup.SetActive(value: false);
		scrollRect.gameObject.SetActive(value: false);
		characterHead?.SetActive(active: false);
		AttributeGroup.SetActive(value: false);
		_btnTutorial.gameObject.SetActive(value: false);
	}

	public void SetInitialSelection(int treasureId)
	{
		_pendingSelectTreasureId = treasureId;
		_hasPendingSelection = true;
	}

	private async void ExecutePendingSelection()
	{
		if (!_hasPendingSelection)
		{
			return;
		}
		int pendingSelectTreasureId = _pendingSelectTreasureId;
		int refreshVersion = _refreshVersion;
		_hasPendingSelection = false;
		_pendingSelectTreasureId = -1;
		int index = -1;
		for (int i = 0; i < m_Treasures.Count; i++)
		{
			if (m_Treasures[i].Id == pendingSelectTreasureId)
			{
				index = i;
				break;
			}
		}
		if (index < 0)
		{
			ViewControlLayer.DefaultSelect = null;
			ViewControlLayer.Focus();
			return;
		}
		ItemUnifierProxy item = m_Treasures[index];
		m_TreasureLoopScrollBag.SelectedModels.Clear();
		m_TreasureLoopScrollBag.SelectedModels.Add(item);
		CurrentSelectedTreasureId = pendingSelectTreasureId;
		if (index >= 0)
		{
			m_TreasureLoopScrollBag.ScrollToIndex(index, keepOffset: false);
		}
		m_TreasureLoopScrollBag.ForceUpdatePerformance();
		RefreshCurrentItemPanel();
		await UniTask.DelayFrame(1);
		if (this == null || refreshVersion != _refreshVersion)
		{
			return;
		}
		ItemUIComponentBase item2 = m_TreasureLoopScrollBag.GetItem(index);
		if (item2 == null)
		{
			ViewControlLayer.DefaultSelect = null;
			ViewControlLayer.Focus();
			return;
		}
		SelectionUGUI selectionUGUI = item2.GetComponent<SelectionUGUI>();
		bool restoreScrollToShow = selectionUGUI != null;
		bool originalScrollToShow = true;
		if (restoreScrollToShow)
		{
			originalScrollToShow = selectionUGUI.ScrollToShow;
			selectionUGUI.ScrollToShow = false;
		}
		ViewControlLayer.UnFocus();
		ViewControlLayer.DefaultSelect = item2.GetComponent<ACT.ViewControl.SelectableEx>();
		ViewControlLayer.Focus();
		await UniTask.DelayFrame(1);
		if (((this != null) & restoreScrollToShow) && selectionUGUI != null)
		{
			selectionUGUI.ScrollToShow = originalScrollToShow;
		}
	}

	private void UpdateRedDot()
	{
		string text = string.Empty;
		ItemTreasureData data = CoreUtils.GetData(CurrentSelectedTreasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (data != null)
		{
			switch (data.type)
			{
			case 1:
				text = RedDotPathDefine.Treasure_Precious + $"|{data.id}";
				break;
			case 2:
				text = RedDotPathDefine.Treasure_Fragmented + $"|{data.id}";
				break;
			case 3:
				text = RedDotPathDefine.Treasure_WaterfallSeal + $"|{data.id}";
				break;
			case 4:
				text = RedDotPathDefine.Treasure_Relic + $"|{data.id}";
				break;
			case 5:
				text = RedDotPathDefine.Treasure_BygoneOldObject + $"|{data.id}";
				break;
			case 6:
				text = RedDotPathDefine.Treasure_LeftOver + $"|{data.id}";
				break;
			case 7:
				text = RedDotPathDefine.Treasure_EnergyControl + $"|{data.id}";
				break;
			}
			if (text != string.Empty)
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(text, active: false);
			}
		}
	}

	private void RefreshRightPanel()
	{
		bool flag = Model<TreasureModel>.Interface.HasGain(CurrentSelectedTreasureId);
		NameText.gameObject.SetActive(value: true);
		HasfundGroup.SetActive(value: true);
		if (flag)
		{
			scrollRect.gameObject.SetActive(value: true);
			NotfundGroup.SetActive(value: false);
			ItemTreasureData data = CoreUtils.GetData(CurrentSelectedTreasureId, RuntimeConfigs.data.itemTreasureDatas);
			ItemData data2 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas);
			NameText.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data2.nameLocal));
			if (data.characterId != 0)
			{
				characterHead?.Init(data.characterId, _station);
				characterHead?.SetActive(active: true);
			}
			else
			{
				characterHead?.SetActive(active: false);
			}
			ItemImg.icon.gameObject.SetActive(value: true);
			ItemData data3 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas);
			_station.LoadItemIconAsync(data3.iconAddress, ItemImg).Forget();
			notFoundImage.SetActive(value: false);
		}
		else
		{
			ItemImg.icon.gameObject.SetActive(value: false);
			NotfundGroup.SetActive(value: true);
			NameText.SetText("???");
			scrollRect.gameObject.SetActive(value: false);
			notFoundImage.SetActive(value: true);
		}
		UpdateRightGroup(flag);
		RefreshTutorialBtn();
	}

	private void RefreshTutorialBtn()
	{
		if (CurrentSelectedTreasureId >= 0)
		{
			bool flag = Model<TreasureModel>.Interface.IsSpecialTreasure(CurrentSelectedTreasureId);
			bool item = Model<TreasureModel>.Interface.IsHaveGuideID(CurrentSelectedTreasureId).Item1;
			bool flag2 = Model<TreasureModel>.Interface.HasGain(CurrentSelectedTreasureId);
			_btnTutorial.gameObject.SetActive(flag & item & flag2);
			_btnTutorial.SetBtnClick(OnClickTutorial);
		}
	}

	private void OnClickTutorial()
	{
		int item = Model<TreasureModel>.Interface.IsHaveGuideID(CurrentSelectedTreasureId).Item2;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
		{
			tutorialId = item
		});
	}

	private async void UpdateRightGroup(bool hasfound)
	{
		int selectedTreasureId = CurrentSelectedTreasureId;
		if (CurrentSelectedTreasureId == -1)
		{
			HasfundGroup.SetActive(value: false);
			NotfundGroup.SetActive(value: false);
			NameText.SetText(string.Empty);
			return;
		}
		ItemTreasureData itemTreasureDatas = CoreUtils.GetData(CurrentSelectedTreasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (hasfound)
		{
			RefreshAttributePanel(itemTreasureDatas);
			ItemData data = CoreUtils.GetData(itemTreasureDatas.itemId, RuntimeConfigs.data.itemDatas);
			if (LocalizationSettings.StringDatabase.GetTable(LocalizationUtility.localizeTableName_shortcommon).GetEntry(itemTreasureDatas.extraText) != null)
			{
				StaticTitles_Special.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, itemTreasureDatas.extraText));
				specialDesGroup.SetActive(value: true);
			}
			else
			{
				specialDesGroup.SetActive(value: false);
			}
			StaticTitles_Detail.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, data.descLocal));
			int gainTime = Model<TreasureModel>.Interface.GetTreasure(CurrentSelectedTreasureId).GainTime;
			IList<object> list = new List<object>();
			list.Add(TimeManager.GetDateTimeString(gainTime));
			StaticTitles_GetTime.SetText("【" + LocalizationUtility.GetLocalizeString("Common", 2068, list) + "】");
			RefreshContentSize(scrollRect);
		}
		else if (itemTreasureDatas != null)
		{
			await Model<TreasureModel>.Interface.RefreshCollectionMap();
			if (this == null || selectedTreasureId != CurrentSelectedTreasureId)
			{
				return;
			}
			if (Model<TreasureModel>.Interface.CollectionMap.TryGetValue(CurrentSelectedTreasureId, out var value))
			{
				ACT.World.MapArea item = value.Item1;
				MapSubArea item2 = value.Item2;
				ACT.Config.MapArea data2 = CoreUtils.GetData((int)item, RuntimeConfigs.data.mapAreas);
				if (data2 != null)
				{
					string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data2.name);
					SubMapArea data3 = CoreUtils.GetData((int)item2, RuntimeConfigs.data.subMapAreas);
					string item3 = string.Empty;
					if (data3 != null)
					{
						item3 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data3.name);
					}
					IList<object> list2 = new List<object>();
					list2.Add(localizeString);
					list2.Add(item3);
					Unfind_detail.SetText(LocalizationUtility.GetLocalizeString("Common", 2072, list2));
				}
			}
			else
			{
				Unfind_detail.SetText(LocalizationUtility.GetLocalizeString("shortcommon", itemTreasureDatas.tips));
			}
			if (LocalizationSettings.StringDatabase.GetTable(LocalizationUtility.localizeTableName_shortcommon).GetEntry(itemTreasureDatas.extraText) != null)
			{
				NotfundStaticTitles_Special.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, itemTreasureDatas.extraText));
				NotfundSpecialDesGroup.SetActive(value: true);
			}
			else
			{
				NotfundSpecialDesGroup.SetActive(value: false);
			}
		}
		await UniTask.DelayFrame(1);
		if (!(this == null) && selectedTreasureId == CurrentSelectedTreasureId && Singleton<NewUIManager>.instance != null)
		{
			ItemTreasureCenterView itemTreasureCenterView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ITEMTREASURECENTER) as ItemTreasureCenterView;
			if (itemTreasureCenterView != null)
			{
				itemTreasureCenterView.RefreshPrompScroll(GetGamepadIsScroll());
			}
		}
	}

	private void RefreshAttributePanel(ItemTreasureData itemTreasureDatas)
	{
		foreach (KeyValuePair<int, AttributeTab> item in _AttributeTabsDic)
		{
			UnityEngine.Object.Destroy(item.Value.gameObject);
		}
		_AttributeTabsDic.Clear();
		if (itemTreasureDatas.attrId.IsNullOrEmpty())
		{
			AttributeGroup.SetActive(value: false);
			return;
		}
		for (int i = 0; i < itemTreasureDatas.attrId.Length; i++)
		{
			PropertyData data = CoreUtils.GetData(itemTreasureDatas.attrId[i], RuntimeConfigs.data.propertyDatas);
			float value = itemTreasureDatas.attrIncreaseNum[i];
			AttributeTab component = UnityEngine.Object.Instantiate(AttributeTab, TabContent).GetComponent<AttributeTab>();
			component.UpdateTabView(data, value);
			_AttributeTabsDic.Add(data.id, component);
			AttributeGroup.SetActive(value: true);
		}
	}

	private void RefreshContentSize(RectTransform contentRect)
	{
		if (!(contentRect == null) && contentRect.TryGetComponent<ScrollRect>(out var component))
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(component.content);
			component.verticalNormalizedPosition = 1f;
		}
	}

	private void GetImageStation()
	{
		if (_station == null)
		{
			_station = ImageManager.instance.GetAssetStation();
		}
	}

	public override void PlayAnimation(string animationName)
	{
		if ((bool)Anim)
		{
			Anim.GetSequence(animationName)?.Play();
		}
	}

	public bool GetGamepadIsScroll()
	{
		if (RightStickScrollSupport == null || !RightStickScrollSupport.GetIsContentFull())
		{
			return false;
		}
		return true;
	}

	public bool TrySubmitDiskDetail()
	{
		if (IsDiskTab() && gameObject.activeInHierarchy && diskItemDetail != null)
		{
			return diskItemDetail.TrySubmitDetailButton();
		}
		return false;
	}
}
