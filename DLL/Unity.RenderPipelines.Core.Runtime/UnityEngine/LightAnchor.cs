namespace UnityEngine;

[AddComponentMenu("Rendering/Light Anchor")]
[ExecuteInEditMode]
[DisallowMultipleComponent]
public class LightAnchor : MonoBehaviour
{
	public enum UpDirection
	{
		World,
		Local
	}

	private struct Axes
	{
		public Vector3 up;

		public Vector3 right;

		public Vector3 forward;
	}

	private const float k_ArcRadius = 5f;

	private const float k_AxisLength = 10f;

	internal const float k_MaxDistance = 10000f;

	[SerializeField]
	[Min(0f)]
	private float m_Distance;

	[SerializeField]
	private UpDirection m_FrameSpace;

	[SerializeField]
	private Transform m_AnchorPositionOverride;

	[SerializeField]
	private Vector3 m_AnchorPositionOffset;

	[SerializeField]
	private float m_Yaw;

	[SerializeField]
	private float m_Pitch;

	[SerializeField]
	private float m_Roll;

	public float yaw
	{
		get
		{
			return m_Yaw;
		}
		set
		{
			m_Yaw = NormalizeAngleDegree(value);
		}
	}

	public float pitch
	{
		get
		{
			return m_Pitch;
		}
		set
		{
			m_Pitch = NormalizeAngleDegree(value);
		}
	}

	public float roll
	{
		get
		{
			return m_Roll;
		}
		set
		{
			m_Roll = NormalizeAngleDegree(value);
		}
	}

	public float distance
	{
		get
		{
			return m_Distance;
		}
		set
		{
			m_Distance = Mathf.Clamp(value, 0f, 10000f);
		}
	}

	public UpDirection frameSpace
	{
		get
		{
			return m_FrameSpace;
		}
		set
		{
			m_FrameSpace = value;
		}
	}

	public Vector3 anchorPosition
	{
		get
		{
			if (anchorPositionOverride != null)
			{
				return anchorPositionOverride.position + anchorPositionOverride.TransformDirection(anchorPositionOffset);
			}
			return base.transform.position + base.transform.forward * distance;
		}
	}

	public Transform anchorPositionOverride
	{
		get
		{
			return m_AnchorPositionOverride;
		}
		set
		{
			m_AnchorPositionOverride = value;
		}
	}

	public Vector3 anchorPositionOffset
	{
		get
		{
			return m_AnchorPositionOffset;
		}
		set
		{
			m_AnchorPositionOffset = value;
		}
	}

	public static float NormalizeAngleDegree(float angle)
	{
		float num = angle - -180f;
		return num - Mathf.Floor(num / 360f) * 360f + -180f;
	}

	public void SynchronizeOnTransform(Camera camera)
	{
		Axes worldSpaceAxes = GetWorldSpaceAxes(camera, anchorPosition);
		Vector3 vector = base.transform.position - anchorPosition;
		if (vector.magnitude == 0f)
		{
			vector = -base.transform.forward;
		}
		Vector3 vector2 = Vector3.ProjectOnPlane(vector, worldSpaceAxes.up);
		if (vector2.magnitude < 0.0001f)
		{
			vector2 = Vector3.ProjectOnPlane(vector, worldSpaceAxes.up + worldSpaceAxes.right * 0.0001f);
		}
		vector2.Normalize();
		float angle = Vector3.SignedAngle(worldSpaceAxes.forward, vector2, worldSpaceAxes.up);
		Vector3 axis = Quaternion.AngleAxis(angle, worldSpaceAxes.up) * worldSpaceAxes.right;
		float num = Vector3.SignedAngle(vector2, vector, axis);
		yaw = angle;
		pitch = num;
		roll = base.transform.rotation.eulerAngles.z;
	}

	public void UpdateTransform(Camera camera, Vector3 anchor)
	{
		Axes worldSpaceAxes = GetWorldSpaceAxes(camera, anchor);
		UpdateTransform(worldSpaceAxes.up, worldSpaceAxes.right, worldSpaceAxes.forward, anchor);
	}

	private Axes GetWorldSpaceAxes(Camera camera, Vector3 anchor)
	{
		if (base.transform.IsChildOf(camera.transform))
		{
			return new Axes
			{
				up = Vector3.up,
				right = Vector3.right,
				forward = Vector3.forward
			};
		}
		Matrix4x4 matrix4x = camera.cameraToWorldMatrix;
		if (m_FrameSpace == UpDirection.Local)
		{
			Vector3 up = Camera.main.transform.up;
			matrix4x = (Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * Matrix4x4.LookAt(camera.transform.position, anchor, up).inverse).inverse;
		}
		else if (!camera.orthographic && camera.transform.position != anchor)
		{
			Quaternion q = Quaternion.LookRotation((anchor - camera.transform.position).normalized);
			matrix4x = (Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * Matrix4x4.TRS(camera.transform.position, q, Vector3.one).inverse).inverse;
		}
		Vector3 up2 = (matrix4x * Vector3.up).normalized;
		Vector3 right = (matrix4x * Vector3.right).normalized;
		Vector3 forward = (matrix4x * Vector3.forward).normalized;
		return new Axes
		{
			up = up2,
			right = right,
			forward = forward
		};
	}

	private void Update()
	{
		if (!(anchorPositionOverride == null) && !(Camera.main == null) && (anchorPositionOverride.hasChanged || Camera.main.transform.hasChanged))
		{
			UpdateTransform(Camera.main, anchorPosition);
		}
	}

	private void OnDrawGizmosSelected()
	{
		Camera main = Camera.main;
		if (!(main == null))
		{
			Vector3 vector = anchorPosition;
			Axes worldSpaceAxes = GetWorldSpaceAxes(main, vector);
			Vector3.ProjectOnPlane(base.transform.position - vector, worldSpaceAxes.up);
			Mathf.Min(distance * 0.25f, 5f);
			Mathf.Min(distance * 0.5f, 10f);
		}
	}

	private void UpdateTransform(Vector3 up, Vector3 right, Vector3 forward, Vector3 anchor)
	{
		Quaternion quaternion = Quaternion.AngleAxis(m_Yaw, up);
		Quaternion quaternion2 = Quaternion.AngleAxis(m_Pitch, right);
		Vector3 position = anchor + quaternion * quaternion2 * forward * distance;
		base.transform.position = position;
		Vector3 eulerAngles = Quaternion.LookRotation(-(quaternion * quaternion2 * forward).normalized, up).eulerAngles;
		eulerAngles.z = m_Roll;
		base.transform.eulerAngles = eulerAngles;
	}
}
