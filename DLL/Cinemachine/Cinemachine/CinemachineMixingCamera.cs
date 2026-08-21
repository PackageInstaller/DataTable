using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine;

[DisallowMultipleComponent]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("Cinemachine/CinemachineMixingCamera")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineMixingCamera.html")]
[ExcludeFromPreset]
[ExecuteAlways]
public class CinemachineMixingCamera : CinemachineVirtualCameraBase
{
	public const int MaxCameras = 8;

	[Tooltip("The weight of the first tracked camera")]
	public float m_Weight0 = 0.5f;

	[Tooltip("The weight of the second tracked camera")]
	public float m_Weight1 = 0.5f;

	[Tooltip("The weight of the third tracked camera")]
	public float m_Weight2 = 0.5f;

	[Tooltip("The weight of the fourth tracked camera")]
	public float m_Weight3 = 0.5f;

	[Tooltip("The weight of the fifth tracked camera")]
	public float m_Weight4 = 0.5f;

	[Tooltip("The weight of the sixth tracked camera")]
	public float m_Weight5 = 0.5f;

	[Tooltip("The weight of the seventh tracked camera")]
	public float m_Weight6 = 0.5f;

	[Tooltip("The weight of the eighth tracked camera")]
	public float m_Weight7 = 0.5f;

	private CameraState m_State = CameraState.Default;

	private CinemachineVirtualCameraBase[] m_ChildCameras;

	private Dictionary<CinemachineVirtualCameraBase, int> m_indexMap;

	private ICinemachineCamera LiveChild { get; set; }

	public override CameraState State => m_State;

	public override Transform LookAt { get; set; }

	public override Transform Follow { get; set; }

	public CinemachineVirtualCameraBase[] ChildCameras
	{
		get
		{
			ValidateListOfChildren();
			return m_ChildCameras;
		}
	}

	public float GetWeight(int index)
	{
		switch (index)
		{
		case 0:
			return m_Weight0;
		case 1:
			return m_Weight1;
		case 2:
			return m_Weight2;
		case 3:
			return m_Weight3;
		case 4:
			return m_Weight4;
		case 5:
			return m_Weight5;
		case 6:
			return m_Weight6;
		case 7:
			return m_Weight7;
		default:
			Debug.LogError("CinemachineMixingCamera: Invalid index: " + index);
			return 0f;
		}
	}

	public void SetWeight(int index, float w)
	{
		switch (index)
		{
		case 0:
			m_Weight0 = w;
			break;
		case 1:
			m_Weight1 = w;
			break;
		case 2:
			m_Weight2 = w;
			break;
		case 3:
			m_Weight3 = w;
			break;
		case 4:
			m_Weight4 = w;
			break;
		case 5:
			m_Weight5 = w;
			break;
		case 6:
			m_Weight6 = w;
			break;
		case 7:
			m_Weight7 = w;
			break;
		default:
			Debug.LogError("CinemachineMixingCamera: Invalid index: " + index);
			break;
		}
	}

	public float GetWeight(CinemachineVirtualCameraBase vcam)
	{
		ValidateListOfChildren();
		if (m_indexMap.TryGetValue(vcam, out var value))
		{
			return GetWeight(value);
		}
		Debug.LogError("CinemachineMixingCamera: Invalid child: " + ((vcam != null) ? vcam.Name : "(null)"));
		return 0f;
	}

	public void SetWeight(CinemachineVirtualCameraBase vcam, float w)
	{
		ValidateListOfChildren();
		if (m_indexMap.TryGetValue(vcam, out var value))
		{
			SetWeight(value, w);
		}
		else
		{
			Debug.LogError("CinemachineMixingCamera: Invalid child: " + ((vcam != null) ? vcam.Name : "(null)"));
		}
	}

	public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		ValidateListOfChildren();
		CinemachineVirtualCameraBase[] childCameras = m_ChildCameras;
		for (int i = 0; i < childCameras.Length; i++)
		{
			childCameras[i].OnTargetObjectWarped(target, positionDelta);
		}
		base.OnTargetObjectWarped(target, positionDelta);
	}

	public override void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
		ValidateListOfChildren();
		CinemachineVirtualCameraBase[] childCameras = m_ChildCameras;
		for (int i = 0; i < childCameras.Length; i++)
		{
			childCameras[i].ForceCameraPosition(pos, rot);
		}
		base.ForceCameraPosition(pos, rot);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		InvalidateListOfChildren();
	}

	public void OnTransformChildrenChanged()
	{
		InvalidateListOfChildren();
	}

	protected override void OnValidate()
	{
		base.OnValidate();
		for (int i = 0; i < 8; i++)
		{
			SetWeight(i, Mathf.Max(0f, GetWeight(i)));
		}
	}

	public override bool IsLiveChild(ICinemachineCamera vcam, bool dominantChildOnly = false)
	{
		CinemachineVirtualCameraBase[] childCameras = ChildCameras;
		for (int i = 0; i < 8 && i < childCameras.Length; i++)
		{
			if (childCameras[i] == vcam)
			{
				if (GetWeight(i) > 0.0001f)
				{
					return childCameras[i].isActiveAndEnabled;
				}
				return false;
			}
		}
		return false;
	}

	protected void InvalidateListOfChildren()
	{
		m_ChildCameras = null;
		m_indexMap = null;
		LiveChild = null;
	}

	protected void ValidateListOfChildren()
	{
		if (m_ChildCameras != null)
		{
			return;
		}
		m_indexMap = new Dictionary<CinemachineVirtualCameraBase, int>();
		List<CinemachineVirtualCameraBase> list = new List<CinemachineVirtualCameraBase>();
		CinemachineVirtualCameraBase[] componentsInChildren = GetComponentsInChildren<CinemachineVirtualCameraBase>(includeInactive: true);
		foreach (CinemachineVirtualCameraBase cinemachineVirtualCameraBase in componentsInChildren)
		{
			if (cinemachineVirtualCameraBase.transform.parent == base.transform)
			{
				int count = list.Count;
				list.Add(cinemachineVirtualCameraBase);
				if (count < 8)
				{
					m_indexMap.Add(cinemachineVirtualCameraBase, count);
				}
			}
		}
		m_ChildCameras = list.ToArray();
	}

	public override void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime)
	{
		base.OnTransitionFromCamera(fromCam, worldUp, deltaTime);
		InvokeOnTransitionInExtensions(fromCam, worldUp, deltaTime);
		CinemachineVirtualCameraBase[] childCameras = ChildCameras;
		for (int i = 0; i < 8 && i < childCameras.Length; i++)
		{
			childCameras[i].OnTransitionFromCamera(fromCam, worldUp, deltaTime);
		}
		InternalUpdateCameraState(worldUp, deltaTime);
	}

	public override void InternalUpdateCameraState(Vector3 worldUp, float deltaTime)
	{
		CinemachineVirtualCameraBase[] childCameras = ChildCameras;
		LiveChild = null;
		float num = 0f;
		float num2 = 0f;
		for (int i = 0; i < 8 && i < childCameras.Length; i++)
		{
			CinemachineVirtualCameraBase cinemachineVirtualCameraBase = childCameras[i];
			if (!cinemachineVirtualCameraBase.isActiveAndEnabled)
			{
				continue;
			}
			float num3 = Mathf.Max(0f, GetWeight(i));
			if (num3 > 0.0001f)
			{
				num2 += num3;
				if (num2 == num3)
				{
					m_State = cinemachineVirtualCameraBase.State;
				}
				else
				{
					m_State = CameraState.Lerp(m_State, cinemachineVirtualCameraBase.State, num3 / num2);
				}
				if (num3 > num)
				{
					num = num3;
					LiveChild = cinemachineVirtualCameraBase;
				}
			}
		}
		InvokePostPipelineStageCallback(this, CinemachineCore.Stage.Finalize, ref m_State, deltaTime);
	}
}
