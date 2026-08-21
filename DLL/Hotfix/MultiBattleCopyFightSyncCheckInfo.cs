using System.Collections.Generic;
using Ase;

public class MultiBattleCopyFightSyncCheckInfo
{
	public List<PbBattleFiledUserInfo> Users = new List<PbBattleFiledUserInfo>();

	public List<int> RobotRoleIds = new List<int>();

	public long CheckCode { get; set; }

	public int Seed { get; set; }

	public long RoomId { get; set; }

	public int CopyId { get; set; }

	public int Difficult { get; set; }

	public string ClientVersion { get; set; }
}
