using System;
using System.Collections.Generic;
using ACT.GameplayAbilitySystem;
using Bamboo.ECS;
using Fundamental;
using UnityEngine.Pool;

namespace ACT.Battle.ECS.System;

public class SystemGas : EntitySystem
{
	private const string GasEventWakeReason = "GAS";

	private Filter _filter;

	private EntityAction<CompGas> _fixedUpdateGasAction;

	private EntityAction _dispatchEventAction;

	private EntityAction<CompGas> _dispatchGasEventAction;

	private IGameplayEvent _dispatchEvent;

	private GasContext _dispatchContext;

	private readonly Dictionary<Type, object> _eventPoolDic = new Dictionary<Type, object>();

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompGas>().Build();
		_fixedUpdateGasAction = FixedUpdateGas;
		_dispatchEventAction = DispatchEventEntity;
		_dispatchGasEventAction = DispatchGasEventEntity;
	}

	public override void FixedUpdate()
	{
		_filter.ForEach(_fixedUpdateGasAction);
	}

	private void FixedUpdateGas(Entity entity, CompGas compGas)
	{
		if (entity.IsTickAvailable())
		{
			compGas.Tick();
		}
	}

	public T GetGameplayEvent<T>() where T : class, IGameplayEvent, new()
	{
		if (!_eventPoolDic.ContainsKey(typeof(T)))
		{
			_eventPoolDic.Add(typeof(T), new UnityEngine.Pool.ObjectPool<T>(() => new T()));
		}
		return ((UnityEngine.Pool.ObjectPool<T>)_eventPoolDic[typeof(T)]).Get();
	}

	public void RecycleGameplayEvent<T>(T eventToRecycle) where T : class, IGameplayEvent, new()
	{
		if (_eventPoolDic.ContainsKey(typeof(T)))
		{
			((UnityEngine.Pool.ObjectPool<T>)_eventPoolDic[typeof(T)]).Release(eventToRecycle);
		}
	}

	public void DispatchEvent(IGameplayEvent evt, GasContext context)
	{
		context.Event = evt;
		WakeTarget(context.Target, "GAS");
		_dispatchEvent = evt;
		_dispatchContext = context;
		_filter.ForEach(_dispatchEventAction);
		_dispatchEvent = null;
		_dispatchContext = default;
	}

	private void DispatchEventEntity(Entity entity)
	{
		entity.GetCompGas().CompDispatchEvent(_dispatchEvent, _dispatchContext);
	}

	public void DispatchEvent(IGameplayEvent evt, IGameplayComponent instigator, IGameplayComponent owner, IGameplayComponent target, GameplayAbility ability, GameplayEffect effect)
	{
		GasContext dispatchContext = new GasContext
		{
			Instigator = instigator,
			Owner = owner,
			Target = target,
			Ability = ability,
			Effect = effect,
			Event = evt
		};
		dispatchContext.Event = evt;
		WakeTarget(target, "GAS");
		_dispatchEvent = evt;
		_dispatchContext = dispatchContext;
		_filter.ForEach(_dispatchGasEventAction);
		_dispatchEvent = null;
		_dispatchContext = default;
	}

	private void DispatchGasEventEntity(Entity entity, CompGas compGas)
	{
		compGas.CompDispatchEvent(_dispatchEvent, _dispatchContext);
	}

	private static void WakeTarget(IGameplayComponent target, string reason)
	{
		if (target is CompGas compGas)
		{
			Singleton<GameManager>.instance?.ecsManager.systemEntityTickLOD?.Wake(compGas.OwnerEntity, reason);
		}
	}
}
