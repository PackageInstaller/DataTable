using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HomeComeSignItemViewModel : OptionBase
{
	private static readonly Color WaitColor = Color.white;

	private static readonly Color CanClaimColor = new Color(1f, 0.84f, 0.42f, 1f);

	private static readonly Color ReceivedColor = new Color(0.72f, 0.72f, 0.72f, 1f);

	private readonly List<HomeComeSignRewardCellViewModel> rewardItems = new List<HomeComeSignRewardCellViewModel>();

	private readonly InteractionRequest refreshRewardListRequest = new InteractionRequest();

	private readonly SimpleCommand clickCommand;

	private bool received;

	private bool canClaim;

	private bool clickable;

	private string stateText;

	private Color stateColor;

	public int SignId { get; }

	public int SignDay { get; }

	public int RequestSignId { get; private set; }

	public int AltRequestSignId { get; private set; }

	public List<HomeComeSignRewardCellViewModel> RewardItems => rewardItems;

	public IInteractionRequest RefreshRewardListRequest => refreshRewardListRequest;

	public SimpleCommand ClickCommand => clickCommand;

	public bool Received
	{
		get
		{
			return received;
		}
		private set
		{
			Set(ref received, value, "Received");
		}
	}

	public bool CanClaim
	{
		get
		{
			return canClaim;
		}
		private set
		{
			Set(ref canClaim, value, "CanClaim");
		}
	}

	public bool Clickable
	{
		get
		{
			return clickable;
		}
		private set
		{
			Set(ref clickable, value, "Clickable");
		}
	}

	public string StateText
	{
		get
		{
			return stateText;
		}
		private set
		{
			Set(ref stateText, value, "StateText");
		}
	}

	public Color StateColor
	{
		get
		{
			return stateColor;
		}
		private set
		{
			Set(ref stateColor, value, "StateColor");
		}
	}

	public HomeComeSignItemViewModel()
	{
	}

	public HomeComeSignItemViewModel(OptionBase parent, int signId, int signDay, List<PropDataBase> rewardProps)
	{
		base.parent = parent;
		SignId = signId;
		SignDay = signDay;
		clickCommand = new SimpleCommand(OnClick);
		if (rewardProps != null)
		{
			for (int i = 0; i < rewardProps.Count; i++)
			{
				if (rewardProps[i] != null && !rewardProps[i].Empty)
				{
					rewardItems.Add(new HomeComeSignRewardCellViewModel(this, rewardProps[i]));
				}
			}
		}
		refreshRewardListRequest.Raise();
		UpdateDynamicState(isReceived: false, isCanClaim: false, unlocked: false, signId, signDay);
	}

	private void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public void SetClickable(bool enable)
	{
		Clickable = enable && CanClaim;
		clickCommand.Enabled = Clickable;
	}

	public void UpdateDynamicState(bool isReceived, bool isCanClaim, bool unlocked, int reqId, int altId)
	{
		Received = isReceived;
		CanClaim = isCanClaim;
		RequestSignId = reqId;
		AltRequestSignId = altId;
		if (Received)
		{
			StateText = "已领取";
			StateColor = ReceivedColor;
		}
		else if (CanClaim)
		{
			StateText = "可领取";
			StateColor = CanClaimColor;
		}
		else if (unlocked)
		{
			StateText = "未达成";
			StateColor = WaitColor;
		}
		else
		{
			StateText = $"第{SignDay}天可领";
			StateColor = WaitColor;
		}
		Clickable = CanClaim;
		clickCommand.Enabled = Clickable;
		for (int i = 0; i < rewardItems.Count; i++)
		{
			rewardItems[i].ShowState = CanClaim;
		}
	}
}
