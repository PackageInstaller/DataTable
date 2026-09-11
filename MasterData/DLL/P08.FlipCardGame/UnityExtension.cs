using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using Brent.UI.UIInjection;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public static class UnityExtension
{
	private static readonly string SYMBOL_REGEX = "(\\！|\\？|\\，|\\。|\\》|\\）|\\：|”|’|\\、|\\；|\\+|\\-|\\】|\\」|\\~|\\～|\\…|\\—|\\.|,|:|;|/|!|\\?|\"|'|\\)|\\>|\\]|\\%|\\=|&)";

	private static readonly string SYMBOL_REGEX2 = "(\\「|\\（|\\(|\\[|<|【|《)";

	public static T GetComponentOrAdd<T>(this GameObject obj) where T : Component
	{
		T val = obj.GetComponent<T>();
		if (val == null)
		{
			val = obj.AddComponent<T>();
		}
		return val;
	}

	public static void InjectUI(this GameObject obj, LuaTable table)
	{
		UIInject component = obj.GetComponent<UIInject>();
		if (component == null)
		{
			return;
		}
		foreach (Injection injection in component.Injections)
		{
			if (injection.name.IsNotNullOrEmpty() && (bool)injection.value)
			{
				table.RawSet(injection.name, injection.value);
			}
		}
	}

	public static void InitTransform(this Component cmpt)
	{
		Transform transform = cmpt.transform;
		transform.localPosition = Vector3.zero;
		transform.localRotation = Quaternion.identity;
		transform.localScale = Vector3.one;
	}

	public static void SetActive(this Component cmpt, bool bActive)
	{
		cmpt.gameObject.SetActive(bActive);
	}

	public static void SetParentAndInitTrans(this Component cmpt, Component parent)
	{
		Transform transform = cmpt.transform;
		transform.SetParent(parent.transform);
		transform.InitTransform();
	}

	public static void SetParentAndInitTrans(this GameObject obj, Component parent)
	{
		obj.transform.SetParent(parent.transform);
		obj.transform.InitTransform();
	}

	public static void SetParentPure(this Component cmpt, Component parent)
	{
		cmpt.transform.SetParent(parent.transform);
	}

	public static void SetParentPure(this GameObject obj, Component parent)
	{
		obj.transform.SetParent(parent.transform);
	}

	public static void SetLocalPositionZero(this Component cmpt)
	{
		cmpt.transform.localPosition = Vector3.zero;
	}

	public static void SetLocalPositionEx(this Component cmpt, float x, float y, float z)
	{
		cmpt.transform.localPosition = new Vector3(x, y, z);
	}

	public static void SetLocalPosition(this Component cmpt, Vector3 pos)
	{
		cmpt.transform.localPosition = pos;
	}

	public static void SetLocalPositionX(this Component cmpt, float x)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.x = x;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionY(this Component cmpt, float y)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.y = y;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionZ(this Component cmpt, float z)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.z = z;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionDelta(this Component cmpt, float deltaX, float deltaY, float deltaZ)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.x += deltaX;
		localPosition.y += deltaY;
		localPosition.z += deltaZ;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionDeltaX(this Component cmpt, float deltaX)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.x += deltaX;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionDeltaY(this Component cmpt, float deltaY)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.y += deltaY;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionDeltaZ(this Component cmpt, float deltaZ)
	{
		Transform transform = cmpt.transform;
		Vector3 localPosition = transform.localPosition;
		localPosition.z += deltaZ;
		transform.localPosition = localPosition;
	}

	public static void SetLocalPositionFromTarget(this Component cmpt, Transform target)
	{
		cmpt.transform.localPosition = target.localPosition;
	}

	public static Vector3 GetLocalPosition(this Component cmpt)
	{
		return cmpt.transform.localPosition;
	}

	public static void GetLocalPositionEx(this Component cmpt, out float x, out float y, out float z)
	{
		Vector3 localPosition = cmpt.transform.localPosition;
		x = localPosition.x;
		y = localPosition.y;
		z = localPosition.z;
	}

	public static float GetLocalPositionX(this Component cmpt)
	{
		return cmpt.transform.localPosition.x;
	}

	public static float GetLocalPositionY(this Component cmpt)
	{
		return cmpt.transform.localPosition.y;
	}

	public static void SetPostionZero(this Component cmpt)
	{
		cmpt.transform.position = Vector3.zero;
	}

	public static void SetPositionEx(this Component cmpt, float x, float y, float z)
	{
		cmpt.transform.position = new Vector3(x, y, z);
	}

	public static void SetPositionEx(this GameObject go, float x, float y, float z)
	{
		go.transform.position = new Vector3(x, y, z);
	}

	public static void SetPosition(this Component cmpt, Vector3 pos)
	{
		cmpt.transform.position = pos;
	}

	public static void SetPositionX(this Component cmpt, float x)
	{
		Transform transform = cmpt.transform;
		Vector3 position = transform.position;
		position.x = x;
		transform.position = position;
	}

	public static void SetPositionY(this Component cmpt, float y)
	{
		Transform transform = cmpt.transform;
		Vector3 position = transform.position;
		position.y = y;
		transform.position = position;
	}

	public static void SetPositionZ(this Component cmpt, float z)
	{
		Transform transform = cmpt.transform;
		Vector3 position = transform.position;
		position.z = z;
		transform.position = position;
	}

	public static void SetPositionFromTarget(this Component cmpt, Transform target)
	{
		cmpt.transform.position = target.position;
	}

	public static void SetPosRotByTarget(this Transform tran, Transform target)
	{
		tran.position = target.position;
		tran.rotation = target.rotation;
	}

	public static void MovePercentToTargetPos(this Transform tran, float targetX, float targetY, float targetZ, float percent, out float finalPosX, out float finalPosY, out float finalPosZ)
	{
		percent = Mathf.Clamp01(percent);
		Vector3 position = tran.position;
		Vector3 vector = new Vector3(targetX, targetY, targetZ);
		Vector3 vector2 = (tran.position = position + (vector - position) * percent);
		finalPosX = vector2.x;
		finalPosY = vector2.y;
		finalPosZ = vector2.z;
	}

	public static Vector3 GetPosition(this Component cmpt)
	{
		return cmpt.transform.position;
	}

	public static Vector3 GetPosition(this GameObject obj)
	{
		return obj.transform.position;
	}

	public static float GetPositionX(this Component cmpt)
	{
		return cmpt.transform.position.x;
	}

	public static float GetPositionY(this Component cmpt)
	{
		return cmpt.transform.position.y;
	}

	public static void GetPositionEx(this Component cmpt, out float x, out float y, out float z)
	{
		Vector3 position = cmpt.transform.position;
		x = position.x;
		y = position.y;
		z = position.z;
	}

	public static void GetPositionOffset(this Transform tran, float offsetX, float offsetY, float offsetZ, out float x, out float y, out float z)
	{
		Vector3 position = tran.position;
		position = position + tran.right * offsetX + tran.up * offsetY + tran.forward * offsetZ;
		x = position.x;
		y = position.y;
		z = position.z;
	}

	public static void OffsetPositionInSelf(this Transform tran, float posX, float posY, float posZ, float offsetX, float offsetY, float offsetZ, out float x, out float y, out float z)
	{
		Vector3 vector = new Vector3(posX, posY, posZ);
		vector = vector + tran.right * offsetX + tran.up * offsetY + tran.forward * offsetZ;
		x = vector.x;
		y = vector.y;
		z = vector.z;
	}

	public static void SetLocalScaleZero(this Component cmpt)
	{
		cmpt.transform.localScale = Vector3.zero;
	}

	public static void SetLocalScaleOne(this Component cmpt)
	{
		cmpt.transform.localScale = Vector3.one;
	}

	public static void SetLocalScaleEx(this Component cmpt, float x, float y, float z)
	{
		cmpt.transform.localScale = new Vector3(x, y, z);
	}

	public static void SetLocalScale(this Component cmpt, Vector3 scale)
	{
		cmpt.transform.localScale = scale;
	}

	public static void SetLocalScaleVal(this Component cmpt, float val)
	{
		cmpt.transform.localScale = new Vector3(val, val, val);
	}

	public static void SetLocalScaleY(this Component cmpt, float y)
	{
		Transform transform = cmpt.transform;
		Vector3 localScale = transform.localScale;
		localScale.y = y;
		transform.localScale = localScale;
	}

	public static void SetLocalScaleX(this Component cmpt, float x)
	{
		Transform transform = cmpt.transform;
		Vector3 localScale = transform.localScale;
		localScale.x = x;
		transform.localScale = localScale;
	}

	public static void SetLocalScaleZ(this Component cmpt, float z)
	{
		Transform transform = cmpt.transform;
		Vector3 localScale = transform.localScale;
		localScale.z = z;
		transform.localScale = localScale;
	}

	public static Vector3 GetLocalScale(this Component cmpt)
	{
		return cmpt.transform.localScale;
	}

	public static void GetLocalScaleEx(this Component cmpt, out float x, out float y, out float z)
	{
		Vector3 localScale = cmpt.transform.localScale;
		x = localScale.x;
		y = localScale.y;
		z = localScale.z;
	}

	public static float GetLocalScaleX(this Component cmpt)
	{
		return cmpt.transform.localScale.x;
	}

	public static void SetRotation(this Transform tran, float x, float y, float z, float w)
	{
		tran.rotation = new Quaternion(x, y, z, w);
	}

	public static void SetLocalRotationOne(this Component cmpt)
	{
		cmpt.transform.rotation = Quaternion.identity;
	}

	public static void SetLocalEulerAngle(this Component cmpt, float x, float y, float z)
	{
		cmpt.transform.localRotation = Quaternion.Euler(new Vector3(x, y, z));
	}

	public static void SetLocalEulerAngleOrigin(this Component cmpt, Vector3 v3)
	{
		cmpt.transform.localEulerAngles = v3;
	}

	public static void SetLocalEulerAngleZ(this Component cmpt, float z)
	{
		Transform transform = cmpt.transform;
		Vector3 localEulerAngles = transform.localEulerAngles;
		localEulerAngles.z = z;
		transform.localEulerAngles = localEulerAngles;
	}

	public static void SetLocalEulerAngleY(this Component cmpt, float y)
	{
		Transform transform = cmpt.transform;
		Vector3 localEulerAngles = transform.localEulerAngles;
		localEulerAngles.y = y;
		transform.localEulerAngles = localEulerAngles;
	}

	public static Vector3 GetLocalEulerAngleOrigin(this Component cmpt)
	{
		return cmpt.transform.localEulerAngles;
	}

	public static void GetLocalEulerAngle(this Component cmpt, out float x, out float y, out float z)
	{
		Vector3 localEulerAngles = cmpt.transform.localEulerAngles;
		x = localEulerAngles.x;
		y = localEulerAngles.y;
		z = localEulerAngles.z;
	}

	public static Vector3 GetEulerAngle(this Component cmpt)
	{
		return cmpt.transform.rotation.eulerAngles;
	}

	public static float GetEulerAngleY(this Component cmpt)
	{
		return cmpt.transform.rotation.eulerAngles.y;
	}

	public static float GetLocalEulerAngleX(this Component cmpt)
	{
		return cmpt.transform.localRotation.eulerAngles.x;
	}

	public static float GetLocalEulerAngleY(this Component cmpt)
	{
		return cmpt.transform.localRotation.eulerAngles.y;
	}

	public static float GetLocalEulerAngleZ(this Component cmpt)
	{
		return cmpt.transform.localRotation.eulerAngles.z;
	}

	public static void RotateAxisY(this Component cmpt, float y, Space relativeTo = Space.Self)
	{
		cmpt.transform.Rotate(0f, y, 0f, relativeTo);
	}

	public static float GetHeight(this RectTransform item)
	{
		return item.rect.height;
	}

	public static float GetHalfHeight(this RectTransform item)
	{
		return item.rect.height / 2f;
	}

	public static float GetWidth(this RectTransform item)
	{
		return item.rect.width;
	}

	public static float GetHalfWidth(this RectTransform item)
	{
		return item.rect.width / 2f;
	}

	public static float GetX(this RectTransform item)
	{
		return item.anchoredPosition.x;
	}

	public static float GetY(this RectTransform item)
	{
		return item.anchoredPosition.y;
	}

	public static Vector2 GetContentSize(this ContentSizeFitter fitter, RectTransform rect)
	{
		Vector2 result = default(Vector2);
		LayoutRebuilder.ForceRebuildLayoutImmediate(rect);
		if (fitter.horizontalFit == ContentSizeFitter.FitMode.PreferredSize)
		{
			result.x = LayoutUtility.GetPreferredSize(rect, 0);
			result.y = rect.rect.height;
		}
		else if (fitter.verticalFit == ContentSizeFitter.FitMode.PreferredSize)
		{
			result.x = rect.rect.width;
			result.y = LayoutUtility.GetPreferredSize(rect, 1);
		}
		return result;
	}

	public static void SetSizeDelta(this Component cmpt, Vector2 size)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		if (rectTransform != null)
		{
			rectTransform.sizeDelta = size;
		}
	}

	public static void SetSizeDeltaEx(this Component cmpt, float x, float y)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		if (rectTransform != null)
		{
			rectTransform.sizeDelta = new Vector2(x, y);
		}
	}

	public static void SetSizeDeltaX(this Component cmpt, float x)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		if (rectTransform != null)
		{
			rectTransform.sizeDelta = new Vector2(x, rectTransform.sizeDelta.y);
		}
	}

	public static void SetSizeDeltaY(this Component cmpt, float y)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		if (rectTransform != null)
		{
			rectTransform.sizeDelta = new Vector2(rectTransform.sizeDelta.x, y);
		}
	}

	public static void GetSizeDeltaEx(this Component cmpt, out float x, out float y)
	{
		Vector2 sizeDelta = (cmpt.transform as RectTransform).sizeDelta;
		x = sizeDelta.x;
		y = sizeDelta.y;
	}

	public static void GetSizeDeltaX(this Component cmpt, out float x)
	{
		x = ((RectTransform)cmpt.transform).sizeDelta.x;
	}

	public static void GetSizeDeltaY(this Component cmpt, out float y)
	{
		y = ((RectTransform)cmpt.transform).sizeDelta.y;
	}

	public static void GetAnchoredPosition(this Component cmpt, out float x, out float y)
	{
		Vector2 anchoredPosition = (cmpt.transform as RectTransform).anchoredPosition;
		x = anchoredPosition.x;
		y = anchoredPosition.y;
	}

	public static void GetAnchoredPositionX(this Component cmpt, out float x)
	{
		x = ((RectTransform)cmpt.transform).anchoredPosition.x;
	}

	public static void GetAnchoredPositionY(this Component cmpt, out float y)
	{
		y = ((RectTransform)cmpt.transform).anchoredPosition.y;
	}

	public static void SetAnchoredPosition(this Component cmpt, Vector2 pos)
	{
		((RectTransform)cmpt.transform).anchoredPosition = pos;
	}

	public static void SetAnchoredPositionEx(this Component cmpt, float x, float y)
	{
		((RectTransform)cmpt.transform).anchoredPosition = new Vector2(x, y);
	}

	public static void SetAnchoredPositionX(this Component cmpt, float x)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		rectTransform.anchoredPosition = new Vector2(x, rectTransform.anchoredPosition.y);
	}

	public static void SetAnchoredPositionY(this Component cmpt, float y)
	{
		RectTransform obj = cmpt.transform as RectTransform;
		obj.anchoredPosition = new Vector2(obj.anchoredPosition.x, y);
	}

	public static float GetRectWidth(this Component cmpt)
	{
		return (cmpt.transform as RectTransform).rect.width;
	}

	public static void GetRectHeight(this Component cmpt, out float height)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		height = rectTransform.rect.height;
	}

	public static void GetRectSize(this Component cmpt, out float width, out float height)
	{
		RectTransform rectTransform = cmpt.transform as RectTransform;
		width = rectTransform.rect.width;
		height = rectTransform.rect.height;
	}

	public static void GetRectEx(this RectTransform rectTrans, out float x, out float y, out float width, out float height)
	{
		Rect rect = rectTrans.rect;
		x = rect.x;
		y = rect.y;
		width = rect.width;
		height = rect.height;
	}

	public static void SetFontColor(this Text txt, float r, float g, float b, float a)
	{
		txt.color = new Color(r, g, b, a);
	}

	public static void SetPivotEx(this RectTransform rectTran, float x, float y)
	{
		rectTran.pivot = new Vector2(x, y);
	}

	public static void SetAnchor(this RectTransform cmpt, TextAnchor anchor)
	{
		switch (anchor)
		{
		case TextAnchor.UpperRight:
			cmpt.anchorMin = new Vector2(1f, 1f);
			cmpt.anchorMax = new Vector2(1f, 1f);
			break;
		case TextAnchor.UpperCenter:
			cmpt.anchorMin = new Vector2(0.5f, 1f);
			cmpt.anchorMax = new Vector2(0.5f, 1f);
			break;
		case TextAnchor.UpperLeft:
			cmpt.anchorMin = new Vector2(0f, 1f);
			cmpt.anchorMax = new Vector2(0f, 1f);
			break;
		case TextAnchor.MiddleLeft:
			cmpt.anchorMin = new Vector2(0f, 0.5f);
			cmpt.anchorMax = new Vector2(0f, 0.5f);
			break;
		case TextAnchor.MiddleCenter:
			cmpt.anchorMin = new Vector2(0.5f, 0.5f);
			cmpt.anchorMax = new Vector2(0.5f, 0.5f);
			break;
		case TextAnchor.MiddleRight:
			cmpt.anchorMin = new Vector2(1f, 0.5f);
			cmpt.anchorMax = new Vector2(1f, 0.5f);
			break;
		case TextAnchor.LowerLeft:
			cmpt.anchorMin = new Vector2(0f, 0f);
			cmpt.anchorMax = new Vector2(0f, 0f);
			break;
		case TextAnchor.LowerCenter:
			cmpt.anchorMin = new Vector2(0.5f, 0f);
			cmpt.anchorMax = new Vector2(0.5f, 0f);
			break;
		case TextAnchor.LowerRight:
			cmpt.anchorMin = new Vector2(1f, 0f);
			cmpt.anchorMax = new Vector2(1f, 0f);
			break;
		}
	}

	public static void SetAnchor(this RectTransform cmpt, int a)
	{
		cmpt.SetAnchor((TextAnchor)a);
	}

	public static void SetAnchorEx(this RectTransform cmpt, float minX, float minY, float maxX, float maxY)
	{
		cmpt.anchorMin = new Vector2(minX, minY);
		cmpt.anchorMax = new Vector2(maxX, maxY);
	}

	public static bool CopyRectTransform(this Button srcBtn, Button tarBtn)
	{
		return (srcBtn.transform as RectTransform).CopyRectTransform(tarBtn);
	}

	public static bool CopyRectTransform(this RectTransform cmpt, Button tarBtn)
	{
		RectTransform rectTransform = tarBtn.transform as RectTransform;
		float height = 0f;
		tarBtn.GetRectSize(out var width, out height);
		cmpt.sizeDelta = new Vector2(width, height);
		cmpt.pivot = rectTransform.pivot;
		if ((double)Vector3.Distance(cmpt.position, rectTransform.position) < 0.0001)
		{
			return true;
		}
		cmpt.position = rectTransform.position;
		return false;
	}

	public static bool CopyAnchoredPosition(this RectTransform cmpt, Vector2 pos)
	{
		if ((double)Vector2.Distance(cmpt.anchoredPosition, pos) < 0.0001)
		{
			return true;
		}
		cmpt.anchoredPosition = pos;
		return false;
	}

	public static void SetRectOffset(this RectTransform cmpt, float left, float right, float up, float bottom)
	{
		cmpt.offsetMin = new Vector2(left, bottom);
		cmpt.offsetMax = new Vector2(right, up);
	}

	public static void ForceRebuildLayoutImmediate(this RectTransform cmpt)
	{
		LayoutRebuilder.ForceRebuildLayoutImmediate(cmpt);
	}

	public static void SetGraphicGray(this Graphic graphic)
	{
		Color color = graphic.color;
		color.r = 0f;
		color.g = 0f;
		color.b = 0f;
		graphic.color = color;
	}

	public static void SetGraphicWhite(this Graphic graphic)
	{
		Color color = graphic.color;
		color.r = 1f;
		color.g = 1f;
		color.b = 1f;
		graphic.color = color;
	}

	public static void SetGraphicWhite(this Button button)
	{
		button.image.SetGraphicWhite();
	}

	public static void SetGraphicGray(this Button button)
	{
		button.image.SetGraphicGray();
	}

	public static void SetColor(this Component cmpt, Color c)
	{
		Graphic component = cmpt.GetComponent<Graphic>();
		if (component != null)
		{
			component.color = c;
		}
	}

	public static void SetGraphicColor(this Graphic graphic, float r, float g, float b, float a)
	{
		graphic.color = new Color(r, g, b, a);
	}

	public static void SetGraphicColor(this Button button, float r, float g, float b, float a)
	{
		button.image.SetGraphicColor(r, g, b, a);
	}

	public static void SetGraphicAlpha(this Graphic gp, float a)
	{
		Color color = gp.color;
		color.a = a;
		gp.color = color;
	}

	public static void SetAlpha(this Component cmpt, float a)
	{
		Graphic component = cmpt.GetComponent<Graphic>();
		if (component != null)
		{
			Color color = component.color;
			color.a = a;
			component.color = color;
		}
	}

	public static void SetRaycastTarget(this Component cmpt, bool isTarget)
	{
		Graphic component = cmpt.GetComponent<Graphic>();
		if (component != null)
		{
			component.raycastTarget = isTarget;
		}
	}

	public static void SetActive(this Image img, bool bActive)
	{
		if (img.canvasRenderer.cull != !bActive)
		{
			img.canvasRenderer.cull = !bActive;
		}
	}

	public static void SetActive(this Image img, bool bActive, bool isRealActive)
	{
		if (isRealActive)
		{
			img.gameObject.SetActive(bActive);
		}
		else if (img.canvasRenderer.cull != !bActive)
		{
			img.canvasRenderer.cull = !bActive;
		}
	}

	public static void SetActive(this Text text, bool bActive)
	{
		if ((bool)text.canvasRenderer != !bActive)
		{
			text.canvasRenderer.cull = !bActive;
		}
	}

	public static void SetActive(this Text text, bool bActive, bool isRealActive)
	{
		if (isRealActive)
		{
			text.gameObject.SetActive(bActive);
		}
		else if (text.canvasRenderer.cull != !bActive)
		{
			text.canvasRenderer.cull = !bActive;
		}
	}

	public static AnimationState GetState(this Animation animation, string name)
	{
		return animation.get_Item(name);
	}

	public static void Play(this Animation animation)
	{
		animation.Play();
	}

	public static void PlayAnimByName(this Animation animation, string name)
	{
		animation.Play(name);
	}

	public static void Play(this Animation animation, string name, float time)
	{
		AnimationState animationState = animation.get_Item(name);
		if ((bool)animationState)
		{
			animation.Play(name);
			animationState.normalizedTime = time;
		}
	}

	public static bool OnCheckPlayingState(this Animator animator, int layIndex, string playingStateName)
	{
		return animator.GetCurrentAnimatorStateInfo(layIndex).IsName(playingStateName);
	}

	public static float GetClipLength(this Animator animator, int layIndex, string clipName)
	{
		AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
		foreach (AnimationClip animationClip in animationClips)
		{
			if (animationClip.name == clipName)
			{
				return animationClip.length;
			}
		}
		return 0f;
	}

	public static float DistanceLocalToPos(this Transform trans, Vector3 pos)
	{
		return Vector3.Distance(trans.localPosition, pos);
	}

	public static float DistanceToPos(this Transform trans, Vector3 pos)
	{
		return Vector3.Distance(trans.position, pos);
	}

	public static float DistanceToTarget(this Transform trans, Transform target)
	{
		return Vector3.Distance(trans.position, target.position);
	}

	public static float SqrDisToPos(this Transform trans, Vector3 pos)
	{
		return (pos - trans.position).sqrMagnitude;
	}

	public static float AngleYLocalToPos(this Transform trans, Vector3 pos)
	{
		Vector3 vector = pos - trans.localPosition;
		return 57.29578f * Mathf.Atan2(vector.z, vector.x);
	}

	public static void SetTargetDirection(this Transform target, float forwardX, float forwardY, float forwardZ, out float yAngleAfterSet)
	{
		target.forward = new Vector3(forwardX, forwardY, forwardZ).normalized;
		yAngleAfterSet = target.eulerAngles.y;
	}

	public static void GetForwardXYZ(this Transform tran, out float x, out float y, out float z)
	{
		Vector3 forward = tran.forward;
		x = forward.x;
		y = forward.y;
		z = forward.z;
	}

	public static void SetForward(this Transform tran, float x, float y, float z)
	{
		tran.forward = new Vector3(x, y, z).normalized;
	}

	public static void GetUpXYZ(this Transform tran, out float x, out float y, out float z)
	{
		Vector3 up = tran.up;
		x = up.x;
		y = up.y;
		z = up.z;
	}

	public static void SetUpXYZ(this Transform tran, float x, float y, float z)
	{
		tran.up = new Vector3(x, y, z).normalized;
	}

	public static void GetRightXYZ(this Transform tran, out float x, out float y, out float z)
	{
		Vector3 right = tran.right;
		x = right.x;
		y = right.y;
		z = right.z;
	}

	public static void SetTargetAngle(this Transform target, float xAngle, float yAngle, float zAngle)
	{
		target.localRotation = Quaternion.Euler(xAngle, yAngle, zAngle);
	}

	public static void RotateHorizontalToDirectionXZ(this Transform tran, float dirX, float dirZ)
	{
		Vector3 to = new Vector3(dirX, 0f, dirZ);
		Vector3 forward = tran.forward;
		forward.y = 0f;
		float num = Vector3.SignedAngle(forward, to, Vector3.up);
		Vector3 localEulerAngles = tran.localEulerAngles;
		localEulerAngles.y += num;
		tran.localEulerAngles = localEulerAngles;
	}

	public static void SetCanvasGroupAlpha(this CanvasGroup canvasGroup, float a)
	{
		canvasGroup.alpha = a;
	}

	public static float GetCanvasGroupAlpha(this CanvasGroup canvasGroup)
	{
		return canvasGroup.alpha;
	}

	public static void SetOneTextAndPreferredFontSize(this Text text, string content)
	{
		text.text = content;
		if (content == null)
		{
			return;
		}
		TextGenerator cachedTextGenerator = text.cachedTextGenerator;
		Rect rect = text.rectTransform.rect;
		TextGenerationSettings generationSettings = text.GetGenerationSettings(rect.size);
		float height = rect.height;
		float preferredHeight = cachedTextGenerator.GetPreferredHeight(content, generationSettings);
		if (preferredHeight > height)
		{
			int num = generationSettings.fontSize;
			while (preferredHeight > height)
			{
				num = (generationSettings.fontSize = num - 2);
				preferredHeight = cachedTextGenerator.GetPreferredHeight(content, generationSettings);
			}
			text.fontSize = num;
		}
	}

	public static float GetOneTextPreferredHeight(this Text text, string content)
	{
		if (!string.IsNullOrEmpty(content))
		{
			TextGenerator cachedTextGenerator = text.cachedTextGenerator;
			TextGenerationSettings generationSettings = text.GetGenerationSettings(text.rectTransform.rect.size);
			return cachedTextGenerator.GetPreferredHeight(content, generationSettings) / text.pixelsPerUnit;
		}
		return 0f;
	}

	public static float[] GetTextsPreferredHeight(this Text text, string[] contents)
	{
		float[] array = new float[contents.Length];
		TextGenerator cachedTextGenerator = text.cachedTextGenerator;
		TextGenerationSettings generationSettings = text.GetGenerationSettings(text.rectTransform.rect.size);
		float pixelsPerUnit = text.pixelsPerUnit;
		for (int i = 0; i < contents.Length; i++)
		{
			if (string.IsNullOrEmpty(contents[i]))
			{
				array[i] = 0f;
			}
			else
			{
				array[i] = cachedTextGenerator.GetPreferredHeight(contents[i], generationSettings) / pixelsPerUnit;
			}
		}
		return array;
	}

	public static void SetTextAndPreferredHeight(this Text text, string content)
	{
		if (content != null)
		{
			text.text = content;
			float preferredHeight = text.preferredHeight;
			text.SetSizeDeltaY(preferredHeight);
		}
	}

	public static float GetSetTextPreferredHeight(this Text text, string content)
	{
		float num = 0f;
		if (content != null)
		{
			text.text = content;
			num = text.preferredHeight;
			text.SetSizeDeltaY(num);
		}
		return num;
	}

	public static void SetTextAndPreferredWidth(this Text text, string content)
	{
		if (content != null)
		{
			text.text = content;
			float preferredWidth = text.preferredWidth;
			text.SetSizeDeltaX(preferredWidth);
		}
	}

	public static float GetSetTextPreferredWidth(this Text text, string content)
	{
		float num = 0f;
		if (content != null)
		{
			text.text = content;
			num = text.preferredWidth;
			text.SetSizeDeltaX(num);
		}
		return num;
	}

	public static void SetTextAnchor(this Text text, int anchor)
	{
		text.alignment = (TextAnchor)anchor;
	}

	public static void SetGrayWithColor(this Text text, Color color, bool alsoSetShadowColor, Color shadowColor)
	{
		text.color = color;
		if (alsoSetShadowColor)
		{
			Shadow component = text.GetComponent<Shadow>();
			if (component != null)
			{
				component.effectColor = shadowColor;
			}
		}
	}

	public static void SetGrayWithColor(this Text text, Color color)
	{
		text.color = color;
	}

	public static void SetShadowsColor(this Component cmpt, Color color)
	{
		Shadow[] components = cmpt.GetComponents<Shadow>();
		if (components != null)
		{
			for (int i = 0; i < components.Length; i++)
			{
				components[i].effectColor = color;
			}
		}
	}

	public static void ClearLinePrefixSymbol(this Text textComp)
	{
		textComp.StartCoroutine(textComp.DoClearLinePrefixSymbol());
	}

	public static IEnumerator DoClearLinePrefixSymbol(this Text textComp)
	{
		yield return null;
		StringBuilder stringBuilder = new StringBuilder(textComp.text);
		bool flag = PlayerPrefs.GetString("text_language") == "en";
		TextGenerator textGenerator = new TextGenerator();
		TextGenerationSettings generationSettings = textComp.GetGenerationSettings(textComp.rectTransform.rect.size);
		textGenerator.Populate(stringBuilder.ToString(), generationSettings);
		IList<UILineInfo> lines = textGenerator.lines;
		int num = 0;
		while (num < lines.Count)
		{
			bool flag2 = false;
			int startCharIdx = lines[num].startCharIdx;
			if (startCharIdx >= 0 && startCharIdx < stringBuilder.Length && num > 0)
			{
				int num2 = startCharIdx;
				while (num2 > 0 && Regex.IsMatch(stringBuilder[num2 - 1].ToString(), SYMBOL_REGEX))
				{
					num2--;
				}
				if (Regex.IsMatch(stringBuilder[startCharIdx].ToString(), SYMBOL_REGEX))
				{
					int insertIndex = FindWordStart(stringBuilder, num2 - 1);
					insertIndex = AvoidRichTextTagBreak(stringBuilder, insertIndex);
					if (insertIndex > 0 && stringBuilder[insertIndex] != '\n')
					{
						stringBuilder.Insert(insertIndex, "\n");
						flag2 = true;
					}
				}
			}
			if (!flag2)
			{
				int num3 = ((num + 1 < lines.Count) ? (lines[num + 1].startCharIdx - 1) : (stringBuilder.Length - 1));
				if (num3 > 0 && num3 <= stringBuilder.Length - 1)
				{
					if (Regex.IsMatch(stringBuilder[num3].ToString(), SYMBOL_REGEX2))
					{
						int index = AvoidRichTextTagBreak(stringBuilder, num3);
						stringBuilder.Insert(index, "\n");
						flag2 = true;
					}
					if (flag && num > 0)
					{
						int insertIndex2 = FindWordStart(stringBuilder, startCharIdx);
						insertIndex2 = AvoidRichTextTagBreak(stringBuilder, insertIndex2);
						if (insertIndex2 < startCharIdx)
						{
							stringBuilder.Insert(insertIndex2, "\n");
							flag2 = true;
						}
					}
				}
			}
			if (flag2)
			{
				textGenerator.Populate(stringBuilder.ToString(), generationSettings);
				lines = textGenerator.lines;
			}
			else
			{
				num++;
			}
		}
		stringBuilder = stringBuilder.Replace("<BR>", "\n");
		textComp.text = stringBuilder.ToString();
	}

	private static int FindWordStart(StringBuilder text, int fromIndex)
	{
		int num = 0;
		while (fromIndex >= 0 && fromIndex < text.Length && IsEnglishChar(text[fromIndex]))
		{
			num++;
			fromIndex--;
		}
		if (num <= 0)
		{
			return fromIndex;
		}
		return fromIndex + 1;
	}

	private static int AvoidRichTextTagBreak(StringBuilder text, int insertIndex)
	{
		if (insertIndex <= 0 || insertIndex > text.Length)
		{
			return insertIndex;
		}
		for (int num = insertIndex - 1; num >= 0; num--)
		{
			switch (text[num])
			{
			case '>':
				return insertIndex;
			case '<':
				return num;
			}
		}
		return insertIndex;
	}

	private static bool IsEnglishChar(char c)
	{
		if ((c < 'A' || c > 'Z') && (c < 'a' || c > 'z') && (c < '0' || c > '9') && c != '\'')
		{
			return c == '-';
		}
		return true;
	}

	private static bool IsStartWithSymbolSequence(StringBuilder textStr, int index)
	{
		if (!Regex.IsMatch(textStr[index].ToString(), SYMBOL_REGEX))
		{
			return false;
		}
		if (index != 0)
		{
			return !Regex.IsMatch(textStr[index - 1].ToString(), SYMBOL_REGEX);
		}
		return true;
	}

	public static void SetRendererMaterialFloat(this Renderer renderer, bool isSharedMaterial, string propertyName, float value)
	{
		if (isSharedMaterial)
		{
			renderer.sharedMaterial.SetFloat(propertyName, value);
		}
		else
		{
			renderer.material.SetFloat(propertyName, value);
		}
	}

	public static void SetRendererMaterialRenderQueue(this Renderer renderer, bool isSharedMaterial, int renderQueue)
	{
		if (isSharedMaterial)
		{
			renderer.sharedMaterial.renderQueue = renderQueue;
		}
		else
		{
			renderer.material.renderQueue = renderQueue;
		}
	}

	public static void ChangeMaterial(this Transform transform, Material material)
	{
		transform.GetComponent<MeshRenderer>().material = material;
	}

	public static Material[] GetChildMaterials(this Transform transform)
	{
		SkinnedMeshRenderer[] componentsInChildren = transform.GetComponentsInChildren<SkinnedMeshRenderer>(includeInactive: true);
		List<Material> list = new List<Material>(componentsInChildren.Length);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			list.AddRange(componentsInChildren[i].materials);
		}
		return list.ToArray();
	}

	public static void ChangeMaterials(this Transform transform, Material material)
	{
		SkinnedMeshRenderer[] componentsInChildren = transform.GetComponentsInChildren<SkinnedMeshRenderer>(includeInactive: true);
		foreach (SkinnedMeshRenderer skinnedMeshRenderer in componentsInChildren)
		{
			if (skinnedMeshRenderer.materials.Length > 1)
			{
				skinnedMeshRenderer.materials = new Material[2] { material, material };
			}
			else
			{
				skinnedMeshRenderer.material = material;
			}
		}
	}

	public static void RevertMaterials(this Transform transform, Material[] materials)
	{
		int num = 0;
		SkinnedMeshRenderer[] componentsInChildren = transform.GetComponentsInChildren<SkinnedMeshRenderer>(includeInactive: true);
		foreach (SkinnedMeshRenderer skinnedMeshRenderer in componentsInChildren)
		{
			if (skinnedMeshRenderer.materials.Length > 1)
			{
				skinnedMeshRenderer.materials = new Material[2]
				{
					materials[num],
					materials[num + 1]
				};
				num += 2;
			}
			else
			{
				skinnedMeshRenderer.material = materials[num];
				num++;
			}
		}
	}

	public static SkinnedMeshRenderer[] GetChildMeshRender(this Transform transform)
	{
		return transform.GetComponentsInChildren<SkinnedMeshRenderer>(includeInactive: true);
	}

	public static void SetImageColor(this Image image, Color color)
	{
		if (image != null)
		{
			image.color = color;
		}
	}

	public static void SetImageRectEx(this Image img, float preferredSizeScale)
	{
		float x = img.preferredWidth * preferredSizeScale;
		float y = img.preferredHeight * preferredSizeScale;
		img.rectTransform.sizeDelta = new Vector2(x, y);
	}

	public static void SetRawImage(this RawImage img, Texture2D tex2d)
	{
		img.texture = tex2d;
	}

	public static void AddListener(this Button btn, UnityAction action)
	{
		btn.onClick.AddListener(action);
	}

	public static void RemoveAllListener(this Button btn)
	{
		btn.onClick.RemoveAllListeners();
	}

	public static void SetSpriteName(this Button btn, Sprite sprite)
	{
		Image component = btn.GetComponent<Image>();
		if (component != null)
		{
			component.sprite = sprite;
		}
	}

	public static void SetImageColor(this Button btn, Color color)
	{
		Image component = btn.GetComponent<Image>();
		if (component != null)
		{
			component.color = color;
		}
	}

	public static void SetInteractable(this Button btn, bool interactable)
	{
		btn.interactable = interactable;
		if (interactable)
		{
			btn.image.SetGraphicWhite();
		}
		else
		{
			btn.image.SetGraphicGray();
		}
	}

	public static bool GetInteractable(this Button btn)
	{
		return btn.image.color.r > 0f;
	}

	public static void SetRaycastTarget(this Button btn, bool enable)
	{
		btn.image.raycastTarget = enable;
	}

	public static void SetRaycastTargetEx(this Button btn, bool enable)
	{
		btn.targetGraphic.enabled = enable;
	}

	public static void AddValueChange(this Toggle tog, UnityAction<bool> action)
	{
		tog.onValueChanged.AddListener(action);
	}

	public static void AddListener(this ScrollRect sr, UnityAction<Vector2> action)
	{
		sr.onValueChanged.AddListener(action);
	}

	public static void AddOptionsEx(this Dropdown dropdown, string[] options)
	{
		List<string> options2 = new List<string>(options);
		dropdown.AddOptions(options2);
	}

	public static void SetSelectValue(this Dropdown dropdown, int select)
	{
		dropdown.value = select;
	}

	public static void ClearOptions(this Dropdown dropdown)
	{
		dropdown.ClearOptions();
	}

	public static int GetLayoutGroupPaddingTop(this Component cmpt)
	{
		LayoutGroup component = cmpt.GetComponent<LayoutGroup>();
		if (component != null)
		{
			return component.padding.top;
		}
		return 0;
	}

	public static float GetHorizontalOrVerticalLayoutGroupSpacing(this Component cmpt)
	{
		HorizontalOrVerticalLayoutGroup component = cmpt.GetComponent<HorizontalOrVerticalLayoutGroup>();
		if (component != null)
		{
			return component.spacing;
		}
		return 0f;
	}

	public static void SetHorizontalOrVerticalLayoutGroupSpacing(this Component cmpt, float spacing)
	{
		HorizontalOrVerticalLayoutGroup component = cmpt.GetComponent<HorizontalOrVerticalLayoutGroup>();
		if (component != null)
		{
			component.spacing = spacing;
		}
	}

	public static void SetPadding(this LayoutGroup layout, int left, int right, int top, int bottom)
	{
		layout.padding = new RectOffset(left, right, top, bottom);
	}

	public static void SetPaddingTop(this LayoutGroup layout, int top)
	{
		RectOffset padding = layout.padding;
		padding.top = top;
		layout.padding = padding;
	}

	public static void SetChildAlignment(this LayoutGroup layout, int alignment)
	{
		layout.childAlignment = (TextAnchor)alignment;
	}

	public static void SetGridParams(this GridLayoutGroup gridLayoutGroup, float cellSizeX, float cellSizeY, float spacingX)
	{
		gridLayoutGroup.cellSize = new Vector2(cellSizeX, cellSizeY);
		Vector2 spacing = gridLayoutGroup.spacing;
		spacing.x = spacingX;
		gridLayoutGroup.spacing = spacing;
	}

	public static void SetStartCorner(this GridLayoutGroup gridLayoutGroup, int corner)
	{
		gridLayoutGroup.startCorner = (GridLayoutGroup.Corner)corner;
	}

	public static void ShowHideByScale(this Component cmpt, bool isShow)
	{
		if (isShow)
		{
			cmpt.SetLocalScaleOne();
		}
		else
		{
			cmpt.SetLocalScaleZero();
		}
	}

	public static float GetCameraOrthographicSize(this Camera camera)
	{
		return camera.orthographicSize;
	}

	public static void SetCameraOrthographicSize(this Camera camera, float size)
	{
		camera.orthographicSize = size;
	}

	public static void SetCameraCullingMaskNothing(this Camera camera)
	{
		camera.cullingMask = 0;
	}

	public static void SetCameraCullingMaskOneLayer(this Camera camera, string layerName)
	{
		camera.cullingMask = 1 << LayerMask.NameToLayer(layerName);
	}

	public static void SetCameraCullingMask(this Camera camera, int cullingMask)
	{
		camera.cullingMask = cullingMask;
	}

	public static void ScreenToWorldPoint(this Camera camera, float x, float y, ref Vector3 posOut)
	{
		if (!(camera == null) && camera.enabled)
		{
			posOut.x = x;
			posOut.y = y;
			posOut.z = 99f;
			Vector3 vector = camera.ScreenToWorldPoint(posOut);
			if (camera.orthographic)
			{
				posOut.x = vector.x;
				posOut.y = vector.y;
				posOut.z = vector.z;
			}
			else
			{
				Vector3 position = camera.transform.position;
				posOut.x = (0f - vector.y / (position.y - vector.y)) * (position.x - vector.x) + vector.x;
				posOut.y = 0f;
				posOut.z = (0f - vector.y / (position.y - vector.y)) * (position.z - vector.z) + vector.z;
			}
		}
	}

	public static void ScreenToWorldPoint(this Camera camera, float inX, float inY, ref float outX, ref float outY, ref float outZ)
	{
		Vector3 posOut = Vector3.zero;
		camera.ScreenToWorldPoint(inX, inY, ref posOut);
		outX = posOut.x;
		outY = posOut.y;
		outZ = posOut.z;
	}

	public static void ScreenToWorldPoint(this Camera camera, Vector2 posIn, ref Vector3 posOut)
	{
		camera.ScreenToWorldPoint(posIn.x, posIn.y, ref posOut);
	}

	public static Transform GetHeorModelAttachPointTrans(this GameObject heroModelGo, string pointName)
	{
		AttachPointSetup component = heroModelGo.GetComponent<AttachPointSetup>();
		if (component != null)
		{
			string attachPointPath = component.GetAttachPointPath(pointName);
			return component.transform.Find(attachPointPath);
		}
		return null;
	}
}
