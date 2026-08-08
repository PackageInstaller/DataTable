using System;
using System.Collections.Generic;
using UnityEngine;

public class CommonLineConnectionPlayer
{
	public Transform Target;

	private bool _isPause;

	private float _timeScale = 1f;

	private Dictionary<string, EffectController> _lineEffect = new Dictionary<string, EffectController>(64);

	private List<UVChainLightning> m_chainLightning = new List<UVChainLightning>(64);

	public EffectController Play(string effectName, Transform startTrans, Transform endTrans, bool needManager, float effectKeepTime = 0.5f, float timeScale = 1f)
	{
		if (needManager && _lineEffect.ContainsKey(effectName))
		{
			return null;
		}
		EffectController effectController = PlayLineEffect(Target, effectName, startTrans, endTrans, effectKeepTime, OnEffectStop);
		if (needManager)
		{
			_lineEffect[effectName] = effectController;
		}
		m_chainLightning.Add(effectController.GetComponent<UVChainLightning>());
		return effectController;
	}

	public void DisableRenders()
	{
		if (m_chainLightning == null || m_chainLightning.Count <= 0)
		{
			return;
		}
		foreach (UVChainLightning item in m_chainLightning)
		{
			EffectController component = item.GetComponent<EffectController>();
			if (component != null)
			{
				component.Hide(v: true);
			}
			else
			{
				Debug.LogError("特效中播放存在bug！");
			}
		}
	}

	public void EnableRenders()
	{
		if (m_chainLightning == null || m_chainLightning.Count <= 0)
		{
			return;
		}
		foreach (UVChainLightning item in m_chainLightning)
		{
			EffectController component = item.GetComponent<EffectController>();
			if (component != null)
			{
				component.Hide(v: false);
			}
			else
			{
				Debug.LogError("特效中播放存在bug！");
			}
		}
	}

	public void Update(float normalizeTime)
	{
	}

	public void SetTimeScale(float timescale)
	{
		for (int i = 0; i < m_chainLightning.Count; i++)
		{
			EffectController component = m_chainLightning[i].GetComponent<EffectController>();
			if (component != null)
			{
				component.SetTimeScale(timescale);
			}
		}
	}

	public void Pause(bool isPause = true)
	{
		if (_isPause = isPause)
		{
			return;
		}
		foreach (UVChainLightning item in m_chainLightning)
		{
			item.Pause = isPause;
			EffectController component = item.GetComponent<EffectController>();
			if (component != null)
			{
				component.Pause(isPause);
			}
		}
		_isPause = isPause;
	}

	public void Stop(string effect)
	{
		EffectController value = null;
		if (_lineEffect.TryGetValue(effect, out value))
		{
			value.Clean();
			_lineEffect.Remove(effect);
			m_chainLightning.Remove(value.GetComponent<UVChainLightning>());
			PooledAsset.DestroyOrReturn(value.gameObject);
		}
	}

	public void StopAll()
	{
		foreach (UVChainLightning item in m_chainLightning)
		{
			item.Reset();
			EffectController component = item.GetComponent<EffectController>();
			if (component != null)
			{
				component.Clean();
				PooledAsset.DestroyOrReturn(component.gameObject);
			}
		}
		m_chainLightning.Clear();
		_lineEffect.Clear();
	}

	public void Shutdown()
	{
		foreach (UVChainLightning item in m_chainLightning)
		{
			item.Reset();
			EffectController component = item.GetComponent<EffectController>();
			if (component != null)
			{
				component.Clean();
			}
		}
		m_chainLightning.Clear();
	}

	public static void PlayLineEffect(Transform Parent, string effectPath, Vector3 startPos, Vector3 endPos, float keepTime, Action<EffectController> OnEffectStop = null)
	{
		EffectController effectController = CommonEffectClipPlayer.PlayEffect(Parent, effectPath, null, Vector3.zero, Vector3.one, Vector3.zero, Parent.forward, isAttach: false, isLoop: false, 1f, 0f, keepTime, usePosition: false, Vector3.zero, isLockEffectRotation: false, OnEffectStop);
		if (effectController != null)
		{
			UVChainLightning component = effectController.gameObject.GetComponent<UVChainLightning>();
			if (component != null)
			{
				component.PointPosList.Clear();
				component.PointPosList.Add(startPos);
				component.PointPosList.Add(endPos);
				component.Update();
			}
			else
			{
				effectController.Clean();
			}
		}
	}

	public static EffectController PlayLineEffect(Transform Parent, string effectPath, Transform startTrans, Transform endTrans, float keepTime, Action<EffectController> OnEffectStop = null)
	{
		EffectController effectController = CommonEffectClipPlayer.PlayEffect(Parent, effectPath, null, Vector3.zero, Vector3.one, Vector3.zero, Parent.forward, isAttach: false, isLoop: false, 1f, 0f, keepTime, usePosition: false, Vector3.zero, isLockEffectRotation: false, OnEffectStop);
		if (effectController != null)
		{
			UVChainLightning component = effectController.gameObject.GetComponent<UVChainLightning>();
			if (component != null)
			{
				component.PointTransformList.Clear();
				component.PointTransformList.Add(startTrans);
				component.PointTransformList.Add(endTrans);
				component.Update();
			}
			else
			{
				effectController.Clean();
			}
		}
		return effectController;
	}

	public void PlayLineEffect(string effectPath, Vector3 startPos, Vector3 endPos, float keepTime)
	{
		EffectController effectController = CommonEffectClipPlayer.PlayEffect(Target, effectPath, null, Vector3.zero, Vector3.one, Vector3.zero, Target.forward, isAttach: false, isLoop: false, 1f, 0f, keepTime, usePosition: false, Vector3.zero, isLockEffectRotation: false, OnEffectStop);
		if (effectController != null)
		{
			UVChainLightning component = effectController.gameObject.GetComponent<UVChainLightning>();
			if (component != null)
			{
				component.PointPosList.Clear();
				component.PointPosList.Add(startPos);
				component.PointPosList.Add(endPos);
				component.Update();
			}
			else
			{
				effectController.Clean();
			}
		}
	}

	public void PlayLineEffect(string effectPath, Transform startTrans, Transform endTrans, float keepTime)
	{
		EffectController effectController = CommonEffectClipPlayer.PlayEffect(Target, effectPath, null, Vector3.zero, Vector3.one, Vector3.zero, Target.forward, isAttach: false, isLoop: false, 1f, 0f, keepTime, usePosition: false, Vector3.zero, isLockEffectRotation: false, OnEffectStop);
		if (effectController != null)
		{
			UVChainLightning component = effectController.gameObject.GetComponent<UVChainLightning>();
			if (component != null)
			{
				component.PointTransformList.Clear();
				component.PointTransformList.Add(startTrans);
				component.PointTransformList.Add(endTrans);
				component.Update();
			}
			else
			{
				effectController.Clean();
			}
		}
	}

	public void OnEffectStop(EffectController effectController)
	{
		UVChainLightning component = effectController.GetComponent<UVChainLightning>();
		component.Reset();
		m_chainLightning.Remove(component);
	}
}
