using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TeamItemData : OptionBase
{
	private long teamId;

	private int difficulty;

	private string difficultyDesc;

	private int advLevelMin;

	private int advLevelMax;

	private List<TeamPlayerItemData> playerList;

	private InteractionRequest refreshPlayerListRequest;

	private string copyName;

	private int copyId;

	private int playerCount;

	public long TeamId
	{
		get
		{
			return teamId;
		}
		private set
		{
			teamId = value;
		}
	}

	public int CopyId => copyId;

	public string CopyName
	{
		get
		{
			return copyName;
		}
		private set
		{
			Set(ref copyName, value, "CopyName");
		}
	}

	public int Difficulty
	{
		get
		{
			return difficulty;
		}
		private set
		{
			Set(ref difficulty, value, "Difficulty");
		}
	}

	public string DifficultyDesc
	{
		get
		{
			return difficultyDesc;
		}
		private set
		{
			Set(ref difficultyDesc, value, "DifficultyDesc");
		}
	}

	public int AdvLevelMin
	{
		get
		{
			return advLevelMin;
		}
		private set
		{
			Set(ref advLevelMin, value, "AdvLevelMin");
		}
	}

	public int AdvLevelMax
	{
		get
		{
			return advLevelMax;
		}
		private set
		{
			Set(ref advLevelMax, value, "AdvLevelMax");
		}
	}

	public List<TeamPlayerItemData> PlayerList => playerList;

	public int PlayerCount
	{
		get
		{
			return playerCount;
		}
		private set
		{
			Set(ref playerCount, value, "PlayerCount");
		}
	}

	public IInteractionRequest RefreshPlayerListRequest => refreshPlayerListRequest;

	public TeamItemData()
	{
	}

	public TeamItemData(OptionBase parent, PbSingleRoomInfo info, string copyName, int copyId, string difficultyDesc)
	{
		base.parent = parent;
		refreshPlayerListRequest = new InteractionRequest();
		SetData(info, copyName, copyId, difficultyDesc);
	}

	public void SetData(PbSingleRoomInfo info, string copyName, int copyId, string difficultyDesc)
	{
		CopyName = copyName;
		TeamId = info.RoomId;
		Difficulty = info.Difficulty;
		this.copyId = copyId;
		DifficultyDesc = difficultyDesc;
		SetPlayerList(info.SingleGamerInfo);
	}

	public void EntryOnClick()
	{
		parent.ItemOnClick(this);
	}

	private void SetPlayerList(List<PbSingleGamerInfo> info)
	{
		if (playerList == null)
		{
			playerList = new List<TeamPlayerItemData>();
			for (int i = 0; i < 3; i++)
			{
				playerList.Add(new TeamPlayerItemData(this));
			}
		}
		for (int j = 0; j < 3; j++)
		{
			if (info.Count > j)
			{
				playerList[j].SetData(info[j]);
			}
			else
			{
				playerList[j].SetEmpty();
			}
		}
		PlayerCount = info.Count;
		refreshPlayerListRequest.Raise();
	}

	public void RefreshPlayerList()
	{
		refreshPlayerListRequest.Raise();
	}
}
