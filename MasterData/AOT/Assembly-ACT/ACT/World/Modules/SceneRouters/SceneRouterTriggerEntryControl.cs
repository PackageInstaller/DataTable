using ACT.World.Data.SceneRouters;
using UnityEngine;

namespace ACT.World.Modules.SceneRouters;

public class SceneRouterTriggerEntryControl : SceneTriggerEntry.ITriggerCallback
{
	private SceneTriggerEntry _entry;

	private readonly ChunkRouterMaintainer _maintainer;

	private GameObject _teleportTriggeredByGameObject;

	private bool _willBlackScreenTeleport;

	public SceneChunkRouterData Data { get; private set; }

	internal SceneRouterTriggerEntryControl(ChunkRouterMaintainer maintainer, SceneChunkRouterData data)
	{
		Data = data;
		_maintainer = maintainer;
	}

	public void Load()
	{
		if (!(_entry != null))
		{
			_entry = SceneTriggerEntry.Pool.Get();
			_entry.Setup(this, Data.Position, Data.ColliderCenter, Data.ColliderSize, Data.DisplayName ?? "");
			CreateDebugView(_entry.gameObject, Data.SpawnOffset);
		}
	}

	public void Unload()
	{
		if (!(_entry == null))
		{
			DestroyDebugView(_entry.gameObject);
			SceneTriggerEntry.Pool.Release(_entry);
			_willBlackScreenTeleport = false;
			_teleportTriggeredByGameObject = null;
			_entry = null;
		}
	}

	void SceneTriggerEntry.ITriggerCallback.OnUpdate()
	{
		if (_willBlackScreenTeleport && !_maintainer.CantTeleport)
		{
			_maintainer.ExecuteTransition(Data);
		}
	}

	void SceneTriggerEntry.ITriggerCallback.OnEnterTrigger(Collider other)
	{
		if (!_willBlackScreenTeleport && !_maintainer.CantTeleport && SceneTriggerEntry.ITriggerCallback.IsMainEntity(other))
		{
			_teleportTriggeredByGameObject = other.gameObject;
			_willBlackScreenTeleport = true;
		}
	}

	void SceneTriggerEntry.ITriggerCallback.OnExitTrigger(Collider other)
	{
		if (_willBlackScreenTeleport && !(other.gameObject != _teleportTriggeredByGameObject))
		{
			_willBlackScreenTeleport = false;
			_teleportTriggeredByGameObject = null;
		}
	}

	private void CreateDebugView(GameObject go, Vector3 offset)
	{
	}

	private void DestroyDebugView(GameObject go)
	{
	}
}
