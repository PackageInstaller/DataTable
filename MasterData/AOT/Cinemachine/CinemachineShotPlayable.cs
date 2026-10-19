using Cinemachine;
using UnityEngine.Playables;

internal sealed class CinemachineShotPlayable : PlayableBehaviour
{
	public CinemachineVirtualCameraBase VirtualCamera;

	public bool IsValid => VirtualCamera != null;
}
