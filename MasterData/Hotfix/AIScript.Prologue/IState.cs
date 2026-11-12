using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Prologue;

public class IState
{
	private fsmStatus fsmStatus;

	public LogicEntity entity;

	public PrologueMgr prologueMgr;

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private Dictionary<WorldOBB, Action<WorldOBB>> dicObb = new Dictionary<WorldOBB, Action<WorldOBB>>();

	private List<WorldOBB> obbs = new List<WorldOBB>();

	public bool IsEnd => fsmStatus == fsmStatus.Exit;

	public SimpleMonsterAdventrueActor monsterActor => PrologueMgr.Ins.monsterActor;

	public SimplePlayerAdventureActor playerActor => PrologueMgr.Ins.playerActor;

	public IState(LogicEntity entity, PrologueMgr prologueMgr)
	{
		this.entity = entity;
		this.prologueMgr = prologueMgr;
	}

	public virtual void Enter()
	{
		fsmStatus = fsmStatus.Enter;
	}

	public virtual void Update()
	{
		for (int i = 0; i < obbs.Count; i++)
		{
			obbs.get_Item(i).OnUpdate(playerActor.transform.position);
		}
	}

	public virtual void Exit()
	{
		fsmStatus = fsmStatus.Exit;
		foreach (KeyValuePair<WorldOBB, Action<WorldOBB>> item in dicObb)
		{
			item.Key.RemoveListener(item.Value);
		}
		obbs.Clear();
		dicObb.Clear();
	}

	protected void StartCor(ref CoroutineNode cor, IEnumerator enumerator)
	{
		if (cor != null)
		{
			entity.StopLogicCoroutine(cor);
		}
		cor = entity.StartLogicCoroutine(enumerator);
	}

	protected void StopCor(ref CoroutineNode cor)
	{
		if (cor != null)
		{
			entity.StopLogicCoroutine(cor);
		}
		cor = null;
	}

	public void Register(WorldOBB worldOBB, Action<WorldOBB> cb)
	{
		obbs.Add(worldOBB);
		dicObb.Add(worldOBB, cb);
		worldOBB.AddListener(cb);
	}

	public void Register(List<WorldOBB> worldOBBs, Action<WorldOBB> cb)
	{
		for (int i = 0; i < worldOBBs.Count; i++)
		{
			Register(worldOBBs.get_Item(i), cb);
		}
	}
}
