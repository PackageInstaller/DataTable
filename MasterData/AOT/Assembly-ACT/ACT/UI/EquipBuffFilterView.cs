using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipBuffFilterView : BaseUIView<EquipBuffFilterViewInputController>
{
	public LoopScrollRectBase equipFeatureScrollForm;

	public LocalizeStringEvent featureName;

	public RectTransform levelDetailRoot;

	public EquipFeatureLevelInfo buffLevelInfoTemplate;

	public ActButton clearButton;

	public ActButton confirmButton;

	[Header("手柄输入")]
	public ViewControlLayer equipFeatureViewControlLayer;

	public ViewControlRoot viewControlRoot;

	private EquipBuffFilterViewData m_data;

	private List<EquipFeatureData> m_equipFeatureDataList;

	private List<int> m_draftSelectedFeatureIds;

	private Stack<GameObject> m_levelInfoPool;

	private int m_selectedIndex = -1;

	private const float CellAnimInterval = 0.05f;

	private const int MAX_SELECT_COUNT = 5;

	private void Awake()
	{
		equipFeatureScrollForm.OnItemShow.AddListener(OnItemShow);
		m_equipFeatureDataList = ListPool<EquipFeatureData>.Get();
		m_draftSelectedFeatureIds = ListPool<int>.Get();
		m_levelInfoPool = new Stack<GameObject>();
		if (buffLevelInfoTemplate != null)
		{
			buffLevelInfoTemplate.gameObject.SetActive(value: false);
		}
		if (clearButton != null)
		{
			clearButton.SetBtnClick(ClearSelectedFeatures);
		}
		if (confirmButton != null)
		{
			confirmButton.SetBtnClick(ConfirmSelectedFeatures);
		}
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		if (equipFeatureScrollForm != null)
		{
			equipFeatureScrollForm.OnItemShow.RemoveListener(OnItemShow);
		}
		ListPool<EquipFeatureData>.Release(m_equipFeatureDataList);
		m_equipFeatureDataList = null;
		if (m_draftSelectedFeatureIds != null)
		{
			ListPool<int>.Release(m_draftSelectedFeatureIds);
			m_draftSelectedFeatureIds = null;
		}
		RecycleLevelInfoItems();
		m_levelInfoPool = null;
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as EquipBuffFilterViewData;
		if (m_data == null)
		{
			m_data = new EquipBuffFilterViewData();
			uiViewData = m_data;
		}
		if (m_data.SelectedFeatureIds == null)
		{
			m_data.SelectedFeatureIds = new List<int>();
		}
		SyncDraftFromCommitted();
		RefreshFeatureList();
		UpdateClearButtonInteractable();
	}

	public override void Close()
	{
		m_data?.OnClose?.Invoke();
		base.Close();
	}

	public void ClearSelectedFeatures()
	{
		EnsureDraftSelectedFeatureIds();
		if (m_draftSelectedFeatureIds.Count > 0)
		{
			m_draftSelectedFeatureIds.Clear();
			RefreshVisibleCellToggleState();
			UpdateClearButtonInteractable();
		}
	}

	public void ConfirmSelectedFeatures()
	{
		EnsureSelectedFeatureIds();
		EnsureDraftSelectedFeatureIds();
		m_data.SelectedFeatureIds.Clear();
		m_data.SelectedFeatureIds.AddRange(m_draftSelectedFeatureIds);
		Close();
	}

	private void SyncDraftFromCommitted()
	{
		EnsureDraftSelectedFeatureIds();
		m_draftSelectedFeatureIds.Clear();
		if (m_data?.SelectedFeatureIds != null && m_data.SelectedFeatureIds.Count > 0)
		{
			m_draftSelectedFeatureIds.AddRange(m_data.SelectedFeatureIds);
		}
	}

	private void UpdateClearButtonInteractable()
	{
		if (!(clearButton == null))
		{
			EnsureDraftSelectedFeatureIds();
			clearButton.Interactable(m_draftSelectedFeatureIds.Count > 0);
		}
	}

	private void RefreshVisibleCellToggleState()
	{
		if (equipFeatureScrollForm == null)
		{
			return;
		}
		for (int i = 0; i < equipFeatureScrollForm.Children.Count; i++)
		{
			InventoryFilterCell component = equipFeatureScrollForm.Children[i].GetComponent<InventoryFilterCell>();
			if (!(component == null))
			{
				int index = component.GetIndex();
				if (index >= 0 && index < m_equipFeatureDataList.Count)
				{
					component.SetIsOn(IsFeatureSelected(m_equipFeatureDataList[index].id));
				}
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
		if (!(equipFeatureScrollForm == null))
		{
			int num = 3;
			for (int i = 0; i < equipFeatureScrollForm.Children.Count; i++)
			{
				equipFeatureScrollForm.Children[i].GetComponent<InventoryFilterCell>()?.PlayCustomAnimation((float)(i / num) * 0.05f);
			}
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	private void RefreshFeatureList()
	{
		m_equipFeatureDataList.Clear();
		m_selectedIndex = -1;
		if (RuntimeConfigs.data.equipFeatureDatas != null)
		{
			foreach (KeyValuePair<int, EquipFeatureData> equipFeatureData in RuntimeConfigs.data.equipFeatureDatas)
			{
				if (equipFeatureData.Value != null)
				{
					m_equipFeatureDataList.Add(equipFeatureData.Value);
				}
			}
			m_equipFeatureDataList.Sort((EquipFeatureData a, EquipFeatureData b) =>
			{
				int id = a.id;
				return id.CompareTo(b.id);
			});
		}
		equipFeatureScrollForm.ClearCells();
		equipFeatureScrollForm.totalCount = m_equipFeatureDataList.Count;
		equipFeatureScrollForm.RefillCells();
		int defaultDetailIndex = GetDefaultDetailIndex();
		if (defaultDetailIndex >= 0)
		{
			UpdateFeatureDetail(defaultDetailIndex);
		}
	}

	private int GetDefaultDetailIndex()
	{
		if (m_equipFeatureDataList.Count <= 0)
		{
			return -1;
		}
		EnsureDraftSelectedFeatureIds();
		if (m_draftSelectedFeatureIds.Count > 0)
		{
			for (int i = 0; i < m_equipFeatureDataList.Count; i++)
			{
				if (m_draftSelectedFeatureIds.Contains(m_equipFeatureDataList[i].id))
				{
					return i;
				}
			}
		}
		return 0;
	}

	private bool IsFeatureSelected(int featureId)
	{
		EnsureDraftSelectedFeatureIds();
		return m_draftSelectedFeatureIds.Contains(featureId);
	}

	private void OnItemShow(ILoopScrollDataSource arg0)
	{
		if (arg0 is InventoryFilterCell inventoryFilterCell)
		{
			int index = inventoryFilterCell.GetIndex();
			if (index >= 0 && index < m_equipFeatureDataList.Count)
			{
				EquipFeatureData equipFeatureData = m_equipFeatureDataList[index];
				inventoryFilterCell.Value = equipFeatureData.id;
				inventoryFilterCell.UpdateName(LocalizationUtility.localizeTableName_shortcommon, CoreUtils.GetEquipFeatureNameLocalId(equipFeatureData));
				inventoryFilterCell.OnToggleOn = OnToggleOn;
				inventoryFilterCell.OnToggleOff = OnToggleOff;
				inventoryFilterCell.SetIsOnWithoutNotify(IsFeatureSelected(equipFeatureData.id));
			}
		}
	}

	private void OnToggleOn(int index)
	{
		if (index >= 0 && index < m_equipFeatureDataList.Count)
		{
			int id = m_equipFeatureDataList[index].id;
			EnsureDraftSelectedFeatureIds();
			if (m_draftSelectedFeatureIds.Contains(id))
			{
				UpdateFeatureDetail(index);
			}
			else if (m_draftSelectedFeatureIds.Count >= 5)
			{
				ForceCellIsOn(index, isOn: false);
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.FilterMaxCount);
			}
			else
			{
				m_draftSelectedFeatureIds.Add(id);
				UpdateFeatureDetail(index);
				UpdateClearButtonInteractable();
			}
		}
	}

	private void OnToggleOff(int index)
	{
		if (index >= 0 && index < m_equipFeatureDataList.Count)
		{
			int id = m_equipFeatureDataList[index].id;
			EnsureDraftSelectedFeatureIds();
			m_draftSelectedFeatureIds.Remove(id);
			UpdateClearButtonInteractable();
		}
	}

	private void ForceCellIsOn(int index, bool isOn)
	{
		if (equipFeatureScrollForm == null)
		{
			return;
		}
		for (int i = 0; i < equipFeatureScrollForm.Children.Count; i++)
		{
			InventoryFilterCell component = equipFeatureScrollForm.Children[i].GetComponent<InventoryFilterCell>();
			if (component != null && component.GetIndex() == index)
			{
				component.SetIsOn(isOn);
				break;
			}
		}
	}

	private void EnsureSelectedFeatureIds()
	{
		if (m_data == null)
		{
			m_data = new EquipBuffFilterViewData();
		}
		if (m_data.SelectedFeatureIds == null)
		{
			m_data.SelectedFeatureIds = new List<int>();
		}
	}

	private void EnsureDraftSelectedFeatureIds()
	{
		if (m_draftSelectedFeatureIds == null)
		{
			m_draftSelectedFeatureIds = ListPool<int>.Get();
		}
	}

	private void UpdateFeatureDetail(int index)
	{
		if (index >= 0 && index < m_equipFeatureDataList.Count)
		{
			m_selectedIndex = index;
			EquipFeatureData equipFeatureData = m_equipFeatureDataList[index];
			if (featureName != null)
			{
				featureName.SetTable(LocalizeTable.ShortCommon);
				featureName.StringReference.TableEntryReference = CoreUtils.GetEquipFeatureNameLocalId(equipFeatureData);
			}
			RefreshFeatureLevelDescriptions(equipFeatureData);
		}
	}

	private void RefreshFeatureLevelDescriptions(EquipFeatureData featureData)
	{
		RecycleLevelInfoItems();
		if (levelDetailRoot != null)
		{
			levelDetailRoot.gameObject.SetActive(value: true);
		}
		int maxLv = featureData.maxLv;
		for (int i = 1; i <= maxLv; i++)
		{
			GameObject gameObject = ((m_levelInfoPool != null && m_levelInfoPool.Count > 0) ? m_levelInfoPool.Pop() : Object.Instantiate(buffLevelInfoTemplate.gameObject, levelDetailRoot));
			gameObject.transform.SetParent(levelDetailRoot, worldPositionStays: false);
			EquipFeatureLevelInfo component = gameObject.GetComponent<EquipFeatureLevelInfo>();
			int skillGroupLevelId = TableRule.GetSkillGroupLevelId(featureData.skillGroupData, i);
			component?.Init(skillGroupLevelId, i, isOn: false);
		}
	}

	private void RecycleLevelInfoItems()
	{
		if (levelDetailRoot == null)
		{
			return;
		}
		if (m_levelInfoPool == null)
		{
			m_levelInfoPool = new Stack<GameObject>();
		}
		for (int num = levelDetailRoot.childCount - 1; num >= 0; num--)
		{
			Transform child = levelDetailRoot.GetChild(num);
			if (buffLevelInfoTemplate != null && child.gameObject == buffLevelInfoTemplate.gameObject)
			{
				child.gameObject.SetActive(value: false);
			}
			else
			{
				m_levelInfoPool.Push(child.gameObject);
				child.SetParent(levelDetailRoot.parent, worldPositionStays: false);
				child.GetComponent<EquipFeatureLevelInfo>().UnInit();
			}
		}
	}
}
