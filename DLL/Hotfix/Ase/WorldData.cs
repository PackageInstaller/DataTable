using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class WorldData : IReference
{
	public uint WorldId;

	public string WorldName;

	public string SceneLoadPath;

	public List<PeripheryHeroData> TeamListConfig;

	public List<TeamMember> TeamMemberList;

	public string MapDataName;

	public int NavMeshId;

	public bool IsDevel;

	public bool IsOpenGM;

	public long RoomId;

	public PreloadBattleData PreloadBattleData;

	public List<AchievementMedal> BattleAchievementMedalList;

	public int RandomSeed;

	public string BonfireKey;

	public int TeachingId;

	public int IsBattleSend;

	public bool isMutil;

	public void Clear()
	{
		TeamListConfig = null;
		TeamMemberList = null;
		PreloadBattleData.Close();
		PreloadBattleData = null;
	}
}
