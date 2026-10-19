using System;
using System.Threading.Tasks;
using UnityEngine;

namespace ACT.UI.AOT;

public class AnnouncementView : MonoBehaviour
{
	public AnnouncementSubPanel AnnouncementPanel;

	public AnnouncementSubPanel TimelinePanel;

	public Animator animator;

	private bool isHCLR;

	public Action OnCloseButtonClicked;

	public bool IsHCLR
	{
		get
		{
			return isHCLR;
		}
		set
		{
			if ((bool)AnnouncementPanel)
			{
				AnnouncementPanel.IsHCLR = value;
			}
			if ((bool)TimelinePanel)
			{
				TimelinePanel.IsHCLR = value;
			}
			isHCLR = value;
		}
	}

	private AnnouncementSubPanel CurrentSubPanel { get; set; }

	public void SwitchToAnnouncementPanel()
	{
		AnnouncementPanel?.gameObject.SetActive(value: true);
		TimelinePanel?.gameObject.SetActive(value: false);
		CurrentSubPanel = AnnouncementPanel;
	}

	public void SwitchToTimelinePanel()
	{
		TimelinePanel?.gameObject.SetActive(value: true);
		AnnouncementPanel?.gameObject.SetActive(value: false);
		CurrentSubPanel = TimelinePanel;
	}

	public void Init()
	{
	}

	public void CloseButtonClicked()
	{
		OnCloseButtonClicked?.Invoke();
		CurrentSubPanel?.ReportOnClose();
	}

	public async Task Clear()
	{
		await CurrentSubPanel.Clear();
	}

	public async Task Refresh()
	{
		await CurrentSubPanel.Refresh();
	}

	public void ReportOpen()
	{
		CurrentSubPanel?.ReportOnOpen();
	}
}
