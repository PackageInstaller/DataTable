using System;
using ACT.Sound.Core;
using UnityEngine;

namespace ACT.Sound;

public struct AudioPlayOptions
{
	public AudioType audioType;

	public Transform attachTarget;

	public float volume;

	public bool IsLoop;

	public AudioSpatialMode spatialMode;

	public Action<IAudioInstance> onParametersSetup;

	public bool forcePlay;

	public Action onCompleteCallback;
}
