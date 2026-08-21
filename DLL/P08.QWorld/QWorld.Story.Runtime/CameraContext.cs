using System;
using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

namespace QWorld.Story.Runtime;

[Serializable]
public struct CameraContext
{
	[SerializeField]
	public QWStoryGraphBlackboard parent;

	[SerializeField]
	public string tag;

	[SerializeField]
	public CinemachineVirtualCamera camera;

	[SerializeField]
	public PlayableDirector cameraTimeline;
}
