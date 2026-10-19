namespace UnityEngine.InputSystem.XR;

public struct Bone
{
	public uint m_ParentBoneIndex;

	public Vector3 m_Position;

	public Quaternion m_Rotation;

	public uint parentBoneIndex
	{
		get
		{
			return m_ParentBoneIndex;
		}
		set
		{
			m_ParentBoneIndex = value;
		}
	}

	public Vector3 position
	{
		get
		{
			return m_Position;
		}
		set
		{
			m_Position = value;
		}
	}

	public Quaternion rotation
	{
		get
		{
			return m_Rotation;
		}
		set
		{
			m_Rotation = value;
		}
	}
}
