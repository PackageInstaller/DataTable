using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[SaveDuringPlay]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.8/manual/CinemachineCollisionImpulseSource.html")]
public class CinemachineCollisionImpulseSource : CinemachineImpulseSource
{
	[Header("Trigger Object Filter")]
	[Tooltip("Only collisions with objects on these layers will generate Impulse events")]
	public LayerMask m_LayerMask = 1;

	[Tooltip("No Impulse evemts will be generated for collisions with objects having these tags")]
	[TagField]
	public string m_IgnoreTag = string.Empty;

	[Header("How To Generate The Impulse")]
	[Tooltip("If checked, signal direction will be affected by the direction of impact")]
	public bool m_UseImpactDirection;

	[Tooltip("If checked, signal amplitude will be multiplied by the mass of the impacting object")]
	public bool m_ScaleImpactWithMass;

	[Tooltip("If checked, signal amplitude will be multiplied by the speed of the impacting object")]
	public bool m_ScaleImpactWithSpeed;

	private Rigidbody mRigidBody;

	private Rigidbody2D mRigidBody2D;

	private void Start()
	{
		mRigidBody = GetComponent<Rigidbody>();
		mRigidBody2D = GetComponent<Rigidbody2D>();
	}

	private void OnEnable()
	{
	}

	private void OnCollisionEnter(Collision c)
	{
		GenerateImpactEvent(c.collider, c.relativeVelocity);
	}

	private void OnTriggerEnter(Collider c)
	{
		GenerateImpactEvent(c, Vector3.zero);
	}

	private float GetMassAndVelocity(Collider other, ref Vector3 vel)
	{
		bool flag = vel == Vector3.zero;
		float num = 1f;
		if (m_ScaleImpactWithMass || m_ScaleImpactWithSpeed || m_UseImpactDirection)
		{
			if (mRigidBody != null)
			{
				if (m_ScaleImpactWithMass)
				{
					num *= mRigidBody.mass;
				}
				if (flag)
				{
					vel = -mRigidBody.velocity;
				}
			}
			Rigidbody rigidbody = ((other != null) ? other.attachedRigidbody : null);
			if (rigidbody != null)
			{
				if (m_ScaleImpactWithMass)
				{
					num *= rigidbody.mass;
				}
				if (flag)
				{
					vel += rigidbody.velocity;
				}
			}
		}
		return num;
	}

	private void GenerateImpactEvent(Collider other, Vector3 vel)
	{
		if (!enabled)
		{
			return;
		}
		if (other != null)
		{
			int layer = other.gameObject.layer;
			if (((1 << layer) & (int)m_LayerMask) == 0 || (m_IgnoreTag.Length != 0 && other.CompareTag(m_IgnoreTag)))
			{
				return;
			}
		}
		float num = GetMassAndVelocity(other, ref vel);
		if (m_ScaleImpactWithSpeed)
		{
			num *= Mathf.Sqrt(vel.magnitude);
		}
		Vector3 vector = m_DefaultVelocity;
		if (m_UseImpactDirection && !vel.AlmostZero())
		{
			vector = -vel.normalized * vector.magnitude;
		}
		GenerateImpulseWithVelocity(vector * num);
	}

	private void OnCollisionEnter2D(Collision2D c)
	{
		GenerateImpactEvent2D(c.collider, c.relativeVelocity);
	}

	private void OnTriggerEnter2D(Collider2D c)
	{
		GenerateImpactEvent2D(c, Vector3.zero);
	}

	private float GetMassAndVelocity2D(Collider2D other2d, ref Vector3 vel)
	{
		bool flag = vel == Vector3.zero;
		float num = 1f;
		if (m_ScaleImpactWithMass || m_ScaleImpactWithSpeed || m_UseImpactDirection)
		{
			if (mRigidBody2D != null)
			{
				if (m_ScaleImpactWithMass)
				{
					num *= mRigidBody2D.mass;
				}
				if (flag)
				{
					vel = -mRigidBody2D.velocity;
				}
			}
			Rigidbody2D rigidbody2D = ((other2d != null) ? other2d.attachedRigidbody : null);
			if (rigidbody2D != null)
			{
				if (m_ScaleImpactWithMass)
				{
					num *= rigidbody2D.mass;
				}
				if (flag)
				{
					Vector3 vector = rigidbody2D.velocity;
					vel += vector;
				}
			}
		}
		return num;
	}

	private void GenerateImpactEvent2D(Collider2D other2d, Vector3 vel)
	{
		if (!enabled)
		{
			return;
		}
		if (other2d != null)
		{
			int layer = other2d.gameObject.layer;
			if (((1 << layer) & (int)m_LayerMask) == 0 || (m_IgnoreTag.Length != 0 && other2d.CompareTag(m_IgnoreTag)))
			{
				return;
			}
		}
		float num = GetMassAndVelocity2D(other2d, ref vel);
		if (m_ScaleImpactWithSpeed)
		{
			num *= Mathf.Sqrt(vel.magnitude);
		}
		Vector3 vector = m_DefaultVelocity;
		if (m_UseImpactDirection && !vel.AlmostZero())
		{
			vector = -vel.normalized * vector.magnitude;
		}
		GenerateImpulseWithVelocity(vector * num);
	}
}
