using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.World.Actions;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.StateObject;

[Serializable]
public class InteractState
{
	public int id;

	[Tooltip("进入此状态需要在服务器存档？")]
	public bool serviceSave;

	private InteractObject interactObject;

	[Tooltip("加载交互物时执行")]
	public InteractActionList initStateObjectActionList = new InteractActionList();

	[Tooltip("在初始化状态时执行")]
	public InteractActionList initActionList = new InteractActionList();

	[Tooltip("在当前状态完成过渡时执行")]
	public InteractActionList completeTransitionActionList = new InteractActionList();

	[Tooltip("在卸载状态时执行")]
	public InteractActionList uninitActionList = new InteractActionList();

	public List<InteractEntry> interactEntries = new List<InteractEntry>();

	[Tooltip("退出到指定状态时是否使用过渡")]
	public List<int> transition = new List<int>();

	public void BindInteractObject(InteractObject interactObject)
	{
		this.interactObject = interactObject;
		initStateObjectActionList.BindInteractObject(interactObject);
		initActionList.BindInteractObject(interactObject);
		completeTransitionActionList.BindInteractObject(interactObject);
		uninitActionList.BindInteractObject(interactObject);
		for (int i = 0; i < interactEntries.Count; i++)
		{
			interactEntries[i].BindInteractObjectBase(interactObject);
			interactEntries[i].BindInteractState(id, i);
		}
	}

	public async void OnInitStateObject()
	{
		foreach (InteractAction interactAction in initStateObjectActionList.interactActions)
		{
			if (interactAction != null)
			{
				await interactAction.TryInteract(default);
			}
		}
	}

	public async void OnInit(int stateId)
	{
		foreach (InteractEntry interactEntry in interactEntries)
		{
			interactEntry?.HandleInit();
		}
		foreach (InteractAction interactAction in initActionList.interactActions)
		{
			if (interactAction != null)
			{
				await interactAction.TryInteract(default);
			}
		}
	}

	public async void OnUnInit(int stateId)
	{
		foreach (InteractEntry interactEntry in interactEntries)
		{
			interactEntry?.HandleUninit();
		}
		foreach (InteractAction interactAction in uninitActionList.interactActions)
		{
			if (interactAction != null)
			{
				await interactAction.TryInteract(default);
			}
		}
	}

	public void OnEnter()
	{
		foreach (InteractEntry interactEntry in interactEntries)
		{
			interactEntry?.HandleEnter();
		}
	}

	public void OnExit()
	{
		foreach (InteractEntry interactEntry in interactEntries)
		{
			interactEntry?.HandleExit();
		}
	}

	public void OnCompleteTransition()
	{
		foreach (InteractAction interactAction in completeTransitionActionList.interactActions)
		{
			interactAction?.TryInteract(default);
		}
	}

	public void OnExposed()
	{
		CompTime compTime = interactObject.entity.GetCompTime();
		foreach (InteractEntry interactEntry in interactEntries)
		{
			interactEntry?.AddTimer(compTime.fixedDeltaTime);
		}
	}

	public void OnExitExposed()
	{
		foreach (InteractEntry interactEntry in interactEntries)
		{
			interactEntry?.OnExitExpose();
		}
	}
}
