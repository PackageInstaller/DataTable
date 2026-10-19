using UnityEngine.Localization;

namespace ACT.MissionSystem;

public struct ConditionDescription
{
	public MissionType IconType;

	public int MissionId;

	public int ConditionId;

	public bool IsFinished;

	public bool HaveContent;

	public int DescriptionContentId;

	public string DescriptionContentTable;

	public LocalizedString DescriptionContent;

	public bool HaveProgress;

	public int Progress;

	public int TotalProgress;

	public bool HaveMissionPoint;

	public int MissionPointId;

	public bool HaveHyperLink;

	public string HyperLinkTextTable;

	public int HyperLinkTextId;

	public LocalizedString HyperLinkText;

	public IConditionDescriptionHyperLink HyperLinkLogic;
}
