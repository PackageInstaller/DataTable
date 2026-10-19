namespace UnityEngine.ResourceManagement.ResourceProviders;

public struct InstantiationParameters
{
	private Vector3 m_Position;

	private Quaternion m_Rotation;

	private Transform m_Parent;

	private bool m_InstantiateInWorldPosition;

	private bool m_SetPositionRotation;

	public Vector3 Position => m_Position;

	public Quaternion Rotation => m_Rotation;

	public Transform Parent => m_Parent;

	public bool InstantiateInWorldPosition => m_InstantiateInWorldPosition;

	public bool SetPositionRotation => m_SetPositionRotation;

	public InstantiationParameters(Transform parent, bool instantiateInWorldSpace)
	{
		m_Position = Vector3.zero;
		m_Rotation = Quaternion.identity;
		m_Parent = parent;
		m_InstantiateInWorldPosition = instantiateInWorldSpace;
		m_SetPositionRotation = false;
	}

	public InstantiationParameters(Vector3 position, Quaternion rotation, Transform parent)
	{
		m_Position = position;
		m_Rotation = rotation;
		m_Parent = parent;
		m_InstantiateInWorldPosition = false;
		m_SetPositionRotation = true;
	}

	public TObject Instantiate<TObject>(TObject source) where TObject : Object
	{
		if (m_Parent == null)
		{
			if (m_SetPositionRotation)
			{
				return Object.Instantiate(source, m_Position, m_Rotation);
			}
			return Object.Instantiate(source);
		}
		if (m_SetPositionRotation)
		{
			return Object.Instantiate(source, m_Position, m_Rotation, m_Parent);
		}
		return Object.Instantiate(source, m_Parent, m_InstantiateInWorldPosition);
	}
}
