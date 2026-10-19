using System;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class AreaCameraBlender : MonoBehaviour
{
	[Serializable]
	public class AreaCameraBlend
	{
		public enum BlendAxis
		{
			X,
			Y
		}

		public AreaCamera a;

		public AreaCamera b;

		public BlendAxis axis;
	}

	[SerializeField]
	private float damp = 3f;

	[Header("要混合的区域相机(最大限制8个)")]
	public List<AreaCamera> AreaCameras = new List<AreaCamera>();

	public List<AreaCameraBlend> AreaCameraBlends = new List<AreaCameraBlend>();

	private Dictionary<CinemachineVirtualCameraBase, AreaCamera> m_AreaCameraMap = new Dictionary<CinemachineVirtualCameraBase, AreaCamera>();

	private CinemachineMixingCamera m_MixingCamera;

	private List<AreaCamera> m_AreaCamerasBuffer = new List<AreaCamera>();

	private Dictionary<AreaCamera, Dictionary<AreaCamera, AreaCameraBlend>> m_BlendMap = new Dictionary<AreaCamera, Dictionary<AreaCamera, AreaCameraBlend>>();

	private void OnEnable()
	{
		m_MixingCamera = GetComponentInChildren<CinemachineMixingCamera>(includeInactive: true);
		if (!m_MixingCamera)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("区域相机混合器：未找到 CinemachineMixingCamera，跳过初始化", this);
			}
			enabled = false;
			return;
		}
		m_AreaCameraMap?.Clear();
		m_BlendMap.Clear();
		foreach (AreaCamera item in AreaCameras ?? (AreaCameras = new List<AreaCamera>()))
		{
			if (!item)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("区域相机混合器：有区域相机为空");
				}
			}
			else if ((bool)item.conditionalCamera.vCamera)
			{
				m_AreaCameraMap[item.conditionalCamera.vCamera] = item;
				item.AreaCameraBlender = this;
				item.conditionalCamera.vCamera.transform.SetParent(m_MixingCamera.transform, worldPositionStays: true);
			}
		}
		foreach (AreaCameraBlend item2 in AreaCameraBlends ?? (AreaCameraBlends = new List<AreaCameraBlend>()))
		{
			if (item2 == null || !item2.a || !item2.b)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("区域相机混合器：忽略了缺少区域相机的混合配置", this);
				}
				continue;
			}
			if (!m_BlendMap.TryGetValue(item2.a, out var value))
			{
				value = (m_BlendMap[item2.a] = new Dictionary<AreaCamera, AreaCameraBlend>());
			}
			value[item2.b] = item2;
			if (!m_BlendMap.TryGetValue(item2.b, out var value2))
			{
				value2 = (m_BlendMap[item2.b] = new Dictionary<AreaCamera, AreaCameraBlend>());
			}
			value2[item2.a] = item2;
		}
		int num = int.MinValue;
		m_AreaCamerasBuffer.Clear();
		for (int i = 0; i < m_MixingCamera.ChildCameras.Length; i++)
		{
			CinemachineVirtualCameraBase cinemachineVirtualCameraBase = m_MixingCamera.ChildCameras[i];
			if (m_AreaCameraMap[cinemachineVirtualCameraBase].IsStay)
			{
				if (cinemachineVirtualCameraBase.Priority > num)
				{
					m_AreaCamerasBuffer.Clear();
					num = cinemachineVirtualCameraBase.Priority;
				}
				m_AreaCamerasBuffer.Add(m_AreaCameraMap[cinemachineVirtualCameraBase]);
			}
		}
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.BackTrace))
		{
			m_MixingCamera.enabled = m_AreaCamerasBuffer.Count > 0;
		}
		else if (m_AreaCamerasBuffer.Count <= 0)
		{
			m_MixingCamera.enabled = false;
		}
	}

	private void Update()
	{
		int num = int.MinValue;
		m_AreaCamerasBuffer.Clear();
		for (int i = 0; i < m_MixingCamera.ChildCameras.Length; i++)
		{
			CinemachineVirtualCameraBase cinemachineVirtualCameraBase = m_MixingCamera.ChildCameras[i];
			if (m_AreaCameraMap[cinemachineVirtualCameraBase].IsStay)
			{
				if (cinemachineVirtualCameraBase.Priority > num)
				{
					m_AreaCamerasBuffer.Clear();
					num = cinemachineVirtualCameraBase.Priority;
				}
				m_AreaCamerasBuffer.Add(m_AreaCameraMap[cinemachineVirtualCameraBase]);
			}
		}
		if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.BackTrace))
		{
			m_MixingCamera.enabled = m_AreaCamerasBuffer.Count > 0;
			return;
		}
		if (m_AreaCamerasBuffer.Count <= 0)
		{
			m_MixingCamera.enabled = false;
			return;
		}
		CameraPlayerWrapper cameraPlayerWrapper = GameManager.cameraSystem.CameraPlayerWrapper;
		m_MixingCamera.enabled = true;
		if (m_AreaCamerasBuffer.Count < 2)
		{
			AreaCamera areaCamera = m_AreaCamerasBuffer[0];
			for (int j = 0; j < m_MixingCamera.ChildCameras.Length; j++)
			{
				float weight = m_MixingCamera.GetWeight(j);
				if (m_MixingCamera.ChildCameras[j] == areaCamera.conditionalCamera.vCamera)
				{
					m_MixingCamera.SetWeight(j, Mathf.MoveTowards(weight, 1f, damp * Time.deltaTime));
				}
				else
				{
					m_MixingCamera.SetWeight(j, Mathf.MoveTowards(weight, 0f, damp * Time.deltaTime));
				}
			}
			return;
		}
		AreaCamera areaCamera2 = m_AreaCamerasBuffer[0];
		AreaCamera areaCamera3 = m_AreaCamerasBuffer[1];
		AreaCameraBlend value = null;
		bool flag = m_BlendMap.TryGetValue(areaCamera2, out var value2) && value2.TryGetValue(areaCamera3, out value);
		float num2 = 0f;
		if (flag)
		{
			Bounds bounds = areaCamera2.Collider.bounds;
			Bounds bounds2 = areaCamera3.Collider.bounds;
			int index = value.axis switch
			{
				AreaCameraBlend.BlendAxis.X => 0, 
				AreaCameraBlend.BlendAxis.Y => 1, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			if (bounds.center[index] > bounds2.center[index])
			{
				AreaCamera areaCamera4 = areaCamera3;
				AreaCamera areaCamera5 = areaCamera2;
				areaCamera2 = areaCamera4;
				areaCamera3 = areaCamera5;
				Bounds bounds3 = bounds2;
				Bounds bounds4 = bounds;
				bounds = bounds3;
				bounds2 = bounds4;
			}
			float num3 = cameraPlayerWrapper.transform.position[index];
			float num4 = bounds2.min[index];
			float num5 = bounds.max[index];
			float num6 = num5 - num4;
			if (num6 > Mathf.Epsilon)
			{
				num2 = Mathf.Clamp01((num3 - num4) / num6);
			}
			else
			{
				num2 = ((num3 >= (num4 + num5) * 0.5f) ? 1f : 0f);
			}
		}
		for (int k = 0; k < m_MixingCamera.ChildCameras.Length; k++)
		{
			CinemachineVirtualCameraBase obj = m_MixingCamera.ChildCameras[k];
			bool flag2 = obj == areaCamera2.conditionalCamera.vCamera;
			bool flag3 = obj == areaCamera3.conditionalCamera.vCamera;
			if (flag || !(flag2 | flag3))
			{
				float target;
				if (flag2)
				{
					target = 1f - num2;
				}
				else
				{
					target = (flag3 ? num2 : 0f);
				}
				float weight2 = m_MixingCamera.GetWeight(k);
				m_MixingCamera.SetWeight(k, Mathf.MoveTowards(weight2, target, damp * Time.deltaTime));
			}
		}
	}

	private void Bake()
	{
		AreaCameraBlends.Clear();
		for (int i = 0; i < AreaCameras.Count; i++)
		{
			for (int j = 0; j < AreaCameras.Count; j++)
			{
				if (j == i)
				{
					continue;
				}
				AreaCamera cameraA = AreaCameras[i];
				AreaCamera cameraB = AreaCameras[j];
				if (!cameraA || !cameraB)
				{
					continue;
				}
				Collider component = cameraA.GetComponent<Collider>();
				Collider component2 = cameraA.GetComponent<Collider>();
				if (!component || !component2)
				{
					continue;
				}
				Bounds bounds = component.bounds;
				Bounds bounds2 = component2.bounds;
				if (bounds.Intersects(bounds2))
				{
					AreaCameraBlend item = new AreaCameraBlend
					{
						a = cameraA,
						b = cameraB
					};
					if (!AreaCameraBlends.Any((AreaCameraBlend existing) => (existing.a == cameraA && existing.b == cameraB) || (existing.a == cameraB && existing.b == cameraA)))
					{
						AreaCameraBlends.Add(item);
					}
				}
			}
		}
	}
}
