using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[DefaultExecutionOrder(-100)]
public class MathTriggerSystem : Singleton<MathTriggerSystem>, ISingletonAwake
{
	private struct TriggerPair : IEquatable<TriggerPair>
	{
		public GameObject Trigger;

		public GameObject Other;

		public int RefCount;

		private static readonly Stack<TriggerPair> _pool = new Stack<TriggerPair>();

		public static TriggerPair Get(GameObject trigger, GameObject other)
		{
			TriggerPair result = ((_pool.Count <= 0) ? default(TriggerPair) : _pool.Pop());
			result.Trigger = trigger;
			result.Other = other;
			result.RefCount = 1;
			return result;
		}

		public void AddRef()
		{
			RefCount++;
		}

		public void Release()
		{
			RefCount--;
			if (RefCount <= 0)
			{
				Trigger = null;
				Other = null;
				_pool.Push(this);
			}
		}

		public bool Equals(TriggerPair other)
		{
			if (Trigger == other.Trigger)
			{
				return Other == other.Other;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is TriggerPair other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (Trigger.GetHashCode() * 397) ^ Other.GetHashCode();
		}
	}

	private readonly List<IMathTrigger> _dynamicTriggers = new List<IMathTrigger>();

	private readonly List<IMathTriggerable> _triggerables = new List<IMathTriggerable>();

	private readonly Dictionary<GameObject, List<IMathTriggerEventHandler>> _handlerCache = new Dictionary<GameObject, List<IMathTriggerEventHandler>>();

	private BoundsOctree<IMathTrigger> _octree;

	private float boundSize = 5f;

	private float _checkInterval = 0.033f;

	private float _nextCheckTime;

	private MathTriggerEventData _eventData;

	private List<IMathTrigger> _collidingWith = new List<IMathTrigger>();

	private List<IMathTrigger> _lastFrameCollidingWith = new List<IMathTrigger>();

	private HashSet<IMathTrigger> _checkedTriggers;

	private bool isStart;

	private HashSet<TriggerPair> _lastFrameInsider = new HashSet<TriggerPair>();

	private HashSet<TriggerPair> _currentFrameInsider = new HashSet<TriggerPair>();

	public void Awake()
	{
		_octree = new BoundsOctree<IMathTrigger>(300f, Vector3.zero, boundSize, boundSize);
		_checkedTriggers = new HashSet<IMathTrigger>(30);
	}

	public void OnStart()
	{
		isStart = true;
	}

	public void OnUpdate()
	{
		if (isStart && Time.time >= _nextCheckTime)
		{
			_nextCheckTime = Time.time + _checkInterval;
			CheckAllTriggers();
		}
	}

	public void ResetTriggerDatas()
	{
		if (_collidingWith != null)
		{
			_collidingWith.Clear();
		}
		if (_lastFrameCollidingWith != null)
		{
			_lastFrameCollidingWith.Clear();
		}
		if (_lastFrameInsider != null)
		{
			_lastFrameInsider.Clear();
		}
		if (_currentFrameInsider != null)
		{
			_currentFrameInsider.Clear();
		}
	}

	public void RegisterTrigger(IMathTrigger trigger)
	{
		if (trigger.Dynamic)
		{
			if (!_dynamicTriggers.Contains(trigger))
			{
				_dynamicTriggers.Add(trigger);
			}
		}
		else
		{
			_octree.Add(trigger, trigger.Bounds());
		}
		GameObject owner = trigger.Owner;
		if (owner != null)
		{
			List<IMathTriggerEventHandler> list = new List<IMathTriggerEventHandler>();
			owner.GetComponents(list);
			_handlerCache[owner] = list;
		}
	}

	public void UnregisterTrigger(IMathTrigger trigger)
	{
		if (trigger.Dynamic)
		{
			if (_dynamicTriggers.Contains(trigger))
			{
				_dynamicTriggers.Remove(trigger);
			}
		}
		else
		{
			_octree.Remove(trigger);
		}
		GameObject owner = trigger.Owner;
		if (owner != null && _handlerCache.ContainsKey(owner))
		{
			_handlerCache.Remove(owner);
		}
	}

	public void RegisterTriggerable(IMathTriggerable triggerable)
	{
		if (!_triggerables.Contains(triggerable))
		{
			_triggerables.Add(triggerable);
		}
	}

	public void UnregisterTriggerable(IMathTriggerable triggerable)
	{
		_triggerables.Remove(triggerable);
	}

	private void CheckAllTriggers()
	{
		if (_triggerables.Count == 0)
		{
			return;
		}
		IMathTriggerable mathTriggerable = null;
		foreach (IMathTriggerable triggerable in _triggerables)
		{
			if (triggerable.IsActor)
			{
				mathTriggerable = triggerable;
				break;
			}
		}
		if (mathTriggerable == null)
		{
			return;
		}
		GameObject owner = mathTriggerable.Owner;
		if (!owner || !owner.activeInHierarchy)
		{
			return;
		}
		foreach (IMathTrigger item in _lastFrameCollidingWith)
		{
			if (item != null && item.Vaild)
			{
				ExecuteTrigger(mathTriggerable, item, owner);
				_checkedTriggers.Add(item);
			}
		}
		foreach (IMathTrigger dynamicTrigger in _dynamicTriggers)
		{
			if (dynamicTrigger != null && dynamicTrigger.Vaild && !_checkedTriggers.Contains(dynamicTrigger))
			{
				ExecuteTrigger(mathTriggerable, dynamicTrigger, owner);
				_checkedTriggers.Add(dynamicTrigger);
			}
		}
		_octree.GetColliding(_collidingWith, mathTriggerable.Bounds());
		foreach (IMathTrigger item2 in _collidingWith)
		{
			if (item2 != null && item2.Vaild && !_checkedTriggers.Contains(item2))
			{
				ExecuteTrigger(mathTriggerable, item2, owner);
			}
		}
		_checkedTriggers.Clear();
		foreach (TriggerPair item3 in _lastFrameInsider)
		{
			item3.Release();
		}
		List<IMathTrigger> collidingWith = _collidingWith;
		List<IMathTrigger> lastFrameCollidingWith = _lastFrameCollidingWith;
		_lastFrameCollidingWith = collidingWith;
		_collidingWith = lastFrameCollidingWith;
		HashSet<TriggerPair> currentFrameInsider = _currentFrameInsider;
		HashSet<TriggerPair> lastFrameInsider = _lastFrameInsider;
		_lastFrameInsider = currentFrameInsider;
		_currentFrameInsider = lastFrameInsider;
		_currentFrameInsider.Clear();
		_collidingWith.Clear();
	}

	private void ExecuteTrigger(IMathTriggerable triggerable, IMathTrigger trigger, GameObject otherGo)
	{
		if (trigger == null)
		{
			return;
		}
		GameObject owner = trigger.Owner;
		if ((bool)owner && owner.activeInHierarchy && !(otherGo == owner))
		{
			TriggerPair item = TriggerPair.Get(owner, otherGo);
			bool flag = trigger.Intersects(triggerable.Bounds());
			bool flag2 = _lastFrameInsider.Contains(item);
			_eventData.Triggerer = owner;
			_eventData.Other = otherGo;
			if (flag && !flag2)
			{
				DispatchEnter(owner, ref _eventData);
			}
			else if (!flag & flag2)
			{
				DispatchExit(owner, ref _eventData);
			}
			else if (flag & flag2)
			{
				DispatchStay(owner, ref _eventData);
			}
			if (flag)
			{
				_currentFrameInsider.Add(item);
			}
		}
	}

	private void DispatchEnter(GameObject target, ref MathTriggerEventData data)
	{
		if (_handlerCache.TryGetValue(target, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].OnMathTriggerEnter(data);
			}
		}
	}

	private void DispatchExit(GameObject target, ref MathTriggerEventData data)
	{
		if (_handlerCache.TryGetValue(target, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].OnMathTriggerExit(data);
			}
		}
	}

	private void DispatchStay(GameObject target, ref MathTriggerEventData data)
	{
		if (_handlerCache.TryGetValue(target, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].OnMathTriggerStay(data);
			}
		}
	}

	public void DrawTree()
	{
	}
}
