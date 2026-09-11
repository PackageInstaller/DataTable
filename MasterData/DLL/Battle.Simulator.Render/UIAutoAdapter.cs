using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

[ExecuteInEditMode]
[RequireComponent(typeof(RectTransform))]
public class UIAutoAdapter : MonoBehaviour
{
	public enum E_AdapterMode
	{
		[InspectorName("以世界坐标自适应")]
		World,
		[InspectorName("以屏幕坐标自适应")]
		Screen,
		[InspectorName("以视图坐标自适应")]
		View,
		[InspectorName("以局部坐标自适应")]
		Local
	}

	public E_AdapterMode mode;

	public Vector3 worldPos;

	public Vector3 screenPos;

	public Vector3 viewPos;

	public Vector3 localPos = new Vector3(-5f, 2f, 0f);

	public string localPosParentPath = "StoryStage/ST0116c";

	public RectTransform root;

	private Camera _ui_cam;

	private Camera _main_cam;

	private RectTransform _rectTransform;

	private void Awake()
	{
		_rectTransform = base.transform as RectTransform;
	}

	private void Update()
	{
		if (_ui_cam == null)
		{
			_ui_cam = CanvasManager.Instance.uiCamera;
		}
		if (_main_cam == null)
		{
			_main_cam = Camera.main;
		}
		if (_ui_cam == null || _main_cam == null || root == null)
		{
			return;
		}
		if (mode == E_AdapterMode.World)
		{
			screenPos = _main_cam.WorldToScreenPoint(worldPos);
		}
		else if (mode == E_AdapterMode.View)
		{
			screenPos = _main_cam.ViewportToScreenPoint(viewPos);
		}
		else if (mode == E_AdapterMode.Local)
		{
			GameObject gameObject = GameObject.Find(localPosParentPath);
			if (gameObject != null)
			{
				Vector3 position = gameObject.transform.TransformPoint(localPos);
				screenPos = _main_cam.WorldToScreenPoint(position);
			}
		}
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(root, screenPos, _ui_cam, out var localPoint))
		{
			_rectTransform.anchoredPosition = localPoint;
		}
	}
}
