using System;

namespace ACT.Config;

[Serializable]
public class RoleMissionData
{
	public readonly int id;

	public readonly int missionName;

	public readonly int missionChapter;

	public readonly int missionChapterRoman;

	public readonly int roleName;

	public readonly int missionbanner;

	public readonly int frontRoleMissionId;

	public readonly int receiveMissionId;

	public RoleMissionData(int id, int missionName, int missionChapter, int missionChapterRoman, int roleName, int missionbanner, int frontRoleMissionId, int receiveMissionId)
	{
		this.id = id;
		this.missionName = missionName;
		this.missionChapter = missionChapter;
		this.missionChapterRoman = missionChapterRoman;
		this.roleName = roleName;
		this.missionbanner = missionbanner;
		this.frontRoleMissionId = frontRoleMissionId;
		this.receiveMissionId = receiveMissionId;
	}
}
