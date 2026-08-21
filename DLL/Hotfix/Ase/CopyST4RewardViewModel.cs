using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyST4RewardViewModel : OptionBase
{
	private List<CopyReward4ItemViewModel> reward4ItemVMs;

	private InteractionRequest rankRequest;

	private string count;

	private int itemType;

	public List<CopyReward4ItemViewModel> Reward4ItemVMs => reward4ItemVMs;

	public string Count
	{
		get
		{
			return count;
		}
		set
		{
			Set(ref count, value, "Count");
		}
	}

	public int ItemType
	{
		get
		{
			return itemType;
		}
		set
		{
			Set(ref itemType, value, "ItemType");
		}
	}

	public IInteractionRequest RankRequest => rankRequest;

	public CopyST4RewardViewModel()
	{
	}

	public CopyST4RewardViewModel(OptionBase parent, string count, List<CopyReward4ItemViewModel> reward4ItemVMs, int itemType)
	{
		base.parent = parent;
		this.reward4ItemVMs = reward4ItemVMs;
		this.count = count;
		rankRequest = new InteractionRequest();
		this.itemType = itemType;
	}

	public void RefreshData(string count, List<CopyReward4ItemViewModel> reward4ItemVMs)
	{
		this.reward4ItemVMs = reward4ItemVMs;
		Count = count;
	}

	public void RefreshData(string count)
	{
		Count = count;
	}

	public override void Close()
	{
		base.IsVisible = false;
	}

	public override void ItemOnClick(object obj)
	{
		parent.ItemOnClick(obj);
	}

	public void Sort()
	{
		reward4ItemVMs.Sort(new CopyReward4ItemVmSort());
		rankRequest.Raise();
	}
}
