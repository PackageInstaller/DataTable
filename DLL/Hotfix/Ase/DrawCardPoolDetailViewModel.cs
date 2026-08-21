using System.Collections.Generic;
using System.Linq;
using GameFramework.Runtime;

namespace Ase;

public class DrawCardPoolDetailViewModel : OptionBase
{
	private List<List<DrawCardRecordItemViewModel>> recordItemGroup;

	private List<DrawCardRecordItemViewModel> curRecordItemViewModels;

	private TabItemNormalData describeBtnViewModel;

	private TabItemNormalData recordBtnViewModel;

	private InteractionRequest openDetailRequest;

	private InteractionRequest refreshRecordRequest;

	private InteractionRequest resetScrollRequest;

	private int page;

	private SimpleCommand leftCommand;

	private SimpleCommand rightCommand;

	private string poolName;

	private string poolDesc;

	public List<DrawCardRecordItemViewModel> CurRecordItemViewModels
	{
		get
		{
			return curRecordItemViewModels;
		}
		private set
		{
			Set(ref curRecordItemViewModels, value, "CurRecordItemViewModels");
		}
	}

	public int Page
	{
		get
		{
			return page;
		}
		private set
		{
			Set(ref page, value, "Page");
		}
	}

	public string PoolName
	{
		get
		{
			return poolName;
		}
		private set
		{
			Set(ref poolName, value, "PoolName");
		}
	}

	public string PoolDesc
	{
		get
		{
			return poolDesc;
		}
		private set
		{
			Set(ref poolDesc, value, "PoolDesc");
		}
	}

	public TabItemNormalData DescribeBtnViewModel => describeBtnViewModel;

	public TabItemNormalData RecordBtnViewModel => recordBtnViewModel;

	public SimpleCommand LeftCommand => leftCommand;

	public SimpleCommand RightCommand => rightCommand;

	public InteractionRequest OpenDetailRequest => openDetailRequest;

	public InteractionRequest RefreshRecordRequest => refreshRecordRequest;

	public InteractionRequest ResetScrollRequest => resetScrollRequest;

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData)
		{
			TabOnClick(tabItemNormalData.ID);
		}
	}

	public DrawCardPoolDetailViewModel(OptionBase parent, DrawCardTabData curPoolInfo)
	{
		base.parent = parent;
		PoolName = curPoolInfo.DrawCardPoolInfo.Name;
		PoolDesc = curPoolInfo.DrawCardPoolInfo.Desc;
		leftCommand = new SimpleCommand(LeftOnClick);
		rightCommand = new SimpleCommand(RightOnClick);
		describeBtnViewModel = new TabItemNormalData(this, string.Empty);
		recordBtnViewModel = new TabItemNormalData(this, string.Empty, 1);
		recordItemGroup = new List<List<DrawCardRecordItemViewModel>>();
		CurRecordItemViewModels = new List<DrawCardRecordItemViewModel>();
		openDetailRequest = new InteractionRequest();
		refreshRecordRequest = new InteractionRequest();
		resetScrollRequest = new InteractionRequest();
		page = 1;
	}

	public void SetPoolInfo(DrawCardTabData curPoolInfo)
	{
		PoolName = curPoolInfo.DrawCardPoolInfo.Name;
		PoolDesc = curPoolInfo.DrawCardPoolInfo.Desc;
		page = 1;
	}

	public void ReSetScroll()
	{
		resetScrollRequest.Raise();
	}

	public void TabOnClick(int index)
	{
		switch (index)
		{
		case 0:
			if (!describeBtnViewModel.IsSelected)
			{
				describeBtnViewModel.IsSelected = true;
				recordBtnViewModel.IsSelected = false;
				openDetailRequest.Raise();
			}
			break;
		case 1:
			if (!recordBtnViewModel.IsSelected)
			{
				recordBtnViewModel.IsSelected = true;
				describeBtnViewModel.IsSelected = false;
				refreshRecordRequest.Raise();
			}
			break;
		}
	}

	private void LeftOnClick()
	{
		leftCommand.Enabled = false;
		rightCommand.Enabled = false;
		if (Page <= 1)
		{
			leftCommand.Enabled = true;
			rightCommand.Enabled = true;
			return;
		}
		Page--;
		CurRecordItemViewModels = recordItemGroup[Page - 1];
		leftCommand.Enabled = true;
		rightCommand.Enabled = true;
		refreshRecordRequest.Raise();
	}

	private void RightOnClick()
	{
		leftCommand.Enabled = false;
		rightCommand.Enabled = false;
		if (Page + 1 > recordItemGroup.Count)
		{
			leftCommand.Enabled = true;
			rightCommand.Enabled = true;
			return;
		}
		Page++;
		CurRecordItemViewModels = recordItemGroup[Page - 1];
		leftCommand.Enabled = true;
		rightCommand.Enabled = true;
		refreshRecordRequest.Raise();
	}

	public void SetDrawCardRecordInfos(List<DrawCardRecordInfo> drawCardRecordInfos)
	{
		recordItemGroup.Clear();
		CurRecordItemViewModels.Clear();
		Page = 1;
		List<DrawCardRecordItemViewModel> list = new List<DrawCardRecordItemViewModel>();
		foreach (DrawCardRecordInfo drawCardRecordInfo in drawCardRecordInfos)
		{
			list.Add(new DrawCardRecordItemViewModel(drawCardRecordInfo));
		}
		recordItemGroup = (from x in list.Select((DrawCardRecordItemViewModel x, int i) => new
			{
				Index = i,
				Value = x
			})
			group x by x.Index / 6 into x
			select x.Select(v => v.Value).ToList()).ToList();
		if (recordItemGroup.Count > 0)
		{
			CurRecordItemViewModels = recordItemGroup[0];
		}
		refreshRecordRequest.Raise();
	}
}
