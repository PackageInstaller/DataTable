using UnityEngine;

namespace ACT.LocalLoader;

public class CameraAspectRatioLimiter : MonoBehaviour
{
	[SerializeField]
	[Tooltip("最大宽高比（例如 21:9 = 2.333）")]
	private float maxAspect = 2.3333333f;

	[Header("Aspect Ratio 设置")]
	[Tooltip("最小宽高比（例如 16:9 = 1.778）")]
	[SerializeField]
	private float minAspect = 1.7777778f;

	[Header("调试信息")]
	[SerializeField]
	[Tooltip("在运行时显示当前的宽高比信息")]
	private bool showDebugInfo = true;

	private Camera _camera;

	private int _lastWidth;

	private int _lastHeight;

	public float MinAspect => minAspect;

	public float MaxAspect => maxAspect;

	public float CurrentScreenAspect { get; private set; }

	public float TargetAspect { get; private set; }

	private void Awake()
	{
		_camera = GetComponent<Camera>();
		if (_camera == null)
		{
			_camera = Camera.main;
		}
		if (minAspect <= 0f || maxAspect <= 0f)
		{
			Debug.LogError("[CameraAspectRatioLimiter] 宽高比必须大于 0！已重置为默认值。");
			minAspect = 1.7777778f;
			maxAspect = 2.3333333f;
		}
		if (minAspect > maxAspect)
		{
			Debug.LogWarning("[CameraAspectRatioLimiter] 最小宽高比大于最大宽高比，已自动交换。");
			float num = maxAspect;
			float num2 = minAspect;
			minAspect = num;
			maxAspect = num2;
		}
		UpdateCameraAspect();
		CacheResolution();
	}

	private void Update()
	{
		if (Screen.orientation == ScreenOrientation.Portrait || Screen.orientation == ScreenOrientation.PortraitUpsideDown)
		{
			_camera.rect = new Rect(0f, 0f, 1f, 1f);
			_camera.ResetAspect();
		}
		else if (Screen.width != _lastWidth || Screen.height != _lastHeight)
		{
			UpdateCameraAspect();
			CacheResolution();
		}
	}

	private void UpdateCameraAspect()
	{
		if (_camera == null)
		{
			return;
		}
		CurrentScreenAspect = (float)Screen.width / (float)Screen.height;
		TargetAspect = Mathf.Clamp(CurrentScreenAspect, minAspect, maxAspect);
		_camera.aspect = TargetAspect;
		if (!Mathf.Approximately(CurrentScreenAspect, TargetAspect))
		{
			if (CurrentScreenAspect > TargetAspect)
			{
				float num = TargetAspect / CurrentScreenAspect;
				float x = (1f - num) * 0.5f;
				_camera.rect = new Rect(x, 0f, num, 1f);
			}
			else
			{
				float num2 = CurrentScreenAspect / TargetAspect;
				float y = (1f - num2) * 0.5f;
				_camera.rect = new Rect(0f, y, 1f, num2);
			}
		}
		else
		{
			_camera.rect = new Rect(0f, 0f, 1f, 1f);
		}
		if (showDebugInfo && LuminApplication.LogEnabled)
		{
			Debug.Log($"[CameraAspectRatioLimiter] 屏幕: {Screen.width}x{Screen.height} ({CurrentScreenAspect:F3}) -> 目标: {TargetAspect:F3} (范围: {minAspect:F3} ~ {maxAspect:F3})");
		}
	}

	private void CacheResolution()
	{
		_lastWidth = Screen.width;
		_lastHeight = Screen.height;
	}

	public void SetAspectRatioRange(float min, float max)
	{
		if (min <= 0f || max <= 0f)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("[CameraAspectRatioLimiter] 宽高比必须大于 0！");
			}
		}
		else
		{
			minAspect = Mathf.Min(min, max);
			maxAspect = Mathf.Max(min, max);
			UpdateCameraAspect();
		}
	}
}
