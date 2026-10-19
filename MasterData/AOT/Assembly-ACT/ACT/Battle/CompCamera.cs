using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CompCamera
{
	public string curVirtualCamera;

	[Obsolete]
	public bool changed;

	public Camera mainCamera;

	public List<Entity> hits;

	[Obsolete]
	public bool setAnimatorParam;

	[Obsolete]
	public bool setLeft;

	private CancellationTokenSource m_cts;

	private Dictionary<int, float> m_camFOV;

	internal void Init()
	{
		hits = new List<Entity>();
		m_cts = new CancellationTokenSource();
		m_camFOV = new Dictionary<int, float>();
	}

	public void FireCameraFOV(AnimationCurve curve, float time, TimeScale timeScale)
	{
		m_cts.Cancel();
		m_cts = new CancellationTokenSource();
		FOVChange(curve, time, m_cts.Token, timeScale);
	}

	private async void FOVChange(AnimationCurve curve, float time, CancellationToken token, TimeScale timeScale = TimeScale.NoScale)
	{
		float curTime = 0f;
		float rate = 0f;
		CinemachineBrain cinemachineBrain = mainCamera.GetComponent<CinemachineBrain>();
		if (!(cinemachineBrain.ActiveVirtualCamera is CinemachineVirtualCamera))
		{
			return;
		}
		CinemachineVirtualCamera virtualCamera = mainCamera.GetComponent<CinemachineBrain>().ActiveVirtualCamera as CinemachineVirtualCamera;
		int cameraId = virtualCamera.GetInstanceID();
		if (!m_camFOV.ContainsKey(cameraId))
		{
			m_camFOV.Add(cameraId, virtualCamera.m_Lens.FieldOfView);
		}
		virtualCamera.m_Lens.FieldOfView = curve.GetFirstValue();
		while (!token.IsCancellationRequested && !(rate >= 1f))
		{
			if (cinemachineBrain.ActiveVirtualCamera != null && (cinemachineBrain.ActiveVirtualCamera as CinemachineVirtualCamera).GetInstanceID() != cameraId)
			{
				virtualCamera.m_Lens.FieldOfView = m_camFOV[cameraId];
				virtualCamera = cinemachineBrain.ActiveVirtualCamera as CinemachineVirtualCamera;
				cameraId = virtualCamera.GetInstanceID();
				if (!m_camFOV.ContainsKey(cameraId))
				{
					m_camFOV.Add(cameraId, virtualCamera.m_Lens.FieldOfView);
				}
			}
			switch (timeScale)
			{
			case TimeScale.Owner:
				curTime += MonoECS.instance.mainEntity.GetCompTime().fixedDeltaTime;
				break;
			case TimeScale.NoScale:
				curTime += Time.fixedDeltaTime;
				break;
			}
			rate = curTime / time;
			float num = curve.Evaluate(rate);
			virtualCamera.m_Lens.FieldOfView = num * m_camFOV[cameraId];
			await UniTask.DelayFrame(1, PlayerLoopTiming.LastFixedUpdate);
		}
		virtualCamera.m_Lens.FieldOfView = m_camFOV[cameraId];
	}
}
