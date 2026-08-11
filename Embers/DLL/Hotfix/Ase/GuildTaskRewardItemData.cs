using UnityEngine;

namespace Ase;

public class GuildTaskRewardItemData : OptionBase
{
	private int state = 1;

	private int needPoint;

	private int totalPoint;

	private Vector2 pos;

	private string icon = "";

	private bool showGetEffect;

	private DRGuildActiveReward drConfigData;

	public bool ShowGetEffect
	{
		get
		{
			return showGetEffect;
		}
		set
		{
			Set(ref showGetEffect, value, "ShowGetEffect");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int State
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

	public int NeedPoint
	{
		get
		{
			return needPoint;
		}
		set
		{
			Set(ref needPoint, value, "NeedPoint");
		}
	}

	public int TotalPoint
	{
		get
		{
			return totalPoint;
		}
		set
		{
			Set(ref totalPoint, value, "TotalPoint");
		}
	}

	public Vector2 Pos
	{
		get
		{
			return pos;
		}
		set
		{
			Set(ref pos, value, "Pos");
		}
	}

	public DRGuildActiveReward DrConfigData => drConfigData;

	public GuildTaskRewardItemData()
	{
	}

	public GuildTaskRewardItemData(OptionBase parent, DRGuildActiveReward drData, float progressLength, int curPoint, int totalPoint, bool alreadyGet)
	{
		base.parent = parent;
		drConfigData = drData;
		Icon = drData.RewardIcon;
		NeedPoint = drData.ActiveLev;
		TotalPoint = totalPoint;
		float num = (float)drData.ActiveLev / (float)totalPoint;
		Pos = new Vector2(num * progressLength, 0f);
		RefreshGetState(alreadyGet, curPoint);
	}

	public void RefreshGetState(bool alreadyGet, int curPoint = 0)
	{
		if (alreadyGet)
		{
			State = 3;
		}
		else if (curPoint >= NeedPoint)
		{
			State = 2;
		}
		else
		{
			State = 1;
		}
	}

	public void RefreshCurPoint(int curPoint)
	{
		if (State != 3)
		{
			if (curPoint >= NeedPoint)
			{
				State = 2;
			}
			else
			{
				State = 1;
			}
		}
	}

	public void OnItemClick(GuildTaskRewardItem item)
	{
		parent?.ItemOnClick(item);
	}
}
