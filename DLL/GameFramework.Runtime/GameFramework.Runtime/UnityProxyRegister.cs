using System;
using System.Reflection;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.UIElements;

namespace GameFramework.Runtime;

public class UnityProxyRegister
{
	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void Initialize()
	{
		Register("localPosition", (Transform t) => t.localPosition, delegate(Transform t, Vector3 v)
		{
			t.localPosition = v;
		});
		Register("eulerAngles", (Transform t) => t.eulerAngles, delegate(Transform t, Vector3 v)
		{
			t.eulerAngles = v;
		});
		Register("localEulerAngles", (Transform t) => t.localEulerAngles, delegate(Transform t, Vector3 v)
		{
			t.localEulerAngles = v;
		});
		Register("right", (Transform t) => t.right, delegate(Transform t, Vector3 v)
		{
			t.right = v;
		});
		Register("up", (Transform t) => t.up, delegate(Transform t, Vector3 v)
		{
			t.up = v;
		});
		Register("forward", (Transform t) => t.forward, delegate(Transform t, Vector3 v)
		{
			t.forward = v;
		});
		Register("position", (Transform t) => t.position, delegate(Transform t, Vector3 v)
		{
			t.position = v;
		});
		Register("localScale", (Transform t) => t.localScale, delegate(Transform t, Vector3 v)
		{
			t.localScale = v;
		});
		Register("lossyScale", (Transform t) => t.lossyScale, null);
		Register("rotation", (Transform t) => t.rotation, delegate(Transform t, Quaternion v)
		{
			t.rotation = v;
		});
		Register("localRotation", (Transform t) => t.localRotation, delegate(Transform t, Quaternion v)
		{
			t.localRotation = v;
		});
		Register("worldToLocalMatrix", (Transform t) => t.worldToLocalMatrix, null);
		Register("localToWorldMatrix", (Transform t) => t.localToWorldMatrix, null);
		Register("childCount", (Transform t) => t.childCount, null);
		Register("offsetMax", (RectTransform t) => t.offsetMax, delegate(RectTransform t, Vector2 v)
		{
			t.offsetMax = v;
		});
		Register("offsetMin", (RectTransform t) => t.offsetMin, delegate(RectTransform t, Vector2 v)
		{
			t.offsetMin = v;
		});
		Register("pivot", (RectTransform t) => t.pivot, delegate(RectTransform t, Vector2 v)
		{
			t.pivot = v;
		});
		Register("sizeDelta", (RectTransform t) => t.sizeDelta, delegate(RectTransform t, Vector2 v)
		{
			t.sizeDelta = v;
		});
		Register("anchoredPosition", (RectTransform t) => t.anchoredPosition, delegate(RectTransform t, Vector2 v)
		{
			t.anchoredPosition = v;
		});
		Register("anchorMax", (RectTransform t) => t.anchorMax, delegate(RectTransform t, Vector2 v)
		{
			t.anchorMax = v;
		});
		Register("anchoredPosition3D", (RectTransform t) => t.anchoredPosition3D, delegate(RectTransform t, Vector3 v)
		{
			t.anchoredPosition3D = v;
		});
		Register("anchorMin", (RectTransform t) => t.anchorMin, delegate(RectTransform t, Vector2 v)
		{
			t.anchorMin = v;
		});
		Register("rect", (RectTransform t) => t.rect, null);
		Register("activeSelf", (GameObject t) => t.activeSelf, delegate(GameObject t, bool v)
		{
			t.SetActive(v);
		});
		Register("layer", (GameObject t) => t.layer, delegate(GameObject t, int v)
		{
			t.layer = v;
		});
		Register("tag", (GameObject t) => t.tag, delegate(GameObject t, string v)
		{
			t.tag = v;
		});
		Register("enabled", (Behaviour t) => t.enabled, delegate(Behaviour t, bool v)
		{
			t.enabled = v;
		});
		Register("isActiveAndEnabled", (Behaviour t) => t.isActiveAndEnabled, null);
		Register("tag", (Component t) => t.tag, delegate(Component t, string v)
		{
			t.tag = v;
		});
		Register("planeDistance", (Canvas t) => t.planeDistance, delegate(Canvas t, float v)
		{
			t.planeDistance = v;
		});
		Register("sortingLayerName", (Canvas t) => t.sortingLayerName, delegate(Canvas t, string v)
		{
			t.sortingLayerName = v;
		});
		Register("sortingLayerID", (Canvas t) => t.sortingLayerID, delegate(Canvas t, int v)
		{
			t.sortingLayerID = v;
		});
		Register("renderOrder", (Canvas t) => t.renderOrder, null);
		Register("alpha", (CanvasGroup t) => t.alpha, delegate(CanvasGroup t, float v)
		{
			t.alpha = v;
		});
		Register("interactable", (CanvasGroup t) => t.interactable, delegate(CanvasGroup t, bool v)
		{
			t.interactable = v;
		});
		Register("blocksRaycasts", (CanvasGroup t) => t.blocksRaycasts, delegate(CanvasGroup t, bool v)
		{
			t.blocksRaycasts = v;
		});
		Register("ignoreParentGroups", (CanvasGroup t) => t.ignoreParentGroups, delegate(CanvasGroup t, bool v)
		{
			t.ignoreParentGroups = v;
		});
		Register("ignoreReversedGraphics", (GraphicRaycaster t) => t.ignoreReversedGraphics, delegate(GraphicRaycaster t, bool v)
		{
			t.ignoreReversedGraphics = v;
		});
		Register("showMaskGraphic", (Mask t) => t.showMaskGraphic, delegate(Mask t, bool v)
		{
			t.showMaskGraphic = v;
		});
		Register("spriteState", (Selectable t) => t.spriteState, delegate(Selectable t, SpriteState v)
		{
			t.spriteState = v;
		});
		Register("colors", (Selectable t) => t.colors, delegate(Selectable t, ColorBlock v)
		{
			t.colors = v;
		});
		Register("interactable", (Selectable t) => t.interactable, delegate(Selectable t, bool v)
		{
			t.interactable = v;
		});
		Register("onClick", (Button t) => t.onClick, null);
		Register("onValueChanged", (InputField t) => t.onValueChanged, null);
		Register("onEndEdit", (InputField t) => t.onEndEdit, null);
		Register("onSubmit", (InputField t) => t.onSubmit, null);
		Register("text", (InputField t) => t.text, delegate(InputField t, string v)
		{
			t.text = v;
		});
		Register("onValueChanged", (Scrollbar t) => t.onValueChanged, null);
		Register("size", (Scrollbar t) => t.size, delegate(Scrollbar t, float v)
		{
			t.size = v;
		});
		Register("value", (Scrollbar t) => t.value, delegate(Scrollbar t, float v)
		{
			t.value = v;
		});
		Register("onValueChanged", (Slider t) => t.onValueChanged, null);
		Register("value", (Slider t) => t.value, delegate(Slider t, float v)
		{
			t.value = v;
		});
		Register("maxValue", (Slider t) => t.maxValue, delegate(Slider t, float v)
		{
			t.maxValue = v;
		});
		Register("minValue", (Slider t) => t.minValue, delegate(Slider t, float v)
		{
			t.minValue = v;
		});
		Register("value", (Dropdown t) => t.value, delegate(Dropdown t, int v)
		{
			t.value = v;
		});
		Register("onValueChanged", (Dropdown t) => t.onValueChanged, null);
		Register("text", (Text t) => t.text, delegate(Text t, string v)
		{
			t.text = v;
		});
		Register("fontSize", (Text t) => t.fontSize, delegate(Text t, int v)
		{
			t.fontSize = v;
		});
		Register("isOn", (Toggle t) => t.isOn, delegate(Toggle t, bool v)
		{
			t.isOn = v;
		});
		Register("onValueChanged", (Toggle t) => t.onValueChanged, delegate(Toggle t, Toggle.ToggleEvent v)
		{
			t.onValueChanged = v;
		});
		Register("allowSwitchOff", (ToggleGroup t) => t.allowSwitchOff, delegate(ToggleGroup t, bool v)
		{
			t.allowSwitchOff = v;
		});
		Register("enabledSelf", (VisualElement t) => t.enabledSelf, delegate(VisualElement t, bool v)
		{
			t.SetEnabled(v);
		});
		Register("visible", (VisualElement t) => t.visible, delegate(VisualElement t, bool v)
		{
			t.visible = v;
		});
		Register("value", (TextField t) => ((BaseField<string>)(object)t).value, delegate(TextField t, string v)
		{
			((BaseField<string>)(object)t).SetValueWithoutNotify(v);
		});
		Register("value", (Toggle t) => ((BaseField<bool>)(object)t).value, delegate(Toggle t, bool v)
		{
			((BaseField<bool>)(object)t).SetValueWithoutNotify(v);
		});
		Register("value", (AbstractProgressBar t) => t.value, delegate(AbstractProgressBar t, float v)
		{
			t.SetValueWithoutNotify(v);
		});
	}

	private static void Register<T, TValue>(string name, Func<T, TValue> getter, Action<T, TValue> setter)
	{
		PropertyInfo property = typeof(T).GetProperty(name);
		if ((object)property != null)
		{
			ProxyFactory.Default.Register(new ProxyPropertyInfo<T, TValue>(name, getter, setter));
			return;
		}
		FieldInfo field = typeof(T).GetField(name);
		if ((object)field != null)
		{
			ProxyFactory.Default.Register(new ProxyFieldInfo<T, TValue>(name, getter, setter));
			return;
		}
		throw new Exception($"Not found the property or field named '{name}' in {typeof(T).Name} type");
	}
}
