using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.World.StateObject;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

public class DecodeRayEmitterBehaveEvent : LuminSerializedMonoBehaviour
{
	[Range(0f, 100f)]
	public int rayMaxCount = 10;

	public MonoCylinderLineRenderer effect;

	public YooAssetReference hitEffectAssetID;

	public string[] raycastLayer;

	[NonSerialized]
	public int receiverCounts;

	private LayerMask m_Mask;

	[SerializeField]
	private float m_InternalCD = 1f;

	private long m_LastExposeTime;

	private bool m_Running;

	private int m_Counter;

	[SerializeField]
	private int m_EmitRate = 5;

	private List<Vector3> points;

	private StateObjectBase m_LastStateObj;

	private List<InstanceHandle> m_CachedHitEffect;

	private void Awake()
	{
		m_Mask = LayerMask.GetMask(raycastLayer);
		m_Running = false;
		points = ListPool<Vector3>.Get();
		m_CachedHitEffect = ListPool<InstanceHandle>.Get();
		PrecacheManager.Instance.Preload(hitEffectAssetID.GUID);
	}

	private void OnDestroy()
	{
		foreach (InstanceHandle item in m_CachedHitEffect)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(item);
		}
		ListPool<Vector3>.Release(points);
		ListPool<InstanceHandle>.Release(m_CachedHitEffect);
		points = null;
		m_CachedHitEffect = null;
		PrecacheManager.Instance.ReleasePreload(hitEffectAssetID.GUID);
	}

	private void Update()
	{
		if (m_Running)
		{
			Vector3 position = transform.position;
			Ray ray = new Ray(position, transform.forward);
			effect.SetPosition(0, position);
			effect.SetPosition(1, Physics.Raycast(ray, out var hitInfo, 1000f, m_Mask) ? hitInfo.point : ray.GetPoint(1000f));
		}
	}

	private void FixedUpdate()
	{
		if (!m_Running)
		{
			return;
		}
		m_Counter++;
		m_Counter %= m_EmitRate;
		if (m_Counter != 0)
		{
			return;
		}
		receiverCounts = 0;
		points.Clear();
		Transform transform = base.transform;
		Vector3 position = transform.position;
		Ray ray = new Ray(position, transform.forward);
		if (Physics.Raycast(ray, out var hitInfo, 1000f, m_Mask))
		{
			AddCorner(position, hitInfo.point);
			DecodeRayReceiverBehaveEvent component = hitInfo.transform.GetComponent<DecodeRayReceiverBehaveEvent>();
			if ((bool)component)
			{
				component.OnReflect(this, position, hitInfo.point);
			}
			StateObjectBase component2 = hitInfo.transform.GetComponent<StateObjectBase>();
			if ((bool)component2)
			{
				try
				{
					OnShootStateObject(component2);
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
				}
			}
		}
		else
		{
			AddCorner(position, ray.GetPoint(1000f));
		}
		effect.positionCount = points.Count;
		effect.SetPositions(points.ToArray());
		UpdateHitEffect();
	}

	public void AddCorner(Vector3 start, Vector3 end)
	{
		try
		{
			int num = receiverCounts + 1;
			if (num >= rayMaxCount)
			{
				throw new StackOverflowException($"无限反射？折射次数{num}太多了,重新设计一下吧！");
			}
			if (num > 1)
			{
				List<Vector3> list = points;
				Vector3 vector = list[list.Count - 2];
				List<Vector3> list2 = points;
				Vector3 vector2 = list2[list2.Count - 1];
				if (Vector3.Magnitude(vector - end) < Mathf.Epsilon && Vector3.Magnitude(vector2 - start) < Mathf.Epsilon)
				{
					throw new StackOverflowException("两条相邻射线存在无限递归！");
				}
			}
			points.Add(start);
			points.Add(end);
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning(message);
			}
		}
	}

	public void OnShootStateObject(StateObjectBase obj)
	{
		if (obj.Inited)
		{
			if (m_LastStateObj != obj && m_LastStateObj != null)
			{
				m_LastStateObj.OnExitExposed();
			}
			obj.OnExposed();
			m_LastStateObj = obj;
		}
	}

	public void OnMissStateObject()
	{
		if (m_LastStateObj != null)
		{
			m_LastStateObj.OnExitExposed();
		}
		m_LastStateObj = null;
	}

	private void SetHitEffect(int index, Vector3 position)
	{
		if (m_CachedHitEffect.Count <= index)
		{
			m_CachedHitEffect.Add(PrecacheManager.Instance.GetInstanceHandle(hitEffectAssetID.GUID));
		}
		m_CachedHitEffect[index].Completed += (InstanceHandle l) =>
		{
			GameObject result = l.Result;
			result.transform.SetParent(transform);
			result.SetActive(value: true);
			result.transform.position = position;
		};
	}

	private void UpdateHitEffect()
	{
		if (points.Count > 1)
		{
			SetHitEffect(0, points[0]);
		}
		int num = 1;
		int i;
		for (i = 1; i < points.Count; i += 2)
		{
			num = i / 2 + 1;
			SetHitEffect(num, points[i]);
		}
		num = i / 2 + 1;
		if (m_CachedHitEffect.Count > num)
		{
			for (int num2 = m_CachedHitEffect.Count - 1; num2 >= num; num2--)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(m_CachedHitEffect[num2]);
				m_CachedHitEffect.RemoveAt(num2);
			}
		}
	}

	public void EmitRay()
	{
		m_Running = true;
		effect.enabled = true;
	}

	public void StopRay()
	{
		m_Running = false;
		receiverCounts = 0;
		effect.enabled = false;
		points.Clear();
		foreach (InstanceHandle item in m_CachedHitEffect)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(item);
		}
		m_CachedHitEffect.Clear();
	}
}
