using System;

namespace ACT.Config;

[Serializable]
public class MissionBase
{
	public readonly int id;

	public readonly int chapterID;

	public readonly int groupID;

	public readonly bool manualAccept;

	public readonly bool resetGroupOnFailure;

	public readonly int world;

	public readonly int mapArea;

	public readonly int subMapArea;

	public readonly int name;

	public readonly int zoneDesc;

	public readonly int placeDesc;

	public readonly int titleDesc;

	public readonly int contentDesc;

	public readonly bool isValid;

	public readonly bool isHidden;

	public readonly bool withForceAccpectHint;

	public readonly bool withForceFinishHint;

	public readonly int[] nextMission = new int[0];

	public readonly int effectiveCount;

	public readonly int refreshTimestamp;

	public readonly int startTimestamp;

	public readonly int endTimestamp;

	public readonly int collectionID;

	public MissionBase(int id, int chapterID, int groupID, bool manualAccept, bool resetGroupOnFailure, int world, int mapArea, int subMapArea, int name, int zoneDesc, int placeDesc, int titleDesc, int contentDesc, bool isValid, bool isHidden, bool withForceAccpectHint, bool withForceFinishHint, int[] nextMission, int effectiveCount, int refreshTimestamp, int startTimestamp, int endTimestamp, int collectionID)
	{
		this.id = id;
		this.chapterID = chapterID;
		this.groupID = groupID;
		this.manualAccept = manualAccept;
		this.resetGroupOnFailure = resetGroupOnFailure;
		this.world = world;
		this.mapArea = mapArea;
		this.subMapArea = subMapArea;
		this.name = name;
		this.zoneDesc = zoneDesc;
		this.placeDesc = placeDesc;
		this.titleDesc = titleDesc;
		this.contentDesc = contentDesc;
		this.isValid = isValid;
		this.isHidden = isHidden;
		this.withForceAccpectHint = withForceAccpectHint;
		this.withForceFinishHint = withForceFinishHint;
		this.nextMission = nextMission;
		this.effectiveCount = effectiveCount;
		this.refreshTimestamp = refreshTimestamp;
		this.startTimestamp = startTimestamp;
		this.endTimestamp = endTimestamp;
		this.collectionID = collectionID;
	}
}
