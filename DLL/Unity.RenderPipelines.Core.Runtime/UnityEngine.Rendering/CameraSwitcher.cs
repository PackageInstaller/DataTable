namespace UnityEngine.Rendering;

public class CameraSwitcher : MonoBehaviour
{
	public Camera[] m_Cameras;

	private int m_CurrentCameraIndex = -1;

	private Camera m_OriginalCamera;

	private Vector3 m_OriginalCameraPosition;

	private Quaternion m_OriginalCameraRotation;

	private Camera m_CurrentCamera;

	private GUIContent[] m_CameraNames;

	private int[] m_CameraIndices;

	private DebugUI.EnumField m_DebugEntry;

	private int m_DebugEntryEnumIndex;

	private void OnEnable()
	{
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Expected O, but got Unknown
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Expected O, but got Unknown
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Expected O, but got Unknown
		m_OriginalCamera = GetComponent<Camera>();
		m_CurrentCamera = m_OriginalCamera;
		if (m_OriginalCamera == null)
		{
			Debug.LogError("Camera Switcher needs a Camera component attached");
			return;
		}
		m_CurrentCameraIndex = GetCameraCount() - 1;
		m_CameraNames = (GUIContent[])(object)new GUIContent[GetCameraCount()];
		m_CameraIndices = new int[GetCameraCount()];
		for (int i = 0; i < m_Cameras.Length; i++)
		{
			Camera camera = m_Cameras[i];
			if (camera != null)
			{
				m_CameraNames[i] = new GUIContent(camera.name);
			}
			else
			{
				m_CameraNames[i] = new GUIContent("null");
			}
			m_CameraIndices[i] = i;
		}
		m_CameraNames[GetCameraCount() - 1] = new GUIContent("Original Camera");
		m_CameraIndices[GetCameraCount() - 1] = GetCameraCount() - 1;
		m_DebugEntry = new DebugUI.EnumField
		{
			displayName = "Camera Switcher",
			getter = () => m_CurrentCameraIndex,
			setter = delegate(int value)
			{
				SetCameraIndex(value);
			},
			enumNames = m_CameraNames,
			enumValues = m_CameraIndices,
			getIndex = () => m_DebugEntryEnumIndex,
			setIndex = delegate(int value)
			{
				m_DebugEntryEnumIndex = value;
			}
		};
		DebugManager.instance.GetPanel("Camera", createIfNull: true).children.Add(m_DebugEntry);
	}

	private void OnDisable()
	{
		if (m_DebugEntry != null && m_DebugEntry.panel != null)
		{
			m_DebugEntry.panel.children.Remove(m_DebugEntry);
		}
	}

	private int GetCameraCount()
	{
		return m_Cameras.Length + 1;
	}

	private Camera GetNextCamera()
	{
		if (m_CurrentCameraIndex == m_Cameras.Length)
		{
			return m_OriginalCamera;
		}
		return m_Cameras[m_CurrentCameraIndex];
	}

	private void SetCameraIndex(int index)
	{
		if (index <= 0 || index >= GetCameraCount())
		{
			return;
		}
		m_CurrentCameraIndex = index;
		if (m_CurrentCamera == m_OriginalCamera)
		{
			m_OriginalCameraPosition = m_OriginalCamera.transform.position;
			m_OriginalCameraRotation = m_OriginalCamera.transform.rotation;
		}
		m_CurrentCamera = GetNextCamera();
		if (m_CurrentCamera != null)
		{
			if (m_CurrentCamera == m_OriginalCamera)
			{
				m_OriginalCamera.transform.position = m_OriginalCameraPosition;
				m_OriginalCamera.transform.rotation = m_OriginalCameraRotation;
			}
			base.transform.position = m_CurrentCamera.transform.position;
			base.transform.rotation = m_CurrentCamera.transform.rotation;
		}
	}
}
