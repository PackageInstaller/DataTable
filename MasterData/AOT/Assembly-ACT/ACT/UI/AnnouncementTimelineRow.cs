using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UnityEngine;

namespace ACT.UI;

public class AnnouncementTimelineRow : MonoBehaviour
{
	[SerializeField]
	private AnnouncementTimelineItem itemTemplate;

	private List<AnnouncementTimelineItem> items = new List<AnnouncementTimelineItem>();

	public AnnouncementTimelineItem GetItem(int index)
	{
		if (items.Count == 0 || index < 0 || index >= items.Count)
		{
			return null;
		}
		return items[index];
	}

	public async Task Set(RectTransform container, List<AnnouncementTimelineWeek> weeks, DateTime startDate, DateTime endDate, List<AnnouncementTimelineData> data)
	{
		List<AnnouncementTimelineData> list = data.OrderBy((AnnouncementTimelineData announcementTimelineData) => announcementTimelineData.StartTime).ToList();
		for (int num = 0; num < list.Count; num++)
		{
			AnnouncementTimelineData d = list[num];
			AnnouncementTimelineItem announcementTimelineItem = UnityEngine.Object.Instantiate(itemTemplate, transform);
			AnnouncementTimelineItemType announcementTimelineItemType = ((!(d is AnnouncementTimelineActivityData) && d is AnnouncementTimelineCardPoolData) ? AnnouncementTimelineItemType.CardPool : AnnouncementTimelineItemType.Activity);
			AnnouncementTimelineItemType announcementTimelineItemType2 = announcementTimelineItemType;
			float num2 = 0f;
			float num3 = 0f;
			if (announcementTimelineItemType2 == AnnouncementTimelineItemType.CardPool)
			{
				if (list.FirstOrDefault((AnnouncementTimelineData o) => o.EndDateTime.Date == d.StartDateTime.Date) != null)
				{
					num2 += 0.5f;
				}
				if (list.FirstOrDefault((AnnouncementTimelineData o) => o.StartDateTime.Date == d.EndDateTime.Date) != null)
				{
					num3 += 0.5f;
				}
				if (num == list.Count - 1)
				{
					num3 = 1f;
				}
			}
			announcementTimelineItem.Set(container, weeks, startDate, endDate, announcementTimelineItemType2, d, num2, num3);
			items.Add(announcementTimelineItem);
		}
	}

	public void Cancel()
	{
		foreach (AnnouncementTimelineItem item in items)
		{
			item.Cancel();
		}
	}
}
