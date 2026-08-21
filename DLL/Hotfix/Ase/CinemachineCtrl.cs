using Cinemachine;
using UnityEngine;

namespace Ase;

public class CinemachineCtrl : MonoBehaviour
{
	[SerializeField]
	public CinemachineBlenderSettings m_CustomBlends;

	private void Awake()
	{
		CinemachineCore.GetBlendOverride = GetBlendOverride;
	}

	private void OnDisable()
	{
		CinemachineCore.GetBlendOverride = null;
	}

	private void OnDestroy()
	{
		CinemachineCore.GetBlendOverride = null;
	}

	private CinemachineBlendDefinition GetBlendOverride(ICinemachineCamera fromKey, ICinemachineCamera toKey, CinemachineBlendDefinition defaultBlend, MonoBehaviour owner)
	{
		CinemachineBlendDefinition cinemachineBlendDefinition = defaultBlend;
		if (m_CustomBlends != null)
		{
			string fromCameraName = ((fromKey != null) ? fromKey.Name : string.Empty);
			string toCameraName = ((toKey != null) ? toKey.Name : string.Empty);
			cinemachineBlendDefinition = m_CustomBlends.GetBlendForVirtualCameras(fromCameraName, toCameraName, cinemachineBlendDefinition);
		}
		return cinemachineBlendDefinition;
	}
}
