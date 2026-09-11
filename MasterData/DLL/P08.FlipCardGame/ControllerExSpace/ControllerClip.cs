using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ControllerExSpace;

[Serializable]
public class ControllerClip : ISerializationCallbackReceiver
{
	public GameObject owner;

	public uint tags;

	private Vector3 anchoredPosition;

	private Vector2 sizeDelta;

	private Vector2 pivot;

	private Vector2 anchorMin;

	private Vector2 anchorMax;

	private Quaternion localRotation;

	private Vector3 localScale;

	private bool active;

	private int font_Size;

	private Color font_color;

	private Sprite sprite;

	private Color image_color;

	private Material image_material;

	private float canvas_group_alpha;

	private float uiBlur;

	[SerializeField]
	[HideInInspector]
	protected float[] floatValues;

	[SerializeField]
	[HideInInspector]
	protected UnityEngine.Object[] objValues;

	[SerializeField]
	[HideInInspector]
	protected string[] controllerKeys;

	[SerializeField]
	[HideInInspector]
	protected string[] controllerStates;

	public void OnBeforeSerialize()
	{
		List<float> list = new List<float>();
		if (ControllerEx.CheckGaearStatus(tags, GearType.ACTIVE))
		{
			list.Add(active ? 1 : 0);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.POSITION))
		{
			list.Add(anchoredPosition.x);
			list.Add(anchoredPosition.y);
			list.Add(sizeDelta.x);
			list.Add(sizeDelta.y);
			list.Add(pivot.x);
			list.Add(pivot.y);
			list.Add(anchorMin.x);
			list.Add(anchorMin.y);
			list.Add(anchorMax.x);
			list.Add(anchorMax.y);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.ROTATION))
		{
			list.Add(localRotation.eulerAngles.x);
			list.Add(localRotation.eulerAngles.y);
			list.Add(localRotation.eulerAngles.z);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.SCALE))
		{
			list.Add(localScale.x);
			list.Add(localScale.y);
			list.Add(localScale.z);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.FONT_SIZE))
		{
			list.Add(font_Size);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.FONT_COLOR))
		{
			list.Add(font_color.r);
			list.Add(font_color.g);
			list.Add(font_color.b);
			list.Add(font_color.a);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_COLOR))
		{
			list.Add(image_color.r);
			list.Add(image_color.g);
			list.Add(image_color.b);
			list.Add(image_color.a);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.CANVAS_GROUP_ALPHA))
		{
			list.Add(canvas_group_alpha);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.UI_BLUR_MIP_MAP))
		{
			list.Add(uiBlur);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.POSITION_Z))
		{
			list.Add(anchoredPosition.z);
		}
		floatValues = list.ToArray();
		List<UnityEngine.Object> list2 = new List<UnityEngine.Object>();
		if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_SPRITE))
		{
			list2.Add(sprite);
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_MATERIAL))
		{
			list2.Add(image_material);
		}
		objValues = list2.ToArray();
	}

	public void OnAfterDeserialize()
	{
		int num = 0;
		if (ControllerEx.CheckGaearStatus(tags, GearType.ACTIVE))
		{
			active = floatValues[num] != 0f;
			num++;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.POSITION))
		{
			anchoredPosition = new Vector3(floatValues[num], floatValues[num + 1], 0f);
			sizeDelta = new Vector2(floatValues[num + 2], floatValues[num + 3]);
			pivot = new Vector2(floatValues[num + 4], floatValues[num + 5]);
			anchorMin = new Vector2(floatValues[num + 6], floatValues[num + 7]);
			anchorMax = new Vector2(floatValues[num + 8], floatValues[num + 9]);
			num += 10;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.ROTATION))
		{
			localRotation = Quaternion.Euler(floatValues[num], floatValues[num + 1], floatValues[num + 2]);
			num += 3;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.SCALE))
		{
			localScale = new Vector3(floatValues[num], floatValues[num + 1], floatValues[num + 2]);
			num += 3;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.FONT_SIZE))
		{
			font_Size = (int)floatValues[num];
			num++;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.FONT_COLOR))
		{
			font_color = new Color(floatValues[num], floatValues[num + 1], floatValues[num + 2], floatValues[num + 3]);
			num += 4;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_COLOR))
		{
			image_color = new Color(floatValues[num], floatValues[num + 1], floatValues[num + 2], floatValues[num + 3]);
			num += 4;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.CANVAS_GROUP_ALPHA))
		{
			canvas_group_alpha = floatValues[num];
			num++;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.UI_BLUR_MIP_MAP))
		{
			uiBlur = floatValues[num];
			num++;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.POSITION_Z))
		{
			anchoredPosition.z = floatValues[num];
			num++;
		}
		int num2 = 0;
		new List<UnityEngine.Object>();
		if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_SPRITE))
		{
			sprite = objValues[num2] as Sprite;
			num2++;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_MATERIAL))
		{
			image_material = objValues[num2] as Material;
			num2++;
		}
	}

	public void UpdateState(GameObject _owner, uint _tags, List<ControllerParams> cControl)
	{
		owner = _owner;
		tags = _tags;
		foreach (GearType value in Enum.GetValues(typeof(GearType)))
		{
			if (ControllerEx.CheckGaearStatus(tags, value))
			{
				UpdateGearState(value, cControl);
			}
		}
		if (!ControllerEx.CheckGaearStatus(tags, GearType.CONTROLLER))
		{
			controllerKeys = null;
			controllerStates = null;
		}
	}

	public void UpdateGearState(GearType gearType, List<ControllerParams> cControl)
	{
		if (!owner)
		{
			return;
		}
		RectTransform component = owner.GetComponent<RectTransform>();
		Text component2 = owner.GetComponent<Text>();
		Image component3 = owner.GetComponent<Image>();
		RawImage component4 = owner.GetComponent<RawImage>();
		CanvasGroup component5 = owner.GetComponent<CanvasGroup>();
		UIBlurMipMap component6 = owner.GetComponent<UIBlurMipMap>();
		ControllerExCollection component7 = owner.GetComponent<ControllerExCollection>();
		switch (gearType)
		{
		case GearType.ACTIVE:
			active = !owner || owner.activeSelf;
			break;
		case GearType.POSITION:
			anchoredPosition = (component ? component.anchoredPosition3D : Vector3.zero);
			sizeDelta = (component ? component.sizeDelta : Vector2.zero);
			pivot = (component ? component.pivot : Vector2.zero);
			anchorMin = (component ? component.anchorMin : Vector2.zero);
			anchorMax = (component ? component.anchorMax : Vector2.one);
			break;
		case GearType.ROTATION:
			localRotation = Quaternion.Euler(component ? component.localRotation.eulerAngles : Vector3.zero);
			break;
		case GearType.SCALE:
			localScale = (component ? component.localScale : Vector3.one);
			break;
		case GearType.FONT_SIZE:
			font_Size = (component2 ? component2.fontSize : 0);
			break;
		case GearType.FONT_COLOR:
			font_color = (component2 ? component2.color : Color.white);
			break;
		case GearType.IMG_COLOR:
			image_color = (component3 ? component3.color : Color.white);
			image_color = (component4 ? component4.color : image_color);
			break;
		case GearType.IMG_SPRITE:
			sprite = component3?.sprite;
			break;
		case GearType.IMG_MATERIAL:
			image_material = component3?.material;
			image_material = (component4 ? component4.material : image_material);
			break;
		case GearType.CANVAS_GROUP_ALPHA:
			canvas_group_alpha = ((component5 != null) ? component5.alpha : 0f);
			break;
		case GearType.UI_BLUR_MIP_MAP:
			uiBlur = ((component6 != null) ? component6.mipLevel : 0f);
			break;
		case GearType.CONTROLLER:
		{
			controllerKeys = null;
			controllerStates = null;
			if (cControl == null || !(component7 != null))
			{
				break;
			}
			controllerKeys = new string[cControl.Count];
			controllerStates = new string[cControl.Count];
			for (int i = 0; i < cControl.Count; i++)
			{
				ControllerEx controller = component7.GetController(cControl[i].controllerName);
				controllerKeys[i] = cControl[i].controllerName;
				if (controller != null)
				{
					controllerStates[i] = controller.GetSelectedState();
				}
				else
				{
					controllerStates[i] = "none";
				}
			}
			break;
		}
		default:
			Debug.LogError("ControllerClip UpdateGearState error");
			break;
		case GearType.POSITION_Z:
			break;
		}
	}

	public void ApplyState(bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (null == owner)
		{
			return;
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.ACTIVE))
		{
			owner.SetActive(active);
		}
		RectTransform component = owner.GetComponent<RectTransform>();
		if (null != component)
		{
			if (ControllerEx.CheckGaearStatus(tags, GearType.POSITION))
			{
				component.pivot = pivot;
				component.anchorMin = anchorMin;
				component.anchorMax = anchorMax;
				component.sizeDelta = sizeDelta;
				if (!ControllerEx.CheckGaearStatus(tags, GearType.IGNORE_POSITION))
				{
					UpdatePosition(component, immediately, easeTweens);
				}
			}
			if (ControllerEx.CheckGaearStatus(tags, GearType.ROTATION))
			{
				UpdateRotation(component, immediately, easeTweens);
			}
			if (ControllerEx.CheckGaearStatus(tags, GearType.SCALE))
			{
				UpdateScale(component, immediately, easeTweens);
			}
		}
		Text component2 = owner.GetComponent<Text>();
		if (null != component2)
		{
			if (ControllerEx.CheckGaearStatus(tags, GearType.FONT_COLOR))
			{
				UpdateFontColor(component2, immediately, easeTweens);
			}
			if (ControllerEx.CheckGaearStatus(tags, GearType.FONT_SIZE))
			{
				component2.fontSize = font_Size;
			}
		}
		Image component3 = owner.GetComponent<Image>();
		if (null != component3)
		{
			if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_SPRITE))
			{
				component3.sprite = sprite;
			}
			if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_COLOR))
			{
				UpdateImageColor(component3, immediately, easeTweens);
			}
			if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_MATERIAL))
			{
				component3.material = image_material;
			}
		}
		RawImage component4 = owner.GetComponent<RawImage>();
		if (null != component4)
		{
			if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_COLOR))
			{
				UpdateImageColor(component4, immediately, easeTweens);
			}
			if (ControllerEx.CheckGaearStatus(tags, GearType.IMG_MATERIAL))
			{
				component3.material = image_material;
			}
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.CANVAS_GROUP_ALPHA))
		{
			CanvasGroup component5 = owner.GetComponent<CanvasGroup>();
			if (null != component5)
			{
				UpdateCanvasGroupAlpha(component5, immediately, easeTweens);
			}
		}
		if (ControllerEx.CheckGaearStatus(tags, GearType.UI_BLUR_MIP_MAP))
		{
			UIBlurMipMap component6 = owner.GetComponent<UIBlurMipMap>();
			if (null != component6)
			{
				UpdateUIBlura(component6, immediately, easeTweens);
			}
		}
		if (!ControllerEx.CheckGaearStatus(tags, GearType.CONTROLLER))
		{
			return;
		}
		ControllerExCollection component7 = owner.GetComponent<ControllerExCollection>();
		if (null != component7 && controllerKeys != null)
		{
			for (int i = 0; i < controllerKeys.Length; i++)
			{
				component7.GetController(controllerKeys[i])?.SetSelectedState(controllerStates[i]);
			}
		}
	}

	public void SetTags(uint _tags)
	{
		uint num = tags;
		uint num2 = _tags & ~num;
		foreach (GearType value in Enum.GetValues(typeof(GearType)))
		{
			if (ControllerEx.CheckGaearStatus(num2, value))
			{
				UpdateGearState(value, null);
			}
		}
		tags = _tags;
	}

	public bool HasGearType(GearType type)
	{
		return ControllerEx.CheckGaearStatus(tags, type);
	}

	private void UpdatePosition(RectTransform rt, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (rt == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.POSITION, out var value))
			{
				LeanTween.cancel(value.runtimeTweenId);
				Vector3 startPos = rt.anchoredPosition3D;
				value.runtimeTweenId = LeanTween.value(rt.gameObject, 0f, 1f, easeTweens[GearType.POSITION].duration).setEase(easeTweens[GearType.POSITION].ease).setOnUpdate(delegate(float t)
				{
					rt.anchoredPosition3D = Vector3.Lerp(startPos, anchoredPosition, t);
				})
					.setOnComplete((Action)delegate
					{
						rt.anchoredPosition3D = anchoredPosition;
					})
					.uniqueId;
				easeTweens[GearType.POSITION] = value;
			}
			else
			{
				rt.anchoredPosition3D = anchoredPosition;
			}
		}
		else
		{
			rt.anchoredPosition3D = anchoredPosition;
		}
	}

	private void UpdateRotation(RectTransform rt, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (rt == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.ROTATION, out var value))
			{
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.rotateLocal(rt.gameObject, localRotation.eulerAngles, easeTweens[GearType.ROTATION].duration).setEase(easeTweens[GearType.ROTATION].ease).uniqueId;
				easeTweens[GearType.ROTATION] = value;
			}
			else
			{
				rt.localRotation = localRotation;
			}
		}
		else
		{
			rt.localRotation = localRotation;
		}
	}

	private void UpdateScale(RectTransform rt, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (rt == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.SCALE, out var value))
			{
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.scale(rt.gameObject, localScale, easeTweens[GearType.SCALE].duration).setEase(easeTweens[GearType.SCALE].ease).uniqueId;
				easeTweens[GearType.SCALE] = value;
			}
			else
			{
				rt.localScale = localScale;
			}
		}
		else
		{
			rt.localScale = localScale;
		}
	}

	private void UpdateCanvasGroupAlpha(CanvasGroup canvasGroup, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (canvasGroup == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.CANVAS_GROUP_ALPHA, out var value))
			{
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.value(canvasGroup.gameObject, canvasGroup.alpha, canvas_group_alpha, easeTweens[GearType.CANVAS_GROUP_ALPHA].duration).setEase(easeTweens[GearType.CANVAS_GROUP_ALPHA].ease).setOnUpdate(delegate(float alpha)
				{
					canvasGroup.alpha = alpha;
				})
					.uniqueId;
				easeTweens[GearType.CANVAS_GROUP_ALPHA] = value;
			}
			else
			{
				canvasGroup.alpha = canvas_group_alpha;
			}
		}
		else
		{
			canvasGroup.alpha = canvas_group_alpha;
		}
	}

	private void UpdateUIBlura(UIBlurMipMap uiBlurComp, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (uiBlurComp == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.UI_BLUR_MIP_MAP, out var value))
			{
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.value(uiBlurComp.gameObject, uiBlurComp.mipLevel, uiBlur, easeTweens[GearType.UI_BLUR_MIP_MAP].duration).setEase(easeTweens[GearType.UI_BLUR_MIP_MAP].ease).setOnUpdate(delegate(float mipLevel)
				{
					uiBlurComp.mipLevel = mipLevel;
				})
					.uniqueId;
				easeTweens[GearType.UI_BLUR_MIP_MAP] = value;
			}
			else
			{
				uiBlurComp.mipLevel = uiBlur;
			}
		}
		else
		{
			uiBlurComp.mipLevel = uiBlur;
		}
	}

	private void UpdateFontColor(Text text, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (text == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.FONT_COLOR, out var value))
			{
				Color originColor = text.color;
				Vector3 originHSV = ColorUtil.RGBToHSV(originColor);
				Vector3 targetHSV = ColorUtil.RGBToHSV(font_color);
				bool isHsvChange = false;
				Vector3 vector = originHSV;
				vector.z = targetHSV.z;
				if (targetHSV == vector)
				{
					isHsvChange = true;
				}
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.value(text.gameObject, 0f, 1f, easeTweens[GearType.FONT_COLOR].duration).setEase(easeTweens[GearType.FONT_COLOR].ease).setOnUpdate(delegate(float num)
				{
					if (isHsvChange)
					{
						Color color = Color.HSVToRGB(originHSV.x, originHSV.y, num * (targetHSV.z - originHSV.z) + originHSV.z);
						color.a = num * (font_color.a - originColor.a) + originColor.a;
						text.color = color;
					}
					else
					{
						text.color = Color.Lerp(originColor, font_color, num);
					}
				})
					.setOnComplete((Action)delegate
					{
						text.color = font_color;
					})
					.uniqueId;
				easeTweens[GearType.FONT_COLOR] = value;
			}
			else
			{
				text.color = font_color;
			}
		}
		else
		{
			text.color = font_color;
		}
	}

	private void UpdateImageColor(Image img, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (img == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.IMG_COLOR, out var value))
			{
				Color originColor = img.color;
				Vector3 originHSV = ColorUtil.RGBToHSV(originColor);
				Vector3 targetHSV = ColorUtil.RGBToHSV(image_color);
				bool isHsvChange = false;
				Vector3 vector = originHSV;
				vector.z = targetHSV.z;
				if (targetHSV == vector)
				{
					isHsvChange = true;
				}
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.value(img.gameObject, 0f, 1f, easeTweens[GearType.IMG_COLOR].duration).setEase(easeTweens[GearType.IMG_COLOR].ease).setOnUpdate(delegate(float num)
				{
					if (isHsvChange)
					{
						Color color = Color.HSVToRGB(originHSV.x, originHSV.y, num * (targetHSV.z - originHSV.z) + originHSV.z);
						color.a = num * (image_color.a - originColor.a) + originColor.a;
						img.color = color;
					}
					else
					{
						img.color = Color.Lerp(originColor, image_color, num);
					}
				})
					.setOnComplete((Action)delegate
					{
						img.color = image_color;
					})
					.uniqueId;
				easeTweens[GearType.IMG_COLOR] = value;
			}
			else
			{
				img.color = image_color;
			}
		}
		else
		{
			img.color = image_color;
		}
	}

	private void UpdateImageColor(RawImage img, bool immediately, Dictionary<GearType, TweenParams> easeTweens = null)
	{
		if (img == null)
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!immediately && easeTweens != null && easeTweens.TryGetValue(GearType.IMG_COLOR, out var value))
			{
				Color originColor = img.color;
				Vector3 originHSV = ColorUtil.RGBToHSV(originColor);
				Vector3 targetHSV = ColorUtil.RGBToHSV(image_color);
				bool isHsvChange = false;
				Vector3 vector = originHSV;
				vector.z = targetHSV.z;
				if (targetHSV == vector)
				{
					isHsvChange = true;
				}
				LeanTween.cancel(value.runtimeTweenId);
				value.runtimeTweenId = LeanTween.value(img.gameObject, 0f, 1f, easeTweens[GearType.IMG_COLOR].duration).setEase(easeTweens[GearType.IMG_COLOR].ease).setOnUpdate(delegate(float num)
				{
					if (isHsvChange)
					{
						Color color = Color.HSVToRGB(originHSV.x, originHSV.y, num * (targetHSV.z - originHSV.z) + originHSV.z);
						color.a = num * (image_color.a - originColor.a) + originColor.a;
						img.color = color;
					}
					else
					{
						img.color = Color.Lerp(originColor, image_color, num);
					}
				})
					.setOnComplete((Action)delegate
					{
						img.color = image_color;
					})
					.uniqueId;
				easeTweens[GearType.IMG_COLOR] = value;
			}
			else
			{
				img.color = image_color;
			}
		}
		else
		{
			img.color = image_color;
		}
	}
}
