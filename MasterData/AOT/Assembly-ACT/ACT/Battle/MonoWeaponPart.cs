using System;
using System.Collections;
using System.Collections.Generic;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(Collider))]
[ExecuteInEditMode]
[AddComponentMenu("4战斗相关组件/攻击的WeaponPart")]
public class MonoWeaponPart : MonoBehaviour
{
	public Collider myCollider;

	[NonSerialized]
	public List<Collider> touches;

	[NonSerialized]
	public List<Collider> frameTouches;

	private const int FIXED_FRAMES = 1;

	private Vector3[] m_Frames = new Vector3[1];

	private int m_CurrentFrame;

	public Vector3 forward;

	private static WaitForFixedUpdate _waitForFixedUpdate;

	private Coroutine m_WaitForFixedUpdate;

	static MonoWeaponPart()
	{
		_waitForFixedUpdate = new WaitForFixedUpdate();
	}

	private void Awake()
	{
		if (!myCollider)
		{
			myCollider = GetComponent<Collider>();
		}
		touches = ListPool<Collider>.Get();
		frameTouches = ListPool<Collider>.Get();
		if ((bool)myCollider)
		{
			myCollider.gameObject.layer = 9;
		}
	}

	private void OnEnable()
	{
		m_WaitForFixedUpdate = StartCoroutine(WaitForFixedUpdate());
	}

	private void FixedUpdate()
	{
		Vector3 position = transform.position;
		forward = position - m_Frames[m_CurrentFrame];
		m_Frames[m_CurrentFrame] = position;
		m_CurrentFrame++;
		if (m_CurrentFrame >= 1)
		{
			m_CurrentFrame = 0;
		}
	}

	private IEnumerator WaitForFixedUpdate()
	{
		while (true)
		{
			yield return _waitForFixedUpdate;
			touches.Clear();
			touches.AddRange(frameTouches);
			frameTouches.Clear();
		}
	}

	private void OnDestroy()
	{
		if (touches != null)
		{
			ListPool<Collider>.Release(touches);
		}
		if (frameTouches != null)
		{
			ListPool<Collider>.Release(frameTouches);
		}
	}

	private void OnTriggerEnter(Collider collision)
	{
	}

	private void OnTriggerExit(Collider collision)
	{
	}

	private void OnTriggerStay(Collider other)
	{
		frameTouches.Add(other);
	}

	private void OnDisable()
	{
		if (m_WaitForFixedUpdate != null)
		{
			StopCoroutine(m_WaitForFixedUpdate);
			m_WaitForFixedUpdate = null;
		}
		touches?.Clear();
	}
}
