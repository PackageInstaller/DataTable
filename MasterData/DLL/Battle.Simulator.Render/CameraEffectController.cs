using System;
using Cinemachine;
using UnityEngine;

public class CameraEffectController : MonoBehaviour
{
	public bool m_AutoInit;

	public bool m_UseMax;

	public bool m_FreezeX;

	public bool m_FreezeY;

	public float baseAspect;

	public float baseFov;

	public EffectController m_effectController;

	private float _LastAspectRate;

	private float _LastFieldOfView;

	private Camera _mainCamera;

	private bool m_Enable;

	private Vector3 _baseScale = Vector3.one;

	public CinemachineVirtualCamera m_parent;

	private bool hasParent;

	public void Initalization(Vector3 pBaseScale, float pFieldOfView, Vector2 pAspectRate)
	{
		m_Enable = true;
		_baseScale = pBaseScale;
		baseFov = pFieldOfView;
		baseAspect = pAspectRate.x / pAspectRate.y;
		CalcUseScale();
	}

	public void OnEnable()
	{
		_LastAspectRate = 0f;
		_LastFieldOfView = 0f;
		if (m_AutoInit)
		{
			Initalization(Vector3.one, 50f, new Vector2(U3DHud.mInstance.mWidth, U3DHud.mInstance.mHeight));
		}
	}

	private bool CalcUseScale()
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		float num = Mathf.Tan(MathF.PI / 180f * _mainCamera.fieldOfView * 0.5f) / Mathf.Tan(MathF.PI / 180f * baseFov * 0.5f);
		float num2 = (m_FreezeY ? _baseScale.y : (_baseScale.y * num));
		float num3 = _mainCamera.aspect / baseAspect;
		float num4 = (m_FreezeX ? _baseScale.x : (_baseScale.x * num3 * num));
		if (m_UseMax)
		{
			if (num4 > num2)
			{
				num2 = num4;
			}
			else
			{
				num4 = num2;
			}
		}
		base.gameObject.transform.localScale = new Vector3(num4, num2, 1f);
		return true;
	}

	private void LateUpdate()
	{
		if (m_Enable)
		{
			if (_mainCamera == null)
			{
				_mainCamera = Camera.main;
			}
			if (!(Mathf.Abs(_LastFieldOfView - _mainCamera.fieldOfView) < 0.0001f) || !(Mathf.Abs(_LastAspectRate - _mainCamera.aspect) < 0.0001f))
			{
				_LastFieldOfView = _mainCamera.fieldOfView;
				_LastAspectRate = _mainCamera.aspect;
				CalcUseScale();
			}
		}
	}

	public void SetCameraEvent(CinemachineVirtualCamera parent)
	{
		CinemachineBrain component = Camera.main.GetComponent<CinemachineBrain>();
		if (component == null)
		{
			return;
		}
		m_parent = parent;
		hasParent = true;
		if (component.ActiveVirtualCamera != m_parent)
		{
			base.transform.SetParent(m_parent.transform, worldPositionStays: false);
			if (m_effectController != null)
			{
				m_effectController.Hide(v: true);
			}
		}
		component.m_CameraActivatedEvent.AddListener(ActivedEvent);
	}

	public void ActivedEvent(ICinemachineCamera ic1, ICinemachineCamera ic2)
	{
		if (ic1 == m_parent)
		{
			Camera main = Camera.main;
			if (main != null && main.transform != null)
			{
				base.transform.SetParent(main.transform, worldPositionStays: false);
				if (m_effectController != null)
				{
					m_effectController.Hide(v: false);
				}
			}
			return;
		}
		if (ic1.VirtualCameraGameObject.transform.root.name.Contains("battle_end") && m_effectController != null)
		{
			m_effectController.SetActive(active: false);
			return;
		}
		if (m_parent != null && m_parent.transform != null)
		{
			base.transform.SetParent(m_parent.transform, worldPositionStays: false);
			if (m_effectController != null)
			{
				m_effectController.Hide(v: true);
			}
		}
		if (hasParent && m_parent == null && m_effectController != null)
		{
			PooledAsset.DestroyOrReturn(m_effectController.gameObject);
		}
	}

	private void OnDisable()
	{
		Camera main = Camera.main;
		if (!(main == null))
		{
			CinemachineBrain component = main.GetComponent<CinemachineBrain>();
			if (!(component == null) && component.m_CameraActivatedEvent != null)
			{
				component.m_CameraActivatedEvent.RemoveListener(ActivedEvent);
				m_Enable = false;
			}
		}
	}
}
