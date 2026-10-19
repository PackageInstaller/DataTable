using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using bamboosdk;

namespace ACT.UI.AOT;

public class AnnouncementContentView : AnnouncementSubPanel
{
	public AnnouncementItem Template;

	public TextMeshProUGUI TextTitle;

	public RectTransform ContentBg;

	public RectTransform ContentContainer;

	public AnnouncementContentText TextTemplate;

	public AnnouncementContentImage ImageTemplate;

	public RectTransform HintNoContent;

	public ScrollRect ContentScrollRect;

	public ScrollRect TitleListScrollRect;

	public RectTransform TitleListScrollContainer;

	public CanvasGroup ContentCanvas;

	public VerticalLayoutGroup ContentLayout;

	public VerticalLayoutGroup ListLayout;

	public float FadeInTime = 0.5f;

	private List<GameObject> items = new List<GameObject>();

	private Tweener contentTweener;

	public override bool IsHCLR { get; set; }

	public int Category { get; set; } = 3;

	public AnnouncementList Announcements { get; private set; }

	public List<AnnouncementItem> AnnouncementComponents { get; private set; } = new List<AnnouncementItem>();

	public AnnouncementData CurrentAnnouncementData { get; private set; }

	public CancellationTokenSource CancellationTokenSource { get; private set; }

	private float ContainerWidth => ContentContainer.rect.width;

	public event Action OnAnnouncementClicked;

	private void OnAnnouncementItemClicked()
	{
		OnAnnouncementClicked?.Invoke();
	}

	public override async Task Refresh()
	{
		await LoadContent();
	}

	private void ClearContent()
	{
		CancelImageLoading();
		items.ForEach(UnityEngine.Object.Destroy);
		items.Clear();
	}

	private void CancelImageLoading()
	{
		if (CancellationTokenSource != null)
		{
			CancellationTokenSource.Cancel();
			CancellationTokenSource.Dispose();
			CancellationTokenSource = null;
		}
	}

	private void OnDestroy()
	{
		CancelImageLoading();
	}

	public override Task Clear()
	{
		ClearContent();
		CurrentAnnouncementData = null;
		ContentBg.gameObject.SetActive(value: false);
		HintNoContent.gameObject.SetActive(value: false);
		TextTitle.text = string.Empty;
		foreach (AnnouncementItem announcementComponent in AnnouncementComponents)
		{
			UnityEngine.Object.Destroy(announcementComponent.gameObject);
		}
		AnnouncementComponents.Clear();
		return Task.CompletedTask;
	}

	public override void ReportOnClose()
	{
		if (gameObject.activeSelf)
		{
			JObject jObject = new JObject
			{
				["type"] = (IsHCLR ? 1 : 2),
				["status"] = 2,
				["announcement_type"] = ((Category == 3) ? 1 : 2),
				["announcement_id"] = CurrentAnnouncementData?.Id ?? 0
			};
			BamBooSdk.getInstance().taEvent("announcement_event", jObject.ToString());
		}
	}

	public override void ReportOnOpen()
	{
	}

	private async Task LoadContent()
	{
		await Clear();
		await FetchData();
		UpdateUIElements();
	}

	private async Task FetchData()
	{
		Announcements = await LuminApplication.GmApi.GetAnnouncements(IsHCLR ? 1 : 2, Category);
		if (Announcements == null)
		{
			Announcements = new AnnouncementList();
		}
	}

	private void UpdateUIElements()
	{
		foreach (AnnouncementData item in Announcements.List)
		{
			AnnouncementItem announcementItem = UnityEngine.Object.Instantiate(Template, TitleListScrollContainer);
			announcementItem.transform.localPosition = Vector3.zero;
			announcementItem.transform.localScale = Vector3.one;
			announcementItem.Set(item, ShowAnnouncement);
			announcementItem.OnClicked += OnAnnouncementItemClicked;
			AnnouncementComponents.Add(announcementItem);
		}
		if (AnnouncementComponents.Count < 1)
		{
			HintNoContent.gameObject.SetActive(value: true);
			ContentBg.gameObject.SetActive(value: false);
		}
		else
		{
			HintNoContent.gameObject.SetActive(value: false);
			ContentBg.gameObject.SetActive(value: true);
			TitleListScrollRect.normalizedPosition = Vector2.zero;
		}
		if (Announcements.List.Count >= 1)
		{
			ShowAnnouncement(Announcements.List.First());
		}
		Canvas.ForceUpdateCanvases();
		ListLayout.enabled = false;
		ListLayout.enabled = true;
	}

	private async Task UpdateCanvas()
	{
		Canvas.ForceUpdateCanvases();
		ContentLayout.enabled = false;
		ContentLayout.enabled = true;
		await UniTask.Yield(PlayerLoopTiming.LastUpdate);
		ContentScrollRect.normalizedPosition = Vector2.one;
	}

	private async void ShowAnnouncement(AnnouncementData announcement)
	{
		contentTweener.Kill();
		ContentCanvas.alpha = 0f;
		ClearContent();
		CancellationTokenSource = new CancellationTokenSource();
		CurrentAnnouncementData = announcement;
		JObject jObject = new JObject
		{
			["announcement_id"] = announcement.Id,
			["announcement_type"] = ((Category == 3) ? 1 : 2),
			["type"] = (IsHCLR ? 1 : 2),
			["status"] = 1
		};
		BamBooSdk.getInstance().taEvent("announcement_event", jObject.ToString());
		foreach (AnnouncementItem announcementComponent in AnnouncementComponents)
		{
			if (announcementComponent.DataContext.Id == announcement.Id)
			{
				announcementComponent.SetSelected(isSelected: true);
			}
			else
			{
				announcementComponent.SetSelected(isSelected: false);
			}
		}
		await GenElements(announcement);
		contentTweener = ContentCanvas.DOFade(1f, FadeInTime);
	}

	private async UniTask GenElements(AnnouncementData announcement)
	{
		TextTitle.text = announcement.Title;
		List<AnnouncementTextSegment> list = ContentSegmentUtilities.ParseText(announcement.Content);
		if (!string.IsNullOrWhiteSpace(announcement.PicUrl))
		{
			AnnouncementTextSegment item = new AnnouncementTextSegment
			{
				Height = 456,
				Width = 1824,
				Text = string.Empty,
				IsImage = true,
				Url = announcement.PicUrl
			};
			list.Insert(0, item);
		}
		foreach (AnnouncementTextSegment item2 in list)
		{
			if (item2.IsImage)
			{
				AnnouncementContentImage announcementContentImage = UnityEngine.Object.Instantiate(ImageTemplate, ContentContainer);
				announcementContentImage.transform.SetAsLastSibling();
				announcementContentImage.Set(ContainerWidth, item2, CancellationTokenSource);
				items.Add(announcementContentImage.gameObject);
			}
			else
			{
				AnnouncementContentText announcementContentText = UnityEngine.Object.Instantiate(TextTemplate, ContentContainer);
				announcementContentText.transform.SetAsLastSibling();
				announcementContentText.Set(item2);
				items.Add(announcementContentText.gameObject);
			}
		}
		await UpdateCanvas();
	}
}
