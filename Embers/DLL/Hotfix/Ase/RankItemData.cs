using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class RankItemData : OptionBase
{
	private int _rank;

	private int _score;

	private string _scoreText;

	private int _itemRank;

	private bool _itemBtnEnable;

	private bool _showHeroes = true;

	private List<int> _heroIds = new List<int>();

	private List<RankSeatItemData> _playerDatas = new List<RankSeatItemData>();

	private string customIcon1 = "";

	private int playerSelectHeroId;

	private string rankInfo1;

	private string rankInfo2;

	private string rankInfo3;

	private InteractionRequest refreshRequest = new InteractionRequest();

	public int Rank
	{
		get
		{
			return _rank;
		}
		private set
		{
			if (value > 3 || value < 0)
			{
				ItemRank = 0;
			}
			else
			{
				ItemRank = value;
			}
			Set(ref _rank, value, "Rank");
		}
	}

	public int ItemRank
	{
		get
		{
			return _itemRank;
		}
		set
		{
			Set(ref _itemRank, value, "ItemRank");
		}
	}

	public int Score
	{
		get
		{
			return _score;
		}
		set
		{
			Set(ref _score, value, "Score");
		}
	}

	public string ScoreText
	{
		get
		{
			return _scoreText;
		}
		set
		{
			Set(ref _scoreText, value, "ScoreText");
		}
	}

	public bool ItemBtnEnable
	{
		get
		{
			return _itemBtnEnable;
		}
		set
		{
			Set(ref _itemBtnEnable, value, "ItemBtnEnable");
		}
	}

	public bool ShowHeroes
	{
		get
		{
			return _showHeroes;
		}
		set
		{
			Set(ref _showHeroes, value, "ShowHeroes");
		}
	}

	public List<int> HeroIds => _heroIds;

	public List<RankSeatItemData> PlayerDatas => _playerDatas;

	public string CustomIcon1
	{
		get
		{
			return customIcon1;
		}
		set
		{
			Set(ref customIcon1, value, "CustomIcon1");
		}
	}

	public string RankInfo1
	{
		get
		{
			return rankInfo1;
		}
		set
		{
			Set(ref rankInfo1, value, "RankInfo1");
		}
	}

	public string RankInfo2
	{
		get
		{
			return rankInfo2;
		}
		set
		{
			Set(ref rankInfo2, value, "RankInfo2");
		}
	}

	public string RankInfo3
	{
		get
		{
			return rankInfo3;
		}
		set
		{
			Set(ref rankInfo3, value, "RankInfo3");
		}
	}

	public int PlayerSelectHeroId
	{
		get
		{
			return playerSelectHeroId;
		}
		set
		{
			Set(ref playerSelectHeroId, value, "PlayerSelectHeroId");
		}
	}

	public InteractionRequest RefreshRequest => refreshRequest;

	public RankItemData()
	{
	}

	public RankItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public RankItemData(OptionBase parent, int rank, int score, bool btnEnable, List<RankSeatItemData> playerDatas)
	{
		base.parent = parent;
		Rank = rank;
		Score = score;
		ScoreText = $"{score}";
		ItemBtnEnable = btnEnable;
		_playerDatas = playerDatas;
	}

	public RankItemData(OptionBase parent, int rank, int score, bool itemBtnEnable, List<RankSeatItemData> playerDatas, int selectHeroId, List<int> heroIds)
	{
		base.parent = parent;
		Rank = rank;
		Score = score;
		ScoreText = $"{score}";
		ItemBtnEnable = itemBtnEnable;
		_playerDatas = playerDatas;
		PlayerSelectHeroId = selectHeroId;
		_heroIds = heroIds;
		ShowHeroes = true;
	}

	public RankItemData(OptionBase parent, int rank, int score, bool itemBtnEnable, List<RankSeatItemData> playerDatas, List<int> heroIds, bool showSingleHeroes)
	{
		base.parent = parent;
		Rank = rank;
		Score = score;
		ScoreText = $"{score}";
		ItemBtnEnable = itemBtnEnable;
		_playerDatas = playerDatas;
		_heroIds = heroIds;
		ShowHeroes = showSingleHeroes;
	}

	public static RankItemData Create(PbSuitboxCopyRankInfo pb, OptionBase parent)
	{
		PbSuitboxCopyRankSingleUserInfo pbSuitboxCopyRankSingleUserInfo = ((pb.Players.Count > 0) ? pb.Players[0] : null);
		if (pbSuitboxCopyRankSingleUserInfo == null)
		{
			return new RankItemData();
		}
		List<RankSeatItemData> playerDatas = new List<RankSeatItemData>
		{
			new RankSeatItemData(parent, pbSuitboxCopyRankSingleUserInfo.UserId, pbSuitboxCopyRankSingleUserInfo.Name, pbSuitboxCopyRankSingleUserInfo.Level, pbSuitboxCopyRankSingleUserInfo.Icon, pbSuitboxCopyRankSingleUserInfo.IconFrame, pbSuitboxCopyRankSingleUserInfo.Title)
		};
		return new RankItemData(parent, pb.Rank, pb.Score, itemBtnEnable: true, playerDatas, pbSuitboxCopyRankSingleUserInfo.SelectRoleId, pbSuitboxCopyRankSingleUserInfo.RoleIds);
	}

	public static RankItemData Create(PbRaceCopyRankInfo pb, OptionBase parent, bool showSingleHeroes)
	{
		List<RankSeatItemData> playerDatas = new List<RankSeatItemData>
		{
			new RankSeatItemData(parent, pb.UserId, pb.UserName, pb.Level, pb.Icon, pb.IconFrame, pb.Title)
		};
		return new RankItemData(parent, pb.Rank, pb.Score, itemBtnEnable: true, playerDatas, pb.RoleIds, showSingleHeroes);
	}

	public static RankItemData Create(PbHeroRankInfo pb, OptionBase parent)
	{
		return new RankItemData(parent, pb.Rank, pb.Score, btnEnable: true, new List<RankSeatItemData>
		{
			new RankSeatItemData(parent, pb.UserId, pb.UserName, pb.Level, pb.Icon, pb.IconFrame, pb.Title)
		});
	}

	public static RankItemData Create(PbUnionRankInfo pb, OptionBase parent)
	{
		RankItemData obj = new RankItemData(parent)
		{
			Rank = pb.Rank,
			Score = pb.WeeklyActivePoinit,
			CustomIcon1 = GuildDefinition.GetGuildFlagIcon(pb.UnionInfo.Flag),
			RankInfo1 = pb.UnionInfo.Name,
			RankInfo2 = $"Lv.{pb.UnionInfo.Level}",
			RankInfo3 = $"{pb.UnionInfo.MemberCount}/{GuildDefinition.GetMaxMemberCount(pb.UnionInfo.Level)}"
		};
		obj.ScoreText = obj.Score.ToString();
		return obj;
	}

	public static RankItemData Create(PbUnionCopyRankInfo pb, OptionBase parent)
	{
		return new RankItemData(parent)
		{
			Rank = pb.Rank,
			Score = pb.Score,
			CustomIcon1 = GuildDefinition.GetGuildFlagIcon(pb.UnionInfo.Flag),
			RankInfo1 = pb.UnionInfo.Name,
			RankInfo2 = $"Lv.{pb.UnionInfo.Level}",
			RankInfo3 = $"{pb.UnionInfo.MemberCount}/{GuildDefinition.GetMaxMemberCount(pb.UnionInfo.Level)}",
			ScoreText = GetFinalScoreText(pb.Score)
		};
	}

	public static RankItemData Create(PbUnionMemberRankInfo pb, OptionBase parent, bool btnEnable)
	{
		return new RankItemData(parent, pb.Rank, pb.Score, btnEnable, new List<RankSeatItemData>
		{
			new RankSeatItemData(parent, pb.UserId, pb.UserName, pb.Level, pb.Icon, pb.IconFrame, pb.Title)
		})
		{
			ScoreText = GetFinalScoreText(pb.Score)
		};
	}

	public static RankItemData Create(PbChallengeCopyRankInfo pb, OptionBase parent)
	{
		PbSuitboxCopyRankSingleUserInfo pbSuitboxCopyRankSingleUserInfo = ((pb.Players.Count > 0) ? pb.Players[0] : null);
		if (pbSuitboxCopyRankSingleUserInfo == null)
		{
			return new RankItemData();
		}
		List<RankSeatItemData> playerDatas = new List<RankSeatItemData>
		{
			new RankSeatItemData(parent, pbSuitboxCopyRankSingleUserInfo.UserId, pbSuitboxCopyRankSingleUserInfo.Name, pbSuitboxCopyRankSingleUserInfo.Level, pbSuitboxCopyRankSingleUserInfo.Icon, pbSuitboxCopyRankSingleUserInfo.IconFrame, pbSuitboxCopyRankSingleUserInfo.Title)
		};
		return new RankItemData(parent, pb.Rank, pb.Score, itemBtnEnable: true, playerDatas, pbSuitboxCopyRankSingleUserInfo.SelectRoleId, pbSuitboxCopyRankSingleUserInfo.RoleIds);
	}

	private static string GetFinalScoreText(int value)
	{
		long num = 0x7FFFFFFF & value;
		num = (((value & 0x80000000u) > 0) ? (num * 10000) : num);
		if (num > 100000000)
		{
			return $"{Mathf.CeilToInt(num / 10000)}万";
		}
		return $"{num}";
	}

	public void OnItemClick()
	{
		if (_playerDatas.Count > 0)
		{
			parent?.ItemOnClick(_playerDatas[0]);
		}
	}
}
