using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.API)]
public abstract class CinemachineExtension : MonoBehaviour
{
	protected const float Epsilon = 0.0001f;

	private CinemachineVirtualCameraBase m_vcamOwner;

	private Dictionary<ICinemachineCamera, object> mExtraState;

	public CinemachineVirtualCameraBase VirtualCamera
	{
		get
		{
			if (m_vcamOwner == null)
			{
				m_vcamOwner = GetComponent<CinemachineVirtualCameraBase>();
			}
			return m_vcamOwner;
		}
	}

	public virtual bool RequiresUserInput => false;

	protected virtual void Awake()
	{
		ConnectToVcam(connect: true);
	}

	protected virtual void OnEnable()
	{
	}

	protected virtual void OnDestroy()
	{
		ConnectToVcam(connect: false);
	}

	internal void EnsureStarted()
	{
		ConnectToVcam(connect: true);
	}

	protected virtual void ConnectToVcam(bool connect)
	{
		if (connect && VirtualCamera == null)
		{
			Debug.LogError("CinemachineExtension requires a Cinemachine Virtual Camera component");
		}
		if (VirtualCamera != null)
		{
			if (connect)
			{
				VirtualCamera.AddExtension(this);
			}
			else
			{
				VirtualCamera.RemoveExtension(this);
			}
		}
		mExtraState = null;
	}

	public virtual void PrePipelineMutateCameraStateCallback(CinemachineVirtualCameraBase vcam, ref CameraState curState, float deltaTime)
	{
	}

	public void InvokePostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		PostPipelineStageCallback(vcam, stage, ref state, deltaTime);
	}

	protected abstract void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime);

	public virtual void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
	}

	public virtual void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
	}

	public virtual bool OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime)
	{
		return false;
	}

	public virtual float GetMaxDampTime()
	{
		return 0f;
	}

	protected T GetExtraState<T>(ICinemachineCamera vcam) where T : class, new()
	{
		if (mExtraState == null)
		{
			mExtraState = new Dictionary<ICinemachineCamera, object>();
		}
		object value = null;
		if (!mExtraState.TryGetValue(vcam, out value))
		{
			object obj = (mExtraState[vcam] = new T());
			value = obj;
		}
		return value as T;
	}

	protected List<T> GetAllExtraStates<T>() where T : class, new()
	{
		List<T> list = new List<T>();
		if (mExtraState != null)
		{
			foreach (KeyValuePair<ICinemachineCamera, object> item in mExtraState)
			{
				list.Add(item.Value as T);
			}
		}
		return list;
	}
}
