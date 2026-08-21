using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class BattleDropInfoViewModel : OptionBase
{
	public float Wait2TweenTime;

	private float wait2TweenTime;

	private bool waitTweenCheck;

	public int MaxShowCount;

	private int shownItemCount;

	private float _itemShowInterval;

	private float showInterval;

	private Queue<DropData> _dropDataQueue = new Queue<DropData>();

	private InteractionRequest<BattleDropItemData> showDropRst = new InteractionRequest<BattleDropItemData>();

	public int ShownItemCount
	{
		get
		{
			return shownItemCount;
		}
		set
		{
			shownItemCount = value;
		}
	}

	public float ItemShowInterval
	{
		get
		{
			return _itemShowInterval;
		}
		set
		{
			_itemShowInterval = value;
			showInterval = value;
		}
	}

	public InteractionRequest<BattleDropItemData> ShowDropRst => showDropRst;

	public BattleDropInfoViewModel()
	{
	}

	public BattleDropInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnUpdate(float deltaTime)
	{
		if (_dropDataQueue.Count <= 0 || ShownItemCount >= MaxShowCount)
		{
			return;
		}
		if (waitTweenCheck)
		{
			if (wait2TweenTime < Wait2TweenTime)
			{
				wait2TweenTime += deltaTime;
				return;
			}
			wait2TweenTime = 0f;
			waitTweenCheck = false;
		}
		if (showInterval < ItemShowInterval)
		{
			showInterval += deltaTime;
			return;
		}
		showInterval = 0f;
		ShowDropRst.Raise(new BattleDropItemData(this, _dropDataQueue.Dequeue()));
	}

	public void ShowDrop(DropSystem.DropInfo dropInfo)
	{
		if (dropInfo != null)
		{
			_dropDataQueue.Enqueue(new DropData(dropInfo.dropItemId, dropInfo.dropCount, dropInfo.dropType));
		}
	}

	public void ShowTaskRewards(TaskRewardsReceiveMessager messager)
	{
		if (messager.Rewards == null)
		{
			return;
		}
		List<DropData> list = new List<DropData>();
		foreach (PbItemBase item in messager.Rewards.Items)
		{
			if ((item.ItemType == 1 || item.ItemType == 3 || item.ItemType == 7 || item.ItemType == 8 || item.ItemType == 10) && item.ItemCount > 0)
			{
				list.Add(new DropData(item.ItemId, item.ItemCount, item.ItemType));
			}
		}
		foreach (PbEquipBase equip in messager.Rewards.Equips)
		{
			if (equip.Type == 2 || equip.Type == 5)
			{
				list.Add(new DropData(equip.EquipId, equip.Count, equip.Type));
			}
		}
		list.Sort((DropData a, DropData b) => (a.quality != b.quality) ? a.quality.CompareTo(b.quality) : a.id.CompareTo(b.id));
		foreach (DropData item2 in list)
		{
			_dropDataQueue.Enqueue(item2);
		}
		waitTweenCheck = true;
	}
}
