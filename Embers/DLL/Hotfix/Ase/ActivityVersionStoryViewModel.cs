#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ActivityVersionStoryViewModel : OptionBase
{
	private SimpleCommand<string> optCmd;

	private InteractionRequest<string> optRequest;

	private ActivityVersionData data;

	private string name;

	private string summary;

	private List<ReceiveItemViewModel> dropProps;

	public ActivityVersionData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string Summary
	{
		get
		{
			return summary;
		}
		private set
		{
			Set(ref summary, value, "Summary");
		}
	}

	public List<ReceiveItemViewModel> DropProps => dropProps;

	public ICommand OptCmd => optCmd;

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}

	public ActivityVersionStoryViewModel()
	{
	}

	public ActivityVersionStoryViewModel(OptionBase parent, ActivityVersionData data)
	{
		base.parent = parent;
		optCmd = new SimpleCommand<string>(OnOpt);
		dropProps = new List<ReceiveItemViewModel>();
		SetData(data);
	}

	public void SetData(ActivityVersionData activityVersionData)
	{
		Data = activityVersionData;
		DRStory dataRow = GameEntry.DataTable.GetDataRow<DRStory>(data.DrVersionActivity.Content);
		if (dataRow == null)
		{
			Name = "";
			Summary = "";
		}
		else
		{
			Name = dataRow.Title;
			Summary = dataRow.Summary;
		}
		GetTimelineDrops(data.DrVersionActivity.Drops);
		SetGot();
	}

	public void SetGot()
	{
		for (int i = 0; i < dropProps.Count; i++)
		{
			dropProps[i].SetGot(data.IsComplete);
		}
	}

	private async void OnOpt(string optName)
	{
		optCmd.Enabled = false;
		try
		{
			if ("ShowTimeline".Equals(optName))
			{
				parent.ItemOnClick(optName);
				return;
			}
			parent.ItemOnClick(optName);
			optCmd.Enabled = true;
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " /" + ex.StackTrace);
			optCmd.Enabled = true;
		}
	}

	public void EnableOpt()
	{
		optCmd.Enabled = true;
	}

	public void GetTimelineDrops(int dropId)
	{
		dropProps.Clear();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == dropId);
		if (dataRow == null)
		{
			return;
		}
		if (dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
		{
			Log.Error($"CopyDrop 配置表，Id【{dataRow.Id}】数据配置异常！");
			return;
		}
		for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
			if (propDataBase == null)
			{
				Log.Error($"CopyDrop 配置表，Id【{dataRow.Id}】CopyDrop.PropTypeShow {dataRow.PropTypeShow[num]}，CopyDrop.PropIDShow {dataRow.PropIDShow[num]}配置有误！");
				continue;
			}
			ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, this);
			dropProps.Add(receiveItemViewModel);
			if (dataRow.IsShowNum.Count > num && dataRow.IsShowNum[num] == 1 && dataRow.PropNumShow.Count > num)
			{
				receiveItemViewModel.SetCountRange(dataRow.PropNumShow[num]);
			}
			else
			{
				receiveItemViewModel.SetCountRange("");
			}
		}
	}
}
