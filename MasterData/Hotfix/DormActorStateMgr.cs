#define LOG_ERROR
using System.Collections.Generic;
using UnityEngine;

public class DormActorStateMgr
{
	private DormActor owner;

	private Dictionary<DormActor.DormActorState, IDormActorFSM> fsmDic;

	private IDormActorFSM curFSM;

	public DormActor.DormActorState State
	{
		get
		{
			if (curFSM != null)
			{
				return (DormActor.DormActorState)curFSM.State;
			}
			return DormActor.DormActorState.None;
		}
	}

	public DormActorStateMgr(DormActor owner)
	{
		this.owner = owner;
	}

	public void Register(DormActor.DormActorState state)
	{
		if (fsmDic == null)
		{
			fsmDic = new Dictionary<DormActor.DormActorState, IDormActorFSM>();
		}
		if (!fsmDic.TryGetValue(state, out var _))
		{
			switch (state)
			{
			case DormActor.DormActorState.None:
				fsmDic.Add(state, new DormActorFSM(owner, (int)state));
				break;
			case DormActor.DormActorState.Control:
				fsmDic.Add(state, new DormActorFSM_Control(owner, (int)state));
				break;
			case DormActor.DormActorState.Rome:
				fsmDic.Add(state, new DormActorFSM_Rome(owner, (int)state));
				break;
			case DormActor.DormActorState.Noticed:
				fsmDic.Add(state, new DormActorFSM_Noticed(owner, (int)state));
				break;
			case DormActor.DormActorState.Hover:
				fsmDic.Add(state, new DormActorFSM_Hover(owner, (int)state));
				break;
			case DormActor.DormActorState.Interactive:
				fsmDic.Add(state, new DormActorFSM_Interactive(owner, (int)state));
				break;
			case DormActor.DormActorState.Hide:
				fsmDic.Add(state, new DormActorFSM_Hide(owner, (int)state));
				break;
			default:
				NovaLogger.Error($"错误的后宅角色状态类型:{state}");
				break;
			}
		}
		else
		{
			NovaLogger.Error($"重复注册已有的后宅角色状态类型:{state}");
		}
	}

	public IDormActorFSM GetFSM(DormActor.DormActorState state)
	{
		if (fsmDic == null)
		{
			return null;
		}
		if (!fsmDic.TryGetValue(state, out var value))
		{
			return null;
		}
		return value;
	}

	public void UnRegister(DormActor.DormActorState state)
	{
		IDormActorFSM value;
		if (fsmDic == null)
		{
			NovaLogger.Error("后宅角色状态机为空!");
		}
		else if (!fsmDic.TryGetValue(state, out value))
		{
			NovaLogger.Error($"后宅角色状态机不包含状态:{state}!");
		}
		else
		{
			fsmDic.Remove(state);
		}
	}

	public void Switch(DormActor.DormActorState state, object data = null)
	{
		if (!fsmDic.TryGetValue(state, out var value))
		{
			NovaLogger.Error($"后宅角色{owner.name}不包含该状态机:{state}");
			return;
		}
		if (curFSM != null)
		{
			if (state == (DormActor.DormActorState)curFSM.State)
			{
				NovaLogger.Error($"后宅角色{owner.name}重复进入状态机:{state}");
				return;
			}
			curFSM.OnExit();
		}
		curFSM = value;
		value.OnEnter(data);
	}

	public void Update()
	{
		curFSM?.OnUpdate();
	}

	public void LateUpdate()
	{
		curFSM?.OnLateUpdate();
	}

	public void OnInputUpdate(bool movementHasInput, Vector2 inputValue, bool bWalk = false)
	{
		curFSM?.OnInputUpdate(movementHasInput, inputValue, bWalk);
	}
}
