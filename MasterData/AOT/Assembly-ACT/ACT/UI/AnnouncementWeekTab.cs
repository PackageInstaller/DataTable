using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

public class AnnouncementWeekTab : MonoBehaviour
{
	[SerializeField]
	private AnnouncementWeekTabItem itemTemplate;

	[SerializeField]
	private RectTransform container;

	private List<AnnouncementTimelineWeek> Data { get; set; }

	private List<AnnouncementWeekTabItem> Objects { get; set; } = new List<AnnouncementWeekTabItem>();

	public void Set(List<AnnouncementTimelineWeek> weeks)
	{
		Data = weeks;
		float width = container.rect.width / (float)weeks.Count;
		Gen(width);
	}

	private void Gen(float width)
	{
		for (int i = 0; i < Data.Count; i++)
		{
			AnnouncementWeekTabItem announcementWeekTabItem = Object.Instantiate(itemTemplate, container);
			RectTransform component = announcementWeekTabItem.GetComponent<RectTransform>();
			component.sizeDelta = new Vector2(width, component.sizeDelta.y);
			component.anchoredPosition = new Vector2(width * (float)i, 0f);
			announcementWeekTabItem.Set(Data[i]);
			Objects.Add(announcementWeekTabItem);
		}
	}

	public void Clear()
	{
		foreach (AnnouncementWeekTabItem @object in Objects)
		{
			Object.Destroy(@object.gameObject);
		}
		Objects.Clear();
	}
}
