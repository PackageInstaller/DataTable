using System;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class AnnouncementWeekTabItem : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI weekName;

	[SerializeField]
	private TextMeshProUGUI dateText;

	[Header("Text Color")]
	[SerializeField]
	private Color activeTextColor;

	[SerializeField]
	private Color inActiveTextColor;

	private AnnouncementTimelineWeek DataContext { get; set; }

	private string GetChineseNumber(int number)
	{
		if (number < 0 || number > 10)
		{
			return number.ToString();
		}
		return (new string[11]
		{
			"零", "一", "二", "三", "四", "五", "六", "七", "八", "九",
			"十"
		})[number];
	}

	public void Set(AnnouncementTimelineWeek data)
	{
		DataContext = data;
		weekName.SetText("第" + GetChineseNumber(DataContext.Index) + "周");
		dateText.SetText($"{DataContext.StartDate:MM/dd}-{DataContext.EndDate:MM/dd}");
		if (DataContext.StartDate <= DateTime.Now && DataContext.EndDate.AddDays(1.0) > DateTime.Now)
		{
			weekName.color = activeTextColor;
			dateText.color = activeTextColor;
		}
		else
		{
			weekName.color = inActiveTextColor;
			dateText.color = inActiveTextColor;
		}
	}
}
