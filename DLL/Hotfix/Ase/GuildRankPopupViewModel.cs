using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GuildRankPopupViewModel : OptionBase
{
	private string _title;

	private List<RankItemData> _rankDatas = new List<RankItemData>();

	private InteractionRequest _refreshRequest = new InteractionRequest();

	public string Title
	{
		get
		{
			return _title;
		}
		set
		{
			Set(ref _title, value, "Title");
		}
	}

	public List<RankItemData> RankDatas => _rankDatas;

	public InteractionRequest RefreshRequest => _refreshRequest;

	public GuildRankPopupViewModel()
	{
	}

	public GuildRankPopupViewModel(OptionBase parent, string title, List<PbUnionMemberRankInfo> pbList)
	{
		base.parent = parent;
		Title = title;
		Refresh(pbList);
	}

	public void Refresh(List<PbUnionMemberRankInfo> pbList)
	{
		_rankDatas.Clear();
		if (pbList == null)
		{
			return;
		}
		foreach (PbUnionMemberRankInfo pb in pbList)
		{
			_rankDatas.Add(RankItemData.Create(pb, this, btnEnable: false));
		}
		_refreshRequest.Raise();
	}
}
