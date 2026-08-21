using UnityEngine;

namespace Ase;

public class MultiRoomInviteItemData : OptionBase
{
	private string gamerImg;

	private int _gamerFrameId;

	private int _gamerLv;

	private int _gamerTitleId;

	private string _gamerName;

	private string _state;

	private Color stateColor;

	private bool _isSelected;

	private long _uid;

	public long Uid => _uid;

	public string GamerImgId => gamerImg;

	public int GamerFrameId => _gamerFrameId;

	public int GamerLv => _gamerLv;

	public int GamerTitleId => _gamerTitleId;

	public string GamerName => _gamerName;

	public string State => _state;

	public Color StateColor => stateColor;

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			Set(ref _isSelected, value, "IsSelected");
		}
	}

	public MultiRoomInviteItemData()
	{
	}

	public MultiRoomInviteItemData(OptionBase parent, PbMultiFightFriendInfo pbMultiFightFriendInfo)
	{
		base.parent = parent;
		_uid = pbMultiFightFriendInfo.FrienInfo.UserId;
		gamerImg = PlayerDataBase.GetIcon(pbMultiFightFriendInfo.FrienInfo.Icon);
		_gamerFrameId = pbMultiFightFriendInfo.FrienInfo.IconFrame;
		_gamerLv = pbMultiFightFriendInfo.FrienInfo.Level;
		_gamerName = pbMultiFightFriendInfo.FrienInfo.Name;
		_gamerTitleId = pbMultiFightFriendInfo.FrienInfo.TitleId;
		_state = ((pbMultiFightFriendInfo.FightState == 1) ? "在线" : "组队中");
		SetStateColor(pbMultiFightFriendInfo.FightState);
		_isSelected = false;
	}

	public MultiRoomInviteItemData(OptionBase parent, PlayerData playerData, int state)
	{
		base.parent = parent;
		_uid = playerData.Uid;
		gamerImg = PlayerDataBase.GetIcon(playerData.IconId);
		_gamerFrameId = playerData.IconFrame;
		_gamerLv = playerData.Level;
		_gamerName = playerData.Name;
		_gamerTitleId = playerData.Title;
		_state = ((state == 1) ? "在线" : "组队中");
		SetStateColor(state);
		_isSelected = false;
	}

	public MultiRoomInviteItemData(OptionBase parent, GuildMemberData guildMemberData, int state)
	{
		base.parent = parent;
		_uid = guildMemberData.Uid;
		gamerImg = PlayerDataBase.GetIcon(guildMemberData.IconId);
		_gamerFrameId = guildMemberData.IconFrame;
		_gamerLv = guildMemberData.Level;
		_gamerName = guildMemberData.Name;
		_gamerTitleId = guildMemberData.Title;
		_state = ((state == 1) ? "在线" : "组队中");
		SetStateColor(state);
		_isSelected = false;
	}

	private void SetStateColor(int state)
	{
		string text = "";
		text = ((state != 1) ? "#d0c9c4" : "#f4d88e");
		ColorUtility.TryParseHtmlString(text, out var color);
		stateColor = color;
	}

	public void OnClick()
	{
		IsSelected = !IsSelected;
	}
}
