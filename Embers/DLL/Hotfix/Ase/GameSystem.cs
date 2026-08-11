#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase;

public class GameSystem : Singleton<GameSystem>, ISingletonAwake, ISingletonUpdate, ISingletonLateUpdate, ISingletonFixedUpdate
{
	private Dictionary<uint, WorldBase> worldChannels;

	private IMessenger worldPauseMessenger;

	private ISubscription<WorldPauseMessenger> subscription;

	private uint serialId;

	private GameObject m_GameRoot;

	private WorldBase _lastWorld;

	public IMessenger GetWorldPauseMessenger()
	{
		return worldPauseMessenger;
	}

	public void Awake()
	{
		worldChannels = new Dictionary<uint, WorldBase>();
		worldPauseMessenger = new Messenger();
		subscription = GetWorldPauseMessenger().Subscribe<WorldPauseMessenger>(OnWorldPauseMessageReceiver);
	}

	private void OnWorldPauseMessageReceiver(WorldPauseMessenger message)
	{
		if (message != null && message.AllPause)
		{
			foreach (WorldBase value in worldChannels.Values)
			{
				if (message.Pause)
				{
					value.GamePause(message.Transition);
				}
				else
				{
					value.GameResume();
				}
			}
			return;
		}
		if (message != null && message.WorldId != 0)
		{
			WorldBase worldChannel = GetWorldChannel(message.WorldId);
			if (message.Pause)
			{
				worldChannel.GamePause(message.Transition);
			}
			else
			{
				worldChannel.GameResume();
			}
		}
	}

	public uint GenerateWorldId()
	{
		serialId++;
		return serialId;
	}

	public WorldBase GetWorldChannel(uint worldId)
	{
		if (worldChannels.TryGetValue(worldId, out var value))
		{
			return value;
		}
		return null;
	}

	public async UniTask<uint> CreateBattleVerificationWorldChannel(WorldType worldType, WorldData worldData)
	{
		GameObject worldRoot = new GameObject(worldData.WorldName);
		WorldBase worldChannel;
		switch (worldType)
		{
		case WorldType.GameBack:
			worldChannel = new GameBackWorld(worldData.WorldName, worldRoot, worldData);
			break;
		case WorldType.GameBackSingle:
			worldChannel = new GameBackSingleWorld(worldData.WorldName, worldRoot, worldData);
			break;
		default:
			return 0u;
		}
		worldChannels.Add(worldData.WorldId, worldChannel);
		_lastWorld = worldChannel;
		if (!(await worldChannel.LoadBattleConfig()))
		{
			return 0u;
		}
		if (!(await worldChannel.GamePreparation(worldData)))
		{
			return 0u;
		}
		worldChannel.WorldAwake();
		return worldChannel.Id;
	}

	public async UniTask<uint> CreateWorldChannel(WorldType worldType, Scene scene, WorldData worldData)
	{
		GameObject gameObject = new GameObject(worldData.WorldName);
		SceneManager.MoveGameObjectToScene(gameObject, scene);
		SceneManager.SetActiveScene(scene);
		WorldBase worldChannel;
		switch (worldType)
		{
		case WorldType.Battle:
			worldChannel = new BattleWorld(worldData.WorldName, gameObject, worldData);
			break;
		case WorldType.Lockstep:
			worldChannel = new NormalLockstepWorld(worldData.WorldName, gameObject, worldData);
			break;
		case WorldType.Story:
			worldChannel = new StoryWorld(worldData.WorldName, gameObject, worldData);
			break;
		case WorldType.TestingWorld:
			worldChannel = new TestingAiOnLineWorld(worldData.WorldName, gameObject, worldData);
			break;
		case WorldType.GameBack:
			worldChannel = new GameBackWorld(worldData.WorldName, gameObject, worldData);
			break;
		case WorldType.ClimbTower:
			worldChannel = new ClimbTowerWorld(worldData.WorldName, gameObject, worldData);
			break;
		default:
			return 0u;
		}
		worldChannels.Add(worldData.WorldId, worldChannel);
		_lastWorld = worldChannel;
		if (!(await worldChannel.LoadBattleConfig()))
		{
			return 0u;
		}
		if (!(await worldChannel.GamePreparation(worldData)))
		{
			return 0u;
		}
		worldChannel.WorldAwake();
		return worldChannel.Id;
	}

	public async UniTask WorldStartBefore(uint worldId)
	{
		worldChannels.TryGetValue(worldId, out var value);
		if (value != null)
		{
			await value.GameStartBefore();
		}
	}

	public void WorldStart(uint worldId)
	{
		worldChannels.TryGetValue(worldId, out var value);
		value?.GameStart();
	}

	private void ResetLastWorld(uint worldId, bool changed)
	{
		if (!changed || worldId != _lastWorld.Id)
		{
			return;
		}
		_lastWorld = null;
		if (worldChannels.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<uint, WorldBase> worldChannel in worldChannels)
		{
			_lastWorld = worldChannel.Value;
		}
	}

	public bool HideWorldChannel(uint worldId)
	{
		if (worldChannels.TryGetValue(worldId, out var _))
		{
			bool flag = worldChannels.Remove(worldId);
			ResetLastWorld(worldId, flag);
			return flag;
		}
		return false;
	}

	public bool DestroyWorldChannel(uint worldId)
	{
		worldChannels.TryGetValue(worldId, out var value);
		return DestroyWorldChannel(value);
	}

	public bool DestroyWorldChannel(WorldBase worldBase)
	{
		if (worldBase == null)
		{
			return false;
		}
		worldBase.Shutdown();
		bool flag = worldChannels.Remove(worldBase.Id);
		ResetLastWorld(worldBase.Id, flag);
		return flag;
	}

	public void Update()
	{
		if (worldChannels.Count == 1)
		{
			_lastWorld.Update(Time.deltaTime);
			return;
		}
		lock (worldChannels)
		{
			if (worldChannels.Count <= 0)
			{
				return;
			}
			foreach (KeyValuePair<uint, WorldBase> worldChannel in worldChannels)
			{
				worldChannel.Value.Update(Time.deltaTime);
			}
		}
	}

	public void FixedUpdate()
	{
		if (worldChannels.Count == 1)
		{
			_lastWorld.FixedUpdate(Time.unscaledDeltaTime);
			return;
		}
		lock (worldChannels)
		{
			if (worldChannels.Count <= 0)
			{
				return;
			}
			foreach (KeyValuePair<uint, WorldBase> worldChannel in worldChannels)
			{
				worldChannel.Value.FixedUpdate(Time.unscaledDeltaTime);
			}
		}
	}

	public void LateUpdate()
	{
		if (worldChannels.Count == 1)
		{
			_lastWorld.LateUpdate(Time.deltaTime);
			return;
		}
		lock (worldChannels)
		{
			if (worldChannels.Count <= 0)
			{
				return;
			}
			foreach (KeyValuePair<uint, WorldBase> worldChannel in worldChannels)
			{
				worldChannel.Value.LateUpdate(Time.deltaTime);
			}
		}
	}

	public override void Dispose()
	{
		try
		{
			if (subscription != null)
			{
				subscription.Dispose();
				subscription = null;
			}
			_lastWorld = null;
			lock (worldChannels)
			{
				foreach (KeyValuePair<uint, WorldBase> worldChannel in worldChannels)
				{
					worldChannel.Value.Shutdown();
				}
				worldChannels.Clear();
			}
			ReferencePool.ClearAll();
		}
		catch (Exception arg)
		{
			Log.Error($"Battle disable error. e : {arg}");
		}
	}
}
