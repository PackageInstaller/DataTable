using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using TrueSync;
using UnityEngine;

public abstract class LogicEntity : MonoBehaviour, ILogicEntity, ICoroutineOwner
{
	private readonly List<ILogicComponent> logicComponents = new List<ILogicComponent>();

	private ILogicComponentVisualUpdate[] visualUpdateComponents;

	private ILogicComponentUpdate[] updateComponents;

	private static readonly Type visualUpdateType = typeof(ILogicComponentVisualUpdate);

	private static readonly Type updateType = typeof(ILogicComponentUpdate);

	private bool initialised;

	private int _logicUpdatePausedRC;

	internal bool _callLogicStartOnce;

	public bool useParentTimeScale;

	private AdventureTimeControlManager _logicTimeControlManager;

	protected LogManager.Logger _logger;

	public LogicEntity Parent { get; set; }

	public TrueSyncTransform tsTransform { get; private set; }

	public bool isInvalid => Id == -1;

	public long Id { get; set; } = -1L;

	public bool ActiveSelf
	{
		get
		{
			if (gameObject != null)
			{
				return gameObject.activeSelf;
			}
			return false;
		}
		set
		{
			if (gameObject != null)
			{
				gameObject.SetActive(value);
			}
		}
	}

	public bool ignoreGlobalLogicTimeScale { get; set; }

	public FP logicTimeScale { get; protected set; } = 1f;

	internal FP finalLogicTimeScale
	{
		get
		{
			if (!ignoreGlobalLogicTimeScale)
			{
				return TSMath.Max(FP.Zero, LockStepManager.logicTimeScale * logicTimeScale);
			}
			return FP.One;
		}
	}

	public FP LogicDeltaTime { get; protected set; } = 0f;

	public FP LogicTime { get; protected set; } = 0f;

	public bool logicUpdateEnabled { get; private set; }

	public bool logicUpdatePaused => _logicUpdatePausedRC > 0;

	protected AdventureTimeControlManager logicTimeControlManager => _logicTimeControlManager ?? (_logicTimeControlManager = new AdventureTimeControlManager(10));

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (this == obj)
		{
			return true;
		}
		if (obj.GetType() != GetType())
		{
			return false;
		}
		return Equals((LogicEntity)obj);
	}

	protected bool Equals(LogicEntity other)
	{
		if (base.Equals(other))
		{
			return Id == other.Id;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(base.GetHashCode(), Id);
	}

	protected virtual void OnActive()
	{
	}

	protected virtual void OnDeactive()
	{
	}

	protected virtual void OnInit()
	{
	}

	protected virtual void OnShutdown()
	{
	}

	public ILogicComponent AddLogicComponent(ILogicComponent component)
	{
		logicComponents.Add(component);
		component.SetEntity(this);
		if (initialised)
		{
			component.Init();
			if (ActiveSelf && component.ActiveSelf)
			{
				component.OnActive();
			}
		}
		return component;
	}

	public T AddMonoLogicComponent<T>() where T : Component, ILogicComponent
	{
		T component = gameObject.AddComponent<T>();
		return (T)AddLogicComponent(component);
	}

	public ILogicComponent GetLogicComponent(Type type)
	{
		for (int i = 0; i < logicComponents.Count; i++)
		{
			if (type.IsInstanceOfType(logicComponents.get_Item(i)))
			{
				return logicComponents.get_Item(i);
			}
		}
		return null;
	}

	public T GetLogicComponent<T>() where T : ILogicComponent
	{
		return (T)GetLogicComponent(typeof(T));
	}

	public T AddOrGetMonoLogicComponent<T>() where T : Component, ILogicComponent
	{
		T logicComponent = GetLogicComponent<T>();
		if (logicComponent != null)
		{
			return logicComponent;
		}
		logicComponent = GetComponent<T>();
		if (logicComponent != null)
		{
			return (T)AddLogicComponent(logicComponent);
		}
		return AddMonoLogicComponent<T>();
	}

	public T AddOrGetLogicComponent<T>() where T : ILogicComponent, new()
	{
		T logicComponent = GetLogicComponent<T>();
		if (logicComponent != null)
		{
			return logicComponent;
		}
		logicComponent = new T();
		return (T)AddLogicComponent(logicComponent);
	}

	private void Awake()
	{
		tsTransform = AddOrGetMonoLogicComponent<TrueSyncTransform>();
		_logger = (_logger = Singleton<LogManager>.Instance.get_Item("Logic_Entity"));
		OnInit();
		for (int i = 0; i < logicComponents.Count; i++)
		{
			logicComponents.get_Item(i)?.Init();
		}
		initialised = true;
	}

	private void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance?.RegisterEntity(this);
		_callLogicStartOnce = false;
		OnActive();
		for (int i = 0; i < logicComponents.Count; i++)
		{
			ILogicComponent logicComponent = logicComponents.get_Item(i);
			if (logicComponent != null && logicComponent.ActiveSelf)
			{
				logicComponent.OnActive();
			}
		}
		List<ILogicComponent> list = logicComponents.FindAll((ILogicComponent x) => visualUpdateType.IsInstanceOfType(x));
		if (list.Count > 0)
		{
			visualUpdateComponents = new ILogicComponentVisualUpdate[list.Count];
			for (int num = 0; num < list.Count; num++)
			{
				visualUpdateComponents[num] = (ILogicComponentVisualUpdate)list.get_Item(num);
			}
		}
		List<ILogicComponent> list2 = logicComponents.FindAll((ILogicComponent x) => updateType.IsInstanceOfType(x));
		if (list2.Count > 0)
		{
			updateComponents = new ILogicComponentUpdate[list2.Count];
			for (int num2 = 0; num2 < list2.Count; num2++)
			{
				updateComponents[num2] = (ILogicComponentUpdate)list2.get_Item(num2);
			}
		}
	}

	private void OnDisable()
	{
		OnDeactive();
		for (int i = 0; i < logicComponents.Count; i++)
		{
			if (logicComponents.get_Item(i).ActiveSelf)
			{
				logicComponents.get_Item(i).OnDeactive();
			}
		}
		DisableLogicUpdate();
		ModuleController<AdventureModuleController>.Instance?.UnRegisterEntity(this);
		Parent = null;
		logicTimeScale = FP.One;
		ignoreGlobalLogicTimeScale = false;
		LogicDeltaTime = FP.Zero;
		LogicTime = FP.Zero;
		_logicUpdatePausedRC = 0;
	}

	private void OnDestroy()
	{
		Id = -1L;
		OnShutdown();
		for (int i = 0; i < logicComponents.Count; i++)
		{
			logicComponents.get_Item(i)?.Shutdown();
		}
		logicComponents.Clear();
	}

	public void EnableLogicUpdate()
	{
		if (!logicUpdateEnabled)
		{
			logicUpdateEnabled = true;
			OnLogicUpdateEnabled();
		}
	}

	public void DisableLogicUpdate()
	{
		if (logicUpdateEnabled)
		{
			OnLogicUpdateDisabled();
			logicUpdateEnabled = false;
			TimeControlReset();
			if (ModuleController<AdventureModuleController>.Instance != null)
			{
				ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StopCoroutinesByOwner(this);
			}
		}
	}

	public void PauseLogicUpdate()
	{
		_logicUpdatePausedRC++;
		if (_logicUpdatePausedRC == 1)
		{
			OnLogicUpdatePaused();
		}
	}

	public void ResumeLogicUpdate()
	{
		_logicUpdatePausedRC--;
		if (_logicUpdatePausedRC == 0)
		{
			OnLogicUpdateResumed();
		}
		if (_logicUpdatePausedRC < 0)
		{
			_logicUpdatePausedRC = 0;
			Debug.LogWarning("PauseLogic与ResumeLogic使用不匹配");
		}
	}

	public void LogicStart()
	{
		OnLogicStart();
	}

	public void LogicUpdate()
	{
		UpdateTimeControl();
		LogicDeltaTime = (ignoreGlobalLogicTimeScale ? LockStepManager.unscaledDeltaTime : (LockStepManager.deltaTime * TSMath.Max(0f, logicTimeScale)));
		LogicTime += LogicDeltaTime;
		OnLogicUpdate();
		if (updateComponents == null)
		{
			return;
		}
		int num = updateComponents.Length;
		for (int i = 0; i < num; i++)
		{
			ILogicComponentUpdate logicComponentUpdate = updateComponents[i];
			if (logicComponentUpdate != null && logicComponentUpdate.ActiveSelf)
			{
				logicComponentUpdate.OnLogicUpdate();
			}
		}
	}

	protected virtual void OnLogicUpdateEnabled()
	{
	}

	protected virtual void OnLogicUpdateDisabled()
	{
	}

	protected virtual void OnLogicUpdatePaused()
	{
	}

	protected virtual void OnLogicUpdateResumed()
	{
	}

	protected virtual void OnLogicStart()
	{
	}

	protected virtual void OnLogicUpdate()
	{
	}

	protected virtual void OnLogicTimeScaleChanged()
	{
	}

	public AdventureTimeControlHandler LogicTimeScale(FP timeScale, AdventureTimeControlHandler.TimeScaleType _type = AdventureTimeControlHandler.TimeScaleType.Normal, FP transitionIn = default(FP), FP transitionOut = default(FP))
	{
		AdventureTimeControlHandler adventureTimeControlHandler = logicTimeControlManager.GenerateTimeControlHandler(isLogicTime: true);
		adventureTimeControlHandler.timeScaleTo = timeScale;
		adventureTimeControlHandler.duration = FP.MaxValue;
		adventureTimeControlHandler.transitionIn = transitionIn;
		adventureTimeControlHandler.transitionOut = transitionOut;
		adventureTimeControlHandler.timeScaleType = _type;
		return adventureTimeControlHandler;
	}

	public AdventureTimeControlHandler LogicTimeScale(FP timeScale, FP duration, AdventureTimeControlHandler.TimeScaleType _type = AdventureTimeControlHandler.TimeScaleType.Normal, FP transitionIn = default(FP), FP transitionOut = default(FP))
	{
		AdventureTimeControlHandler adventureTimeControlHandler = logicTimeControlManager.GenerateTimeControlHandler(isLogicTime: true);
		adventureTimeControlHandler.timeScaleTo = timeScale;
		adventureTimeControlHandler.duration = duration;
		adventureTimeControlHandler.transitionIn = transitionIn;
		adventureTimeControlHandler.transitionOut = transitionOut;
		adventureTimeControlHandler.timeScaleType = _type;
		return adventureTimeControlHandler;
	}

	public void TimeControlReset()
	{
		_logicTimeControlManager?.Stop();
		logicTimeScale = FP.One;
	}

	public void TimeControlResetForFreezeFrame()
	{
		_logicTimeControlManager?.StopByType(AdventureTimeControlHandler.TimeScaleType.FreezeFrame);
	}

	protected void UpdateTimeControl()
	{
		if (useParentTimeScale && Parent != null)
		{
			ignoreGlobalLogicTimeScale = Parent.ignoreGlobalLogicTimeScale;
			logicTimeScale = Parent.logicTimeScale;
		}
		else if (_logicTimeControlManager != null)
		{
			if (ModuleController<AdventureModuleController>.Instance.InGlobalFreezeFrame())
			{
				TimeControlResetForFreezeFrame();
			}
			FP fP = (ignoreGlobalLogicTimeScale ? LockStepManager.unscaledDeltaTime : LockStepManager.deltaTime);
			_logicTimeControlManager.Update(fP, fP);
			if (logicTimeScale != _logicTimeControlManager.finalLogicScaleValue)
			{
				logicTimeScale = _logicTimeControlManager.finalLogicScaleValue;
			}
		}
	}

	public CoroutineNode StartLogicCoroutine(IEnumerator routine, bool runImmediately = false)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			return ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StartCoroutine(routine, this, runImmediately);
		}
		return null;
	}

	public void StopLogicCoroutine(CoroutineNode coroutine)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StopCoroutine(coroutine);
		}
	}

	public bool IsCoroutineAlive()
	{
		return logicUpdateEnabled;
	}

	public bool IsCoroutineRunning()
	{
		return _logicUpdatePausedRC == 0;
	}

	public FP GetCoroutineDeltaTime()
	{
		return LogicDeltaTime;
	}

	public void VisualUpdate()
	{
		if (!ActiveSelf)
		{
			return;
		}
		OnVisualUpdate();
		if (visualUpdateComponents == null)
		{
			return;
		}
		int num = visualUpdateComponents.Length;
		for (int i = 0; i < num; i++)
		{
			ILogicComponentVisualUpdate logicComponentVisualUpdate = visualUpdateComponents[i];
			if (logicComponentVisualUpdate != null && logicComponentVisualUpdate.ActiveSelf)
			{
				logicComponentVisualUpdate.OnVisualUpdate();
			}
		}
	}

	protected virtual void OnVisualUpdate()
	{
	}

	[DebuggerHidden]
	internal void Log(string message)
	{
		_logger.LogInfo("[" + gameObject.name + "] " + message);
	}

	[DebuggerHidden]
	internal void LogWarning(string message)
	{
		_logger.LogWarning("[" + gameObject.name + "] " + message);
	}

	[DebuggerHidden]
	internal void LogError(string message)
	{
		_logger.LogError("[" + gameObject.name + "] " + message);
	}

	public static bool operator ==(LogicEntity entityA, LogicEntity entityB)
	{
		if ((UnityEngine.Object)entityA == (UnityEngine.Object)entityB)
		{
			if ((object)entityA != null && (object)entityB != null)
			{
				return entityA.Id == entityB.Id;
			}
			return true;
		}
		return false;
	}

	public static bool operator !=(LogicEntity entityA, LogicEntity entityB)
	{
		return !(entityA == entityB);
	}
}
