using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;

[RequireComponent(typeof(PlayableDirector))]
public class InteractiveBase : LogicEntity
{
	public class interactiveOperation
	{
		public bool iAwakeState;

		public bool iRefreshState;

		public Action _completeEvent;

		public InteractiveManager.processState _processState;

		public InteractiveBase _interactiveObj;

		public FP aniDurotion = 0;

		public FP switchTime = 0;

		public bool isActive = true;

		public bool isOpen0p()
		{
			InteractiveManager.processState processState = _processState;
			return processState == InteractiveManager.processState.state1 || processState == InteractiveManager.processState.active1 || processState == InteractiveManager.processState.deactive1;
		}

		public bool isNpcOp()
		{
			InteractiveManager.processState processState = _processState;
			return processState == InteractiveManager.processState.state1 || processState == InteractiveManager.processState.state0;
		}

		public bool afterCompleteRefesh()
		{
			if (iRefreshState)
			{
				return false;
			}
			return _processState != InteractiveManager.processState.destroy;
		}

		public bool logicUpdate(FP _dt)
		{
			aniDurotion -= _dt;
			if (switchTime > 0)
			{
				switchTime -= _dt;
				if (switchTime <= 0)
				{
					_interactiveObj.SetMeshCollider();
				}
			}
			return aniDurotion >= 0;
		}

		public void OnExcute(bool playerOp = false)
		{
			if (iAwakeState)
			{
				_interactiveObj.playBornSate();
			}
			else if (iRefreshState)
			{
				_interactiveObj.onRefreshState();
			}
			else
			{
				_interactiveObj.FireUiEvent();
				_interactiveObj.switchProcessState(_processState, playerOp);
			}
			if (switchTime <= 0)
			{
				_interactiveObj.SetMeshCollider();
			}
		}

		public void OnEnd()
		{
			isActive = false;
			_interactiveObj._interactiveState = _interactiveObj._tempInteractiveState;
			_interactiveObj.FireUiEvent(_interactiveObj.getUIActiveState());
			_interactiveObj.SetMeshCollider();
			_completeEvent?.Invoke();
			_interactiveObj.completeEventForTeleporter?.Invoke();
			if (_processState == InteractiveManager.processState.destroy)
			{
				_interactiveObj.interCollider?.SetNavmeshCut(active: false);
			}
		}
	}

	[HideInInspector]
	public int uid;

	protected string _uid;

	public bool defaultDeactive;

	public int iId;

	public int dataId;

	public bool battleStatCanTrigger;

	protected InterColliderCom interCollider;

	protected InteractiveAction interConfig;

	protected PlayableDirector _director;

	protected InteractiveManager.interactiveState _tempInteractiveState;

	[HideInInspector]
	public PlayerAdventureActor _actor;

	protected Action _completeEvent;

	public Action completeEventForTeleporter;

	public Action<InteractiveManager.processState> setStateEventForTeleporter;

	protected readonly List<interactiveOperation> interOperatons = new List<interactiveOperation>(3);

	private bool activeInterPos;

	private bool disableInput;

	private FP turnAroundTime = 0.1f;

	private FP toPointDis;

	private InteractiveManager.processState _inAC;

	private bool playerOpe;

	public TrueSyncTransform targrtPos;

	public bool tunOff = true;

	public TriggerCom adventureTriggerTask1_Tr;

	public TriggerCom adventureTriggerTask2_Tr;

	public TriggerCom adventureTriggerTaskP1_Tr;

	public TriggerCom adventureTriggerTaskP2_Tr;

	public InteractiveManager.interactiveState _interactiveState;

	public TimelinePlayerData[] pbDatas;

	public TimelinePlayerClip pbActive0;

	public TimelinePlayerClip pbActive1;

	public TimelinePlayerClip pbDeActive0;

	public TimelinePlayerClip pbDeActive1;

	protected FP oprateCd;

	protected FP moveCd;

	protected override void OnInit()
	{
		if (_director == null)
		{
			_director = GetComponent<PlayableDirector>();
		}
		interCollider = transform.GetComponentInChildren<InterColliderCom>(includeInactive: true);
		if (interCollider == null)
		{
			Debug.LogError("策划配置错误！缺少组件interCollider===" + gameObject.name);
		}
		else
		{
			interCollider.enabled = false;
		}
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
		if (interConfig == null)
		{
			interConfig = Singleton<HotfixDataController>.Instance.GetInteractiveAction(dataId);
		}
		regestListener(active: true);
		if (iId == 0)
		{
			iId = (int)Id;
		}
		Singleton<InteractiveManager>.Instance.AddInteractiveObj(this);
		initState();
		toPointDis = 0;
	}

	protected override void OnDeactive()
	{
		regestListener(active: false);
		Singleton<InteractiveManager>.Instance.removeInteractiveObj(this);
		if (interOperatons.Count > 0)
		{
			interOperatons.Clear();
		}
		_completeEvent = null;
		if (this is InteractiveTeleporter && activeInterPos)
		{
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
			if (disableInput)
			{
				SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
			}
			SceneSingleton<AdventureHUDController>.Instance.ShowAllHUD();
		}
	}

	protected virtual void regestListener(bool active)
	{
	}

	protected virtual bool deafaultActive()
	{
		return !defaultDeactive;
	}

	protected virtual bool initState()
	{
		if (deafaultActive())
		{
			interactiveOperation interactiveOperation2 = new interactiveOperation
			{
				iAwakeState = true,
				_interactiveObj = this
			};
			interOperatons.Add(interactiveOperation2);
			if (interOperatons.Count == 1)
			{
				interactiveOperation2.OnExcute();
			}
			return true;
		}
		gameObject.SetActive(value: false);
		return false;
	}

	protected virtual void SetMeshCollider()
	{
		InteractiveManager.interactiveState tempInteractiveState = _tempInteractiveState;
		bool meshCollider = tempInteractiveState == InteractiveManager.interactiveState.deactive0 || tempInteractiveState == InteractiveManager.interactiveState.deactive1;
		if (interCollider != null)
		{
			if (!interCollider.enabled)
			{
				interCollider.enabled = true;
			}
			interCollider?.SetMeshCollider(meshCollider);
		}
	}

	public void ForceActive()
	{
		defaultDeactive = false;
		gameObject.SetActive(value: true);
	}

	public virtual string GetInteractiveID()
	{
		if (string.IsNullOrEmpty(_uid))
		{
			if (iId <= 0)
			{
				iId = uid;
			}
			_uid = iId.ToString();
		}
		return _uid;
	}

	public virtual string GetBoxName()
	{
		return "";
	}

	public virtual bool IsBox()
	{
		return false;
	}

	public bool uiOperate(bool _playerOp = true)
	{
		if (_actor == null)
		{
			return false;
		}
		if (_playerOp)
		{
			if (oprateCd > 0)
			{
				return false;
			}
			oprateCd = 0.2;
		}
		playerOpe = _playerOp;
		return DoEventAction(_playerOp);
	}

	protected bool DoEventAction(bool _playerOp = true)
	{
		if (null == _actor)
		{
			return false;
		}
		if (!_actor.isControllable)
		{
			return false;
		}
		_inAC = InteractiveManager.processState.state0;
		InteractiveManager.interactiveState interactiveState = _interactiveState;
		if (interactiveState == InteractiveManager.interactiveState.active0 || interactiveState == InteractiveManager.interactiveState.deactive0)
		{
			_inAC = InteractiveManager.processState.state1;
		}
		if (!((_inAC != InteractiveManager.processState.state0) ? (_tempInteractiveState != InteractiveManager.interactiveState.active1 && _tempInteractiveState != InteractiveManager.interactiveState.deactive1) : (_tempInteractiveState != InteractiveManager.interactiveState.active0 && _tempInteractiveState != InteractiveManager.interactiveState.deactive0)))
		{
			return false;
		}
		if (this is InteractiveTeleporter && completeEventForTeleporter != null)
		{
			MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(0, "opendoor");
		}
		_actor.InterruptAttack(force: true);
		_actor.InterruptMovement();
		_actor.actorSkillManage.DestoryAllSkill();
		if (targrtPos != null)
		{
			targrtPos.RefreshTsPos();
		}
		if (targrtPos != null && _actor.QueryPositionReachable(targrtPos.Position))
		{
			MoveToPointOperate();
		}
		else
		{
			_actor.LookAt(tsTransform.Position, 0);
			SetProcessState(_inAC, null, _playerOp);
		}
		return true;
	}

	private void MoveToPointOperate(bool hideUi = true)
	{
		toPointDis = TSVector2.DistanceSquared(_actor.tsTransform.Position, targrtPos.Position);
		PlayerAdventureActor actor = _actor;
		if (hideUi)
		{
			disableInput = SceneSingleton<AdventurePlayerController>.Instance.inputEnabled;
			if (disableInput)
			{
				SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
			}
			SceneSingleton<AdventureHUDController>.Instance.HideAllHUD();
			if (this is InteractiveTeleporter)
			{
				activeInterPos = true;
				actor.Idle();
				SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
				MonoSingleton<LuaManager>.Instance.FireEvent("LEVEL_ON_TELEPORTER_TRIGGER_RUN");
				AdventureTriggerTeleportRunEvent aEvent = AdventureTriggerTeleportRunEvent.Generate();
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
			}
		}
		TSVector2 position = targrtPos.Position;
		FP stopDistance = 0;
		bool enableNavigation = !hideUi;
		Action onLeave = toOperate;
		if (!actor.MoveTo(position, stopDistance, enableNavigation, AdventureActor.MovementMode.Run, null, randomMove: false, forceMove: false, default, onLeave))
		{
			toOperate();
		}
	}

	private void toOperate()
	{
		if (_actor == null)
		{
			_actor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		}
		toPointDis = 0;
		if (tunOff)
		{
			_actor.LookAtDir(tsTransform.Position - targrtPos.Position, turnAroundTime, () =>
			{
				SetProcessState(_inAC, ShowUI, playerOpe);
			});
		}
		else
		{
			SetProcessState(_inAC, ShowUI, playerOpe);
		}
	}

	private void ShowUI()
	{
		if (_actor != null)
		{
			_actor.StopRotate();
		}
		if (this is InteractiveTeleporter)
		{
			if (_actor != null)
			{
				_actor.Action();
			}
			return;
		}
		if (disableInput)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		}
		SceneSingleton<AdventureHUDController>.Instance.ShowAllHUD();
	}

	public virtual bool getUIActiveState()
	{
		return _interactiveState switch
		{
			InteractiveManager.interactiveState.active0 => true, 
			InteractiveManager.interactiveState.active1 => iSwich(), 
			_ => false, 
		};
	}

	public virtual string getBtnIcon()
	{
		if (interConfig == null)
		{
			return "";
		}
		switch (_interactiveState)
		{
		case InteractiveManager.interactiveState.active0:
			return interConfig.Icon0;
		case InteractiveManager.interactiveState.active1:
			return interConfig.Icon1;
		default:
			throw new ArgumentOutOfRangeException();
		case InteractiveManager.interactiveState.deactive0:
		case InteractiveManager.interactiveState.deactive1:
			return "";
		}
	}

	public virtual string getBtnString()
	{
		if (interConfig == null)
		{
			return "";
		}
		return _interactiveState switch
		{
			InteractiveManager.interactiveState.active0 => interConfig.Title0, 
			InteractiveManager.interactiveState.active1 => interConfig.Title1, 
			_ => "", 
		};
	}

	protected virtual bool iSwich()
	{
		return false;
	}

	public virtual void FireUiEvent(bool active = false)
	{
		if (interOperatons.Count <= 0 || !interOperatons.get_Item(0).iAwakeState || !interOperatons.get_Item(0).isActive)
		{
			bool showUI = active && _actor != null;
			Singleton<InteractiveManager>.Instance.SetIneractiveUI(this, showUI);
		}
	}

	public void AddTargrtPos()
	{
		Transform transform = base.transform.FindInChildren("targrtPos");
		if (transform != null)
		{
			targrtPos = transform.GetComponent<TrueSyncTransform>();
			return;
		}
		GameObject gameObject = new GameObject("targrtPos");
		targrtPos = gameObject.AddComponent<TrueSyncTransform>();
		gameObject.transform.SetParent(base.transform);
	}

	public void Add0T1_Tr()
	{
		Transform transform = base.transform.FindInChildren("trigger021_Tr");
		if (transform != null)
		{
			adventureTriggerTask1_Tr = transform.GetComponent<TriggerCom>();
			return;
		}
		GameObject gameObject = new GameObject("trigger021_Tr");
		adventureTriggerTask1_Tr = gameObject.AddComponent<TriggerCom>();
		adventureTriggerTask1_Tr.defaultActive = true;
		adventureTriggerTask1_Tr.isInterActiveTrigger = true;
		gameObject.transform.SetParent(base.transform);
	}

	public void Add1T0_Tr()
	{
		Transform transform = base.transform.FindInChildren("trigger120_Tr");
		if (transform != null)
		{
			adventureTriggerTask2_Tr = transform.GetComponent<TriggerCom>();
			return;
		}
		GameObject gameObject = new GameObject("trigger120_Tr");
		adventureTriggerTask2_Tr = gameObject.AddComponent<TriggerCom>();
		adventureTriggerTask2_Tr.defaultActive = true;
		adventureTriggerTask2_Tr.isInterActiveTrigger = true;
		gameObject.transform.SetParent(base.transform);
	}

	public void Add0T1P_Tr()
	{
		Transform transform = base.transform.FindInChildren("trigger021P_Tr");
		if (transform != null)
		{
			adventureTriggerTaskP1_Tr = transform.GetComponent<TriggerCom>();
			return;
		}
		GameObject gameObject = new GameObject("trigger021P_Tr");
		adventureTriggerTaskP1_Tr = gameObject.AddComponent<TriggerCom>();
		adventureTriggerTaskP1_Tr.defaultActive = true;
		adventureTriggerTaskP1_Tr.isInterActiveTrigger = true;
		gameObject.transform.SetParent(base.transform);
	}

	public void Add1T0P_Tr()
	{
		Transform transform = base.transform.FindInChildren("trigger120P_Tr");
		if (transform != null)
		{
			adventureTriggerTaskP2_Tr = transform.GetComponent<TriggerCom>();
			return;
		}
		GameObject gameObject = new GameObject("trigger120P_Tr");
		adventureTriggerTaskP2_Tr = gameObject.AddComponent<TriggerCom>();
		adventureTriggerTaskP2_Tr.defaultActive = true;
		adventureTriggerTaskP2_Tr.isInterActiveTrigger = true;
		gameObject.transform.SetParent(base.transform);
	}

	private void RefrshConditions()
	{
	}

	protected void playBornSate()
	{
		_director.extrapolationMode = DirectorWrapMode.Hold;
		_tempInteractiveState = _interactiveState;
		TimelinePlayerData pbData = getPbData(InteractiveManager.typeState.pbBornClip);
		if (pbData != null)
		{
			playDirector(pbData.pbClip);
		}
	}

	protected void refreshState()
	{
		_director.extrapolationMode = DirectorWrapMode.Loop;
		interactiveOperation interactiveOperation2 = new interactiveOperation
		{
			iRefreshState = true,
			_interactiveObj = this
		};
		interOperatons.Add(interactiveOperation2);
		if (interOperatons.Count == 1)
		{
			interactiveOperation2.OnExcute();
		}
	}

	protected void onRefreshState()
	{
		TimelinePlayerClip pDirecClip = null;
		_tempInteractiveState = _interactiveState;
		switch (_interactiveState)
		{
		case InteractiveManager.interactiveState.active0:
			pDirecClip = pbActive0;
			break;
		case InteractiveManager.interactiveState.active1:
			pDirecClip = pbActive1;
			break;
		case InteractiveManager.interactiveState.deactive0:
			pDirecClip = pbDeActive0;
			break;
		case InteractiveManager.interactiveState.deactive1:
			pDirecClip = pbDeActive1;
			break;
		}
		playDirector(pDirecClip);
	}

	protected bool loadClip(TimelinePlayerClip clip)
	{
		if (_director == null || clip == null)
		{
			return false;
		}
		_director.playableAsset = clip.playableAsset;
		if (clip.bindingPairs != null)
		{
			for (int i = 0; i < clip.bindingPairs.Length; i++)
			{
				TimelinePlayerClip.BindingPair bindingPair = clip.bindingPairs[i];
				_director.SetGenericBinding(bindingPair.trackName, bindingPair.binding);
			}
		}
		return true;
	}

	protected bool playDirector(TimelinePlayerClip pDirecClip)
	{
		if (pDirecClip == null || pDirecClip.playableAsset == null)
		{
			_director.extrapolationMode = DirectorWrapMode.Hold;
			return false;
		}
		if (!loadClip(pDirecClip))
		{
			return false;
		}
		AdventureTimelinePlayer.BindCameraBrain(_director, MonoSingleton<GameCameraStackManager>.Instance.mainCameraBrain);
		_director.Play();
		interOperatons.get_Item(0).aniDurotion = Singleton<InteractiveManager>.Instance.getPbDuration(pDirecClip);
		return true;
	}

	protected override void OnLogicUpdate()
	{
		logicUpdate(LogicDeltaTime);
		oprateCd -= LogicDeltaTime;
		if (toPointDis <= 0)
		{
			return;
		}
		moveCd += LogicDeltaTime;
		if (!(moveCd <= 0.1))
		{
			moveCd = 0;
			if (_actor == null)
			{
				_actor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			}
			if (_actor.movementState == ActorState.StandBy)
			{
				MoveToPointOperate(hideUi: false);
			}
		}
	}

	protected void logicUpdate(FP _dt)
	{
		if (interOperatons.Count <= 0)
		{
			return;
		}
		if (!interOperatons.get_Item(0).logicUpdate(_dt))
		{
			onPlayableDirComplete();
		}
		if (interOperatons.Count > 0 && !interOperatons.get_Item(0).isActive)
		{
			bool flag = interOperatons.get_Item(0).afterCompleteRefesh();
			interOperatons.RemoveAt(0);
			if (interOperatons.Count > 0)
			{
				interOperatons.get_Item(0).OnExcute();
			}
			else if (flag)
			{
				refreshState();
			}
		}
	}

	protected void switchProcessState(InteractiveManager.processState _state, bool playerOp = false)
	{
		if (null == _director)
		{
			return;
		}
		_director.extrapolationMode = DirectorWrapMode.Hold;
		TimelinePlayerData pbData;
		if (_state == InteractiveManager.processState.destroy)
		{
			pbData = getPbData(InteractiveManager.typeState.destroyPb);
		}
		else
		{
			InteractiveManager.typeState pbName = Singleton<InteractiveManager>.Instance.GetPbName(_state, _interactiveState);
			Singleton<InteractiveManager>.Instance.refreshTypeState(pbName, ref _tempInteractiveState);
			pbData = getPbData(pbName);
			switch (pbName)
			{
			case InteractiveManager.typeState.active0ToActive1:
			case InteractiveManager.typeState.active0ToDeactive1:
			case InteractiveManager.typeState.deactive0ToActive1:
			case InteractiveManager.typeState.deactive0ToDeactive1:
				adventureTriggerTask1_Tr?.Initialize(-1, -1, iInteractive: true);
				if (playerOp)
				{
					adventureTriggerTaskP1_Tr?.Initialize(-1, -1, iInteractive: true);
				}
				break;
			case InteractiveManager.typeState.active1ToActive0:
			case InteractiveManager.typeState.active1ToDeactive0:
			case InteractiveManager.typeState.deactive1ToActive0:
			case InteractiveManager.typeState.deactive1ToDeactive0:
				adventureTriggerTask2_Tr?.Initialize(-1, -1, iInteractive: true);
				if (playerOp)
				{
					adventureTriggerTaskP2_Tr?.Initialize(-1, -1, iInteractive: true);
				}
				break;
			}
		}
		if (pbData != null)
		{
			interOperatons.get_Item(0).switchTime = pbData.bSwichTime;
			playDirector(pbData.pbClip);
		}
		setStateEventForTeleporter?.Invoke(_state);
	}

	protected TimelinePlayerData getPbData(InteractiveManager.typeState activeStateName)
	{
		if (activeStateName == InteractiveManager.typeState.pbNone)
		{
			return null;
		}
		TimelinePlayerData[] array = pbDatas;
		if (array == null || array.Length <= 0)
		{
			return null;
		}
		for (int i = 0; i < pbDatas.Length; i++)
		{
			if (pbDatas[i].checkByType(activeStateName))
			{
				return pbDatas[i];
			}
		}
		return null;
	}

	protected virtual void onPlayableDirComplete()
	{
		if (interOperatons.Count > 0)
		{
			interOperatons.get_Item(0).OnEnd();
		}
	}

	protected virtual void playAnimation()
	{
		if (_actor != null && interConfig != null && interConfig.PlayerAni)
		{
			_actor.EnterInteractive();
		}
	}

	public void SetProcessState(InteractiveManager.processState _state, Action onComplete = null, bool playerOp = false)
	{
		if (ActiveSelf)
		{
			if (this is InteractiveNpc && interOperatons.Count > 0 && (_state == InteractiveManager.processState.state1 || _state == InteractiveManager.processState.state0))
			{
				interOperatons.Clear();
			}
			interactiveOperation interactiveOperation2 = new interactiveOperation
			{
				iAwakeState = false,
				_interactiveObj = this,
				_processState = _state,
				_completeEvent = onComplete
			};
			interOperatons.Add(interactiveOperation2);
			if (interOperatons.Count == 1)
			{
				interactiveOperation2.OnExcute(playerOp);
			}
		}
	}
}
