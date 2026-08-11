using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CampaignTimelineViewModel : OptionBase
{
	private List<CampaignTimelineItemData> timelineDataList;

	private InteractionRequest refreshDataRequest;

	public List<CampaignTimelineItemData> TimelineDataList => timelineDataList;

	public InteractionRequest RefreshDataRequest => refreshDataRequest;

	public CampaignTimelineViewModel()
	{
	}

	public CampaignTimelineViewModel(OptionBase parent, List<int> campaignIds)
	{
		base.parent = parent;
		refreshDataRequest = new InteractionRequest();
		InitData(campaignIds);
	}

	private void InitData(List<int> campaignIds)
	{
		timelineDataList = new List<CampaignTimelineItemData>();
		bool flag = false;
		if (campaignIds != null && campaignIds.Count >= 0)
		{
			for (int i = 0; i < campaignIds.Count; i++)
			{
				DRCampaign dataRow = GameEntry.DataTable.GetDataRow<DRCampaign>(campaignIds[i]);
				if (dataRow.NodeSeat == 2)
				{
					flag = true;
				}
				if (dataRow.NodeType == 1)
				{
					CampaignTimelineItemData item = new CampaignTimelineItemData(this, dataRow);
					timelineDataList.Add(item);
				}
			}
		}
		if (!flag)
		{
			CampaignTimelineItemData campaignTimelineItemData = new CampaignTimelineItemData(this, null);
			campaignTimelineItemData.IsLock = true;
			timelineDataList.Add(campaignTimelineItemData);
		}
		bool flag2 = true;
		foreach (CampaignTimelineItemData timelineData in TimelineDataList)
		{
			timelineData.UpDown = flag2;
			flag2 = !flag2;
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg { Obj: CampaignTimelineItemData obj2 } optionArg && "Open".Equals(optionArg.OptionName))
		{
			PlayStory(obj2);
		}
	}

	private async void PlayStory(CampaignTimelineItemData campaignTimelineItemData)
	{
		if (campaignTimelineItemData?.TimelineIds == null)
		{
			return;
		}
		foreach (int timelineId in campaignTimelineItemData.TimelineIds)
		{
			if (!(await Singleton<Story>.Instance.PlayStory(0u, timelineId)))
			{
				break;
			}
		}
	}
}
