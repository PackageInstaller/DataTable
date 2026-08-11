using System;
using UnityEngine;

namespace Cinemachine;

[Serializable]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public struct LensSettings
{
	public enum OverrideModes
	{
		None,
		Orthographic,
		Perspective,
		Physical
	}

	public static LensSettings Default = new LensSettings(40f, 10f, 0.1f, 5000f, 0f);

	[Tooltip("This is the camera view in degrees. Display will be in vertical degress, unless the associated camera has its FOV axis setting set to Horizontal, in which case display will be in horizontal degress.  Internally, it is always vertical degrees.  For cinematic people, a 50mm lens on a super-35mm sensor would equal a 19.6 degree FOV")]
	[Range(1f, 179f)]
	public float FieldOfView;

	[Tooltip("When using an orthographic camera, this defines the half-height, in world coordinates, of the camera view.")]
	public float OrthographicSize;

	[Tooltip("This defines the near region in the renderable range of the camera frustum. Raising this value will stop the game from drawing things near the camera, which can sometimes come in handy.  Larger values will also increase your shadow resolution.")]
	public float NearClipPlane;

	[Tooltip("This defines the far region of the renderable range of the camera frustum. Typically you want to set this value as low as possible without cutting off desired distant objects")]
	public float FarClipPlane;

	[Tooltip("Camera Z roll, or tilt, in degrees.")]
	[Range(-180f, 180f)]
	public float Dutch;

	[Tooltip("Allows you to select a different camera mode to apply to the Camera component when Cinemachine activates this Virtual Camera.  The changes applied to the Camera component through this setting will remain after the Virtual Camera deactivation.")]
	public OverrideModes ModeOverride;

	public Vector2 LensShift;

	public Camera.GateFitMode GateFit;

	[SerializeField]
	private Vector2 m_SensorSize;

	private bool m_OrthoFromCamera;

	private bool m_PhysicalFromCamera;

	public bool Orthographic
	{
		get
		{
			if (ModeOverride != OverrideModes.Orthographic)
			{
				if (ModeOverride == OverrideModes.None)
				{
					return m_OrthoFromCamera;
				}
				return false;
			}
			return true;
		}
		set
		{
			m_OrthoFromCamera = value;
			ModeOverride = (value ? OverrideModes.Orthographic : OverrideModes.Perspective);
		}
	}

	public Vector2 SensorSize
	{
		get
		{
			return m_SensorSize;
		}
		set
		{
			m_SensorSize = value;
		}
	}

	public float Aspect
	{
		get
		{
			if (SensorSize.y != 0f)
			{
				return SensorSize.x / SensorSize.y;
			}
			return 1f;
		}
	}

	public bool IsPhysicalCamera
	{
		get
		{
			if (ModeOverride != OverrideModes.Physical)
			{
				if (ModeOverride == OverrideModes.None)
				{
					return m_PhysicalFromCamera;
				}
				return false;
			}
			return true;
		}
		set
		{
			m_PhysicalFromCamera = value;
			ModeOverride = (value ? OverrideModes.Physical : OverrideModes.Perspective);
		}
	}

	public static LensSettings FromCamera(Camera fromCamera)
	{
		LensSettings result = Default;
		if (fromCamera != null)
		{
			result.FieldOfView = fromCamera.fieldOfView;
			result.OrthographicSize = fromCamera.orthographicSize;
			result.NearClipPlane = fromCamera.nearClipPlane;
			result.FarClipPlane = fromCamera.farClipPlane;
			result.LensShift = fromCamera.lensShift;
			result.GateFit = fromCamera.gateFit;
			result.SnapshotCameraReadOnlyProperties(fromCamera);
		}
		return result;
	}

	public void SnapshotCameraReadOnlyProperties(Camera camera)
	{
		m_OrthoFromCamera = false;
		m_PhysicalFromCamera = false;
		if (camera != null && ModeOverride == OverrideModes.None)
		{
			m_OrthoFromCamera = camera.orthographic;
			m_PhysicalFromCamera = camera.usePhysicalProperties;
			m_SensorSize = camera.sensorSize;
			GateFit = camera.gateFit;
		}
		if (IsPhysicalCamera)
		{
			if (camera != null && m_SensorSize == Vector2.zero)
			{
				m_SensorSize = camera.sensorSize;
				GateFit = camera.gateFit;
			}
		}
		else
		{
			if (camera != null)
			{
				m_SensorSize = new Vector2(camera.aspect, 1f);
			}
			LensShift = Vector2.zero;
		}
	}

	public void SnapshotCameraReadOnlyProperties(ref LensSettings lens)
	{
		if (ModeOverride == OverrideModes.None)
		{
			m_OrthoFromCamera = lens.Orthographic;
			m_SensorSize = lens.m_SensorSize;
			m_PhysicalFromCamera = lens.IsPhysicalCamera;
		}
		if (!IsPhysicalCamera)
		{
			LensShift = Vector2.zero;
		}
	}

	public LensSettings(float verticalFOV, float orthographicSize, float nearClip, float farClip, float dutch)
	{
		this = default(LensSettings);
		FieldOfView = verticalFOV;
		OrthographicSize = orthographicSize;
		NearClipPlane = nearClip;
		FarClipPlane = farClip;
		Dutch = dutch;
		m_SensorSize = new Vector2(1f, 1f);
		GateFit = Camera.GateFitMode.Horizontal;
	}

	public static LensSettings Lerp(LensSettings lensA, LensSettings lensB, float t)
	{
		t = Mathf.Clamp01(t);
		LensSettings result = ((t < 0.5f) ? lensA : lensB);
		result.FarClipPlane = Mathf.Lerp(lensA.FarClipPlane, lensB.FarClipPlane, t);
		result.NearClipPlane = Mathf.Lerp(lensA.NearClipPlane, lensB.NearClipPlane, t);
		result.FieldOfView = Mathf.Lerp(lensA.FieldOfView, lensB.FieldOfView, t);
		result.OrthographicSize = Mathf.Lerp(lensA.OrthographicSize, lensB.OrthographicSize, t);
		result.Dutch = Mathf.Lerp(lensA.Dutch, lensB.Dutch, t);
		result.m_SensorSize = Vector2.Lerp(lensA.m_SensorSize, lensB.m_SensorSize, t);
		result.LensShift = Vector2.Lerp(lensA.LensShift, lensB.LensShift, t);
		return result;
	}

	public void Validate()
	{
		FarClipPlane = Mathf.Max(FarClipPlane, NearClipPlane + 0.001f);
		FieldOfView = Mathf.Clamp(FieldOfView, 0.01f, 179f);
		m_SensorSize.x = Mathf.Max(m_SensorSize.x, 0.1f);
		m_SensorSize.y = Mathf.Max(m_SensorSize.y, 0.1f);
	}
}
