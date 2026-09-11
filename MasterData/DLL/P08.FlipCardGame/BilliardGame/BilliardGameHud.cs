using UnityEngine;

namespace BilliardGame;

public class BilliardGameHud : MonoBehaviour
{
	[HideInInspector]
	public Transform target;

	[HideInInspector]
	public CanvasGroup canvasGroup;

	[HideInInspector]
	public GameObject canvas;

	[HideInInspector]
	public bool isShow;

	public Camera uiCamera { get; set; }

	public virtual void Init(Transform targetTrs = null)
	{
		if (targetTrs != null)
		{
			target = targetTrs;
		}
		canvasGroup = base.transform.GetComponent<CanvasGroup>();
		canvas = GameObject.Find("UICamera/Canvas");
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		isShow = false;
	}

	public void Update()
	{
		UpdatePos();
	}

	public virtual void UpdatePos()
	{
		if (!(null == target) && isShow)
		{
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, target.position);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, screenPoint, uiCamera, out var localPoint))
			{
				base.transform.localPosition = localPoint;
			}
		}
	}

	public virtual void Show(bool isShow)
	{
		canvasGroup.alpha = (isShow ? 1f : 0f);
		this.isShow = isShow;
	}
}
