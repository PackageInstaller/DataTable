using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class PlayerLoadingViewModel : ItemOptionBase
{
	private string _cardFrame = "";

	private TeamMember _teamMember;

	private int _progress;

	private bool _isReconnect;

	private const float SendProgressInterval = 10f;

	private float _tempValue;

	private Action<int, int> _tmProgress;

	public string CardFrame
	{
		get
		{
			return _cardFrame;
		}
		set
		{
			Set(ref _cardFrame, value, "CardFrame");
		}
	}

	public TeamMember TeamMember
	{
		get
		{
			return _teamMember;
		}
		set
		{
			Set(ref _teamMember, value, "TeamMember");
		}
	}

	public int Progress
	{
		get
		{
			return _progress;
		}
		set
		{
			Set(ref _progress, value, "Progress");
		}
	}

	public PlayerLoadingViewModel()
	{
	}

	public PlayerLoadingViewModel(TeamMember teamMember, bool isReconnect)
	{
		_isReconnect = isReconnect;
		_teamMember = teamMember;
		int num = 0;
		if (TeamMember.IsSelf)
		{
			List<int> list = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetCardFrameSet() ?? new List<int>();
			num = ((list.Count > 0) ? list[0] : 0);
		}
		else
		{
			num = teamMember.heroCardFrame;
		}
		CardFrame = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(num)?.EdgePath ?? "";
		if (!TeamMember.IsSelf)
		{
			_progress = UnityEngine.Random.Range(0, 20);
		}
		_tempValue = 0f;
	}

	public async void UpdateProgress(float p)
	{
		Progress = Mathf.FloorToInt(p * 100f);
		if (_tempValue + 10f < (float)Progress)
		{
			if (!_isReconnect)
			{
				SendRate(Progress);
			}
			_tempValue = Progress;
		}
	}

	public void UpdateTeammateProgress()
	{
		_tmProgress = (Action<int, int>)Delegate.Combine(_tmProgress, (Action<int, int>)delegate(int seatId, int progress)
		{
			if (seatId == _teamMember.MemberId)
			{
				Progress = progress;
			}
		});
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().RegisterTmProgress(_tmProgress);
	}

	public void SendRate(int p)
	{
		if (p != 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SendLoadingRate(p);
		}
	}
}
