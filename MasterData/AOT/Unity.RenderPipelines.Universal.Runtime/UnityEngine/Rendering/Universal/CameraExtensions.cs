namespace UnityEngine.Rendering.Universal;

public static class CameraExtensions
{
	public static UniversalAdditionalCameraData GetUniversalAdditionalCameraData(this Camera camera)
	{
		GameObject gameObject = camera.gameObject;
		if (!gameObject.TryGetComponent<UniversalAdditionalCameraData>(out var component))
		{
			return gameObject.AddComponent<UniversalAdditionalCameraData>();
		}
		return component;
	}

	public static VolumeFrameworkUpdateMode GetVolumeFrameworkUpdateMode(this Camera camera)
	{
		return camera.GetUniversalAdditionalCameraData().volumeFrameworkUpdateMode;
	}

	public static void SetVolumeFrameworkUpdateMode(this Camera camera, VolumeFrameworkUpdateMode mode)
	{
		UniversalAdditionalCameraData universalAdditionalCameraData = camera.GetUniversalAdditionalCameraData();
		if (universalAdditionalCameraData.volumeFrameworkUpdateMode != mode)
		{
			bool requiresVolumeFrameworkUpdate = universalAdditionalCameraData.requiresVolumeFrameworkUpdate;
			universalAdditionalCameraData.volumeFrameworkUpdateMode = mode;
			if (requiresVolumeFrameworkUpdate && !universalAdditionalCameraData.requiresVolumeFrameworkUpdate)
			{
				camera.UpdateVolumeStack(universalAdditionalCameraData);
			}
		}
	}

	public static void UpdateVolumeStack(this Camera camera)
	{
		UniversalAdditionalCameraData universalAdditionalCameraData = camera.GetUniversalAdditionalCameraData();
		camera.UpdateVolumeStack(universalAdditionalCameraData);
	}

	public static void UpdateVolumeStack(this Camera camera, UniversalAdditionalCameraData cameraData)
	{
		if (!cameraData.requiresVolumeFrameworkUpdate)
		{
			if (cameraData.volumeStack == null)
			{
				cameraData.volumeStack = VolumeManager.instance.CreateStack();
			}
			camera.GetVolumeLayerMaskAndTrigger(cameraData, out var layerMask, out var trigger);
			VolumeManager.instance.Update(cameraData.volumeStack, trigger, layerMask);
		}
	}

	public static void DestroyVolumeStack(this Camera camera)
	{
		UniversalAdditionalCameraData universalAdditionalCameraData = camera.GetUniversalAdditionalCameraData();
		camera.DestroyVolumeStack(universalAdditionalCameraData);
	}

	public static void DestroyVolumeStack(this Camera camera, UniversalAdditionalCameraData cameraData)
	{
		cameraData.volumeStack.Dispose();
		cameraData.volumeStack = null;
	}

	internal static void GetVolumeLayerMaskAndTrigger(this Camera camera, UniversalAdditionalCameraData cameraData, out LayerMask layerMask, out Transform trigger)
	{
		layerMask = 1;
		trigger = camera.transform;
		if (cameraData != null)
		{
			layerMask = cameraData.volumeLayerMask;
			trigger = ((cameraData.volumeTrigger != null) ? cameraData.volumeTrigger : trigger);
		}
	}
}
