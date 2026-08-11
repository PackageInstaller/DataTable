using System;
using GameFramework.Runtime;

namespace Ase;

public class LotteryActItemData : OptionBase
{
	private int _index;

	private string _rewardIcon = "";

	private string _rewardCountText;

	private bool _showSpIcon;

	private bool _showOverlayMask;

	private bool _showMidMask;

	private bool _finished;

	private PropDataBase _rewardData;

	private InteractionRequest<Action> _playLotteryAniRst = new InteractionRequest<Action>();

	public InteractionRequest<Action> PlayLotteryAniRst => _playLotteryAniRst;

	public int Index
	{
		get
		{
			return _index;
		}
		set
		{
			Set(ref _index, value, "Index");
		}
	}

	public string RewardIcon
	{
		get
		{
			return _rewardIcon;
		}
		set
		{
			Set(ref _rewardIcon, value, "RewardIcon");
		}
	}

	public bool ShowSpIcon
	{
		get
		{
			return _showSpIcon;
		}
		set
		{
			Set(ref _showSpIcon, value, "ShowSpIcon");
		}
	}

	public string RewardCountText
	{
		get
		{
			return _rewardCountText;
		}
		set
		{
			Set(ref _rewardCountText, value, "RewardCountText");
		}
	}

	public bool ShowOverlayMask
	{
		get
		{
			return _showOverlayMask;
		}
		set
		{
			Set(ref _showOverlayMask, value, "ShowOverlayMask");
		}
	}

	public bool ShowMidMask
	{
		get
		{
			return _showMidMask;
		}
		set
		{
			Set(ref _showMidMask, value, "ShowMidMask");
		}
	}

	public bool Finished
	{
		get
		{
			return _finished;
		}
		set
		{
			Set(ref _finished, value, "Finished");
		}
	}

	public void PlayLotteryAni(Action callback)
	{
		_playLotteryAniRst.Raise(callback);
	}

	public LotteryActItemData()
	{
	}

	public LotteryActItemData(OptionBase parent, int position)
	{
		base.parent = parent;
		Index = position;
	}

	public void RefreshResultData(int rewardConfigId)
	{
		Finished = rewardConfigId > 0;
		ShowMidMask = !Finished;
		ShowOverlayMask = !Finished;
		if (!Finished)
		{
			_rewardData = null;
			RewardIcon = "";
			ShowSpIcon = false;
			return;
		}
		DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(rewardConfigId);
		if (dataRow == null)
		{
			_rewardData = null;
			RewardIcon = "";
			ShowSpIcon = false;
			return;
		}
		_rewardData = PropDataBase.CreateByType((dataRow.RewardType.Count > 0) ? dataRow.RewardType[0] : 0, (dataRow.RewardId.Count > 0) ? dataRow.RewardId[0] : 0, (dataRow.RewardNum.Count > 0) ? dataRow.RewardNum[0] : 0);
		if (_rewardData == null || _rewardData.Empty)
		{
			RewardIcon = "";
			ShowSpIcon = false;
		}
		else
		{
			ShowSpIcon = _rewardData.PropTypeEnum == PropTypeEnum.HeroSkin;
			RewardIcon = _rewardData.Icon;
			RewardCountText = $"x{_rewardData.Amount}";
		}
	}

	public void OnItemClick()
	{
		if (!Finished)
		{
			parent?.ItemOnClick(this);
		}
		else if (_rewardData != null && !_rewardData.Empty)
		{
			parent?.ItemOnClick(new KnapsackItemViewModel(this, _rewardData));
		}
	}

	public void UpdateWindowMaskTime(float time)
	{
		parent?.ItemOnClick(new OptionArg(time, "UpdateWindowMaskTime"));
	}
}
