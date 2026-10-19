using ACT.World.Data.Audios;
using UnityEngine;

namespace ACT.World.Modules.SceneAudios;

internal class SceneAudioProbeEntryControl : SceneTriggerEntry.ITriggerCallback
{
	private SceneTriggerEntry _entry;

	private readonly SceneAudioModule _module;

	private GameObject _triggeredByGameObject;

	private bool _isAudioProbeStateChange;

	public SceneAudioOverrideProbeData Data { get; private set; }

	internal SceneAudioProbeEntryControl(SceneAudioModule module, SceneAudioOverrideProbeData data)
	{
		Data = data;
		_module = module;
	}

	void SceneTriggerEntry.ITriggerCallback.OnEnterTrigger(Collider other)
	{
		if (!(_triggeredByGameObject != null) && SceneTriggerEntry.ITriggerCallback.IsMainEntity(other))
		{
			_triggeredByGameObject = other.gameObject;
			_isAudioProbeStateChange = true;
		}
	}

	void SceneTriggerEntry.ITriggerCallback.OnExitTrigger(Collider other)
	{
		if (!(_triggeredByGameObject != other.gameObject))
		{
			_triggeredByGameObject = null;
			_isAudioProbeStateChange = true;
		}
	}

	void SceneTriggerEntry.ITriggerCallback.OnUpdate()
	{
		if (_isAudioProbeStateChange)
		{
			_isAudioProbeStateChange = false;
			if (_triggeredByGameObject == null)
			{
				_module.RemoveAudioProbeData(Data);
			}
			else
			{
				_module.AppendAudioProbeData(Data);
			}
		}
	}

	public void Load()
	{
		if (!(_entry != null))
		{
			_entry = SceneTriggerEntry.Pool.Get();
			_entry.Setup(this, Data.Position, Data.ColliderCenter, Data.ColliderSize, "AudioProbe(" + Data.DebugName + ")");
			CreateDebugView(_entry.gameObject, Data.OverrideSceneAudioData);
		}
	}

	public void Unload()
	{
		if (!(_entry == null))
		{
			DestroyDebugView(_entry.gameObject);
			SceneTriggerEntry.Pool.Release(_entry);
			_triggeredByGameObject = null;
			_isAudioProbeStateChange = false;
			_entry = null;
		}
	}

	private void CreateDebugView(GameObject go, OverrideSceneAudioData data)
	{
	}

	private void DestroyDebugView(GameObject go)
	{
	}
}
