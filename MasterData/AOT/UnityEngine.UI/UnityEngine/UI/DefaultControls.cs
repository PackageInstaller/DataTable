using System;

namespace UnityEngine.UI;

public static class DefaultControls
{
	public interface IFactoryControls
	{
		GameObject CreateGameObject(string name, params Type[] components);
	}

	private class DefaultRuntimeFactory : IFactoryControls
	{
		public static IFactoryControls Default = new DefaultRuntimeFactory();

		public GameObject CreateGameObject(string name, params Type[] components)
		{
			return new GameObject(name, components);
		}
	}

	public struct Resources
	{
		public Sprite standard;

		public Sprite background;

		public Sprite inputField;

		public Sprite knob;

		public Sprite checkmark;

		public Sprite dropdown;

		public Sprite mask;
	}

	private static IFactoryControls m_CurrentFactory = DefaultRuntimeFactory.Default;

	private const float kWidth = 160f;

	private const float kThickHeight = 30f;

	private const float kThinHeight = 20f;

	private static Vector2 s_ThickElementSize = new Vector2(160f, 30f);

	private static Vector2 s_ThinElementSize = new Vector2(160f, 20f);

	private static Vector2 s_ImageElementSize = new Vector2(100f, 100f);

	private static Color s_DefaultSelectableColor = new Color(1f, 1f, 1f, 1f);

	private static Color s_PanelColor = new Color(1f, 1f, 1f, 0.392f);

	private static Color s_TextColor = new Color(50f / 255f, 50f / 255f, 50f / 255f, 1f);

	public static IFactoryControls factory => m_CurrentFactory;

	private static GameObject CreateUIElementRoot(string name, Vector2 size, params Type[] components)
	{
		GameObject gameObject = factory.CreateGameObject(name, components);
		gameObject.GetComponent<RectTransform>().sizeDelta = size;
		return gameObject;
	}

	private static GameObject CreateUIObject(string name, GameObject parent, params Type[] components)
	{
		GameObject gameObject = factory.CreateGameObject(name, components);
		SetParentAndAlign(gameObject, parent);
		return gameObject;
	}

	private static void SetDefaultTextValues(Text lbl)
	{
		lbl.color = s_TextColor;
		if (lbl.font == null)
		{
			lbl.AssignDefaultFont();
		}
	}

	private static void SetDefaultColorTransitionValues(Selectable slider)
	{
		ColorBlock colors = slider.colors;
		colors.highlightedColor = new Color(0.882f, 0.882f, 0.882f);
		colors.pressedColor = new Color(0.698f, 0.698f, 0.698f);
		colors.disabledColor = new Color(0.521f, 0.521f, 0.521f);
	}

	private static void SetParentAndAlign(GameObject child, GameObject parent)
	{
		if (!(parent == null))
		{
			child.transform.SetParent(parent.transform, worldPositionStays: false);
			SetLayerRecursively(child, parent.layer);
		}
	}

	private static void SetLayerRecursively(GameObject go, int layer)
	{
		go.layer = layer;
		Transform transform = go.transform;
		for (int i = 0; i < transform.childCount; i++)
		{
			SetLayerRecursively(transform.GetChild(i).gameObject, layer);
		}
	}

	public static GameObject CreatePanel(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Panel", s_ThickElementSize, typeof(Image));
		RectTransform component = gameObject.GetComponent<RectTransform>();
		component.anchorMin = Vector2.zero;
		component.anchorMax = Vector2.one;
		component.anchoredPosition = Vector2.zero;
		component.sizeDelta = Vector2.zero;
		Image component2 = gameObject.GetComponent<Image>();
		component2.sprite = resources.background;
		component2.type = Image.Type.Sliced;
		component2.color = s_PanelColor;
		return gameObject;
	}

	public static GameObject CreateButton(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Button (Legacy)", s_ThickElementSize, typeof(Image), typeof(Button));
		GameObject gameObject2 = CreateUIObject("Text (Legacy)", gameObject, typeof(Text));
		Image component = gameObject.GetComponent<Image>();
		component.sprite = resources.standard;
		component.type = Image.Type.Sliced;
		component.color = s_DefaultSelectableColor;
		SetDefaultColorTransitionValues(gameObject.GetComponent<Button>());
		Text component2 = gameObject2.GetComponent<Text>();
		component2.text = "Button";
		component2.alignment = TextAnchor.MiddleCenter;
		SetDefaultTextValues(component2);
		RectTransform component3 = gameObject2.GetComponent<RectTransform>();
		component3.anchorMin = Vector2.zero;
		component3.anchorMax = Vector2.one;
		component3.sizeDelta = Vector2.zero;
		return gameObject;
	}

	public static GameObject CreateText(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Text (Legacy)", s_ThickElementSize, typeof(Text));
		Text component = gameObject.GetComponent<Text>();
		component.text = "New Text";
		SetDefaultTextValues(component);
		return gameObject;
	}

	public static GameObject CreateImage(Resources resources)
	{
		return CreateUIElementRoot("Image", s_ImageElementSize, typeof(Image));
	}

	public static GameObject CreateRawImage(Resources resources)
	{
		return CreateUIElementRoot("RawImage", s_ImageElementSize, typeof(RawImage));
	}

	public static GameObject CreateSlider(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Slider", s_ThinElementSize, typeof(Slider));
		GameObject gameObject2 = CreateUIObject("Background", gameObject, typeof(Image));
		GameObject gameObject3 = CreateUIObject("Fill Area", gameObject, typeof(RectTransform));
		GameObject gameObject4 = CreateUIObject("Fill", gameObject3, typeof(Image));
		GameObject gameObject5 = CreateUIObject("Handle Slide Area", gameObject, typeof(RectTransform));
		GameObject gameObject6 = CreateUIObject("Handle", gameObject5, typeof(Image));
		Image component = gameObject2.GetComponent<Image>();
		component.sprite = resources.background;
		component.type = Image.Type.Sliced;
		component.color = s_DefaultSelectableColor;
		RectTransform component2 = gameObject2.GetComponent<RectTransform>();
		component2.anchorMin = new Vector2(0f, 0.25f);
		component2.anchorMax = new Vector2(1f, 0.75f);
		component2.sizeDelta = new Vector2(0f, 0f);
		RectTransform component3 = gameObject3.GetComponent<RectTransform>();
		component3.anchorMin = new Vector2(0f, 0.25f);
		component3.anchorMax = new Vector2(1f, 0.75f);
		component3.anchoredPosition = new Vector2(-5f, 0f);
		component3.sizeDelta = new Vector2(-20f, 0f);
		Image component4 = gameObject4.GetComponent<Image>();
		component4.sprite = resources.standard;
		component4.type = Image.Type.Sliced;
		component4.color = s_DefaultSelectableColor;
		gameObject4.GetComponent<RectTransform>().sizeDelta = new Vector2(10f, 0f);
		RectTransform component5 = gameObject5.GetComponent<RectTransform>();
		component5.sizeDelta = new Vector2(-20f, 0f);
		component5.anchorMin = new Vector2(0f, 0f);
		component5.anchorMax = new Vector2(1f, 1f);
		Image component6 = gameObject6.GetComponent<Image>();
		component6.sprite = resources.knob;
		component6.color = s_DefaultSelectableColor;
		gameObject6.GetComponent<RectTransform>().sizeDelta = new Vector2(20f, 0f);
		Slider component7 = gameObject.GetComponent<Slider>();
		component7.fillRect = gameObject4.GetComponent<RectTransform>();
		component7.handleRect = gameObject6.GetComponent<RectTransform>();
		component7.targetGraphic = component6;
		component7.direction = Slider.Direction.LeftToRight;
		SetDefaultColorTransitionValues(component7);
		return gameObject;
	}

	public static GameObject CreateScrollbar(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Scrollbar", s_ThinElementSize, typeof(Image), typeof(Scrollbar));
		GameObject gameObject2 = CreateUIObject("Sliding Area", gameObject, typeof(RectTransform));
		GameObject gameObject3 = CreateUIObject("Handle", gameObject2, typeof(Image));
		Image component = gameObject.GetComponent<Image>();
		component.sprite = resources.background;
		component.type = Image.Type.Sliced;
		component.color = s_DefaultSelectableColor;
		Image component2 = gameObject3.GetComponent<Image>();
		component2.sprite = resources.standard;
		component2.type = Image.Type.Sliced;
		component2.color = s_DefaultSelectableColor;
		RectTransform component3 = gameObject2.GetComponent<RectTransform>();
		component3.sizeDelta = new Vector2(-20f, -20f);
		component3.anchorMin = Vector2.zero;
		component3.anchorMax = Vector2.one;
		RectTransform component4 = gameObject3.GetComponent<RectTransform>();
		component4.sizeDelta = new Vector2(20f, 20f);
		Scrollbar component5 = gameObject.GetComponent<Scrollbar>();
		component5.handleRect = component4;
		component5.targetGraphic = component2;
		SetDefaultColorTransitionValues(component5);
		return gameObject;
	}

	public static GameObject CreateToggle(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Toggle", s_ThinElementSize, typeof(Toggle));
		GameObject gameObject2 = CreateUIObject("Background", gameObject, typeof(Image));
		GameObject gameObject3 = CreateUIObject("Checkmark", gameObject2, typeof(Image));
		GameObject gameObject4 = CreateUIObject("Label", gameObject, typeof(Text));
		Toggle component = gameObject.GetComponent<Toggle>();
		component.isOn = true;
		Image component2 = gameObject2.GetComponent<Image>();
		component2.sprite = resources.standard;
		component2.type = Image.Type.Sliced;
		component2.color = s_DefaultSelectableColor;
		Image component3 = gameObject3.GetComponent<Image>();
		component3.sprite = resources.checkmark;
		Text component4 = gameObject4.GetComponent<Text>();
		component4.text = "Toggle";
		SetDefaultTextValues(component4);
		component.graphic = component3;
		component.targetGraphic = component2;
		SetDefaultColorTransitionValues(component);
		RectTransform component5 = gameObject2.GetComponent<RectTransform>();
		component5.anchorMin = new Vector2(0f, 1f);
		component5.anchorMax = new Vector2(0f, 1f);
		component5.anchoredPosition = new Vector2(10f, -10f);
		component5.sizeDelta = new Vector2(20f, 20f);
		RectTransform component6 = gameObject3.GetComponent<RectTransform>();
		component6.anchorMin = new Vector2(0.5f, 0.5f);
		component6.anchorMax = new Vector2(0.5f, 0.5f);
		component6.anchoredPosition = Vector2.zero;
		component6.sizeDelta = new Vector2(20f, 20f);
		RectTransform component7 = gameObject4.GetComponent<RectTransform>();
		component7.anchorMin = new Vector2(0f, 0f);
		component7.anchorMax = new Vector2(1f, 1f);
		component7.offsetMin = new Vector2(23f, 1f);
		component7.offsetMax = new Vector2(-5f, -2f);
		return gameObject;
	}

	public static GameObject CreateInputField(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("InputField (Legacy)", s_ThickElementSize, typeof(Image), typeof(InputField));
		GameObject gameObject2 = CreateUIObject("Placeholder", gameObject, typeof(Text));
		GameObject gameObject3 = CreateUIObject("Text (Legacy)", gameObject, typeof(Text));
		Image component = gameObject.GetComponent<Image>();
		component.sprite = resources.inputField;
		component.type = Image.Type.Sliced;
		component.color = s_DefaultSelectableColor;
		InputField component2 = gameObject.GetComponent<InputField>();
		SetDefaultColorTransitionValues(component2);
		Text component3 = gameObject3.GetComponent<Text>();
		component3.text = "";
		component3.supportRichText = false;
		SetDefaultTextValues(component3);
		Text component4 = gameObject2.GetComponent<Text>();
		component4.text = "Enter text...";
		component4.fontStyle = FontStyle.Italic;
		Color color = component3.color;
		color.a *= 0.5f;
		component4.color = color;
		RectTransform component5 = gameObject3.GetComponent<RectTransform>();
		component5.anchorMin = Vector2.zero;
		component5.anchorMax = Vector2.one;
		component5.sizeDelta = Vector2.zero;
		component5.offsetMin = new Vector2(10f, 6f);
		component5.offsetMax = new Vector2(-10f, -7f);
		RectTransform component6 = gameObject2.GetComponent<RectTransform>();
		component6.anchorMin = Vector2.zero;
		component6.anchorMax = Vector2.one;
		component6.sizeDelta = Vector2.zero;
		component6.offsetMin = new Vector2(10f, 6f);
		component6.offsetMax = new Vector2(-10f, -7f);
		component2.textComponent = component3;
		component2.placeholder = component4;
		return gameObject;
	}

	public static GameObject CreateDropdown(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Dropdown (Legacy)", s_ThickElementSize, typeof(Image), typeof(Dropdown));
		GameObject gameObject2 = CreateUIObject("Label", gameObject, typeof(Text));
		GameObject gameObject3 = CreateUIObject("Arrow", gameObject, typeof(Image));
		GameObject gameObject4 = CreateUIObject("Template", gameObject, typeof(Image), typeof(ScrollRect));
		GameObject gameObject5 = CreateUIObject("Viewport", gameObject4, typeof(Image), typeof(Mask));
		GameObject gameObject6 = CreateUIObject("Content", gameObject5, typeof(RectTransform));
		GameObject gameObject7 = CreateUIObject("Item", gameObject6, typeof(Toggle));
		GameObject gameObject8 = CreateUIObject("Item Background", gameObject7, typeof(Image));
		GameObject gameObject9 = CreateUIObject("Item Checkmark", gameObject7, typeof(Image));
		GameObject gameObject10 = CreateUIObject("Item Label", gameObject7, typeof(Text));
		GameObject gameObject11 = CreateScrollbar(resources);
		gameObject11.name = "Scrollbar";
		SetParentAndAlign(gameObject11, gameObject4);
		Scrollbar component = gameObject11.GetComponent<Scrollbar>();
		component.SetDirection(Scrollbar.Direction.BottomToTop, includeRectLayouts: true);
		RectTransform component2 = gameObject11.GetComponent<RectTransform>();
		component2.anchorMin = Vector2.right;
		component2.anchorMax = Vector2.one;
		component2.pivot = Vector2.one;
		component2.sizeDelta = new Vector2(component2.sizeDelta.x, 0f);
		Text component3 = gameObject10.GetComponent<Text>();
		SetDefaultTextValues(component3);
		component3.alignment = TextAnchor.MiddleLeft;
		Image component4 = gameObject8.GetComponent<Image>();
		component4.color = new Color32(245, 245, 245, byte.MaxValue);
		Image component5 = gameObject9.GetComponent<Image>();
		component5.sprite = resources.checkmark;
		Toggle component6 = gameObject7.GetComponent<Toggle>();
		component6.targetGraphic = component4;
		component6.graphic = component5;
		component6.isOn = true;
		Image component7 = gameObject4.GetComponent<Image>();
		component7.sprite = resources.standard;
		component7.type = Image.Type.Sliced;
		ScrollRect component8 = gameObject4.GetComponent<ScrollRect>();
		component8.content = gameObject6.GetComponent<RectTransform>();
		component8.viewport = gameObject5.GetComponent<RectTransform>();
		component8.horizontal = false;
		component8.movementType = ScrollRect.MovementType.Clamped;
		component8.verticalScrollbar = component;
		component8.verticalScrollbarVisibility = ScrollRect.ScrollbarVisibility.AutoHideAndExpandViewport;
		component8.verticalScrollbarSpacing = -3f;
		gameObject5.GetComponent<Mask>().showMaskGraphic = false;
		Image component9 = gameObject5.GetComponent<Image>();
		component9.sprite = resources.mask;
		component9.type = Image.Type.Sliced;
		Text component10 = gameObject2.GetComponent<Text>();
		SetDefaultTextValues(component10);
		component10.alignment = TextAnchor.MiddleLeft;
		gameObject3.GetComponent<Image>().sprite = resources.dropdown;
		Image component11 = gameObject.GetComponent<Image>();
		component11.sprite = resources.standard;
		component11.color = s_DefaultSelectableColor;
		component11.type = Image.Type.Sliced;
		Dropdown component12 = gameObject.GetComponent<Dropdown>();
		component12.targetGraphic = component11;
		SetDefaultColorTransitionValues(component12);
		component12.template = gameObject4.GetComponent<RectTransform>();
		component12.captionText = component10;
		component12.itemText = component3;
		component3.text = "Option A";
		component12.options.Add(new Dropdown.OptionData
		{
			text = "Option A"
		});
		component12.options.Add(new Dropdown.OptionData
		{
			text = "Option B"
		});
		component12.options.Add(new Dropdown.OptionData
		{
			text = "Option C"
		});
		component12.RefreshShownValue();
		RectTransform component13 = gameObject2.GetComponent<RectTransform>();
		component13.anchorMin = Vector2.zero;
		component13.anchorMax = Vector2.one;
		component13.offsetMin = new Vector2(10f, 6f);
		component13.offsetMax = new Vector2(-25f, -7f);
		RectTransform component14 = gameObject3.GetComponent<RectTransform>();
		component14.anchorMin = new Vector2(1f, 0.5f);
		component14.anchorMax = new Vector2(1f, 0.5f);
		component14.sizeDelta = new Vector2(20f, 20f);
		component14.anchoredPosition = new Vector2(-15f, 0f);
		RectTransform component15 = gameObject4.GetComponent<RectTransform>();
		component15.anchorMin = new Vector2(0f, 0f);
		component15.anchorMax = new Vector2(1f, 0f);
		component15.pivot = new Vector2(0.5f, 1f);
		component15.anchoredPosition = new Vector2(0f, 2f);
		component15.sizeDelta = new Vector2(0f, 150f);
		RectTransform component16 = gameObject5.GetComponent<RectTransform>();
		component16.anchorMin = new Vector2(0f, 0f);
		component16.anchorMax = new Vector2(1f, 1f);
		component16.sizeDelta = new Vector2(-18f, 0f);
		component16.pivot = new Vector2(0f, 1f);
		RectTransform component17 = gameObject6.GetComponent<RectTransform>();
		component17.anchorMin = new Vector2(0f, 1f);
		component17.anchorMax = new Vector2(1f, 1f);
		component17.pivot = new Vector2(0.5f, 1f);
		component17.anchoredPosition = new Vector2(0f, 0f);
		component17.sizeDelta = new Vector2(0f, 28f);
		RectTransform component18 = gameObject7.GetComponent<RectTransform>();
		component18.anchorMin = new Vector2(0f, 0.5f);
		component18.anchorMax = new Vector2(1f, 0.5f);
		component18.sizeDelta = new Vector2(0f, 20f);
		RectTransform component19 = gameObject8.GetComponent<RectTransform>();
		component19.anchorMin = Vector2.zero;
		component19.anchorMax = Vector2.one;
		component19.sizeDelta = Vector2.zero;
		RectTransform component20 = gameObject9.GetComponent<RectTransform>();
		component20.anchorMin = new Vector2(0f, 0.5f);
		component20.anchorMax = new Vector2(0f, 0.5f);
		component20.sizeDelta = new Vector2(20f, 20f);
		component20.anchoredPosition = new Vector2(10f, 0f);
		RectTransform component21 = gameObject10.GetComponent<RectTransform>();
		component21.anchorMin = Vector2.zero;
		component21.anchorMax = Vector2.one;
		component21.offsetMin = new Vector2(20f, 1f);
		component21.offsetMax = new Vector2(-10f, -2f);
		gameObject4.SetActive(value: false);
		return gameObject;
	}

	public static GameObject CreateScrollView(Resources resources)
	{
		GameObject gameObject = CreateUIElementRoot("Scroll View", new Vector2(200f, 200f), typeof(Image), typeof(ScrollRect));
		GameObject gameObject2 = CreateUIObject("Viewport", gameObject, typeof(Image), typeof(Mask));
		GameObject gameObject3 = CreateUIObject("Content", gameObject2, typeof(RectTransform));
		GameObject gameObject4 = CreateScrollbar(resources);
		gameObject4.name = "Scrollbar Horizontal";
		SetParentAndAlign(gameObject4, gameObject);
		RectTransform component = gameObject4.GetComponent<RectTransform>();
		component.anchorMin = Vector2.zero;
		component.anchorMax = Vector2.right;
		component.pivot = Vector2.zero;
		component.sizeDelta = new Vector2(0f, component.sizeDelta.y);
		GameObject gameObject5 = CreateScrollbar(resources);
		gameObject5.name = "Scrollbar Vertical";
		SetParentAndAlign(gameObject5, gameObject);
		gameObject5.GetComponent<Scrollbar>().SetDirection(Scrollbar.Direction.BottomToTop, includeRectLayouts: true);
		RectTransform component2 = gameObject5.GetComponent<RectTransform>();
		component2.anchorMin = Vector2.right;
		component2.anchorMax = Vector2.one;
		component2.pivot = Vector2.one;
		component2.sizeDelta = new Vector2(component2.sizeDelta.x, 0f);
		RectTransform component3 = gameObject2.GetComponent<RectTransform>();
		component3.anchorMin = Vector2.zero;
		component3.anchorMax = Vector2.one;
		component3.sizeDelta = Vector2.zero;
		component3.pivot = Vector2.up;
		RectTransform component4 = gameObject3.GetComponent<RectTransform>();
		component4.anchorMin = Vector2.up;
		component4.anchorMax = Vector2.one;
		component4.sizeDelta = new Vector2(0f, 300f);
		component4.pivot = Vector2.up;
		ScrollRect component5 = gameObject.GetComponent<ScrollRect>();
		component5.content = component4;
		component5.viewport = component3;
		component5.horizontalScrollbar = gameObject4.GetComponent<Scrollbar>();
		component5.verticalScrollbar = gameObject5.GetComponent<Scrollbar>();
		component5.horizontalScrollbarVisibility = ScrollRect.ScrollbarVisibility.AutoHideAndExpandViewport;
		component5.verticalScrollbarVisibility = ScrollRect.ScrollbarVisibility.AutoHideAndExpandViewport;
		component5.horizontalScrollbarSpacing = -3f;
		component5.verticalScrollbarSpacing = -3f;
		Image component6 = gameObject.GetComponent<Image>();
		component6.sprite = resources.background;
		component6.type = Image.Type.Sliced;
		component6.color = s_PanelColor;
		gameObject2.GetComponent<Mask>().showMaskGraphic = false;
		Image component7 = gameObject2.GetComponent<Image>();
		component7.sprite = resources.mask;
		component7.type = Image.Type.Sliced;
		return gameObject;
	}
}
