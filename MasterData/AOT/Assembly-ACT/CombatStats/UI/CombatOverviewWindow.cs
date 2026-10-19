using System.Collections.Generic;
using ACT.UI;
using CombatStats.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace CombatStats.UI;

public sealed class CombatOverviewWindow : MonoBehaviour
{
	[SerializeField]
	private ActButton closeButton;

	[SerializeField]
	private ActButton clearAllButton;

	[SerializeField]
	private CombatFloatingWindow floatingWindow;

	[SerializeField]
	private CombatStatsBootstrap statsBootstrap;

	[SerializeField]
	private SegmentListItemView segmentItemPrefab;

	[SerializeField]
	private Transform segmentContainer;

	[SerializeField]
	private GameObject damageViewRoot;

	[SerializeField]
	private GameObject skillViewRoot;

	[SerializeField]
	private DamageOverviewRowView damageRowPrefab;

	[SerializeField]
	private Transform damageRowContainer;

	[SerializeField]
	private SkillDamageRowView skillRowPrefab;

	[SerializeField]
	private Transform skillRowContainer;

	[SerializeField]
	private ToggleGroup segmentToggleGroup;

	[SerializeField]
	private ToggleGroup viewToggleGroup;

	[SerializeField]
	private Toggle damageToggle;

	[SerializeField]
	private Toggle skillToggle;

	[SerializeField]
	private TextMeshProUGUI infoDurationText;

	[SerializeField]
	private TextMeshProUGUI infoTotalDamageText;

	private readonly List<SegmentListItemView> segmentItems = new List<SegmentListItemView>();

	private readonly List<DamageOverviewRowView> damageRowItems = new List<DamageOverviewRowView>();

	private readonly List<SkillDamageRowView> skillRowItems = new List<SkillDamageRowView>();

	private int selectedSegmentId;

	private CombatOverviewSnapshot currentSnapshot;

	private CombatOverviewViewType currentViewType;

	private void Awake()
	{
		if (closeButton != null)
		{
			closeButton.OnClick.AddListener(Close);
		}
		if (clearAllButton != null)
		{
			clearAllButton.OnClick.AddListener(ClearAll);
		}
		if (damageToggle != null)
		{
			damageToggle.onValueChanged.AddListener(OnDamageToggleChanged);
		}
		if (skillToggle != null)
		{
			skillToggle.onValueChanged.AddListener(OnSkillToggleChanged);
		}
	}

	private void OnDestroy()
	{
		if (damageToggle != null)
		{
			damageToggle.onValueChanged.RemoveListener(OnDamageToggleChanged);
		}
		if (skillToggle != null)
		{
			skillToggle.onValueChanged.RemoveListener(OnSkillToggleChanged);
		}
	}

	private void OnDamageToggleChanged(bool isOn)
	{
		if (isOn)
		{
			currentViewType = CombatOverviewViewType.Damage;
			RefreshRightPanel();
		}
	}

	private void OnSkillToggleChanged(bool isOn)
	{
		if (isOn)
		{
			currentViewType = CombatOverviewViewType.Skills;
			RefreshRightPanel();
		}
	}

	private void RefreshRightPanel()
	{
		if (statsBootstrap != null && statsBootstrap.Service != null)
		{
			CombatOverviewSnapshot snapshot = statsBootstrap.Service.BuildOverviewSnapshot(selectedSegmentId, currentViewType);
			BindRightPanel(snapshot);
		}
	}

	public void Open()
	{
		gameObject.SetActive(value: true);
		if (floatingWindow != null)
		{
			floatingWindow.gameObject.SetActive(value: false);
		}
		currentViewType = CombatOverviewViewType.Damage;
		if (statsBootstrap != null && statsBootstrap.Service != null)
		{
			CombatOverviewSnapshot combatOverviewSnapshot = statsBootstrap.Service.BuildOverviewSnapshot(0, currentViewType);
			selectedSegmentId = ((combatOverviewSnapshot.Segments.Count > 0) ? (combatOverviewSnapshot.Segments.Count - 1) : 0);
			CombatOverviewSnapshot snapshot = statsBootstrap.Service.BuildOverviewSnapshot(selectedSegmentId, currentViewType);
			BindSegmentList(snapshot);
			BindRightPanel(snapshot);
			if (segmentItems.Count > 0 && selectedSegmentId < segmentItems.Count)
			{
				segmentItems[selectedSegmentId].SetSelected(selected: true);
			}
		}
	}

	public void Close()
	{
		gameObject.SetActive(value: false);
		if (floatingWindow != null)
		{
			floatingWindow.gameObject.SetActive(value: true);
		}
	}

	private void BindSegmentList(CombatOverviewSnapshot snapshot)
	{
		if (snapshot == null)
		{
			return;
		}
		currentSnapshot = snapshot;
		EnsureSegmentCount(snapshot.Segments.Count);
		for (int i = 0; i < segmentItems.Count; i++)
		{
			bool flag = i < snapshot.Segments.Count;
			segmentItems[i].gameObject.SetActive(flag);
			if (flag)
			{
				SegmentListItemSnapshot snapshot2 = snapshot.Segments[i];
				segmentItems[i].Bind(snapshot2, OnSegmentSelected);
				segmentItems[i].SetToggleGroup(segmentToggleGroup);
			}
		}
	}

	private void BindRightPanel(CombatOverviewSnapshot snapshot)
	{
		if (snapshot == null)
		{
			return;
		}
		currentViewType = snapshot.ViewType;
		SetViewState(snapshot.ViewType);
		SyncViewToggleState();
		EnsureDamageRowCount(snapshot.DamageRows.Count);
		for (int i = 0; i < damageRowItems.Count; i++)
		{
			bool flag = i < snapshot.DamageRows.Count;
			damageRowItems[i].gameObject.SetActive(flag);
			if (flag)
			{
				damageRowItems[i].Bind(snapshot.DamageRows[i]);
			}
		}
		EnsureSkillRowCount(snapshot.SkillRows.Count);
		for (int j = 0; j < skillRowItems.Count; j++)
		{
			bool flag2 = j < snapshot.SkillRows.Count;
			skillRowItems[j].gameObject.SetActive(flag2);
			if (flag2)
			{
				skillRowItems[j].Bind(snapshot.SkillRows[j]);
			}
		}
		if (snapshot.Segments.Count == 0)
		{
			ClearInfoPanel();
		}
		else
		{
			UpdateInfoPanel(selectedSegmentId);
		}
	}

	private void EnsureSegmentCount(int requiredCount)
	{
		while (segmentItems.Count < requiredCount && !(segmentItemPrefab == null) && !(segmentContainer == null))
		{
			SegmentListItemView segmentListItemView = Object.Instantiate(segmentItemPrefab, segmentContainer);
			segmentListItemView.gameObject.SetActive(value: true);
			segmentItems.Add(segmentListItemView);
		}
	}

	private void EnsureDamageRowCount(int requiredCount)
	{
		while (damageRowItems.Count < requiredCount && !(damageRowPrefab == null) && !(damageRowContainer == null))
		{
			DamageOverviewRowView damageOverviewRowView = Object.Instantiate(damageRowPrefab, damageRowContainer);
			damageOverviewRowView.gameObject.SetActive(value: true);
			damageRowItems.Add(damageOverviewRowView);
		}
	}

	private void EnsureSkillRowCount(int requiredCount)
	{
		while (skillRowItems.Count < requiredCount && !(skillRowPrefab == null) && !(skillRowContainer == null))
		{
			SkillDamageRowView skillDamageRowView = Object.Instantiate(skillRowPrefab, skillRowContainer);
			skillDamageRowView.gameObject.SetActive(value: true);
			skillRowItems.Add(skillDamageRowView);
		}
	}

	private void OnSegmentSelected(int segmentId)
	{
		selectedSegmentId = segmentId;
		RefreshRightPanel();
	}

	private void UpdateInfoPanel(int segmentId)
	{
		if (currentSnapshot == null)
		{
			return;
		}
		SegmentListItemSnapshot segmentListItemSnapshot = currentSnapshot.Segments.Find((SegmentListItemSnapshot s) => s.SegmentId == segmentId);
		if (segmentListItemSnapshot != null)
		{
			if (infoDurationText != null)
			{
				infoDurationText.text = CombatStatsFormatter.FormatDuration(segmentListItemSnapshot.Duration);
			}
			if (infoTotalDamageText != null)
			{
				infoTotalDamageText.text = CombatStatsFormatter.FormatDamage(segmentListItemSnapshot.TotalDamage);
			}
		}
	}

	private void ClearAll()
	{
		if (statsBootstrap != null && statsBootstrap.Service != null)
		{
			statsBootstrap.Service.Reset();
		}
		selectedSegmentId = 0;
		currentSnapshot = null;
		ClearAllSegmentItems();
		ClearAllDamageRows();
		ClearAllSkillRows();
		ClearInfoPanel();
	}

	private void ClearAllSegmentItems()
	{
		foreach (SegmentListItemView segmentItem in segmentItems)
		{
			if (segmentItem != null)
			{
				segmentItem.gameObject.SetActive(value: false);
			}
		}
	}

	private void ClearAllDamageRows()
	{
		foreach (DamageOverviewRowView damageRowItem in damageRowItems)
		{
			if (damageRowItem != null)
			{
				damageRowItem.gameObject.SetActive(value: false);
			}
		}
	}

	private void ClearAllSkillRows()
	{
		foreach (SkillDamageRowView skillRowItem in skillRowItems)
		{
			if (skillRowItem != null)
			{
				skillRowItem.gameObject.SetActive(value: false);
			}
		}
	}

	private void ClearInfoPanel()
	{
		if (infoDurationText != null)
		{
			infoDurationText.text = "--";
		}
		if (infoTotalDamageText != null)
		{
			infoTotalDamageText.text = "--";
		}
	}

	private void SetViewState(CombatOverviewViewType viewType)
	{
		if (damageViewRoot != null)
		{
			damageViewRoot.SetActive(viewType == CombatOverviewViewType.Damage);
		}
		if (skillViewRoot != null)
		{
			skillViewRoot.SetActive(viewType == CombatOverviewViewType.Skills);
		}
	}

	private void SyncViewToggleState()
	{
		if (damageToggle != null)
		{
			damageToggle.SetIsOnWithoutNotify(currentViewType == CombatOverviewViewType.Damage);
		}
		if (skillToggle != null)
		{
			skillToggle.SetIsOnWithoutNotify(currentViewType == CombatOverviewViewType.Skills);
		}
	}
}
