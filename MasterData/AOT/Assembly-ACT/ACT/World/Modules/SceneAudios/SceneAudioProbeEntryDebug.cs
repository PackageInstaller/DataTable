using ACT.World.Data.Audios;
using UnityEngine;

namespace ACT.World.Modules.SceneAudios;

internal class SceneAudioProbeEntryDebug : MonoBehaviour
{
	[SerializeField]
	[HideInInspector]
	private OverrideSceneAudioData _overrideSceneAudioData;

	public OverrideSceneAudioData overrideSceneAudioData => _overrideSceneAudioData;

	public void Setup(OverrideSceneAudioData data)
	{
		_overrideSceneAudioData = data;
	}
}
