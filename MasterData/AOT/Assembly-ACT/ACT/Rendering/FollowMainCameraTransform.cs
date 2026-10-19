using UnityEngine;

namespace ACT.Rendering;

[ExecuteAlways]
public class FollowMainCameraTransform : MonoBehaviour
{
	[SerializeField]
	private Camera targetCamera;

	public bool FollowRotation;

	public bool FollowScale;

	public Camera TargetCamera => targetCamera;

	private void OnEnable()
	{
		ResolveTargetCamera();
		SyncTransform();
	}

	private void OnDisable()
	{
	}

	private void LateUpdate()
	{
		SyncTransform();
	}

	public void SetCamera(Camera camera, bool syncImmediately = true)
	{
		targetCamera = camera;
		if (syncImmediately)
		{
			SyncTransform();
		}
	}

	private void ResolveTargetCamera()
	{
		if (targetCamera == null)
		{
			targetCamera = Camera.main;
		}
	}

	private void SyncTransform()
	{
		ResolveTargetCamera();
		if (targetCamera == null)
		{
			return;
		}
		Transform transform = targetCamera.transform;
		if (!(transform == base.transform))
		{
			base.transform.SetPositionAndRotation(transform.position, FollowRotation ? transform.rotation : Quaternion.identity);
			if (FollowScale)
			{
				base.transform.localScale = transform.localScale;
			}
		}
	}
}
