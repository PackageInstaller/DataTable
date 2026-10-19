using System;
using System.Collections.Generic;
using ACT.Battle.ECS.System;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(Collider))]
[ExecuteInEditMode]
[AddComponentMenu("4战斗相关组件/自定义的子弹碰撞")]
public class MonoCustomBulletCollider : MonoBehaviour
{
	public enum MonoCustomBulletColliderDurationType
	{
		always,
		timer
	}

	public MonoCustomBulletColliderDurationType monoCustomBulletColliderDurationType;

	public float timer;

	public Collider myCollider;

	[HideInInspector]
	public Vector3 forward;

	[NonSerialized]
	public Entity ownerEntity;

	[NonSerialized]
	public List<Collider> touches;

	private const int FIXED_FRAMES = 1;

	private Vector3[] m_Frames = new Vector3[1];

	private int m_CurrentFrame;

	private bool m_IsExpired;

	private void Awake()
	{
		if (myCollider == null)
		{
			myCollider = GetComponent<Collider>();
		}
		touches = ListPool<Collider>.Get();
		for (int i = 0; i < 1; i++)
		{
			m_Frames[i] = transform.position;
		}
	}

	private void Start()
	{
		m_IsExpired = false;
	}

	private void FixedUpdate()
	{
		if (m_IsExpired)
		{
			return;
		}
		if (monoCustomBulletColliderDurationType == MonoCustomBulletColliderDurationType.timer)
		{
			timer -= Time.fixedDeltaTime;
			if (timer <= 0f)
			{
				timer = 0f;
				m_IsExpired = true;
				return;
			}
		}
		Vector3 position = transform.position;
		forward = position - m_Frames[m_CurrentFrame];
		m_Frames[m_CurrentFrame] = position;
		m_CurrentFrame++;
		if (m_CurrentFrame >= 1)
		{
			m_CurrentFrame = 0;
		}
		touches.Clear();
		float magnitude = forward.magnitude;
		Vector3 direction = ((magnitude > 1E-06f) ? (forward / magnitude) : transform.forward);
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		int num = PhysicsUtility.CastCustomCollider(myCollider, m_Frames[m_CurrentFrame], transform.rotation, direction, cacheHits, magnitude, BattleConsts.enviromentMask | BattleConsts.hitMask);
		SystemTrajectory trajectorySystem = GameManager.trajectorySystem;
		string value = null;
		if (ownerEntity.IsValid && ownerEntity.TryGetCompTrajectory(out CompTrajectory component))
		{
			value = component.ignoreEnvironmentCollisionTag;
		}
		for (int i = 0; i < num; i++)
		{
			Collider collider = cacheHits[i].collider;
			if (!(collider == null) && (string.IsNullOrEmpty(value) || (BattleConsts.enviromentMask & (1 << collider.gameObject.layer)) == 0 || !collider.CompareTag(value)))
			{
				touches.Add(collider);
				if (ownerEntity.IsValid)
				{
					trajectorySystem.ProcessWeaponPartHit(ownerEntity, collider);
				}
			}
		}
		PhysicsUtility.Release(cacheHits);
	}

	private void OnDestroy()
	{
		if (touches != null)
		{
			ListPool<Collider>.Release(touches);
		}
	}

	private void OnDisable()
	{
		touches?.Clear();
		m_IsExpired = false;
	}
}
