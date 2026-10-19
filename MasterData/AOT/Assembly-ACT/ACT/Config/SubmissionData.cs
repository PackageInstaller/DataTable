using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class SubmissionData
{
	public readonly int id;

	public readonly int missionID;

	public readonly List<ItemKv> submissionPre;

	public readonly int[] applyItem = new int[0];

	public readonly List<ItemKv> submissionFlowItem;

	public readonly List<ItemKv> submissionSubmitItem;

	public readonly int taskItemSubmitID;

	public readonly int submissionSeverPassDay;

	public readonly List<ItemKv> conditions;

	public readonly int name;

	public readonly int place;

	public readonly int zone;

	public readonly int desc;

	public readonly bool hasProgress;

	public readonly int time;

	public readonly float posx;

	public readonly float posy;

	public readonly float sizex;

	public readonly float sizey;

	public readonly List<ItemKv> stateChange;

	public readonly List<InteractionObj> changeInteractionObjs;

	public readonly int guide;

	public readonly float Uiposx;

	public readonly float Uiposy;

	public readonly float Uisizex;

	public readonly float Uisizey;

	public readonly bool isAutoRestart;

	public readonly int[][] subBluePrint = new int[0][];

	public SubmissionData(int id, int missionID, List<ItemKv> submissionPre, int[] applyItem, List<ItemKv> submissionFlowItem, List<ItemKv> submissionSubmitItem, int taskItemSubmitID, int submissionSeverPassDay, List<ItemKv> conditions, int name, int place, int zone, int desc, bool hasProgress, int time, float posx, float posy, float sizex, float sizey, List<ItemKv> stateChange, List<InteractionObj> changeInteractionObjs, int guide, float Uiposx, float Uiposy, float Uisizex, float Uisizey, bool isAutoRestart, int[][] subBluePrint)
	{
		this.id = id;
		this.missionID = missionID;
		this.submissionPre = submissionPre;
		this.applyItem = applyItem;
		this.submissionFlowItem = submissionFlowItem;
		this.submissionSubmitItem = submissionSubmitItem;
		this.taskItemSubmitID = taskItemSubmitID;
		this.submissionSeverPassDay = submissionSeverPassDay;
		this.conditions = conditions;
		this.name = name;
		this.place = place;
		this.zone = zone;
		this.desc = desc;
		this.hasProgress = hasProgress;
		this.time = time;
		this.posx = posx;
		this.posy = posy;
		this.sizex = sizex;
		this.sizey = sizey;
		this.stateChange = stateChange;
		this.changeInteractionObjs = changeInteractionObjs;
		this.guide = guide;
		this.Uiposx = Uiposx;
		this.Uiposy = Uiposy;
		this.Uisizex = Uisizex;
		this.Uisizey = Uisizey;
		this.isAutoRestart = isAutoRestart;
		this.subBluePrint = subBluePrint;
	}
}
