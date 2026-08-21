using System.Collections.Generic;

namespace Ase;

public class MatchRoomUserInfo
{
	private int capFlag;

	private int seatId;

	private int state;

	private int selectModel;

	private long userId;

	private int icon;

	private string name;

	private int selectRoleId;

	private int selectRoleStar;

	private int selectRoleLevel;

	private int selectRoleSkin;

	private List<int> seatLevel;

	private Dictionary<int, BPData> carryingBPs;

	private int heroCardFrame;

	public int HeroCardFrame => heroCardFrame;

	public int CapFlag => capFlag;

	public int SeatId => seatId;

	public int State => state;

	public int SelectModel => selectModel;

	public long UserId => userId;

	public int Icon => icon;

	public string Name => name;

	public int SelectRoleId => selectRoleId;

	public int SelectRoleStar => selectRoleStar;

	public int SelectRoleLevel => selectRoleLevel;

	public int SelectRoleSkin => selectRoleSkin;

	public List<int> SeatLevel => seatLevel;

	public Dictionary<int, BPData> CarryingBPs => carryingBPs;

	public MatchRoomUserInfo(int capFlag, long userId, int seatId, int state, int selectModel, int icon, string name, int selectRoleId, int selectRoleStar, int selectRoleLevel, int selectRoleSkin, int heroCardFrame, List<int> seatLevel, Dictionary<int, BPData> carryingBPs)
	{
		this.selectModel = selectModel;
		this.seatId = seatId;
		this.capFlag = capFlag;
		this.state = state;
		this.userId = userId;
		this.icon = icon;
		this.name = name;
		this.selectRoleId = selectRoleId;
		this.selectRoleStar = selectRoleStar;
		this.selectRoleLevel = selectRoleLevel;
		this.selectRoleSkin = selectRoleSkin;
		this.heroCardFrame = heroCardFrame;
		this.seatLevel = seatLevel;
		this.carryingBPs = carryingBPs;
	}
}
