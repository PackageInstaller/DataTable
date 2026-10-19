using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ACT.UI.AOT;
using ACT.UI.InputController;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.UI;
using bamboosdk;

namespace ACT.UI;

public class AnnouncementTimeline : AnnouncementSubPanel
{
	[SerializeField]
	private AnnouncementTimelineRow itemTemplate;

	[SerializeField]
	private RectTransform itemContainer;

	[SerializeField]
	private AnnouncementWeekTab weekTab;

	[SerializeField]
	private AnnouncementTimeRuler ruler;

	[SerializeField]
	private AnnouncementTimelinePointer pointer;

	[SerializeField]
	private RectTransform mainContainer;

	[SerializeField]
	private RectTransform hintNoContent;

	[SerializeField]
	public ScrollRect scrollRect;

	private DateTime startDate;

	private DateTime endDate;

	private List<AnnouncementTimelineActivityData> activityData = new List<AnnouncementTimelineActivityData>();

	private List<AnnouncementTimelineCardPoolData> cardPoolData = new List<AnnouncementTimelineCardPoolData>();

	private List<AnnouncementTimelineWeek> weeks = new List<AnnouncementTimelineWeek>();

	private List<AnnouncementTimelineRow> rows = new List<AnnouncementTimelineRow>();

	public override bool IsHCLR { get; set; }

	private AnnouncementData DataContext { get; set; }

	public async Task Set(DateTime start, DateTime end, AnnouncementData data)
	{
		DataContext = data;
		startDate = start.Date;
		endDate = end.Date;
		activityData = data.ActivityConfig;
		cardPoolData = data.CardPoolConfig;
		weeks = CutDate();
		BuildWeekUI();
		await GenRows();
	}

	private void BuildWeekUI()
	{
		Debug.Log(JsonConvert.SerializeObject(weeks));
		weekTab.Set(weeks);
		ruler.Set(weeks);
		pointer.Set(weeks, startDate, endDate);
	}

	private async Task GenRows()
	{
		foreach (AnnouncementTimelineCardPoolData cardPoolDatum in cardPoolData)
		{
			await CreateRow(new List<AnnouncementTimelineData> { cardPoolDatum });
		}
		foreach (AnnouncementTimelineActivityData activityDatum in activityData)
		{
			await CreateRow(new List<AnnouncementTimelineData> { activityDatum });
		}
		if (rows.Count > 0)
		{
			EventSystemHelper.SetSelectedGameObject(rows.First().GetItem(0).gameObject);
		}
	}

	private async Task CreateRow(List<AnnouncementTimelineData> data)
	{
		AnnouncementTimelineRow row = UnityEngine.Object.Instantiate(itemTemplate, itemContainer.transform);
		await row.Set(itemContainer, weeks, startDate, endDate, data);
		rows.Add(row);
	}

	private List<AnnouncementTimelineWeek> CutDate()
	{
		List<AnnouncementTimelineWeek> list = new List<AnnouncementTimelineWeek>();
		DateTime dateTime = startDate.Date;
		DateTime date = endDate.Date;
		int num = 1;
		while (dateTime <= date)
		{
			DateTime dateTime2 = dateTime.AddDays(6.0);
			if (dateTime2 > date)
			{
				dateTime2 = date;
			}
			int dayCount = (int)(dateTime2 - dateTime).TotalDays + 1;
			list.Add(new AnnouncementTimelineWeek
			{
				Index = num,
				StartDate = dateTime,
				EndDate = dateTime2,
				DayCount = dayCount
			});
			dateTime = dateTime2.AddDays(1.0);
			num++;
		}
		return list;
	}

	public override async Task Refresh()
	{
		AnnouncementList announcementList = await LuminApplication.GmApi.GetAnnouncements(IsHCLR ? 1 : 2, 5);
		AnnouncementData announcementData = announcementList.List.FirstOrDefault((AnnouncementData d) => d.IsOpen == 1);
		if (announcementData != null)
		{
			AnnouncementRedDot.RecordTimelineId(announcementData.Id.ToString());
			hintNoContent.gameObject.SetActive(value: false);
			mainContainer.gameObject.SetActive(value: true);
			await Set(announcementData.StartDateTime, announcementData.EndDateTime, announcementList.List.FirstOrDefault());
		}
		else
		{
			AnnouncementRedDot.RecordTimelineId(string.Empty);
			hintNoContent.gameObject.SetActive(value: true);
			mainContainer.gameObject.SetActive(value: false);
		}
	}

	public override Task Clear()
	{
		ruler.Clear();
		weekTab.Clear();
		foreach (AnnouncementTimelineRow row in rows)
		{
			row.Cancel();
			UnityEngine.Object.Destroy(row.gameObject);
		}
		rows.Clear();
		return Task.CompletedTask;
	}

	public override void ReportOnClose()
	{
		if (DataContext != null && gameObject.activeSelf)
		{
			JObject jObject = new JObject
			{
				["type"] = (IsHCLR ? 1 : 2),
				["status"] = 2,
				["announcement_type"] = 3,
				["announcement_id"] = DataContext.Id
			};
			BamBooSdk.getInstance().taEvent("announcement_event", jObject.ToString());
		}
	}

	public override void ReportOnOpen()
	{
		if (DataContext != null)
		{
			JObject jObject = new JObject
			{
				["announcement_id"] = DataContext.Id,
				["announcement_type"] = 3,
				["type"] = (IsHCLR ? 1 : 2),
				["status"] = 1
			};
			BamBooSdk.getInstance().taEvent("announcement_event", jObject.ToString());
		}
	}
}
