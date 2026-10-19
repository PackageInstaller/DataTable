using ACT.Event;
using ACT.Net;
using Cinemachine;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[RequireComponent(typeof(CinemachineBrain))]
public class CinemachineDynamicFOVBrain : MonoBehaviour
{
	[Range(0f, 2f)]
	public float FovScale0 = 1f;

	[Range(0f, 2f)]
	public float FovScale1 = 1f;

	[Range(0f, 2f)]
	public float FovScale2 = 1f;

	private float _targetFovScaler = 1f;

	public static CinemachineDynamicFOVBrain Instance { get; private set; }

	public static float FovScaler => Instance.FovScale0;

	public float CurrentFovScaler { get; private set; } = 1f;

	private void Awake()
	{
		Instance = this;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, AfterEnterWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_RespawnCompelete, RespawnCompelete);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, Tp);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ResetZoom, ResetZoomEvt);
		Singleton<NetManager>.instance.NetworkReconnect += NetworkReconnect;
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, AfterEnterWorld);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_RespawnCompelete, RespawnCompelete);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, Tp);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ResetZoom, ResetZoomEvt);
		Singleton<NetManager>.instance.NetworkReconnect -= NetworkReconnect;
	}

	private void Start()
	{
		CinemachineVirtualCamera.OnSelfStart = OnCameraActivated;
	}

	private void LateUpdate()
	{
		UpdateCurrentFovScaler();
	}

	private void OnCameraActivated(CinemachineVirtualCamera virtualCamera)
	{
		if (virtualCamera.mobileFovScaler && virtualCamera.VirtualCameraGameObject.GetComponent<CinemachineDynamicFOV>() == null)
		{
			virtualCamera.gameObject.AddComponent<CinemachineDynamicFOV>();
		}
	}

	public void OnZoomFov(float value)
	{
		float num = (MonoECS.instance.ispc ? GameLoader.meta.ZoomStep : GameLoader.meta.MobileZoomStep);
		if (!Mathf.Approximately(value, 0f) && !(num <= 0f))
		{
			float value2 = _targetFovScaler - Mathf.Sign(value) * num;
			_targetFovScaler = Mathf.Clamp(value2, 0f, 1f);
		}
	}

	public void ResetZoom()
	{
		_targetFovScaler = 1f;
	}

	private void UpdateCurrentFovScaler()
	{
		if (!(MonoECS.instance == null) && !(GameLoader.meta == null))
		{
			float deltaTime = Time.deltaTime;
			float num = (MonoECS.instance.ispc ? GameLoader.meta.ZoomLerpTime : GameLoader.meta.MobileZoomLerpTime);
			if (num <= 0f || deltaTime <= 0f)
			{
				CurrentFovScaler = _targetFovScaler;
				return;
			}
			float t = Mathf.Clamp01(deltaTime / num);
			CurrentFovScaler = Mathf.Lerp(CurrentFovScaler, _targetFovScaler, t);
		}
	}

	private void RespawnCompelete(BaseEventContent obj)
	{
		ResetZoom();
	}

	private void NetworkReconnect()
	{
		ResetZoom();
	}

	private void Tp(BaseEventContent obj)
	{
		ResetZoom();
	}

	private void AfterEnterWorld(BaseEventContent obj)
	{
		ResetZoom();
	}

	private void ResetZoomEvt(BaseEventContent obj)
	{
		ResetZoom();
	}
}
