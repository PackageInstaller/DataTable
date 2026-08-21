using System.Collections.Generic;

namespace Ase;

public class HeroGrowRarityItemData : ItemOptionBase
{
	public enum ItemStateEnum
	{
		Lock = 1,
		NotEnough,
		Enough,
		Lighted,
		Lighting
	}

	private DRHeroSeat _drHeroSeat;

	private string itemIcon = "";

	private ItemStateEnum state;

	private bool selected;

	private bool showRed;

	private int pointIndex;

	private bool isSelf;

	public string ItemIcon
	{
		get
		{
			return itemIcon;
		}
		set
		{
			Set(ref itemIcon, value, "ItemIcon");
		}
	}

	public ItemStateEnum State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public bool Selected
	{
		get
		{
			return selected;
		}
		set
		{
			Set(ref selected, value, "Selected");
		}
	}

	public bool ShowRed
	{
		get
		{
			return showRed;
		}
		set
		{
			Set(ref showRed, value, "ShowRed");
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public int PointIndex => pointIndex;

	public HeroGrowRarityItemData()
	{
	}

	public HeroGrowRarityItemData(OptionBase parent, bool isSelf = true)
	{
		base.parent = parent;
		IsSelf = isSelf;
	}

	public void RefreshData(int index, DRHeroSeat config, int destinyLevel, List<int> destinyData)
	{
		pointIndex = index;
		_drHeroSeat = config;
		ItemIcon = GetIconByConfig(index, config);
		RefreshItemState(destinyLevel, destinyData);
	}

	public void RefreshItemState(int destinyLevel, List<int> destinyData)
	{
		if (destinyLevel >= _drHeroSeat.TargetSeat || (destinyLevel == _drHeroSeat.TargetSeat - 1 && destinyData.Count >= pointIndex && destinyData[pointIndex - 1] == 1))
		{
			State = ItemStateEnum.Lighted;
			ShowRed = false;
		}
		else if (destinyLevel == _drHeroSeat.TargetSeat - 1)
		{
			if (pointIndex == 1 || (pointIndex > 1 && destinyData.Count >= pointIndex - 1 && destinyData[pointIndex - 2] == 1))
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(_drHeroSeat.NeedItem);
				if (dataRow != null)
				{
					int amount = ((_drHeroSeat.ItemNum.Count >= pointIndex) ? _drHeroSeat.ItemNum[pointIndex - 1] : 0);
					bool flag = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().CheckEnough(new PropData(dataRow, amount));
					State = (flag ? ItemStateEnum.Enough : ItemStateEnum.NotEnough);
					if (IsSelf)
					{
						ShowRed = flag;
					}
					else
					{
						ShowRed = false;
					}
				}
				else
				{
					State = ItemStateEnum.Enough;
					if (IsSelf)
					{
						ShowRed = true;
					}
					else
					{
						ShowRed = false;
					}
				}
			}
			else
			{
				State = ItemStateEnum.Lock;
				ShowRed = false;
			}
		}
		else
		{
			State = ItemStateEnum.Lock;
			ShowRed = false;
		}
	}

	public void OnLighted()
	{
		State = ItemStateEnum.Lighted;
		ShowRed = false;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	private string GetIconByConfig(int index, DRHeroSeat config)
	{
		return index switch
		{
			1 => config.PropIcon1, 
			2 => config.PropIcon2, 
			3 => config.PropIcon3, 
			4 => config.PropIcon4, 
			_ => "", 
		};
	}
}
