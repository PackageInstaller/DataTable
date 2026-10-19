using System;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.RichText;
using ACT.Sound;
using ACT.UI;
using DG.Tweening;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.Utility;

public static class UIUtility
{
	public static Vector2 screenCenter => new Vector2(Screen.width / 2, Screen.height / 2);

	public static Vector2 fullScreen => new Vector2(Screen.width, Screen.height);

	public static string GetUIAssetPathByUIType(UI_TYPE uiType)
	{
		if (CommonUIData.DICT_UI_DATA.TryGetValue(uiType, out var value))
		{
			if (MonoECS.instance.ispc)
			{
				return value.GetPcPath();
			}
			return value.mobilePath;
		}
		throw new IndexOutOfRangeException(uiType.ToString());
	}

	public static UI_LAYER GetUILayerByUIType(UI_TYPE uiType)
	{
		if (CommonUIData.DICT_UI_DATA.TryGetValue(uiType, out var value))
		{
			return value.layer;
		}
		throw new IndexOutOfRangeException(uiType.ToString());
	}

	public static Vector2 GetScreenPos(RectTransform rectTransform)
	{
		return RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, rectTransform.position);
	}

	public static Vector3[] GetWorldCorners(RectTransform rt)
	{
		Vector3[] array = new Vector3[4];
		rt.GetWorldCorners(array);
		return array;
	}

	public static Vector3 GetWorldPosIgnorePivot(RectTransform rectTransform)
	{
		return rectTransform.TransformPoint(rectTransform.rect.center);
	}

	public static Vector2 GetPivotOffset(RectTransform rectTransform)
	{
		return new Vector2((0.5f - rectTransform.pivot.x) * rectTransform.rect.size.x, (0.5f - rectTransform.pivot.y) * rectTransform.rect.size.y);
	}

	public static Vector2 GetSelfCenterLocalPos(RectTransform rectTransform)
	{
		return new Vector2((0.5f - rectTransform.pivot.x) * rectTransform.rect.size.x, (0.5f - rectTransform.pivot.y) * rectTransform.rect.size.y);
	}

	public static Vector2 GetSelfTargetLocalPos(RectTransform rectTransform, Vector2 target)
	{
		return new Vector2((target.x - rectTransform.pivot.x) * rectTransform.rect.size.x, (target.y - rectTransform.pivot.y) * rectTransform.rect.size.y);
	}

	public static Vector2 ConvertLocalPosToTargetPos(RectTransform selfTransform, RectTransform targetTransform)
	{
		return targetTransform.InverseTransformPoint(ConvertLocalPosToWorldPos(selfTransform));
	}

	public static Vector3 ConvertLocalPosToWorldPos(RectTransform target)
	{
		Vector2 pivotOffset = GetPivotOffset(target);
		Vector3 position = target.localPosition + (Vector3)pivotOffset;
		return target.parent.TransformPoint(position);
	}

	public static Vector2 GetToCenterNormalizedPos(this ScrollRect scrollRect, RectTransform transform)
	{
		Vector2 vector = ConvertLocalPosToTargetPos(transform, scrollRect.viewport);
		Vector2 vector2 = GetSelfCenterLocalPos(scrollRect.viewport) - vector;
		Vector2 vector3 = scrollRect.content.sizeDelta * scrollRect.content.localScale - scrollRect.viewport.rect.size;
		Vector2 vector4 = new Vector2((vector3.x != 0f) ? (vector2.x / vector3.x) : 0f, (vector3.y != 0f) ? (vector2.y / vector3.y) : 0f);
		Vector2 result = scrollRect.normalizedPosition - vector4;
		result.x = Mathf.Clamp01(result.x);
		result.y = Mathf.Clamp01(result.y);
		return result;
	}

	public static Vector2 GetToCenterContentLocalPos(this ScrollRect scrollRect, RectTransform transform)
	{
		return scrollRect.GetToTargetContentLocalPos(transform, 0.5f * Vector2.one);
	}

	public static Vector2 GetToTargetContentLocalPos(this ScrollRect scrollRect, RectTransform transform, Vector2 target)
	{
		Vector2 vector = ConvertLocalPosToTargetPos(transform, scrollRect.viewport);
		Vector2 vector2 = GetSelfTargetLocalPos(scrollRect.viewport, target) - vector;
		return (Vector2)scrollRect.content.localPosition + vector2;
	}

	public static Tweener DOContentLocalPos(this ScrollRect target, Vector2 endValue, float duration, bool snapping = false)
	{
		return DOTween.To(() => target.content.localPosition, (Vector2 pos) =>
		{
			target.content.localPosition = pos;
		}, endValue, duration).SetOptions(snapping).SetTarget(target);
	}

	public static bool OverLaps(this RectTransform self, RectTransform other)
	{
		Vector3[] worldCorners = GetWorldCorners(self);
		Vector3[] worldCorners2 = GetWorldCorners(other);
		float x = worldCorners[2].x;
		float x2 = worldCorners2[2].x;
		float x3 = worldCorners[0].x;
		float x4 = worldCorners2[0].x;
		float y = worldCorners[2].y;
		float y2 = worldCorners2[2].y;
		float y3 = worldCorners[0].y;
		float y4 = worldCorners2[0].y;
		if (x2 > x3 && x4 < x && y2 > y3)
		{
			return y4 < y;
		}
		return false;
	}

	public static Vector2 OvalConstraint(Vector2 input, float semiMajorAxis, float semiMinorAxis)
	{
		semiMinorAxis = Mathf.Clamp01(semiMinorAxis);
		semiMajorAxis = Mathf.Clamp01(semiMajorAxis);
		float x = input.x * semiMinorAxis * (float)Screen.height / (semiMajorAxis * (float)Screen.width);
		float f = Mathf.Atan2(input.y, x);
		float x2 = semiMajorAxis * (float)Screen.width * Mathf.Cos(f);
		float y = semiMinorAxis * (float)Screen.height * Mathf.Sin(f);
		return new Vector2(x2, y);
	}

	public static bool AllInScreen(RectTransform rectTransform)
	{
		Vector3[] worldCorners = GetWorldCorners(rectTransform);
		Vector3 position = worldCorners[0];
		Vector3 position2 = worldCorners[2];
		Vector3 vector = GameUtility.uiCamera.WorldToScreenPoint(position);
		Vector3 vector2 = GameUtility.uiCamera.WorldToScreenPoint(position2);
		if (vector.x >= 0f && vector.y >= 0f && vector2.x <= (float)Screen.width)
		{
			return vector2.y <= (float)Screen.height;
		}
		return false;
	}

	public static void DestroyChildren(this Transform t, Func<Transform, int, bool> checkChild = null)
	{
		for (int num = t.childCount - 1; num >= 0; num--)
		{
			Transform child = t.GetChild(num);
			if (checkChild == null || checkChild(child, num))
			{
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
	}

	public static T AddWidget<T>(Transform parent, GameObject item) where T : Component
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(item, parent);
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.localScale = Vector3.one;
		gameObject.transform.localRotation = Quaternion.identity;
		return gameObject.GetOrAddComponent<T>();
	}

	public static void SetBtnClick(this Button btn, UnityAction action, string soundPath = "")
	{
		if (!(btn == null))
		{
			btn.onClick.RemoveAllListeners();
			if (action != null)
			{
				btn.onClick.AddListener(action);
			}
			if (string.IsNullOrEmpty(soundPath))
			{
				soundPath = "event:/UI/Common/Button_Click";
			}
			btn.onClick.AddListener(() =>
			{
				PlayClickSound(soundPath);
			});
		}
	}

	private static void PlayClickSound(string name)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(name, new AudioPlayOptions
		{
			attachTarget = GameUtility.mainCamera.transform
		});
	}

	public static void SetBtnClick(this ActButton btn, UnityAction onClickEvent, string soundPath = "")
	{
		if (!(btn == null))
		{
			btn.OnClick.RemoveAllListeners();
			if (onClickEvent != null)
			{
				btn.OnClick.AddListener(onClickEvent.Invoke);
			}
			if (!string.IsNullOrEmpty(soundPath))
			{
				btn.SetButtonSound(soundPath);
			}
		}
	}

	public static int StrLength(string inputString)
	{
		ASCIIEncoding aSCIIEncoding = new ASCIIEncoding();
		int num = 0;
		byte[] bytes = aSCIIEncoding.GetBytes(inputString);
		for (int i = 0; i < bytes.Length; i++)
		{
			num = ((bytes[i] != 63) ? (num + 1) : (num + 2));
		}
		return num;
	}

	[Obsolete("请使用GameStart.ReturnLegalSafeAreaDefaultValue")]
	public static float ReturnLegalSafeAreaDefaultValue()
	{
		float num = ((float)Screen.width - Screen.safeArea.width) / 2f / (float)Screen.width * 1f;
		if (num < 0.15f)
		{
			return num;
		}
		return 0.15f;
	}

	[Obsolete("请使用GameStart.ReturnLegalSafeAreaYDefaultValue")]
	public static float ReturnLegalSafeAreaYDefaultValue()
	{
		float num = ((float)Screen.height - Screen.safeArea.height) / 2f / (float)Screen.height * 1f;
		if (num < 0.08f)
		{
			return num;
		}
		return 0.08f;
	}

	public static SkillDetailData GetSkillInfo(int skillGroupId, int level)
	{
		if (skillGroupId == 0 || level == 0)
		{
			return null;
		}
		int[] skillTotalIds = RuntimeConfigs.data.skillGroupDatas[skillGroupId].skillTotalIds;
		if (skillTotalIds.Length > level - 1)
		{
			return CoreUtils.GetData(skillTotalIds[level - 1], RuntimeConfigs.data.skillDetailDatas);
		}
		return CoreUtils.GetData(skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas);
	}

	private static string GetBloodBottleSkillDes(SkillDetailData data, int level)
	{
		if (data == null)
		{
			return null;
		}
		string localizeString = LocalizationUtility.GetLocalizeString("longcommon", RuntimeConfigs.data.skillDetailDatas[data.id].briefDescLocal);
		return CustomTagParser.ReplaceText(data.id, localizeString, level);
	}

	public static string SetBloodBottleSkillDes(BloodBottleData bottle)
	{
		int curLevel = bottle.curLevel;
		int healSkillId = CoreUtils.GetData(bottle.curLevel, RuntimeConfigs.data.potionDatas).healSkillId;
		int wearSkillId = CoreUtils.GetData(bottle.curLevel, RuntimeConfigs.data.potionDatas).wearSkillId;
		int useExtraSkillId = CoreUtils.GetData(bottle.curLevel, RuntimeConfigs.data.potionDatas).useExtraSkillId;
		string bloodBottleSkillDes = GetBloodBottleSkillDes(GetSkillInfo(healSkillId, curLevel), curLevel);
		string bloodBottleSkillDes2 = GetBloodBottleSkillDes(GetSkillInfo(wearSkillId, curLevel), curLevel);
		string bloodBottleSkillDes3 = GetBloodBottleSkillDes(GetSkillInfo(useExtraSkillId, curLevel), curLevel);
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(bloodBottleSkillDes);
		if (!string.IsNullOrEmpty(bloodBottleSkillDes2))
		{
			stringBuilder.Append(",");
			stringBuilder.Append(bloodBottleSkillDes2);
		}
		if (!string.IsNullOrEmpty(bloodBottleSkillDes3))
		{
			stringBuilder.Append(",");
			stringBuilder.Append(bloodBottleSkillDes3);
		}
		return stringBuilder.ToString();
	}

	public static void OpenWebView(string url, bool isPortrait)
	{
		if (string.IsNullOrEmpty(url) && LuminApplication.LogEnabled)
		{
			Debug.LogError("OpenWebView: url is null or empty");
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("open webview : " + url);
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_WEBFORANDROIDIOSMAC, new WebViewData
		{
			Url = url,
			IsPortrait = isPortrait
		});
	}

	public static void OpenGuideTipView(int guideTipId)
	{
		if (guideTipId == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("传进来的tipId为0");
			}
		}
		else
		{
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_GUIDEPROMPT, new GuidePromptTipData
			{
				tipId = guideTipId
			});
		}
	}

	public static void CloseGuideTipView(bool hideNotComplete = false)
	{
		if (GuidePromptTip.guideTipInstance != null)
		{
			if (hideNotComplete)
			{
				GuidePromptTip.guideTipInstance.HideNotComplete();
			}
			else
			{
				Singleton<TipManager>.instance.OnTipClose(GuidePromptTip.guideTipInstance);
			}
		}
	}

	public static void SetSortingLayer(Canvas canvas, int layer)
	{
		if (!canvas)
		{
			return;
		}
		canvas.overrideSorting = true;
		if (layer >= NewUIManager.SortingLayers.Length)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"view : {canvas.name} sorting layer : {layer} is out of range, max sorting layer is {NewUIManager.SortingLayers.Length - 1}");
			}
			layer = NewUIManager.SortingLayers.Length - 1;
		}
		canvas.sortingLayerID = NewUIManager.SortingLayers[layer].id;
	}

	public static void TriggerGuideImageVideoPopUp(int tutorialId)
	{
		if (!Model<TutorialModel>.HasInstance() || !Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialId) || CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			return;
		}
		G.service.TriggerTutorial(tutorialId, (bool b) =>
		{
			if (b)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
				{
					tutorialId = tutorialId
				});
			}
		});
	}

	public static void TriggerGuideTimerComponent(int tutorialId)
	{
		if (!Model<TutorialModel>.HasInstance() || !Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialId) || CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			return;
		}
		G.service.TriggerTutorial(tutorialId, (bool b) =>
		{
			if (b && !TriggerGuideTutorialComponent.EnqueueIfListenerNotReady(tutorialId, 5f))
			{
				TriggerGuideTutorial evt = Singleton<EventManager>.instance.GetEvt<TriggerGuideTutorial>();
				evt.triggerTutorialId = tutorialId;
				evt.duration = 5f;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Trigger_Tutorial, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		});
	}
}
