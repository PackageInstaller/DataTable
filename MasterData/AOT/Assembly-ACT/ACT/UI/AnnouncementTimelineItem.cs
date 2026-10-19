using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using ACT.EventTrack;
using ACT.UI.AOT;
using DG.Tweening;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.U2D;
using UnityEngine.UI;

namespace ACT.UI;

public class AnnouncementTimelineItem : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	[Header("Components")]
	[SerializeField]
	private Image background;

	[SerializeField]
	private TextMeshProUGUI text;

	[SerializeField]
	private CanvasGroup textContainer;

	[SerializeField]
	private AnnouncementTimelineJumpButton gotoButton;

	[SerializeField]
	private AnnouncementTimelineReward[] rewardIcons;

	[SerializeField]
	private RectTransform titleIconContainer;

	[SerializeField]
	private RectTransform cardPoolTitleIconBg;

	[SerializeField]
	private RectTransform actTitleIconBg;

	[SerializeField]
	private RectTransform resIconContainer;

	[Header("Resources")]
	[SerializeField]
	private Sprite bgActiveActivity;

	[SerializeField]
	private Sprite bgActiveCardPool;

	[SerializeField]
	private Sprite bgInactive;

	[SerializeField]
	private SpriteAtlas iconAtlas;

	[SerializeField]
	private TimelineItemTitleIcon titleIconTemplate;

	[Header("Text Color")]
	[SerializeField]
	private Color cardPoolTextColor;

	[SerializeField]
	private Color actTextColor;

	[SerializeField]
	private Color inActiveTextColor;

	[Header("Data")]
	[SerializeField]
	private float titleIconBgOffset;

	[SerializeField]
	private float textOffset;

	private DateTime StartDate { get; set; }

	private DateTime EndDate { get; set; }

	private List<AnnouncementTimelineWeek> Weeks { get; set; }

	private AnnouncementTimelineItemType Type { get; set; }

	private AnnouncementTimelineData DataContext { get; set; }

	private CancellationTokenSource CancellationTokenSource { get; set; }

	private RectTransform ClipContainer { get; set; }

	private List<TimelineItemTitleIcon> TitleIcons { get; set; }

	private void Start()
	{
		textContainer.alpha = 0f;
	}

	public void Cancel()
	{
		CancellationTokenSource.Cancel();
	}

	public async void Set(RectTransform container, List<AnnouncementTimelineWeek> weeks, DateTime startDate, DateTime endDate, AnnouncementTimelineItemType type, AnnouncementTimelineData data, float startDayOffset, float endDayOffset)
	{
		DataContext = data;
		ClipContainer = container;
		if (CancellationTokenSource != null)
		{
			CancellationTokenSource.Cancel();
			CancellationTokenSource.Dispose();
		}
		CancellationTokenSource = new CancellationTokenSource();
		Type = type;
		Weeks = weeks;
		StartDate = startDate;
		EndDate = endDate;
		FillData();
		SetWidth(startDayOffset, endDayOffset);
		FillIcon();
		await FetchIcons();
	}

	public void Jump()
	{
		ActivityCalendarJumpEvent evt = EventTrackSolver.Instance.GetEvt<ActivityCalendarJumpEvent>();
		evt.systemId = ((Type == AnnouncementTimelineItemType.Activity) ? 3001 : 1007);
		evt.jumpId = DataContext.SystemId;
		EventTrackSolver.Instance.Dispatch(evt);
		if (Type == AnnouncementTimelineItemType.Activity)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYCENTER, new ActivityCenterViewData
			{
				ActivityId = DataContext.SystemId
			});
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CARDDRAW, new CardDrawViewData
			{
				PoolId = DataContext.SystemId
			});
		}
	}

	private void SetWidth(float startOffset = 0f, float endOffset = 0f)
	{
		float width = ClipContainer.rect.width;
		int num = Weeks.Count * 7;
		float num2 = (float)(int)(DataContext.EndDateTime.Date - DataContext.StartDateTime.Date).TotalDays + (endOffset - startOffset);
		float num3 = width / (float)num;
		float x = ((float)(int)(DataContext.StartDateTime.Date - StartDate).TotalDays + startOffset) * num3;
		float x2 = num3 * num2;
		RectTransform component = GetComponent<RectTransform>();
		component.anchoredPosition = new Vector2(x, component.anchoredPosition.y);
		component.sizeDelta = new Vector2(x2, component.sizeDelta.y);
	}

	private void FillData()
	{
		AnnouncementTimelineReward[] array = rewardIcons;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].gameObject.SetActive(value: false);
		}
		if (DataContext.SystemId == 0)
		{
			gotoButton.gameObject.SetActive(value: false);
		}
		else
		{
			gotoButton.gameObject.SetActive(value: true);
		}
		if (DateTime.Now > DataContext.EndDateTime)
		{
			background.sprite = bgInactive;
			text.color = inActiveTextColor;
			gotoButton.SetType(Type, locked: true, setGray: true);
		}
		else if (DateTime.Now < DataContext.StartDateTime)
		{
			gotoButton.SetType(Type, locked: true, setGray: false);
			if (Type == AnnouncementTimelineItemType.Activity)
			{
				text.color = actTextColor;
				background.sprite = bgActiveActivity;
			}
			else
			{
				text.color = cardPoolTextColor;
				background.sprite = bgActiveCardPool;
			}
		}
		else
		{
			gotoButton.SetType(Type, locked: false, setGray: false);
			if (Type == AnnouncementTimelineItemType.Activity)
			{
				if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity))
				{
					gotoButton.SetType(Type, locked: true, setGray: false);
				}
				text.color = actTextColor;
				background.sprite = bgActiveActivity;
			}
			else
			{
				if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.DrawCard))
				{
					gotoButton.SetType(Type, locked: true, setGray: false);
				}
				text.color = cardPoolTextColor;
				background.sprite = bgActiveCardPool;
			}
		}
		text.SetText(DataContext.Name);
	}

	private async void FillIcon()
	{
		if (CancellationTokenSource.IsCancellationRequested)
		{
			return;
		}
		TitleIcons = new List<TimelineItemTitleIcon>();
		if (Type == AnnouncementTimelineItemType.Activity)
		{
			actTitleIconBg.gameObject.SetActive(value: true);
			cardPoolTitleIconBg.gameObject.SetActive(value: false);
			if (DataContext is AnnouncementTimelineActivityData announcementTimelineActivityData)
			{
				Sprite sprite = iconAtlas.GetSprite(announcementTimelineActivityData.ActivityTypeIcon);
				if ((object)sprite != null)
				{
					TimelineItemTitleIcon timelineItemTitleIcon = UnityEngine.Object.Instantiate(titleIconTemplate, titleIconContainer);
					timelineItemTitleIcon.SetSprite(sprite);
					timelineItemTitleIcon.SetCardPoolStyle(visible: false);
					TitleIcons.Add(timelineItemTitleIcon);
				}
			}
			for (int i = 0; i < DataContext.IconUrl.Length && i < DataContext.IconUrl.Length; i++)
			{
				rewardIcons[i].gameObject.SetActive(value: true);
			}
			Canvas.ForceUpdateCanvases();
			text.rectTransform.sizeDelta = new Vector2(resIconContainer.localPosition.x - text.rectTransform.localPosition.x - resIconContainer.sizeDelta.x, resIconContainer.sizeDelta.y);
			Canvas.ForceUpdateCanvases();
			if (text.textInfo.lineCount > 1)
			{
				text.fontSize = 20f;
			}
			textContainer.DOFade(1f, 0.2f);
		}
		else
		{
			actTitleIconBg.gameObject.SetActive(value: false);
			cardPoolTitleIconBg.gameObject.SetActive(value: true);
			for (int j = 0; j < DataContext.IconUrl.Length; j++)
			{
				TimelineItemTitleIcon timelineItemTitleIcon2 = UnityEngine.Object.Instantiate(titleIconTemplate, titleIconContainer);
				timelineItemTitleIcon2.SetCardPoolStyle(visible: true);
				TitleIcons.Add(timelineItemTitleIcon2);
			}
			textContainer.DOFade(1f, 0.2f);
		}
		if (TitleIcons.Count > 0)
		{
			TimelineItemTitleIcon timelineItemTitleIcon3 = TitleIcons.Last();
			cardPoolTitleIconBg.anchoredPosition = new Vector2(timelineItemTitleIcon3.rectTransform.anchoredPosition.x + timelineItemTitleIcon3.rectTransform.rect.width * (float)TitleIcons.Count + titleIconBgOffset, cardPoolTitleIconBg.anchoredPosition.y);
			text.rectTransform.anchoredPosition = new Vector2(timelineItemTitleIcon3.rectTransform.anchoredPosition.x + timelineItemTitleIcon3.rectTransform.rect.width * (float)TitleIcons.Count + textOffset, text.rectTransform.anchoredPosition.y);
		}
	}

	private async Task FetchIcons()
	{
		List<(string quality, Texture2D tex)> list = new List<(string, Texture2D)>();
		for (int i = 0; i < DataContext.IconUrl.Length; i++)
		{
			string url = DataContext.IconUrl[i];
			string quality = string.Empty;
			if (DataContext.ItemQuality != null)
			{
				quality = DataContext.ItemQuality[i];
			}
			byte[] array = await AnnouncementCache.CacheImage(url, CancellationTokenSource.Token);
			if (array != null)
			{
				Texture2D texture2D = new Texture2D(108, 108)
				{
					wrapMode = TextureWrapMode.Clamp
				};
				texture2D.LoadImage(array);
				list.Add((quality, texture2D));
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			(string, Texture2D) tuple = list[j];
			if (Type == AnnouncementTimelineItemType.Activity)
			{
				rewardIcons[j].Set(tuple.Item2, (!string.Equals(tuple.Item1, "S", StringComparison.OrdinalIgnoreCase)) ? 1 : 0);
				rewardIcons[j].CanvasGroup.DOFade(1f, 0.2f);
			}
			else
			{
				TitleIcons[j].SetImage(tuple.Item2);
			}
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		gotoButton.Click();
	}
}
