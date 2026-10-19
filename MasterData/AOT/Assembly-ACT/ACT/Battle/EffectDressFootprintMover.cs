using System;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.Battle;

public class EffectDressFootprintMover : MonoBehaviour
{
	private InstanceHandle _handle;

	private Action _onRelease;

	private Transform[] _layerTransforms;

	private int[] _originalLayers;

	private Vector3 _startLocalPosition;

	private Vector3 _localOffset;

	private float _duration;

	private float _elapsed;

	private bool _released;

	public void Play(InstanceHandle handle, Vector3 localDirection, float distance, float duration, Action onRelease)
	{
		_handle = handle;
		_onRelease = onRelease;
		_startLocalPosition = transform.localPosition;
		_localOffset = ((localDirection.sqrMagnitude > 0.0001f) ? (localDirection.normalized * distance) : Vector3.zero);
		_duration = Mathf.Max(0.01f, duration);
		_elapsed = 0f;
		_released = false;
		Transform[] array = (_layerTransforms = GetComponentsInChildren<Transform>(includeInactive: true));
		_originalLayers = new int[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			_originalLayers[i] = array[i].gameObject.layer;
			array[i].gameObject.layer = 22;
		}
		enabled = true;
	}

	public void Recycle()
	{
		if (_released)
		{
			return;
		}
		_released = true;
		if (_layerTransforms != null && _originalLayers != null)
		{
			int num = Mathf.Min(_layerTransforms.Length, _originalLayers.Length);
			for (int i = 0; i < num; i++)
			{
				if (_layerTransforms[i] != null)
				{
					_layerTransforms[i].gameObject.layer = _originalLayers[i];
				}
			}
		}
		ParticleSystem[] componentsInChildren = GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		foreach (ParticleSystem particleSystem in componentsInChildren)
		{
			if (!(particleSystem == null))
			{
				particleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
				particleSystem.Clear(withChildren: true);
				particleSystem.time = 0f;
			}
		}
		InstanceHandle handle = _handle;
		Action onRelease = _onRelease;
		_handle = null;
		_onRelease = null;
		_layerTransforms = null;
		_originalLayers = null;
		onRelease?.Invoke();
		UnityEngine.Object.Destroy(this);
		if (handle != null && handle.IsValid)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
		}
	}

	private void Update()
	{
		if (!_released)
		{
			_elapsed += Time.deltaTime;
			float num = Mathf.Clamp01(_elapsed / _duration);
			transform.localPosition = _startLocalPosition + _localOffset * num;
			if (num >= 1f)
			{
				Recycle();
			}
		}
	}

	private void OnDisable()
	{
		Recycle();
	}

	private void OnDestroy()
	{
		Recycle();
	}
}
