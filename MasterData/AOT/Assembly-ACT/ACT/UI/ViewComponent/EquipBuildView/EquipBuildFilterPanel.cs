using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI.ViewComponent.EquipBuildView;

public class EquipBuildFilterPanel : MonoBehaviour
{
	[Header("仅显示可打造装备")]
	public AnimateToggle onlyShowBuildableToggle;

	[Header("品质筛选")]
	public ActToggle SLevelQualityToggle;

	public ActToggle ALevelQualityToggle;

	public ActToggle BLevelQualityToggle;

	[Header("技能筛选")]
	public EquipFeatureCell equipFeatureFilterCellTemplate;

	public Transform equipFeatureFilterRoot;

	public ActButton equipFeatureAddBtn;

	[Header("重置/确认")]
	public ActButton resetBtn;

	public ActButton confirmBtn;

	[Header("动画")]
	public BetterAnimation animation;

	private bool m_snapshotOnlyShowBuildable;

	private bool m_snapshotSLevelQuality;

	private bool m_snapshotALevelQuality;

	private bool m_snapshotBLevelQuality;

	private readonly List<int> m_snapshotSelectedEquipFeatureIds = new List<int>();

	private readonly Stack<EquipFeatureCell> m_equipFeatureCellPool = new Stack<EquipFeatureCell>();

	private readonly List<EquipFeatureCell> m_activeEquipFeatureCells = new List<EquipFeatureCell>();

	private const string ToggleSwitchOnAnimationName = "open";

	private const string ToggleSwitchOffAnimationName = "close";

	public Action OnConfirm { get; set; }

	public Action OnClosed { get; set; }

	public List<int> SelectedEquipFeatureIds { get; } = new List<int>();

	private void Awake()
	{
		confirmBtn?.OnClick.AddListener(OnConfirmBtnClick);
		resetBtn?.OnClick.AddListener(ResetFilter);
		if (equipFeatureAddBtn != null)
		{
			equipFeatureAddBtn.OnClick.AddListener(OpenEquipFeatureFilterView);
		}
		if (equipFeatureFilterCellTemplate != null)
		{
			equipFeatureFilterCellTemplate.gameObject.SetActive(value: false);
		}
	}

	private void OnDestroy()
	{
		if (equipFeatureAddBtn != null)
		{
			equipFeatureAddBtn.OnClick.RemoveListener(OpenEquipFeatureFilterView);
		}
		m_activeEquipFeatureCells.Clear();
		m_equipFeatureCellPool.Clear();
	}

	public void Open()
	{
		CaptureSnapshot();
		gameObject.SetActive(value: true);
		RefreshOnlyShowBuildableToggleVisual();
		animation.GetSequence("Show").Play();
	}

	public void Close()
	{
		RestoreFromSnapshot();
		animation?.GetSequence("Hide")?.OnComplete((AnimationBuilder x) =>
		{
			gameObject.SetActive(value: false);
		}).Play();
		OnClosed?.Invoke();
	}

	public void ResetAllFilterRecords()
	{
		gameObject.SetActive(value: false);
		ClearSnapshot();
		ResetFilter();
	}

	public bool HasActiveFilter()
	{
		if ((bool)onlyShowBuildableToggle && onlyShowBuildableToggle.isOn)
		{
			return true;
		}
		if ((bool)SLevelQualityToggle && SLevelQualityToggle.IsOn)
		{
			return true;
		}
		if ((bool)ALevelQualityToggle && ALevelQualityToggle.IsOn)
		{
			return true;
		}
		if ((bool)BLevelQualityToggle && BLevelQualityToggle.IsOn)
		{
			return true;
		}
		return SelectedEquipFeatureIds.Count > 0;
	}

	public void DoFilter(IList<EquipData> equips)
	{
		if (equips == null)
		{
			return;
		}
		if ((bool)onlyShowBuildableToggle && onlyShowBuildableToggle.isOn)
		{
			for (int num = equips.Count - 1; num >= 0; num--)
			{
				if (!Model<EquipModel>.Interface.CanBuildEquip(equips[num]))
				{
					equips.RemoveAt(num);
				}
			}
		}
		List<int> list = new List<int>();
		CollectSelectedQualities(list);
		if (list.Count > 0)
		{
			for (int num2 = equips.Count - 1; num2 >= 0; num2--)
			{
				ItemData data = CoreUtils.GetData(equips[num2].id, RuntimeConfigs.data.itemDatas);
				if (data == null || !list.Contains(data.quality))
				{
					equips.RemoveAt(num2);
				}
			}
		}
		if (SelectedEquipFeatureIds.Count <= 0)
		{
			return;
		}
		for (int num3 = equips.Count - 1; num3 >= 0; num3--)
		{
			if (!HasAllSelectedEquipFeatures(equips[num3]))
			{
				equips.RemoveAt(num3);
			}
		}
	}

	private void CollectSelectedQualities(List<int> qualityFilters)
	{
		if ((bool)SLevelQualityToggle && SLevelQualityToggle.IsOn)
		{
			qualityFilters.Add(5);
		}
		if ((bool)ALevelQualityToggle && ALevelQualityToggle.IsOn)
		{
			qualityFilters.Add(4);
		}
		if ((bool)BLevelQualityToggle && BLevelQualityToggle.IsOn)
		{
			qualityFilters.Add(3);
		}
	}

	private void ResetFilter()
	{
		ResetOnlyShowBuildableToggle();
		SLevelQualityToggle?.SetIsOnWithoutNotify(val: false);
		ALevelQualityToggle?.SetIsOnWithoutNotify(val: false);
		BLevelQualityToggle?.SetIsOnWithoutNotify(val: false);
		SelectedEquipFeatureIds.Clear();
		RefreshSelectedEquipFeatureCells();
	}

	private void ResetOnlyShowBuildableToggle()
	{
		if (onlyShowBuildableToggle != null && onlyShowBuildableToggle.isOn)
		{
			onlyShowBuildableToggle.isOn = false;
		}
	}

	private void RefreshOnlyShowBuildableToggleVisual()
	{
		AnimateToggle animateToggle = onlyShowBuildableToggle;
		if (!(animateToggle == null) && !(animateToggle.anim == null))
		{
			string animationName = (animateToggle.isOn ? "open" : "close");
			animateToggle.anim.GetSequence(animationName)?.Complete();
		}
	}

	private void CaptureSnapshot()
	{
		m_snapshotOnlyShowBuildable = (bool)onlyShowBuildableToggle && onlyShowBuildableToggle.isOn;
		m_snapshotSLevelQuality = (bool)SLevelQualityToggle && SLevelQualityToggle.IsOn;
		m_snapshotALevelQuality = (bool)ALevelQualityToggle && ALevelQualityToggle.IsOn;
		m_snapshotBLevelQuality = (bool)BLevelQualityToggle && BLevelQualityToggle.IsOn;
		m_snapshotSelectedEquipFeatureIds.Clear();
		if (SelectedEquipFeatureIds.Count > 0)
		{
			m_snapshotSelectedEquipFeatureIds.AddRange(SelectedEquipFeatureIds);
		}
	}

	private void ClearSnapshot()
	{
		m_snapshotOnlyShowBuildable = false;
		m_snapshotSLevelQuality = false;
		m_snapshotALevelQuality = false;
		m_snapshotBLevelQuality = false;
		m_snapshotSelectedEquipFeatureIds.Clear();
	}

	private void RestoreFromSnapshot()
	{
		onlyShowBuildableToggle?.SetIsOnWithoutNotify(m_snapshotOnlyShowBuildable);
		SLevelQualityToggle?.SetIsOnWithoutNotify(m_snapshotSLevelQuality);
		ALevelQualityToggle?.SetIsOnWithoutNotify(m_snapshotALevelQuality);
		BLevelQualityToggle?.SetIsOnWithoutNotify(m_snapshotBLevelQuality);
		SelectedEquipFeatureIds.Clear();
		if (m_snapshotSelectedEquipFeatureIds.Count > 0)
		{
			SelectedEquipFeatureIds.AddRange(m_snapshotSelectedEquipFeatureIds);
		}
		RefreshSelectedEquipFeatureCells();
	}

	private void OpenEquipFeatureFilterView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPBUFFFILTER, new EquipBuffFilterViewData
		{
			SelectedFeatureIds = SelectedEquipFeatureIds,
			OnClose = RefreshSelectedEquipFeatureCells
		});
	}

	private void RefreshSelectedEquipFeatureCells()
	{
		ReturnAllEquipFeatureCells();
		if (equipFeatureFilterCellTemplate == null || equipFeatureFilterRoot == null)
		{
			return;
		}
		for (int i = 0; i < SelectedEquipFeatureIds.Count; i++)
		{
			EquipFeatureData data = CoreUtils.GetData(SelectedEquipFeatureIds[i], RuntimeConfigs.data.equipFeatureDatas);
			if (data != null)
			{
				EquipFeatureCell equipFeatureCell = GetEquipFeatureCell();
				equipFeatureCell.SetName(CoreUtils.GetEquipFeatureNameLocalId(data));
				equipFeatureCell.gameObject.SetActive(value: true);
				m_activeEquipFeatureCells.Add(equipFeatureCell);
			}
		}
	}

	private EquipFeatureCell GetEquipFeatureCell()
	{
		EquipFeatureCell equipFeatureCell = ((m_equipFeatureCellPool.Count <= 0) ? UnityEngine.Object.Instantiate(equipFeatureFilterCellTemplate, equipFeatureFilterRoot) : m_equipFeatureCellPool.Pop());
		equipFeatureCell.transform.SetParent(equipFeatureFilterRoot, worldPositionStays: false);
		return equipFeatureCell;
	}

	private void ReturnAllEquipFeatureCells()
	{
		for (int num = m_activeEquipFeatureCells.Count - 1; num >= 0; num--)
		{
			EquipFeatureCell equipFeatureCell = m_activeEquipFeatureCells[num];
			if (!(equipFeatureCell == null))
			{
				equipFeatureCell.gameObject.SetActive(value: false);
				m_equipFeatureCellPool.Push(equipFeatureCell);
			}
		}
		m_activeEquipFeatureCells.Clear();
	}

	private bool HasAllSelectedEquipFeatures(EquipData equipData)
	{
		if (equipData == null || SelectedEquipFeatureIds.Count <= 0)
		{
			return false;
		}
		EquipStrengthenListData data = CoreUtils.GetData(equipData.strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
		if (data == null)
		{
			return false;
		}
		for (int i = 0; i < SelectedEquipFeatureIds.Count; i++)
		{
			int featureId = SelectedEquipFeatureIds[i];
			if (!ContainsFeature(data.equipFeature0, featureId) && !ContainsFeature(data.equipFeature10, featureId) && !ContainsFeature(data.equipFeature20, featureId))
			{
				return false;
			}
		}
		return true;
	}

	private static bool ContainsFeature(List<ItemKv> features, int featureId)
	{
		if (features == null)
		{
			return false;
		}
		for (int i = 0; i < features.Count; i++)
		{
			if (features[i].id == featureId)
			{
				return true;
			}
		}
		return false;
	}

	private void OnConfirmBtnClick()
	{
		CaptureSnapshot();
		OnConfirm?.Invoke();
		Close();
	}
}
