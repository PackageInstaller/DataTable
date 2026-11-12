using UnityEngine;

public class AdventureMiniMapController : SceneSingleton<AdventureMiniMapController>
{
	public Camera MinimapCam;

	public SmoothFollowMotor Follower;

	public Camera MapCam;

	[Space]
	[Range(0f, 1f)]
	public float miniMapTextureResolutionPercentage = 0.333f;

	[Range(0f, 1f)]
	public float mapTextureResolutionPercentage = 0.667f;

	public float miniMapRefreshInterval = 0.05f;

	private RenderTexture _miniMapRenderTexture;

	private RenderTexture _mapRenderTexture;

	private float _lastRotY;

	private int _miniMapCamCullMask;

	private int _mapCamCullMask;

	private float _miniMapRefreshTimer;

	public bool isActived { get; private set; }

	public RenderTexture miniMapRenderTexture => _miniMapRenderTexture;

	public RenderTexture mapRenderTexture => _mapRenderTexture;

	public void Active()
	{
		if (!isActived)
		{
			isActived = true;
			Vector2Int currentWindowResolution = MonoSingleton<ClientManager>.Instance.currentWindowResolution;
			int num = Mathf.RoundToInt((float)currentWindowResolution.y * miniMapTextureResolutionPercentage);
			_miniMapRenderTexture = UIUtils.GenerateRenderTextureFor2D(num, num);
			int num2 = Mathf.RoundToInt((float)currentWindowResolution.y * mapTextureResolutionPercentage);
			_mapRenderTexture = UIUtils.GenerateRenderTextureFor2D(num2, num2);
			MinimapCam.targetTexture = _miniMapRenderTexture;
			MapCam.targetTexture = _mapRenderTexture;
			MinimapCam.farClipPlane = 150f;
			_miniMapRefreshTimer = miniMapRefreshInterval;
			MinimapCam.enabled = true;
			MapCam.enabled = true;
			enabled = true;
		}
	}

	public void Deactive()
	{
		if (isActived)
		{
			isActived = false;
			MinimapCam.targetTexture = null;
			MapCam.targetTexture = null;
			UIUtils.ReleaseRenderTexture(_miniMapRenderTexture);
			UIUtils.ReleaseRenderTexture(_mapRenderTexture);
			MinimapCam.enabled = false;
			MapCam.enabled = false;
			enabled = false;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		_miniMapCamCullMask = MinimapCam.cullingMask;
		_mapCamCullMask = MapCam.cullingMask;
	}

	protected void Update()
	{
		if (isActived)
		{
			_miniMapRefreshTimer += Time.unscaledDeltaTime;
			if (_miniMapRefreshTimer >= miniMapRefreshInterval)
			{
				_miniMapRefreshTimer = 0f;
				MinimapCam.cullingMask = _miniMapCamCullMask;
				MapCam.cullingMask = _mapCamCullMask;
			}
			else
			{
				MinimapCam.cullingMask = 0;
				MapCam.cullingMask = 0;
			}
		}
	}

	protected override void OnDestroy()
	{
		Deactive();
		base.OnDestroy();
	}

	public void ResumeMinimapCameraFollowMotion()
	{
		if (isActived)
		{
			Follower.transform.position = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.transform.position;
			SceneSingleton<AdventurePlayerController>.Instance.playerAgent.transform.position = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.transform.position;
			Follower.gameObject.SetActive(value: true);
		}
	}

	public void PauseMinimapCameraFollowMotion()
	{
		if (isActived)
		{
			Follower.gameObject.SetActive(value: false);
		}
	}

	public void SyncMinimapCameraRotation()
	{
		if (!isActived)
		{
			return;
		}
		float y = SceneSingleton<AdventurePlayerController>.Instance.playerMainVCam.transform.eulerAngles.y;
		if (MinimapCam.gameObject.activeSelf && !Mathf.Approximately(_lastRotY, y))
		{
			_lastRotY = y;
			Vector3 localEulerAngles = MinimapCam.transform.localEulerAngles;
			localEulerAngles.z = 0f - y;
			while (localEulerAngles.z < 0f)
			{
				localEulerAngles.z += 360f;
			}
			localEulerAngles.y = 0f;
			MinimapCam.transform.localEulerAngles = localEulerAngles;
		}
	}

	public void OpenMapCamera()
	{
		if (isActived)
		{
			MapCam.gameObject.SetActive(value: true);
			ResetMapCameraPosition();
			MinimapCam.gameObject.SetActive(value: false);
		}
	}

	public void CloseMapCamera()
	{
		if (isActived)
		{
			MapCam.gameObject.SetActive(value: false);
			MinimapCam.gameObject.SetActive(value: true);
		}
	}

	public void ResetMapCameraPosition()
	{
		if (isActived)
		{
			MapCam.transform.localEulerAngles = MinimapCam.transform.localEulerAngles;
		}
	}
}
