#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;

namespace Ase;

[RequireComponent(typeof(CanvasGroup))]
public abstract class EntityInfoBase : MonoBehaviour
{
	protected Canvas canvas;

	protected Camera camera;

	protected RectTransform rectTransform;

	protected CanvasGroup canvasGroup;

	protected Transform followRoot;

	public bool IsInitHandlerCalled { get; private set; }

	public virtual void Init(Camera barCamera, Canvas infoCanvas)
	{
		if (!IsInitHandlerCalled)
		{
			IsInitHandlerCalled = true;
			camera = barCamera;
			if (camera == null)
			{
				camera = GameEntry.Camera.MainCamera;
			}
			canvas = infoCanvas;
			if (!TryGetComponent<RectTransform>(out rectTransform))
			{
				Log.Error("RectTransform is invalid.");
			}
			else if (!TryGetComponent<CanvasGroup>(out canvasGroup))
			{
				Log.Error("CanvasGroup is invalid.");
			}
		}
	}

	public virtual void BindFollowRoot(Transform follow)
	{
		followRoot = follow;
		base.transform.SetAsLastSibling();
	}

	public void ShowUI()
	{
		RefreshPosition();
		base.gameObject.SetActive(value: true);
	}

	protected virtual void LateUpdate()
	{
		RefreshPosition();
	}

	public void ExternalCallRefreshPosition()
	{
		RefreshPosition();
	}

	protected virtual void RefreshPosition()
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (!(followRoot == null))
		{
			Vector3 vector = camera.WorldToScreenPoint(followRoot.position);
			Vector2 vector2 = default(Vector2);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)((Component)(object)canvas).transform, (Vector2)vector, ((int)canvas.renderMode == 0) ? null : canvas.worldCamera, ref vector2))
			{
				rectTransform.localPosition = vector2;
			}
		}
	}

	public virtual void Remove()
	{
		Recovery();
	}

	public virtual void Recovery()
	{
		followRoot = null;
		GetComponent<IPooledObject>()?.Free();
		canvasGroup.alpha = 1f;
	}
}
