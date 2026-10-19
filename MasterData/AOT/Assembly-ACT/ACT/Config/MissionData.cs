using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class MissionData
{
	public readonly int id;

	public readonly int submission;

	public readonly int nameLocal;

	public readonly int type;

	public readonly bool isHiddenMission;

	public readonly int rule;

	public readonly int stTime;

	public readonly int holdTime;

	public readonly int endTime;

	public readonly int mainMissionId;

	public readonly List<ItemKv> pre;

	public readonly int reward;

	public readonly int[] world = new int[0];

	public readonly bool autoAdd;

	public readonly int nextMission;

	public readonly bool overrideState;

	public readonly List<InteractionObj> changeInteractionObjs;

	public readonly string missionCode = "";

	public MissionData(int id, int submission, int nameLocal, int type, bool isHiddenMission, int rule, int stTime, int holdTime, int endTime, int mainMissionId, List<ItemKv> pre, int reward, int[] world, bool autoAdd, int nextMission, bool overrideState, List<InteractionObj> changeInteractionObjs, string missionCode)
	{
		this.id = id;
		this.submission = submission;
		this.nameLocal = nameLocal;
		this.type = type;
		this.isHiddenMission = isHiddenMission;
		this.rule = rule;
		this.stTime = stTime;
		this.holdTime = holdTime;
		this.endTime = endTime;
		this.mainMissionId = mainMissionId;
		this.pre = pre;
		this.reward = reward;
		this.world = world;
		this.autoAdd = autoAdd;
		this.nextMission = nextMission;
		this.overrideState = overrideState;
		this.changeInteractionObjs = changeInteractionObjs;
		this.missionCode = missionCode;
	}
}
