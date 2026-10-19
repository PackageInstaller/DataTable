using System;
using ACT.World.Data.Audios;
using UnityEngine;

namespace ACT.World.SceneChunks;

[Serializable]
public abstract class SceneOverrideAudioData
{
	[SerializeField]
	[HideInInspector]
	protected bool _isBaked;

	[SerializeField]
	[HideInInspector]
	private bool _enableOverrideAudio;

	[SerializeField]
	private OverrideSceneAudioData _overrideSceneAudioData;

	public bool EnableOverrideAudio => _enableOverrideAudio;

	public OverrideSceneAudioData OverrideSceneAudioData => _overrideSceneAudioData;
}
