using System;
using ACT.Battle;
using ACT.Utility;
using ACT.World.SceneChunks;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.Modules;

internal class SafeAreaModule : WorldModuleBase
{
	private int _worldId = -1;

	private IPartitionChunkBoundsInfo _partitionChunkBoundsInfo;

	private bool _hasSafeArea;

	private Bounds _activeSafeArea;

	private float _notInSafeAreaTick;

	private const float NotInSafeAreaRecallInterval = 1f;

	private bool _inRecall;

	internal override bool NeedGotChunkChange => true;

	public void SetupWorldPartition(ConfigWorldPartition_v2 partitionData)
	{
		_partitionChunkBoundsInfo = partitionData;
	}

	protected override void OnSwitchActiveChunk(int activeWorldId, SceneChunk chunkData, SceneBlock chunkActiveStateData)
	{
		if (_worldId != activeWorldId || _partitionChunkBoundsInfo == null)
		{
			_hasSafeArea = false;
			_activeSafeArea = default;
		}
		else
		{
			_hasSafeArea = _partitionChunkBoundsInfo.TryGetChunkBounds(chunkData.ChunkId, out _activeSafeArea);
		}
	}

	protected override void OnEnterWorld(WorldBase world)
	{
		base.OnEnterWorld(world);
		_worldId = world.WorldId;
	}

	protected override void OnLeaveWorld(WorldBase world)
	{
		base.OnLeaveWorld(world);
		_worldId = -1;
		_partitionChunkBoundsInfo = null;
		_hasSafeArea = false;
		_activeSafeArea = default;
	}

	protected override void OnLateUpdate()
	{
		base.OnLateUpdate();
		if (_inRecall || !_hasSafeArea || Singleton<GameState>.instance.RunningState != GameRunningState.Playing)
		{
			return;
		}
		Transform rootTransform = MonoECS.instance.mainEntity.GetRootTransform();
		if (!(rootTransform == null))
		{
			Vector3 position = rootTransform.position;
			if (_activeSafeArea.Contains(position))
			{
				_notInSafeAreaTick = 0f;
			}
			else if (_notInSafeAreaTick > 1f)
			{
				Recall();
			}
			else
			{
				_notInSafeAreaTick += Time.deltaTime;
			}
		}
	}

	private async void Recall()
	{
		try
		{
			if (!_inRecall)
			{
				_inRecall = true;
				Vector3 recallPosition = TeleportUtility.GetRecallPosition();
				TeleportParams teleportParams = new TeleportParams
				{
					targetPos = recallPosition,
					forceToFloor = true
				};
				await TeleportUtility.TeleportWithPureBlackScreen(Singleton<GameManager>.instance.worldManager.ActiveChunkId, teleportParams);
				_inRecall = false;
			}
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("安全区回溯时发生错误: " + ex.Message + "\n" + ex.StackTrace);
			}
		}
	}
}
