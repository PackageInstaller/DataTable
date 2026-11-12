using System.Collections.Generic;
using UnityEngine;

namespace AIScript.Prologue;

public class PrologueMgr : AIBase
{
	public enum Status
	{
		Enter,
		FirstPart,
		SencondPart,
		ThirdPart,
		End_Sec
	}

	public static PrologueMgr Ins;

	public string key_npcTargetPos = "SlideStartPoint";

	public Transform npcTargetPos;

	public List<string> key_edgeOBBs = new List<string> { "LookDownArea1", "LookDownArea2", "LookDownArea3", "LookDownArea4", "LookDownArea5" };

	public List<WorldOBB> edgeOBBs = new List<WorldOBB>();

	public string key_endOBB_1 = "SlideReadyArea";

	public WorldOBB endOBB_1;

	public string key_preSlidePos = "SlideStartPoint";

	public Transform preSlidePos;

	public string key_runOBB = "ChangeToRunArea";

	public WorldOBB runOBB;

	public string key_monsterOBB = "StartBattleArea";

	public WorldOBB monsterOBB;

	public string key_battle2StartPoint = "Battle2StartPoint";

	public Transform battle2StartPoint;

	public string key_climbStartPos = "ClimbStartPoint_Butterfly";

	public Transform climbStartPos;

	public string key_sandstormOBB = "SandstormArea";

	public WorldOBB sandstormOBB;

	public string key_climbEndPos = "ClimbEndPoint_Butterfly";

	public Transform climbEndPos;

	public string key_climbOBB = "StartClimbArea";

	public WorldOBB climbOBB;

	public string key_endOBB_3 = "EndClimbArea";

	public WorldOBB endOBB_3;

	public string key_EndPos = "ChimbEndPoint";

	public Transform EndPos;

	private LogicEntity entity;

	public RefTool refTool;

	private readonly Status curStatus;

	private IState curState;

	private readonly Dictionary<Status, IState> dicState = new Dictionary<Status, IState>();

	public Transform cacheCameraBeacon;

	public SimpleMonsterAdventrueActor monsterActor;

	public SimplePlayerAdventureActor playerActor;

	public void OnEnable()
	{
		Ins = this;
		entity = ProloguelevelMgr.Instance;
		refTool = ProloguelevelMgr.Instance.refTool;
		npcTargetPos = refTool.GetTransformByKey(key_npcTargetPos);
		for (int i = 0; i < key_edgeOBBs.Count; i++)
		{
			edgeOBBs.Add(refTool.GetWorldOBBByKey(key_edgeOBBs.get_Item(i)));
		}
		endOBB_1 = refTool.GetWorldOBBByKey(key_endOBB_1);
		preSlidePos = refTool.GetTransformByKey(key_preSlidePos);
		runOBB = refTool.GetWorldOBBByKey(key_runOBB);
		monsterOBB = refTool.GetWorldOBBByKey(key_monsterOBB);
		battle2StartPoint = refTool.GetTransformByKey(key_battle2StartPoint);
		climbStartPos = refTool.GetTransformByKey(key_climbStartPos);
		sandstormOBB = refTool.GetWorldOBBByKey(key_sandstormOBB);
		climbEndPos = refTool.GetTransformByKey(key_climbEndPos);
		climbOBB = refTool.GetWorldOBBByKey(key_climbOBB);
		endOBB_3 = refTool.GetWorldOBBByKey(key_endOBB_3);
		EndPos = refTool.GetTransformByKey(key_EndPos);
		Transform transformByKey = refTool.GetTransformByKey("player");
		playerActor = transformByKey.gameObject.AddComponent<SimplePlayerAdventureActor>();
		Transform transformByKey2 = refTool.GetTransformByKey("monster");
		monsterActor = transformByKey2.gameObject.AddComponent<SimpleMonsterAdventrueActor>();
		dicState.Add(Status.Enter, new EnterState(entity, this));
		dicState.Add(Status.FirstPart, new FirstPartState(entity, this));
		dicState.Add(Status.SencondPart, new SecondPartState(entity, this));
		dicState.Add(Status.ThirdPart, new ThirdPartState(entity, this));
		SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = false;
		SceneSingleton<AdventureIndicatorController>.Instance?.ShowHighlightBlob(show: false);
		cacheCameraBeacon = SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon;
	}

	public void OnDisable()
	{
	}

	public void OnLevelStart()
	{
		ChangeState(Status.Enter);
	}

	public void OnLevelStop()
	{
	}

	public void OnUpdate()
	{
		curState?.Update();
	}

	public void ChangeState(Status status)
	{
		if (curStatus != status)
		{
			_ = curState;
		}
		curState = dicState.get_Item(status);
		curState.Enter();
	}
}
