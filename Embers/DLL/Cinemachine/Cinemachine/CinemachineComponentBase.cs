using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.API)]
public abstract class CinemachineComponentBase : MonoBehaviour
{
	protected const float Epsilon = 0.0001f;

	private CinemachineVirtualCameraBase m_vcamOwner;

	public CinemachineVirtualCameraBase VirtualCamera
	{
		get
		{
			if (m_vcamOwner == null)
			{
				m_vcamOwner = GetComponent<CinemachineVirtualCameraBase>();
			}
			if (m_vcamOwner == null && base.transform.parent != null)
			{
				m_vcamOwner = base.transform.parent.GetComponent<CinemachineVirtualCameraBase>();
			}
			return m_vcamOwner;
		}
	}

	public Transform FollowTarget
	{
		get
		{
			CinemachineVirtualCameraBase virtualCamera = VirtualCamera;
			if (!(virtualCamera == null))
			{
				return virtualCamera.ResolveFollow(virtualCamera.Follow);
			}
			return null;
		}
	}

	public Transform LookAtTarget
	{
		get
		{
			CinemachineVirtualCameraBase virtualCamera = VirtualCamera;
			if (!(virtualCamera == null))
			{
				return virtualCamera.ResolveLookAt(virtualCamera.LookAt);
			}
			return null;
		}
	}

	public ICinemachineTargetGroup AbstractFollowTargetGroup
	{
		get
		{
			CinemachineVirtualCameraBase virtualCamera = VirtualCamera;
			if (!(virtualCamera == null))
			{
				return virtualCamera.AbstractFollowTargetGroup;
			}
			return null;
		}
	}

	public CinemachineTargetGroup FollowTargetGroup => AbstractFollowTargetGroup as CinemachineTargetGroup;

	public Vector3 FollowTargetPosition
	{
		get
		{
			CinemachineVirtualCameraBase followTargetAsVcam = VirtualCamera.FollowTargetAsVcam;
			if (followTargetAsVcam != null)
			{
				return followTargetAsVcam.State.FinalPosition;
			}
			Transform followTarget = FollowTarget;
			if (followTarget != null)
			{
				return TargetPositionCache.GetTargetPosition(followTarget);
			}
			return Vector3.zero;
		}
	}

	public Quaternion FollowTargetRotation
	{
		get
		{
			CinemachineVirtualCameraBase followTargetAsVcam = VirtualCamera.FollowTargetAsVcam;
			if (followTargetAsVcam != null)
			{
				return followTargetAsVcam.State.FinalOrientation;
			}
			Transform followTarget = FollowTarget;
			if (followTarget != null)
			{
				return TargetPositionCache.GetTargetRotation(followTarget);
			}
			return Quaternion.identity;
		}
	}

	public ICinemachineTargetGroup AbstractLookAtTargetGroup => VirtualCamera.AbstractLookAtTargetGroup;

	public CinemachineTargetGroup LookAtTargetGroup => AbstractLookAtTargetGroup as CinemachineTargetGroup;

	public Vector3 LookAtTargetPosition
	{
		get
		{
			CinemachineVirtualCameraBase lookAtTargetAsVcam = VirtualCamera.LookAtTargetAsVcam;
			if (lookAtTargetAsVcam != null)
			{
				return lookAtTargetAsVcam.State.FinalPosition;
			}
			Transform lookAtTarget = LookAtTarget;
			if (lookAtTarget != null)
			{
				return TargetPositionCache.GetTargetPosition(lookAtTarget);
			}
			return Vector3.zero;
		}
	}

	public Quaternion LookAtTargetRotation
	{
		get
		{
			CinemachineVirtualCameraBase lookAtTargetAsVcam = VirtualCamera.LookAtTargetAsVcam;
			if (lookAtTargetAsVcam != null)
			{
				return lookAtTargetAsVcam.State.FinalOrientation;
			}
			Transform lookAtTarget = LookAtTarget;
			if (lookAtTarget != null)
			{
				return TargetPositionCache.GetTargetRotation(lookAtTarget);
			}
			return Quaternion.identity;
		}
	}

	public CameraState VcamState
	{
		get
		{
			CinemachineVirtualCameraBase virtualCamera = VirtualCamera;
			if (!(virtualCamera == null))
			{
				return virtualCamera.State;
			}
			return CameraState.Default;
		}
	}

	public abstract bool IsValid { get; }

	public abstract CinemachineCore.Stage Stage { get; }

	public virtual bool BodyAppliesAfterAim => false;

	public virtual bool RequiresUserInput => false;

	public virtual void PrePipelineMutateCameraState(ref CameraState curState, float deltaTime)
	{
	}

	public abstract void MutateCameraState(ref CameraState curState, float deltaTime);

	public virtual bool OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime, ref CinemachineVirtualCameraBase.TransitionParams transitionParams)
	{
		return false;
	}

	public virtual void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
	}

	public virtual void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
	}

	public virtual float GetMaxDampTime()
	{
		return 0f;
	}
}
