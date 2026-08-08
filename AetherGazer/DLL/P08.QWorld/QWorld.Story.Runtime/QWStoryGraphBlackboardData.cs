using System.Collections.Generic;
using Cinemachine;

namespace QWorld.Story.Runtime;

public struct QWStoryGraphBlackboardData
{
	public string lastCameraTag;

	public CinemachineBlendDefinition oldBlend;

	public CinemachineBrain brain;

	public QWorldMapEntity target;

	public int stroyType;

	public Dictionary<int, QWStoryGraphActor> actors;

	public Dictionary<int, QWStoryItem> things;

	public QWStoryCameraShakeComponent cameraShakeComp;

	public int cameraTweenId;

	public CriAtomExPlayback _Playback;

	public bool hasStoryTeleport;
}
