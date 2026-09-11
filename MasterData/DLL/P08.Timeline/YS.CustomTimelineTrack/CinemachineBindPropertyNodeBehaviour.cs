using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class CinemachineBindPropertyNodeBehaviour : PlayableBehaviour
{
	public PROPERTY_TYPE propertyType;

	public string gameObjectName;

	private bool hasInit;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		hasInit = false;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (hasInit || !(playerData is CinemachineVirtualCameraBase cinemachineVirtualCameraBase))
		{
			return;
		}
		GameObject gameObject = GameObject.Find(gameObjectName);
		if (cinemachineVirtualCameraBase != null && gameObject != null)
		{
			if (propertyType == PROPERTY_TYPE.LOOK_AT)
			{
				cinemachineVirtualCameraBase.LookAt = gameObject.transform;
			}
			else if (propertyType == PROPERTY_TYPE.FOLLOW)
			{
				cinemachineVirtualCameraBase.Follow = gameObject.transform;
			}
		}
		else if (cinemachineVirtualCameraBase != null && gameObject == null)
		{
			if (propertyType == PROPERTY_TYPE.LOOK_AT)
			{
				cinemachineVirtualCameraBase.LookAt = null;
			}
			else if (propertyType == PROPERTY_TYPE.FOLLOW)
			{
				cinemachineVirtualCameraBase.Follow = null;
			}
		}
		hasInit = true;
	}
}
