using GameFramework.Runtime;

namespace Ase;

public class GamerHeadInfoViewModel : OptionBase
{
	private long _uid;

	private string _roleName;

	private string _icon;

	private int _frame;

	private int _level;

	private int _title;

	public string heroOriginal;

	private bool isFriend;

	private SimpleCommand addFriendCmd;

	public long Uid => _uid;

	public string Icon => _icon;

	public int Frame => _frame;

	public string RoleName => _roleName;

	public int Level => _level;

	public int Title => _title;

	public bool IsFriend => isFriend;

	public SimpleCommand AddFriendCmd => addFriendCmd;

	public GamerHeadInfoViewModel(OptionBase parent, TeamInfo teamInfo, string heroOriginal)
	{
		base.parent = parent;
		addFriendCmd = new SimpleCommand(AddFriend);
		_uid = teamInfo.UserId;
		_roleName = teamInfo.UserName;
		_icon = PlayerDataBase.GetIcon(teamInfo.Icon);
		_frame = teamInfo.IconFrame;
		_level = teamInfo.Level;
		_title = teamInfo.Title;
		this.heroOriginal = heroOriginal;
		CheckFriend();
	}

	private async void AddFriend()
	{
		if (addFriendCmd.Enabled)
		{
			await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().AddFriend(_uid, "");
			addFriendCmd.Enabled = false;
		}
	}

	private void CheckFriend()
	{
		isFriend = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckFriendExist(Uid);
	}
}
