using System;
using CombatStats.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace CombatStats.UI;

public sealed class SegmentListItemView : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI labelText;

	[SerializeField]
	private Toggle toggle;

	private int segmentId;

	private Action<int> onSelected;

	public int SegmentId => segmentId;

	private void Awake()
	{
		if (toggle != null)
		{
			toggle.onValueChanged.AddListener(OnToggleChanged);
		}
	}

	private void OnDestroy()
	{
		if (toggle != null)
		{
			toggle.onValueChanged.RemoveListener(OnToggleChanged);
		}
	}

	public void Bind(SegmentListItemSnapshot snapshot, Action<int> onSegmentSelected)
	{
		segmentId = snapshot.SegmentId;
		onSelected = onSegmentSelected;
		if (labelText != null)
		{
			labelText.text = $"{snapshot.SegmentId + 1} {snapshot.SegmentType}, {FormatDuration(snapshot.Duration)}";
		}
	}

	private static string FormatDuration(float seconds)
	{
		int num = (int)seconds;
		if (num < 60)
		{
			return $"{num}s";
		}
		int num2 = num / 60;
		int num3 = num % 60;
		return $"{num2}:{num3:D2}";
	}

	public void SetToggleGroup(ToggleGroup group)
	{
		if (toggle != null && group != null)
		{
			toggle.group = group;
		}
	}

	public void SetSelected(bool selected)
	{
		if (toggle != null)
		{
			toggle.isOn = selected;
		}
	}

	private void OnToggleChanged(bool isOn)
	{
		if (isOn && onSelected != null)
		{
			onSelected(segmentId);
		}
	}
}
