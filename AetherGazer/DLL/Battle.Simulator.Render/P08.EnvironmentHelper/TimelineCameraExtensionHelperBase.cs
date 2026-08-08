using UnityEngine.Pipelines.SimPipeline;

namespace P08.EnvironmentHelper;

public abstract class TimelineCameraExtensionHelperBase : TimelineBase
{
	protected CameraExtension _cameraExtension;

	public void InitCameraExtension(CameraExtension pCameraExtension)
	{
		if (_cameraExtension == null)
		{
			_cameraExtension = pCameraExtension;
			InitOriginData(pCameraExtension);
		}
	}

	protected abstract void InitOriginData(CameraExtension pCameraExtension);
}
