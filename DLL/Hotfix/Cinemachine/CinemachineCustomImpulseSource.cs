using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
public class CinemachineCustomImpulseSource : MonoBehaviour
{
	public CinemachineCustomImpulseDefinition m_ImpulseDefinition = new CinemachineCustomImpulseDefinition();

	[Header("Default Invocation")]
	[Tooltip("The default direction and force of the Impulse Signal in the absense of any specified overrides.  Overrides can be specified by calling the appropriate GenerateImpulse method in the API.")]
	public Vector3 m_DefaultVelocity = Vector3.down;

	private void OnValidate()
	{
		m_ImpulseDefinition.OnValidate();
	}

	private void Reset()
	{
		m_ImpulseDefinition = new CinemachineCustomImpulseDefinition
		{
			m_ImpulseChannel = 1,
			m_ImpulseShape = CinemachineCustomImpulseDefinition.ImpulseShapes.Bump,
			m_CustomImpulseShape = new AnimationCurve(),
			m_ImpulseDuration = 0.2f,
			m_ImpulseType = CinemachineCustomImpulseDefinition.ImpulseTypes.Uniform,
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
		GenerateImpulseAtPositionWithVelocity(base.transform.position, velocity);
	}

	public void GenerateImpulseWithForce(float force)
	{
		GenerateImpulseAtPositionWithVelocity(base.transform.position, m_DefaultVelocity * force);
	}

	public void GenerateImpulse()
	{
		GenerateImpulseWithVelocity(m_DefaultVelocity);
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
