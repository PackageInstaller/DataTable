using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class InteractiveManager : Singleton<InteractiveManager>
{
	public enum processState
	{
		[InspectorName("可交互")]
		active,
		[InspectorName("不可交互")]
		deactive,
		[InspectorName("状态0")]
		state0,
		[InspectorName("状态1")]
		state1,
		[InspectorName("销毁")]
		destroy,
		[InspectorName("可交互0")]
		active0,
		[InspectorName("可交互1")]
		active1,
		[InspectorName("不可交互0")]
		deactive0,
		[InspectorName("不可交互1")]
		deactive1
	}

	public enum interactiveState
	{
		[InspectorName("可交互0")]
		active0,
		[InspectorName("可交互1")]
		active1,
		[InspectorName("不可交互0")]
		deactive0,
		[InspectorName("不可交互1")]
		deactive1
	}

	public enum typeState
	{
		[InspectorName("无")]
		pbNone,
		[InspectorName("出生动画")]
		pbBornClip,
		[InspectorName("可交互0->可交互1")]
		active0ToActive1,
		[InspectorName("可交互0->不可交互0")]
		active0ToDeactive0,
		[InspectorName("可交互0->不可交互1")]
		active0ToDeactive1,
		[InspectorName("可交互1->可交互0")]
		active1ToActive0,
		[InspectorName("可交互1->不可交互0")]
		active1ToDeactive0,
		[InspectorName("可交互1->不可交互1")]
		active1ToDeactive1,
		[InspectorName("不可交互0->可交互0")]
		deactive0ToActive0,
		[InspectorName("不可交互0->可交互1")]
		deactive0ToActive1,
		[InspectorName("不可交互0->不可交互1")]
		deactive0ToDeactive1,
		[InspectorName("不可交互1->可交互0")]
		deactive1ToActive0,
		[InspectorName("不可交互1->可交互1")]
		deactive1ToActive1,
		[InspectorName("不可交互1->不可交互0")]
		deactive1ToDeactive0,
		[InspectorName("销毁动画")]
		destroyPb
	}

	public int _Uid;

	private readonly Dictionary<string, InteractiveBase> interactiveLs = new Dictionary<string, InteractiveBase>(30);

	private readonly List<InteractiveBase> interBoxLs = new List<InteractiveBase>(20);

	private readonly List<InteractiveBase> deactiveInters = new List<InteractiveBase>(10);

	private readonly List<TriggerInteractiveOperate> tOperateS = new List<TriggerInteractiveOperate>(5);

	private readonly List<TriggerInteractiveOperate> removeOps = new List<TriggerInteractiveOperate>(5);

	private readonly List<InteractiveGroup> _interactiveGroups = new List<InteractiveGroup>(5);

	private readonly List<InteractiveBase> _activeList = new List<InteractiveBase>(3);

	public void ClearData()
	{
		interactiveLs.Clear();
		interBoxLs.Clear();
		deactiveInters.Clear();
		tOperateS.Clear();
		removeOps.Clear();
		_interactiveGroups.Clear();
		_activeList.Clear();
	}

	public void AddInteractiveGroup(InteractiveGroup _interGroup)
	{
		_interactiveGroups.Add(_interGroup);
	}

	public void AddInteractiveObj(InteractiveBase interactiveObj)
	{
		interactiveObj.uid = _Uid++;
		if (interactiveObj.IsBox())
		{
			interBoxLs.Add(interactiveObj);
		}
		string interactiveID = interactiveObj.GetInteractiveID();
		if (!interactiveLs.TryAdd(interactiveID, interactiveObj))
		{
			Debug.LogError("配置了相同的交互物uid==" + interactiveObj.gameObject.name);
		}
		if (interactiveObj.defaultDeactive && !deactiveInters.Contains(interactiveObj))
		{
			deactiveInters.Add(interactiveObj);
		}
	}

	public void removeInteractiveObj(InteractiveBase interactiveObj)
	{
		if (interactiveObj.IsBox())
		{
			interBoxLs.Remove(interactiveObj);
		}
		interactiveLs.Remove(interactiveObj.GetInteractiveID());
	}

	public bool setInteractiveObjState(string id)
	{
		if (interactiveLs.TryGetValue(id, out var value))
		{
			return value.uiOperate();
		}
		return false;
	}

	public void triggerInteractiveObjState(string id)
	{
		if (interactiveLs.TryGetValue(id, out var value))
		{
			value.uiOperate(_playerOp: false);
		}
	}

	public void setInteractiveNpcState(string id)
	{
		if (interactiveLs.TryGetValue(id, out var value) && value is InteractiveNpc interactiveNpc)
		{
			interactiveNpc.setNpcState();
		}
	}

	public void setInteractiveObjActiveState(string id, processState _activeState, Action onComplete)
	{
		if (interactiveLs.TryGetValue(id, out var value))
		{
			value.SetProcessState(_activeState, onComplete);
		}
		else
		{
			if (interBoxLs.Count <= 0)
			{
				return;
			}
			for (int i = 0; i < interBoxLs.Count; i++)
			{
				if (interBoxLs.get_Item(i).GetBoxName() == id)
				{
					interBoxLs.get_Item(i).SetProcessState(_activeState, onComplete);
				}
			}
		}
	}

	public void setInteractiveObjInterState(string id, processState _interactiveState, Action onComplete)
	{
		if (interactiveLs.TryGetValue(id, out var value))
		{
			value.SetProcessState(_interactiveState, onComplete);
		}
		else
		{
			if (interBoxLs.Count <= 0)
			{
				return;
			}
			for (int i = 0; i < interBoxLs.Count; i++)
			{
				if (interBoxLs.get_Item(i).GetBoxName() == id)
				{
					interBoxLs.get_Item(i).SetProcessState(_interactiveState, onComplete);
				}
			}
		}
	}

	public void ForceActiveInterObj(string groupTitle, string id)
	{
		if (!string.IsNullOrEmpty(groupTitle))
		{
			for (int i = 0; i < _interactiveGroups.Count; i++)
			{
				if (_interactiveGroups.get_Item(i).groupTitle == groupTitle)
				{
					_interactiveGroups.get_Item(i).ForceActive();
				}
			}
		}
		if (string.IsNullOrEmpty(id))
		{
			return;
		}
		for (int j = 0; j < deactiveInters.Count; j++)
		{
			if (deactiveInters.get_Item(j).GetInteractiveID() == id)
			{
				deactiveInters.get_Item(j).ForceActive();
			}
		}
	}

	public void setInteractiveInterActiveByGroup(string groupTitle, processState _interactiveState)
	{
		for (int i = 0; i < _interactiveGroups.Count; i++)
		{
			if (_interactiveGroups.get_Item(i).groupTitle == groupTitle)
			{
				_interactiveGroups.get_Item(i).setIneractiveInerState(_interactiveState);
			}
		}
	}

	public void addopTiggerOpListener(TriggerInteractiveOperate oprate)
	{
		if (oprate.uid == 0)
		{
			_Uid++;
			oprate.uid = _Uid;
		}
		if (!tOperateS.Contains(oprate))
		{
			tOperateS.Add(oprate);
		}
	}

	public void removeTiggerOpListener(TriggerInteractiveOperate oprate)
	{
		removeOps.Add(oprate);
	}

	public void triggerOpListener(int opId)
	{
		triggerOpListener(opId.ToString());
	}

	public void triggerOpListener(string opId)
	{
		AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = AdventureInteractiveIDTrigger.Generate();
		adventureInteractiveIDTrigger.interactiveID = opId;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveIDTrigger);
		for (int i = 0; i < tOperateS.Count; i++)
		{
			tOperateS.get_Item(i).triggerOp(opId);
		}
		if (removeOps.Count > 0)
		{
			for (int j = 0; j < removeOps.Count; j++)
			{
				tOperateS.Remove(removeOps.get_Item(j));
			}
			removeOps.Clear();
		}
	}

	public FP getPbDuration(TimelinePlayerClip pDirecClip)
	{
		if (pDirecClip == null || pDirecClip.playableAsset == null)
		{
			return 0;
		}
		if (pDirecClip.longDuration > 0)
		{
			return FP.FromMyriad(pDirecClip.longDuration);
		}
		return pDirecClip.playableAsset.duration;
	}

	public typeState GetPbName(processState state, interactiveState _interactiveState)
	{
		typeState result = typeState.pbNone;
		switch (_interactiveState)
		{
		case interactiveState.active0:
			switch (state)
			{
			case processState.state1:
			case processState.active1:
				result = typeState.active0ToActive1;
				break;
			case processState.deactive:
			case processState.deactive0:
				result = typeState.active0ToDeactive0;
				break;
			case processState.deactive1:
				result = typeState.active0ToDeactive1;
				break;
			}
			break;
		case interactiveState.active1:
			switch (state)
			{
			case processState.state0:
			case processState.active0:
				result = typeState.active1ToActive0;
				break;
			case processState.deactive:
			case processState.deactive1:
				result = typeState.active1ToDeactive1;
				break;
			case processState.deactive0:
				result = typeState.active1ToDeactive0;
				break;
			}
			break;
		case interactiveState.deactive0:
			switch (state)
			{
			case processState.state1:
			case processState.deactive1:
				result = typeState.deactive0ToDeactive1;
				break;
			case processState.active:
			case processState.active0:
				result = typeState.deactive0ToActive0;
				break;
			case processState.active1:
				result = typeState.deactive0ToActive1;
				break;
			}
			break;
		case interactiveState.deactive1:
			switch (state)
			{
			case processState.state0:
			case processState.deactive0:
				result = typeState.deactive1ToDeactive0;
				break;
			case processState.active:
			case processState.active1:
				result = typeState.deactive1ToActive1;
				break;
			case processState.active0:
				result = typeState.deactive1ToActive0;
				break;
			}
			break;
		}
		return result;
	}

	public void refreshTypeState(typeState _type, ref interactiveState _tempInteractiveState)
	{
		switch (_type)
		{
		case typeState.active1ToActive0:
		case typeState.deactive0ToActive0:
		case typeState.deactive1ToActive0:
			_tempInteractiveState = interactiveState.active0;
			break;
		case typeState.active0ToActive1:
		case typeState.deactive0ToActive1:
		case typeState.deactive1ToActive1:
			_tempInteractiveState = interactiveState.active1;
			break;
		case typeState.active0ToDeactive0:
		case typeState.active1ToDeactive0:
		case typeState.deactive1ToDeactive0:
			_tempInteractiveState = interactiveState.deactive0;
			break;
		case typeState.active0ToDeactive1:
		case typeState.active1ToDeactive1:
		case typeState.deactive0ToDeactive1:
			_tempInteractiveState = interactiveState.deactive1;
			break;
		}
	}

	public static FP getLogicDeletaTime()
	{
		if (!(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null))
		{
			return LockStepManager.unscaledDeltaTime;
		}
		return SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.LogicDeltaTime;
	}

	public void SetIneractiveUI(InteractiveBase _activeObj, bool showUI)
	{
		if ((!_activeObj.battleStatCanTrigger && ModuleController<AdventureModuleController>.Instance.InBattleState) & showUI)
		{
			return;
		}
		if (showUI)
		{
			if (!_activeList.Contains(_activeObj))
			{
				_activeList.Add(_activeObj);
			}
		}
		else if (_activeList.Contains(_activeObj))
		{
			_activeList.Remove(_activeObj);
		}
		if (_activeList.Count > 0)
		{
			InteractiveBase interactiveBase = _activeList.get_Item(0);
			MonoSingleton<LuaManager>.Instance?.FireEvent("interactiveUI", interactiveBase.GetInteractiveID(), a2: true, interactiveBase.getBtnIcon(), interactiveBase.getBtnString(), 0);
			AdventureInteractiveUITrigger adventureInteractiveUITrigger = AdventureInteractiveUITrigger.Generate();
			adventureInteractiveUITrigger.interactiveID = interactiveBase.GetInteractiveID();
			adventureInteractiveUITrigger.showUI = true;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveUITrigger);
		}
		else
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("interactiveUI", _activeObj.GetInteractiveID(), a2: false, _activeObj.getBtnIcon(), _activeObj.getBtnString(), 0);
			AdventureInteractiveUITrigger adventureInteractiveUITrigger2 = AdventureInteractiveUITrigger.Generate();
			adventureInteractiveUITrigger2.interactiveID = _activeObj.GetInteractiveID();
			adventureInteractiveUITrigger2.showUI = false;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureInteractiveUITrigger2);
		}
	}
}
