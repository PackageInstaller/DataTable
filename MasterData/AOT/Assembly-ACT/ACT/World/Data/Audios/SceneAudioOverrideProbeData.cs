using UnityEngine;

namespace ACT.World.Data.Audios;

public class SceneAudioOverrideProbeData
{
	[SerializeField]
	[HideInInspector]
	private Vector3 _position;

	[SerializeField]
	[HideInInspector]
	private Vector3 _center;

	[SerializeField]
	[HideInInspector]
	private Vector3 _size;

	[SerializeField]
	[HideInInspector]
	private OverrideSceneAudioData _overrideSceneAudioData;

	private string _debugName;

	public string DebugName => _debugName;

	public Vector3 Position => _position;

	public Vector3 ColliderCenter => _center;

	public Vector3 ColliderSize => _size;

	public OverrideSceneAudioData OverrideSceneAudioData => _overrideSceneAudioData;
}
