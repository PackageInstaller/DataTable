using UnityEngine;

namespace Unity.VisualScripting;

public abstract class EventMachine<TGraph, TMacro> : Machine<TGraph, TMacro>, IEventMachine, IMachine, IGraphRoot, IGraphParent, IGraphNester, IAotStubbable where TGraph : class, IGraph, new() where TMacro : Macro<TGraph>, new()
{
	protected void TriggerEvent(string name)
	{
		if (hasGraph)
		{
			TriggerRegisteredEvent<EmptyEventArgs>(new EventHook(name, this), default);
		}
	}

	protected void TriggerEvent<TArgs>(string name, TArgs args)
	{
		if (hasGraph)
		{
			TriggerRegisteredEvent(new EventHook(name, this), args);
		}
	}

	protected void TriggerUnregisteredEvent(string name)
	{
		if (hasGraph)
		{
			TriggerUnregisteredEvent<EmptyEventArgs>(name, default);
		}
	}

	protected virtual void TriggerRegisteredEvent<TArgs>(EventHook hook, TArgs args)
	{
		EventBus.Trigger(hook, args);
	}

	protected virtual void TriggerUnregisteredEvent<TArgs>(EventHook hook, TArgs args)
	{
		using GraphStack graphStack = reference.ToStackPooled();
		graphStack.TriggerEventHandler((EventHook _hook) => _hook == hook, args, (IGraphParentElement parent) => true, force: true);
		graphStack.ClearReference();
	}

	protected override void Awake()
	{
		base.Awake();
		GlobalMessageListener.Require();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		TriggerEvent("OnEnable");
	}

	protected virtual void Start()
	{
		TriggerEvent("Start");
	}

	protected override void OnInstantiateWhileEnabled()
	{
		base.OnInstantiateWhileEnabled();
		TriggerEvent("OnEnable");
	}

	protected virtual void Update()
	{
		TriggerEvent("Update");
	}

	protected virtual void FixedUpdate()
	{
		TriggerEvent("FixedUpdate");
	}

	protected virtual void LateUpdate()
	{
		TriggerEvent("LateUpdate");
	}

	protected override void OnUninstantiateWhileEnabled()
	{
		TriggerEvent("OnDisable");
		base.OnUninstantiateWhileEnabled();
	}

	protected override void OnDisable()
	{
		TriggerEvent("OnDisable");
		base.OnDisable();
	}

	protected override void OnDestroy()
	{
		try
		{
			TriggerEvent("OnDestroy");
		}
		finally
		{
			base.OnDestroy();
		}
	}

	public override void TriggerAnimationEvent(AnimationEvent animationEvent)
	{
		TriggerEvent("AnimationEvent", animationEvent);
	}

	public override void TriggerUnityEvent(string name)
	{
		TriggerEvent("UnityEvent", name);
	}

	protected virtual void OnDrawGizmos()
	{
		TriggerUnregisteredEvent("OnDrawGizmos");
	}

	protected virtual void OnDrawGizmosSelected()
	{
		TriggerUnregisteredEvent("OnDrawGizmosSelected");
	}
}
