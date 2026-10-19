using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.8/manual/CinemachineImpulseSourceOverview.html")]
public class CinemachineImpulseSource : MonoBehaviour
{
	public CinemachineImpulseDefinition m_ImpulseDefinition = new CinemachineImpulseDefinition();

	[Header("Default Invocation")]
	[Tooltip("The default direction and force of the Impulse Signal in the absense of any specified overrides.  Overrides can be specified by calling the appropriate GenerateImpulse method in the API.")]
	public Vector3 m_DefaultVelocity = Vector3.down;

	private void OnValidate()
	{
		m_ImpulseDefinition.OnValidate();
	}

	private void Reset()
	{
		m_ImpulseDefinition = new CinemachineImpulseDefinition
		{
			m_ImpulseChannel = 1,
			m_ImpulseShape = CinemachineImpulseDefinition.ImpulseShapes.Bump,
			m_CustomImpulseShape = new AnimationCurve(),
			m_CustomImpulseShapeY = new AnimationCurve(),
			m_CustomImpulseShapeZ = new AnimationCurve(),
			m_ImpulseDuration = 0.2f,
			m_ImpulseType = CinemachineImpulseDefinition.ImpulseTypes.Uniform,
			m_DissipationDistance = 100f,
			m_DissipationRate = 0.25f,
			m_PropagationSpeed = 343f
		};
		m_DefaultVelocity = Vector3.down;
	}

	public void GenerateImpulseAtPositionWithVelocity(Vector3 position, Vector3 velocity)
	{
		if (m_ImpulseDefinition != null)
		{
			m_ImpulseDefinition.CreateEvent(position, velocity);
		}
	}

	public void GenerateImpulseWithVelocity(Vector3 velocity)
	{
		GenerateImpulseAtPositionWithVelocity(transform.position, velocity);
	}

	public void GenerateImpulseWithForce(float force)
	{
		GenerateImpulseAtPositionWithVelocity(transform.position, m_DefaultVelocity * force);
	}

	public void GenerateImpulse()
	{
		GenerateImpulseWithVelocity(m_DefaultVelocity);
	}

	public void GenerateImpulseWithPositionAndForce(Vector3 position, float force, bool changeVelocityXZ = false)
	{
		Vector3 velocity = m_DefaultVelocity * force;
		if (changeVelocityXZ)
		{
			velocity.x *= -1f;
		}
		GenerateImpulseAtPositionWithVelocity(position, velocity);
	}

	public void GenerateImpulseAt(Vector3 position, Vector3 velocity)
	{
		GenerateImpulseAtPositionWithVelocity(position, velocity);
	}

	public void GenerateImpulse(Vector3 velocity)
	{
		GenerateImpulseWithVelocity(velocity);
	}

	public void GenerateImpulse(float force)
	{
		GenerateImpulseWithForce(force);
	}
}
