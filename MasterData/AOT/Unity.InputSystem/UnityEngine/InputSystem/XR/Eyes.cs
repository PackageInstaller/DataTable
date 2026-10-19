namespace UnityEngine.InputSystem.XR;

public struct Eyes
{
	public Vector3 m_LeftEyePosition;

	public Quaternion m_LeftEyeRotation;

	public Vector3 m_RightEyePosition;

	public Quaternion m_RightEyeRotation;

	public Vector3 m_FixationPoint;

	public float m_LeftEyeOpenAmount;

	public float m_RightEyeOpenAmount;

	public Vector3 leftEyePosition
	{
		get
		{
			return m_LeftEyePosition;
		}
		set
		{
			m_LeftEyePosition = value;
		}
	}

	public Quaternion leftEyeRotation
	{
		get
		{
			return m_LeftEyeRotation;
		}
		set
		{
			m_LeftEyeRotation = value;
		}
	}

	public Vector3 rightEyePosition
	{
		get
		{
			return m_RightEyePosition;
		}
		set
		{
			m_RightEyePosition = value;
		}
	}

	public Quaternion rightEyeRotation
	{
		get
		{
			return m_RightEyeRotation;
		}
		set
		{
			m_RightEyeRotation = value;
		}
	}

	public Vector3 fixationPoint
	{
		get
		{
			return m_FixationPoint;
		}
		set
		{
			m_FixationPoint = value;
		}
	}

	public float leftEyeOpenAmount
	{
		get
		{
			return m_LeftEyeOpenAmount;
		}
		set
		{
			m_LeftEyeOpenAmount = value;
		}
	}

	public float rightEyeOpenAmount
	{
		get
		{
			return m_RightEyeOpenAmount;
		}
		set
		{
			m_RightEyeOpenAmount = value;
		}
	}
}
