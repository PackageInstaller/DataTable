using System.Collections.Generic;

namespace Ase.Editors;

public class SingleCopyFightSyncCheckInfo
{
	public long roomId;

	public long checkCode;

	public int seed;

	public int copyId;

	public long userId;

	public int userLevel;

	public bool isFirst;

	public long unionId;

	public string ClientVersion;

	public Dictionary<int, int> posRoleDict = new Dictionary<int, int>();

	public List<int> tryRoleIds = new List<int>();

	public List<PbRoomRoleInfo> roleInfos = new List<PbRoomRoleInfo>();

	public List<PbRoomBattlePropInfo> BattleProp = new List<PbRoomBattlePropInfo>();
}
