using System.Collections.Generic;
using ACT.UI;
using CombatStats.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace CombatStats.UI;

public sealed class CombatFloatingWindow : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler
{
	[SerializeField]
	private RectTransform windowRect;

	[SerializeField]
	private GameObject expandedRoot;

	[SerializeField]
	private GameObject collapsedRoot;

	[SerializeField]
	private ActButton collapseButton;

	[SerializeField]
	private ActButton expandButton;

	[SerializeField]
	private ActButton openOverviewButton;

	[SerializeField]
	private ActButton newRunButton;

	[SerializeField]
	private TextMeshProUGUI newRunButtonText;

	[SerializeField]
	private FloatingCharacterRowView rowPrefab;

	[SerializeField]
	private Transform rowContainer;

	[SerializeField]
	private CombatStatsBootstrap statsBootstrap;

	[SerializeField]
	private CombatOverviewWindow overviewWindow;

	[SerializeField]
	private TextMeshProUGUI timeText;

	[SerializeField]
	private TextMeshProUGUI totalDamageText;

	private readonly List<FloatingCharacterRowView> rows = new List<FloatingCharacterRowView>();

	private bool isCollapsed;

	private float nextUpdateTime;

	private Vector2 dragOffset;

	private void Awake()
	{
		if (collapseButton != null)
		{
			collapseButton.OnClick.AddListener(Collapse);
		}
		if (expandButton != null)
		{
			expandButton.OnClick.AddListener(Expand);
		}
		if (openOverviewButton != null)
		{
			openOverviewButton.OnClick.AddListener(OpenOverview);
		}
		if (newRunButton != null)
		{
			newRunButton.OnClick.AddListener(OnNewRunButtonClicked);
		}
		RefreshState();
	}

	private void Update()
	{
		if (statsBootstrap != null && statsBootstrap.Service != null && Time.unscaledTime >= nextUpdateTime)
		{
			UpdateFloatingWindow();
		}
	}

	private void UpdateFloatingWindow()
	{
		if (statsBootstrap != null && statsBootstrap.Service != null)
		{
			CombatFloatingSnapshot combatFloatingSnapshot = statsBootstrap.Service.BuildFloatingSnapshot(isCollapsed);
			Bind(combatFloatingSnapshot);
			float num = (float)Mathf.FloorToInt(combatFloatingSnapshot.Duration / 0.5f) * 0.5f + 0.5f - combatFloatingSnapshot.Duration;
			nextUpdateTime = Time.unscaledTime + num;
		}
	}

	public void Bind(CombatFloatingSnapshot snapshot)
	{
		if (snapshot == null)
		{
			return;
		}
		isCollapsed = snapshot.IsCollapsed;
		RefreshState();
		UpdateNewRunButtonState(snapshot.HasActiveSegment);
		if (timeText != null)
		{
			SetDurationText(snapshot.Duration);
		}
		if (totalDamageText != null)
		{
			SetDamageText(snapshot.TotalDamage);
		}
		EnsureRowCount(snapshot.TopCharacters.Count);
		for (int i = 0; i < rows.Count; i++)
		{
			FloatingCharacterRowView floatingCharacterRowView = rows[i];
			bool flag = i < snapshot.TopCharacters.Count;
			floatingCharacterRowView.gameObject.SetActive(flag);
			if (flag)
			{
				floatingCharacterRowView.Bind(snapshot.TopCharacters[i]);
			}
		}
	}

	private void EnsureRowCount(int requiredCount)
	{
		while (rows.Count < requiredCount && !(rowPrefab == null) && !(rowContainer == null))
		{
			FloatingCharacterRowView floatingCharacterRowView = Object.Instantiate(rowPrefab, rowContainer);
			floatingCharacterRowView.gameObject.SetActive(value: true);
			rows.Add(floatingCharacterRowView);
		}
	}

	private void UpdateNewRunButtonState(bool isRunning)
	{
		if (newRunButtonText != null)
		{
			newRunButtonText.SetText(isRunning ? "End" : "New Run");
		}
	}

	private void SetDurationText(float duration)
	{
		int num = Mathf.RoundToInt(duration * 10f);
		if (duration >= 60f)
		{
			int num2 = num / 600;
			int num3 = num % 600;
			timeText.SetText("{0}:{1:00}.{2}", num2, num3 / 10, num3 % 10);
		}
		else
		{
			timeText.SetText("{0}.{1}s", num / 10, num % 10);
		}
	}

	private void SetDamageText(long damage)
	{
		if (damage >= 1000000)
		{
			totalDamageText.SetText("{0:0.00}M", (float)damage / 1000000f);
		}
		else if (damage >= 1000)
		{
			totalDamageText.SetText("{0:0.00}K", (float)damage / 1000f);
		}
		else
		{
			totalDamageText.SetText("{0}", damage);
		}
	}

	private void OnNewRunButtonClicked()
	{
		if (statsBootstrap != null && statsBootstrap.Service != null)
		{
			if (statsBootstrap.Service.BuildFloatingSnapshot(isCollapsed).HasActiveSegment)
			{
				statsBootstrap.NotifySegmentEnded(SegmentEndReason.Manual);
			}
			else
			{
				statsBootstrap.StartNewSegment();
			}
		}
	}

	public void Collapse()
	{
		isCollapsed = true;
		RefreshState();
	}

	public void Expand()
	{
		isCollapsed = false;
		RefreshState();
	}

	public void OpenOverview()
	{
		if (overviewWindow != null)
		{
			overviewWindow.Open();
		}
	}

	private void RefreshState()
	{
		if (expandedRoot != null)
		{
			expandedRoot.SetActive(!isCollapsed);
		}
		if (collapsedRoot != null)
		{
			collapsedRoot.SetActive(isCollapsed);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!(windowRect == null))
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(windowRect.parent as RectTransform, eventData.position, eventData.pressEventCamera, out var localPoint);
			dragOffset = windowRect.anchoredPosition - localPoint;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!(windowRect == null) && RectTransformUtility.ScreenPointToLocalPointInRectangle(windowRect.parent as RectTransform, eventData.position, eventData.pressEventCamera, out var localPoint))
		{
			Vector2 anchoredPosition = localPoint + dragOffset;
			windowRect.anchoredPosition = anchoredPosition;
		}
	}
}
