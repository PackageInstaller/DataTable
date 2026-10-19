using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ACT.UI;

public class AnnouncementTimeRuler : MonoBehaviour
{
	[SerializeField]
	private RectTransform itemTemplate;

	[SerializeField]
	private RectTransform container;

	[SerializeField]
	private float itemWidth = 12f;

	private List<RectTransform> Objects { get; set; } = new List<RectTransform>();

	public void Set(List<AnnouncementTimelineWeek> weeks)
	{
		float width = container.rect.width;
		int num = weeks.Sum((AnnouncementTimelineWeek w) => 7);
		float width2 = width / (float)num;
		Gen(width2, num);
	}

	private void Gen(float width, int steps)
	{
		for (int i = 0; i < steps; i++)
		{
			RectTransform rectTransform = Object.Instantiate(itemTemplate, container);
			rectTransform.sizeDelta = new Vector2(itemWidth, rectTransform.sizeDelta.y);
			rectTransform.anchoredPosition = new Vector3(width * (float)i, 0f);
			Objects.Add(rectTransform);
		}
	}

	public void Clear()
	{
		foreach (RectTransform @object in Objects)
		{
			Object.Destroy(@object.gameObject);
		}
		Objects.Clear();
	}
}
