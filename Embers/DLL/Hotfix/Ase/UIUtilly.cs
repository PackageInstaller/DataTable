using System.Collections.Generic;
using Spine.Unity;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace Ase;

public static class UIUtilly
{
	private static Plane cameraPlane;

	public static Vector2 uiCanvasSize
	{
		get
		{
			RectTransform rootTransform = GameEntry.UI.RootTransform;
			return new Vector2(rootTransform.localScale.x * rootTransform.sizeDelta.x, rootTransform.localScale.y * rootTransform.sizeDelta.y);
		}
	}

	public static Canvas s_uiCanvas => GameEntry.UI.Canvas;

	public static CanvasScaler s_uiCanvasScale => GameEntry.UI.Scaler;

	public static Vector3 WorldPos2ScenePosCameraMain(Vector3 vector3)
	{
		return GameEntry.Camera.MainCamera.WorldToScreenPoint(vector3);
	}

	public static Vector3 WorldPos2ScenePosCameraMain(Vector3 vector3, Camera camera)
	{
		return camera.WorldToScreenPoint(vector3);
	}

	public static Vector3 WorldPos2ScreenPosCameraMain(Camera camera, Vector3 vector3)
	{
		Vector3 vector4 = camera.WorldToViewportPoint(vector3);
		RectTransformUtility.WorldToScreenPoint(camera, camera.transform.position);
		cameraPlane.SetNormalAndPosition(camera.transform.forward, camera.transform.position);
		if (!cameraPlane.SameSide(camera.transform.forward + camera.transform.position, vector3))
		{
			return new Vector3((0f - vector4.x) * (float)Screen.width, (0f - vector4.y) * (float)Screen.height);
		}
		return new Vector3(vector4.x * (float)Screen.width, vector4.y * (float)Screen.height);
	}

	public static Vector3 WorldPos2ScenePosCameraMainInSideScreen(Camera camera, Vector3 vector3, float width, float height)
	{
		return SetPosInsideScreen(camera.WorldToViewportPoint(vector3), width, height);
	}

	public static Vector3 ScreenPointToLocalPointInRectangle(Camera camera, Vector3 worldPosition)
	{
		Vector3 vector = WorldPos2ScreenPosCameraMain(camera, worldPosition);
		vector.z = 0f;
		Vector2 vector2 = default(Vector2);
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(GameEntry.UI.RootTransform, (Vector2)vector, GetUICamera(), ref vector2))
		{
			return vector2;
		}
		return Vector3.zero;
	}

	public static Vector3 ScenePosToScreenPos(Camera camera, Vector3 worldPosition)
	{
		Vector3 vector = camera.WorldToScreenPoint(worldPosition);
		Vector2 vector2 = default(Vector2);
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(GameEntry.UI.RootTransform, (Vector2)vector, GetUICamera(), ref vector2))
		{
			return vector2;
		}
		return Vector3.zero;
	}

	public static Vector2 PutUIPosInsideScreen(Vector2 UIPos, float offsetL, float offsetR, float offsetT, float offsetB)
	{
		return new Vector2(Mathf.Clamp(UIPos.x, 0f + offsetL, uiCanvasSize.x - offsetR), Mathf.Clamp(UIPos.y, 0f + offsetB, uiCanvasSize.y - offsetT));
	}

	public static bool IsUIPosInsideScreen(Vector2 v2, float offsetL, float offsetR, float offsetT, float offsetB)
	{
		if (v2.x > 0f + offsetL && v2.x < uiCanvasSize.x - offsetR && v2.y > 0f + offsetB && v2.y < uiCanvasSize.y - offsetT)
		{
			return true;
		}
		return false;
	}

	private static Vector3 SetPosInsideScreen(Vector3 viewPointPos, float offsetWidth, float offsetHeight)
	{
		float x = uiCanvasSize.x;
		float y = uiCanvasSize.y;
		float num = uiCanvasSize.x * viewPointPos.x;
		float num2 = uiCanvasSize.y * viewPointPos.y;
		if (num - offsetWidth / 2f < 0f)
		{
			num = offsetWidth / 2f;
		}
		if (num + offsetWidth / 2f > x)
		{
			num = x - offsetWidth / 2f;
		}
		if (num2 - offsetHeight / 2f < 0f)
		{
			num2 = offsetHeight / 2f;
		}
		if (num2 + offsetHeight / 2f > y)
		{
			num2 = y - offsetHeight / 2f;
		}
		return new Vector3(num - x / 2f, num2 - y / 2f, 0f);
	}

	public static Vector2 GetScreenSize()
	{
		return new Vector2(Screen.width, Screen.height);
	}

	public static Vector2 GetCanvasSize()
	{
		return GameEntry.UI.RootTransform.sizeDelta;
	}

	public static Vector2 GetCanvasScalerSize()
	{
		return GameEntry.UI.Scaler.referenceResolution;
	}

	public static Vector2 GetCanvasCenter()
	{
		return uiCanvasSize / 2f;
	}

	public static Vector2 GetCanvasRatioFixedMatchWidth()
	{
		float num = (float)Screen.height * 1f / (float)Screen.width;
		return new Vector2(GameEntry.UI.Scaler.referenceResolution.x, num * GameEntry.UI.Scaler.referenceResolution.x);
	}

	public static Vector2 Screen2CanvasRatioMatchWidth()
	{
		float num = (float)Screen.height * 1f / (float)Screen.width;
		return new Vector2(GameEntry.UI.Scaler.referenceResolution.x * 1f / (float)Screen.width, num * GameEntry.UI.Scaler.referenceResolution.x / (float)Screen.height);
	}

	public static float GetSizeScaleRatio()
	{
		if (GameEntry.UI.Scaler.matchWidthOrHeight == 0f)
		{
			return GetSizeScaleRatioMatchWidth();
		}
		return GetSizeScaleRatioMatchHeight();
	}

	public static float GetSizeScaleRatioMatchWidth()
	{
		return (float)Screen.width * 1f / GameEntry.UI.Scaler.referenceResolution.x;
	}

	public static float GetSizeScaleRatioMatchHeight()
	{
		return (float)Screen.height * 1f / GameEntry.UI.Scaler.referenceResolution.y;
	}

	public static void SetPivotWithCurrentPosition(this RectTransform rectTransform, Vector2 pivot)
	{
		if (!rectTransform.pivot.Equals(pivot))
		{
			Vector2 anchoredPosition = rectTransform.anchoredPosition;
			anchoredPosition.x -= rectTransform.rect.width * rectTransform.localScale.x * (rectTransform.pivot.x - pivot.x);
			anchoredPosition.y -= rectTransform.rect.height * rectTransform.localScale.y * (rectTransform.pivot.y - pivot.y);
			rectTransform.pivot = pivot;
			rectTransform.anchoredPosition = anchoredPosition;
		}
	}

	public static Camera GetUICamera()
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if ((int)s_uiCanvas.renderMode == 0)
		{
			return null;
		}
		return GameEntry.UI.UICamera;
	}

	public static void WrapperSceneToWorldPoint(Vector3 lp, out Vector3 worldPoint)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if ((int)s_uiCanvas.renderMode != 0)
		{
			worldPoint = GameEntry.UI.UICamera.ScreenToWorldPoint(lp);
			return;
		}
		float orthographicSize = GameEntry.UI.UICamera.orthographicSize;
		float num = uiCanvasSize.y / 2f;
		float num2 = uiCanvasSize.x / 2f;
		worldPoint = new Vector3
		{
			x = (lp.x / num2 - 1f) * (uiCanvasSize.x / uiCanvasSize.y) * orthographicSize,
			y = (lp.y / num - 1f) * orthographicSize,
			z = 0f
		};
	}

	public static float WrapperCanvasScaleFactor()
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if ((int)s_uiCanvas.renderMode != 0)
		{
			return GameEntry.UI.RootTransform.localScale.x;
		}
		return GameEntry.UI.UICamera.orthographicSize / s_uiCanvasScale.referenceResolution.y * 2f;
	}

	public static Vector3 WrapperGetUIPosition(Transform transform, bool setZZero = true)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if ((int)s_uiCanvas.renderMode != 0)
		{
			Vector3 position = transform.position;
			if (setZZero)
			{
				return new Vector3
				{
					x = position.x,
					y = position.y,
					z = 0f
				};
			}
			return position;
		}
		Vector2 vector = uiCanvasSize;
		float orthographicSize = GameEntry.UI.UICamera.orthographicSize;
		float num = vector.y / 2f;
		float num2 = vector.x / 2f;
		Vector3 position2 = transform.position;
		return new Vector3
		{
			x = (position2.x / num2 - 1f) * (vector.x / vector.y) * orthographicSize,
			y = (position2.y / num - 1f) * orthographicSize,
			z = (setZZero ? 0f : position2.z)
		};
	}

	public static void WrapperSetUIPosition(Transform transform, Vector3 to)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if ((int)s_uiCanvas.renderMode != 0)
		{
			transform.position = to;
			return;
		}
		Vector2 vector = uiCanvasSize;
		float orthographicSize = GameEntry.UI.UICamera.orthographicSize;
		float num = vector.y / 2f;
		float num2 = vector.x / 2f;
		transform.position = new Vector3
		{
			x = (to.x / orthographicSize / (vector.x / vector.y) + 1f) * num2,
			y = (to.y / orthographicSize + 1f) * num,
			z = 0f
		};
	}

	public static Vector3 FingerPos2ScenePosCameraUI(Vector3 pos)
	{
		WrapperSceneToWorldPoint(pos, out var worldPoint);
		return worldPoint;
	}

	public static float GetCanvasScaleFactor()
	{
		return WrapperCanvasScaleFactor();
	}

	public static void SpineMatchRectHelper(GameObject spineGo, Transform position, bool overwrite)
	{
		List<SkeletonGraphic> list = CollectionPool<List<SkeletonGraphic>, SkeletonGraphic>.Get();
		spineGo.GetComponentsInChildren(list);
		for (int i = 0; i < list.Count; i++)
		{
			SpineMatchRectHelper(position, list[i], overwrite);
		}
		list.Clear();
		CollectionPool<List<SkeletonGraphic>, SkeletonGraphic>.Release(list);
	}

	public static void SpineMatchRectHelper(Transform parent, SkeletonGraphic spineCtrl, bool overwrite)
	{
		if (!((Object)(object)spineCtrl == null))
		{
			if (!parent.gameObject.activeInHierarchy && spineCtrl.allowMultipleCanvasRenderers)
			{
				((Component)(object)spineCtrl).gameObject.AddComponent<SpineDelayInit>().InjectSpineCtrl(spineCtrl, overwrite);
				return;
			}
			spineCtrl.Initialize(overwrite);
			spineCtrl.MatchRectTransformWithBounds();
		}
	}
}
