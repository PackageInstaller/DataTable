using System.Collections.Generic;

public class DormLevelLoadParam : DynamicModuleLevelLoadParam
{
	public int DormRoomId;

	public int DormRoomSceneId;

	public bool bIsGuide;

	public bool bIsMoWangMale;

	public List<DormRoleInfo> listRoleInfo;

	public DormLevelLoadParam()
	{
		levelType = DynamicModuleLevelType.Dorm;
	}
}
