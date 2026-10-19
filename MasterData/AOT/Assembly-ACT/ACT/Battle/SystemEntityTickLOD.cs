using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public sealed class SystemEntityTickLOD : EntitySystem
{
	private const float FullResumeDistance = 15f;

	private const float SleepResumeDistance = 25f;

	private const float FullLeaveDistance = 18f;

	private const float SleepLeaveDistance = 28f;

	private const int RescanInterval = 30;

	private const int InitialEntityCapacity = 256;

	private const int DistanceChecksPerFrame = 16;

	private Filter _filter;

	private EntityAction<CompBehave, CompMonster> _registerAction;

	private IEntities _entityEvents;

	private readonly List<Entity> _trackedEntities = new List<Entity>(256);

	private readonly Dictionary<EntityId, int> _trackedIndices = new Dictionary<EntityId, int>(256);

	private int _nextDistanceCheck;

	private int _rescanCounter;

	private string _lastWakeReason;

	public int FullCount { get; private set; }

	public int QuarterCount { get; private set; }

	public int SleepCount { get; private set; }

	public int DistanceCheckCount { get; private set; }

	public int SkippedTickCount { get; private set; }

	public int WakeCount { get; private set; }

	public string LastWakeReason => _lastWakeReason;

	public int TrackedCount => _trackedEntities.Count;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompBehave, CompTransform, CompMonster>().Build();
		_registerAction = RegisterEntity;
		_entityEvents = GameManager.entities;
		_entityEvents.OnEntityCreate += OnEntityCreate;
		_entityEvents.OnEntityBeforeDestroy += OnEntityBeforeDestroy;
	}

	protected override void OnDestroy()
	{
		if (_entityEvents != null)
		{
			_entityEvents.OnEntityCreate -= OnEntityCreate;
			_entityEvents.OnEntityBeforeDestroy -= OnEntityBeforeDestroy;
		}
		_entityEvents = null;
		_trackedEntities.Clear();
		_trackedIndices.Clear();
	}

	public override void FixedUpdate()
	{
		int num = (SkippedTickCount = 0);
		int num3 = (DistanceCheckCount = num);
		int num5 = (SleepCount = num3);
		int fullCount = (QuarterCount = num5);
		FullCount = fullCount;
		if (++_rescanCounter >= 30)
		{
			_rescanCounter = 0;
			_filter.ForEach(_registerAction);
		}
		MonoECS instance = MonoECS.instance;
		Entity entity = ((instance != null) ? instance.mainEntity : default(Entity));
		CompTransform component = null;
		bool flag = instance != null && entity.IsValid && entity.TryGetCompTransform(out component) && !instance.IsLoadSubScene;
		for (int num8 = _trackedEntities.Count - 1; num8 >= 0; num8--)
		{
			Entity entity2 = _trackedEntities[num8];
			if (!entity2.IsValid || !entity2.TryGetCompBehave(out CompBehave component2))
			{
				RemoveAt(num8);
			}
			else
			{
				component2.PrepareTickFrame();
				if (!flag)
				{
					component2.SetTickLod(EntityTickLod.Full, due: true, 1f);
				}
				else if (HasActiveHatred(entity2) || component2.HasForcedFullTick(Time.time) || component2.IsToRemove() || component2.IsOnRemove())
				{
					component2.SetTickLod(EntityTickLod.Full, due: true, 1f);
				}
			}
		}
		if (flag)
		{
			CheckDistanceBudget(component.physicsPosition.x);
		}
		for (int num9 = _trackedEntities.Count - 1; num9 >= 0; num9--)
		{
			Entity entity3 = _trackedEntities[num9];
			if (!entity3.IsValid || !entity3.TryGetCompBehave(out CompBehave component3))
			{
				RemoveAt(num9);
			}
			else
			{
				switch (component3.TickLod)
				{
				case EntityTickLod.Full:
					FullCount++;
					break;
				case EntityTickLod.Quarter:
					QuarterCount++;
					if (!component3.IsTickDue)
					{
						SkippedTickCount++;
					}
					break;
				default:
					SleepCount++;
					SkippedTickCount++;
					break;
				}
			}
		}
	}

	private void CheckDistanceBudget(float mainX)
	{
		int num = 0;
		while (num < 16 && _trackedEntities.Count > 0)
		{
			if (_nextDistanceCheck >= _trackedEntities.Count)
			{
				_nextDistanceCheck = 0;
			}
			Entity entity = _trackedEntities[_nextDistanceCheck];
			if (!entity.IsValid || !entity.TryGetCompBehave(out CompBehave component))
			{
				RemoveAt(_nextDistanceCheck);
				continue;
			}
			CheckDistance(entity, component, mainX);
			DistanceCheckCount++;
			num++;
			_nextDistanceCheck++;
			if (_nextDistanceCheck >= _trackedEntities.Count)
			{
				_nextDistanceCheck = 0;
			}
		}
	}

	private void CheckDistance(Entity entity, CompBehave behave, float mainX)
	{
		if (!entity.TryGetCompTransform(out CompTransform component))
		{
			return;
		}
		float num = Mathf.Abs(component.physicsPosition.x - mainX);
		EntityTickLod entityTickLod = behave.TickLod;
		if (HasActiveHatred(entity) || behave.HasForcedFullTick(Time.time) || behave.IsToRemove() || behave.IsOnRemove())
		{
			entityTickLod = EntityTickLod.Full;
		}
		else
		{
			switch (behave.TickLod)
			{
			case EntityTickLod.Full:
				entityTickLod = ((num >= 28f) ? EntityTickLod.Sleep : ((num >= 18f) ? EntityTickLod.Quarter : EntityTickLod.Full));
				break;
			case EntityTickLod.Quarter:
				entityTickLod = ((num >= 28f) ? EntityTickLod.Sleep : ((!(num <= 15f)) ? EntityTickLod.Quarter : EntityTickLod.Full));
				break;
			case EntityTickLod.Sleep:
				entityTickLod = ((num <= 25f) ? EntityTickLod.Quarter : EntityTickLod.Sleep);
				break;
			}
		}
		if (entityTickLod != behave.TickLod)
		{
			if (entityTickLod == EntityTickLod.Sleep && behave.TickLod == EntityTickLod.Quarter)
			{
				entityTickLod = EntityTickLod.Full;
			}
			float deltaScale = ((entityTickLod == EntityTickLod.Quarter && behave.TickLod == EntityTickLod.Quarter) ? 4f : 1f);
			behave.SetTickLod(entityTickLod, entityTickLod != EntityTickLod.Sleep, deltaScale);
		}
	}

	private static bool HasActiveHatred(Entity entity)
	{
		if (entity.TryGetCompHatred(out CompHatred component))
		{
			return component.HasHatredTarget();
		}
		return false;
	}

	private void OnEntityCreate(Entity entity)
	{
		Register(entity);
	}

	private void RegisterEntity(Entity entity, CompBehave behave, CompMonster monster)
	{
		if ((behave.EntityType == EntityType.Monster || behave.EntityType == EntityType.Elite) && !_trackedIndices.ContainsKey(entity.Id))
		{
			_trackedIndices.Add(entity.Id, _trackedEntities.Count);
			_trackedEntities.Add(entity);
			behave.SetTickPhase((byte)((_trackedEntities.Count - 1) & 3));
			behave.OnLogicAvailable += OnEntityLogicAvailable;
			TryRefreshDistance(entity, behave);
		}
	}

	private void OnEntityLogicAvailable(Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			TryRefreshDistance(entity, component);
			component.OnLogicAvailable -= OnEntityLogicAvailable;
		}
	}

	private void TryRefreshDistance(Entity entity, CompBehave behave)
	{
		MonoECS instance = MonoECS.instance;
		if (instance != null && instance.mainEntity.IsValid && instance.mainEntity.TryGetCompTransform(out CompTransform component) && !instance.IsLoadSubScene)
		{
			CheckDistance(entity, behave, component.physicsPosition.x);
		}
	}

	public void Register(Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component) && entity.TryGetCompMonster(out CompMonster component2))
		{
			RegisterEntity(entity, component, component2);
		}
	}

	private void OnEntityBeforeDestroy(Entity entity)
	{
		if (_trackedIndices.TryGetValue(entity.Id, out var value))
		{
			RemoveAt(value);
		}
	}

	private void RemoveAt(int index)
	{
		if ((uint)index >= (uint)_trackedEntities.Count)
		{
			return;
		}
		int num = _trackedEntities.Count - 1;
		Entity entity = _trackedEntities[index];
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.OnLogicAvailable -= OnEntityLogicAvailable;
		}
		if (index != num)
		{
			Entity value = _trackedEntities[num];
			_trackedEntities[index] = value;
			_trackedIndices[value.Id] = index;
		}
		_trackedEntities.RemoveAt(num);
		_trackedIndices.Remove(entity.Id);
		if (_trackedEntities.Count == 0)
		{
			_nextDistanceCheck = 0;
			return;
		}
		if (_nextDistanceCheck > index)
		{
			_nextDistanceCheck--;
		}
		if (_nextDistanceCheck >= _trackedEntities.Count)
		{
			_nextDistanceCheck = 0;
		}
	}

	public void Wake(Entity entity, string reason, float minimumFullTickSeconds = 1f)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.WakeForSeconds(minimumFullTickSeconds);
			_lastWakeReason = reason;
			WakeCount++;
		}
	}

	public void PushFullTick(Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.PushFullTick();
		}
	}

	public void PopFullTick(Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.PopFullTick();
		}
	}
}
