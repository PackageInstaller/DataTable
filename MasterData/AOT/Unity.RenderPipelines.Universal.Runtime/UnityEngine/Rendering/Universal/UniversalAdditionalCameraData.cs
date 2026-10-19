using System;
using System.Collections.Generic;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

[RequireComponent(typeof(Camera))]
[DisallowMultipleComponent]
[ImageEffectAllowedInSceneView]
public class UniversalAdditionalCameraData : MonoBehaviour, ISerializationCallbackReceiver, IAdditionalData
{
	private const string k_GizmoPath = "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/";

	private const string k_BaseCameraGizmoPath = "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/Camera_Base.png";

	private const string k_OverlayCameraGizmoPath = "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/Camera_Base.png";

	private const string k_PostProcessingGizmoPath = "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/Camera_PostProcessing.png";

	[SerializeField]
	[FormerlySerializedAs("renderShadows")]
	private bool m_RenderShadows = true;

	[SerializeField]
	private CameraRenderType m_CameraType;

	[SerializeField]
	private List<Camera> m_Cameras = new List<Camera>();

	[SerializeField]
	private int m_RendererIndex = -1;

	[SerializeField]
	private LayerMask m_VolumeLayerMask = 1;

	[SerializeField]
	private Transform m_VolumeTrigger;

	[SerializeField]
	private VolumeFrameworkUpdateMode m_VolumeFrameworkUpdateModeOption = VolumeFrameworkUpdateMode.UsePipelineSettings;

	[SerializeField]
	private bool m_RenderPostProcessing;

	[SerializeField]
	private bool m_ClearDepth = true;

	[NonSerialized]
	private Camera m_Camera;

	[SerializeField]
	private bool m_GammaUI;

	[SerializeField]
	private bool m_SkipBase;

	[SerializeField]
	[HideInInspector]
	private float m_Version = 2f;

	[NonSerialized]
	private MotionVectorsPersistentData m_MotionVectorsPersistentData = new MotionVectorsPersistentData();

	private static UniversalAdditionalCameraData s_DefaultAdditionalCameraData;

	private VolumeStack m_VolumeStack;

	public bool gammaUI
	{
		get
		{
			return m_GammaUI;
		}
		set
		{
			m_GammaUI = value;
		}
	}

	public bool skipBase
	{
		get
		{
			return m_SkipBase;
		}
		set
		{
			m_SkipBase = value;
		}
	}

	public float version => m_Version;

	internal static UniversalAdditionalCameraData defaultAdditionalCameraData
	{
		get
		{
			if (s_DefaultAdditionalCameraData == null)
			{
				s_DefaultAdditionalCameraData = new UniversalAdditionalCameraData();
			}
			return s_DefaultAdditionalCameraData;
		}
	}

	internal Camera camera
	{
		get
		{
			if (!m_Camera)
			{
				gameObject.TryGetComponent<Camera>(out m_Camera);
			}
			return m_Camera;
		}
	}

	public bool renderShadows
	{
		get
		{
			return m_RenderShadows;
		}
		set
		{
			m_RenderShadows = value;
		}
	}

	public CameraRenderType renderType
	{
		get
		{
			return m_CameraType;
		}
		set
		{
			m_CameraType = value;
		}
	}

	public List<Camera> cameraStack => m_Cameras;

	public bool clearDepth => m_ClearDepth;

	public ScriptableRenderer scriptableRenderer => UniversalRenderPipeline.asset.GetRenderer(m_RendererIndex);

	public UniversalRenderer ur => scriptableRenderer as UniversalRenderer;

	public LayerMask volumeLayerMask
	{
		get
		{
			return m_VolumeLayerMask;
		}
		set
		{
			m_VolumeLayerMask = value;
		}
	}

	public Transform volumeTrigger
	{
		get
		{
			return m_VolumeTrigger;
		}
		set
		{
			m_VolumeTrigger = value;
		}
	}

	internal VolumeFrameworkUpdateMode volumeFrameworkUpdateMode
	{
		get
		{
			return m_VolumeFrameworkUpdateModeOption;
		}
		set
		{
			m_VolumeFrameworkUpdateModeOption = value;
		}
	}

	public bool requiresVolumeFrameworkUpdate => m_VolumeFrameworkUpdateModeOption != VolumeFrameworkUpdateMode.ViaScripting;

	public VolumeStack volumeStack
	{
		get
		{
			return m_VolumeStack;
		}
		set
		{
			m_VolumeStack = value;
		}
	}

	public bool renderPostProcessing
	{
		get
		{
			return m_RenderPostProcessing;
		}
		set
		{
			m_RenderPostProcessing = value;
		}
	}

	internal MotionVectorsPersistentData motionVectorsPersistentData => m_MotionVectorsPersistentData;

	internal void UpdateCameraStack()
	{
		int count = m_Cameras.Count;
		m_Cameras.RemoveAll((Camera cam) => cam == null);
		int count2 = m_Cameras.Count;
		int num = count - count2;
		if (num != 0)
		{
			Debug.LogWarning(name + ": " + num + " camera overlay" + ((num > 1) ? "s" : "") + " no longer exists and will be removed from the camera stack.");
		}
	}

	public void SetRenderer(int index)
	{
		m_RendererIndex = index;
	}

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
	}

	public void OnDrawGizmos()
	{
		string value = "";
		Color white = Color.white;
		if (m_CameraType == CameraRenderType.Base)
		{
			value = "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/Camera_Base.png";
		}
		else if (m_CameraType == CameraRenderType.Overlay)
		{
			value = "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/Camera_Base.png";
		}
		if (!string.IsNullOrEmpty(value))
		{
			Gizmos.DrawIcon(transform.position, value, allowScaling: true, white);
		}
		if (camera.cameraType == CameraType.Game && m_CameraType == CameraRenderType.Base)
		{
			Gizmos.DrawIcon(transform.position, "Packages/com.unity.render-pipelines.universal/Editor/Gizmos/Camera_PostProcessing.png", allowScaling: true, white);
		}
	}
}
