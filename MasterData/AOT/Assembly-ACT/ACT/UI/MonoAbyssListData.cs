using ACT.Model;

namespace ACT.UI;

public class MonoAbyssListData : UIViewData
{
	public AbyssType AbyssType = AbyssType.Fixed;

	public int AbyssId;

	public bool IsOpenAbyssTeamPanel;

	public int OpenAbyssTeamChossIndex;
}
