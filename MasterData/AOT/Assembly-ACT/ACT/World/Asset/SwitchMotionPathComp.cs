using ACT.Battle;
using Cinemachine;
using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/WorldAssetComp/SwitchMotionPathComp")]
public class SwitchMotionPathComp : StateWorldAssetComp<SwitchMotionPathData>
{
	public void GetCameraProperties()
	{
		if (assetData.target == null)
		{
			return;
		}
		CinemachineVirtualCamera vc = assetData.target.vc;
		assetData.target.useCameraProperties = vc != null;
		if (vc != null)
		{
			assetData.target.cameraProperties.fov = vc.m_Lens.FieldOfView;
			CinemachineFramingTransposerACT cinemachineComponent = vc.GetCinemachineComponent<CinemachineFramingTransposerACT>();
			if (cinemachineComponent != null)
			{
				assetData.target.cameraProperties.cameraDistance = cinemachineComponent.m_CameraDistance;
			}
			CinemachineConfiner component = vc.GetComponent<CinemachineConfiner>();
			if (component != null && component.m_BoundingVolume != null)
			{
				assetData.target.cameraProperties.confinerVolume = component.m_BoundingVolume.bounds;
			}
		}
	}
}
