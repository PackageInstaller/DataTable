using System;
using System.Collections;
using Cinemachine;
using UnityEngine;

public class CinemachineTransitionCheker : MonoBehaviour
{
	private CinemachineBrain cinemachineBrain;

	private Action<string> transitionEndCallback;

	private IEnumerator checkTransitionCoroutine;

	private void Awake()
	{
		cinemachineBrain = UnityEngine.Object.FindObjectOfType<CinemachineBrain>();
		cinemachineBrain.m_CameraActivatedEvent.AddListener(OnCameraActivated);
	}

	public void SetTransitionEndCallback(Action<string> callback)
	{
		transitionEndCallback = callback;
	}

	private void OnCameraActivated(ICinemachineCamera incoming_vcam, ICinemachineCamera outgoing_vcam)
	{
		if (checkTransitionCoroutine != null)
		{
			StopCoroutine(checkTransitionCoroutine);
		}
		checkTransitionCoroutine = CheckTransition();
		StartCoroutine(checkTransitionCoroutine);
	}

	private IEnumerator CheckTransition()
	{
		while (true)
		{
			if (cinemachineBrain == null)
			{
				checkTransitionCoroutine = null;
				yield break;
			}
			if (!cinemachineBrain.IsBlending)
			{
				break;
			}
			yield return null;
		}
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = (CinemachineVirtualCameraBase)cinemachineBrain.ActiveVirtualCamera;
		transitionEndCallback?.Invoke(cinemachineVirtualCameraBase.name);
		checkTransitionCoroutine = null;
	}

	private void OnDestroy()
	{
		transitionEndCallback = null;
	}
}
