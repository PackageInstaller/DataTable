using ACT.Config;
using ACT.Utility;
using ACT.World;

namespace ACT.MissionSystem;

public struct MissionConfig(MissionBase missionBase, MissionDetail missionDetail, MainmissionData chapter, MissionRGroup group)
{
	private MissionBase m_MissionBase = missionBase;

	private MissionDetail m_MissionDetail = missionDetail;

	private MainmissionData m_Chapter = chapter;

	private MissionRGroup m_Group = group;

	public MissionBase MissionBase => m_MissionBase;

	public MissionDetail MissionDetail => m_MissionDetail;

	public MainmissionData Chapter => m_Chapter;

	public MissionRGroup Group => m_Group;

	public bool IsValid
	{
		get
		{
			if (m_MissionBase != null && m_MissionDetail != null)
			{
				return m_Chapter != null;
			}
			return false;
		}
	}

	public int MissionId => m_MissionBase.id;

	public int MissionGroupId => m_MissionBase.groupID;

	public int ChapterId => m_MissionBase.chapterID;

	public int MissionType => m_Chapter.type;

	public MissionType MissionTypeEnum => (MissionType)m_Chapter.type;

	public int World => m_MissionBase.world;

	public ACT.World.MapArea MapArea => (ACT.World.MapArea)m_MissionBase.mapArea;

	public int MissionNameId => m_MissionBase.name;

	public int MissionContentDescId => m_MissionBase.contentDesc;

	public int MissionTitleDescId => m_MissionBase.titleDesc;

	public int ZoneDescId => m_MissionBase.zoneDesc;

	public int PlaceDescId => m_MissionBase.placeDesc;

	public int RewardId => m_Group.collectionID;

	public int StageCount => m_MissionDetail.finishConditionOrAnd.Length;

	public int GetConditionCount(int stageIndex)
	{
		if (m_MissionDetail.finishCondition.Length <= stageIndex)
		{
			return 0;
		}
		return m_MissionDetail.finishCondition[stageIndex].Length;
	}

	public int GetConditionId(int stageIndex, int conditionIndex)
	{
		if (m_MissionDetail.finishCondition.Length <= stageIndex)
		{
			return 0;
		}
		return m_MissionDetail.finishCondition[stageIndex][conditionIndex];
	}

	public string GetMissionName()
	{
		if (!IsValid)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, MissionNameId);
	}

	public string GetMissionTitle()
	{
		if (!IsValid)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, MissionTitleDescId);
	}

	public string GetGroupDescription()
	{
		if (!IsValid)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, Group.description);
	}

	public string GetMissionChapterTitle()
	{
		if (!IsValid)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, Chapter.title);
	}

	public string GetMissionChapterSubTitle()
	{
		if (!IsValid)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, Chapter.subTitle);
	}

	public string GetMissionContent()
	{
		if (!IsValid)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, MissionContentDescId);
	}
}
