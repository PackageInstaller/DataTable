using System;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class AnnouncementTimelinePointer : MonoBehaviour
{
	[Header("Components")]
	[SerializeField]
	private RectTransform date;

	[SerializeField]
	private TextMeshProUGUI label;

	[SerializeField]
	private RectTransform pointer;

	[SerializeField]
	private RectTransform container;

	[SerializeField]
	private float maxOverflow;

	private Dictionary<DayOfWeek, string> DayOfWeek = new Dictionary<DayOfWeek, string>
	{
		{
			System.DayOfWeek.Monday,
			"星期一"
		},
		{
			System.DayOfWeek.Tuesday,
			"星期二"
		},
		{
			System.DayOfWeek.Wednesday,
			"星期三"
		},
		{
			System.DayOfWeek.Thursday,
			"星期四"
		},
		{
			System.DayOfWeek.Friday,
			"星期五"
		},
		{
			System.DayOfWeek.Saturday,
			"星期六"
		},
		{
			System.DayOfWeek.Sunday,
			"星期日"
		}
	};

	public void Set(List<AnnouncementTimelineWeek> weeks, DateTime startTime, DateTime endTime)
	{
		float width = container.rect.width;
		int num = weeks.Count * 7;
		float num2 = width / (float)num;
		int num3 = (int)(DateTime.Now.Date - startTime).TotalDays;
		pointer.anchoredPosition = new Vector2((float)num3 * num2, pointer.anchoredPosition.y);
		date.anchoredPosition = new Vector2((float)num3 * num2, date.anchoredPosition.y);
		if (date.anchoredPosition.x - date.sizeDelta.x / 2f < 0f - maxOverflow)
		{
			date.anchoredPosition = new Vector2(date.sizeDelta.x / 2f - maxOverflow, date.anchoredPosition.y);
		}
		else if (date.anchoredPosition.x + date.sizeDelta.x / 2f > width + maxOverflow)
		{
			date.anchoredPosition = new Vector2(width + maxOverflow - date.sizeDelta.x / 2f, date.anchoredPosition.y);
		}
		DateTime now = DateTime.Now;
		label.text = $"今天 {now:MM/dd} {DayOfWeek[now.DayOfWeek]}";
	}
}
