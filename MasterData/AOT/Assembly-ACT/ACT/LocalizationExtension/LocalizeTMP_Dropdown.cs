using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Sound;
using ACT.UI;
using ACT.ViewControl;
using DG.Tweening;
using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.LocalizationExtension;

[AddComponentMenu("UI/Localize Dropdown - TextMeshPro", 35)]
[RequireComponent(typeof(RectTransform))]
public class LocalizeTMP_Dropdown : Selectable, IPointerClickHandler, IEventSystemHandler, ISubmitHandler, ICancelHandler
{
	public class DropdownItem : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, ICancelHandler
	{
		[SerializeField]
		private LocalizeStringEvent m_Text;

		[SerializeField]
		private Image m_Image;

		[SerializeField]
		private RectTransform m_RectTransform;

		[SerializeField]
		private Toggle m_Toggle;

		public LocalizeStringEvent text
		{
			get
			{
				return m_Text;
			}
			set
			{
				m_Text = value;
			}
		}

		public Image image
		{
			get
			{
				return m_Image;
			}
			set
			{
				m_Image = value;
			}
		}

		public RectTransform rectTransform
		{
			get
			{
				return m_RectTransform;
			}
			set
			{
				m_RectTransform = value;
			}
		}

		public Toggle toggle
		{
			get
			{
				return m_Toggle;
			}
			set
			{
				m_Toggle = value;
			}
		}

		public virtual void OnPointerEnter(PointerEventData eventData)
		{
			EventSystem.current.SetSelectedGameObject(gameObject);
		}

		public virtual void OnCancel(BaseEventData eventData)
		{
			LocalizeTMP_Dropdown componentInParent = GetComponentInParent<LocalizeTMP_Dropdown>();
			if ((bool)componentInParent)
			{
				componentInParent.Hide();
			}
		}
	}

	[Serializable]
	public class OptionData
	{
		[SerializeField]
		private LocalizedString m_Text;

		[SerializeField]
		private string m_CommonText;

		[SerializeField]
		private string m_RedDefine;

		[SerializeField]
		private Sprite m_Image;

		[SerializeField]
		private object m_CustomData;

		public LocalizedString text
		{
			get
			{
				return m_Text;
			}
			set
			{
				m_Text = value;
			}
		}

		public string CommonText
		{
			get
			{
				return m_CommonText;
			}
			set
			{
				m_CommonText = value;
			}
		}

		public string RedDefine
		{
			get
			{
				return m_RedDefine;
			}
			set
			{
				m_RedDefine = value;
			}
		}

		public Sprite image
		{
			get
			{
				return m_Image;
			}
			set
			{
				m_Image = value;
			}
		}

		public object customData
		{
			get
			{
				return m_CustomData;
			}
			set
			{
				m_CustomData = value;
			}
		}

		public OptionData()
		{
		}

		public OptionData(LocalizedString text)
		{
			this.text = text;
		}

		public OptionData(string text)
		{
			CommonText = text;
		}

		public OptionData(LocalizedString text, string redDefine)
		{
			this.text = text;
			RedDefine = redDefine;
		}

		public OptionData(Sprite image)
		{
			this.image = image;
		}

		public OptionData(LocalizedString text, Sprite image)
		{
			this.text = text;
			this.image = image;
		}
	}

	[Serializable]
	public class OptionDataList
	{
		[SerializeField]
		private List<OptionData> m_Options;

		public List<OptionData> options
		{
			get
			{
				return m_Options;
			}
			set
			{
				m_Options = value;
			}
		}

		public OptionDataList()
		{
			options = new List<OptionData>();
		}
	}

	[Serializable]
	public class DropdownEvent : UnityEvent<int>
	{
	}

	[SerializeField]
	private RectTransform m_Template;

	[SerializeField]
	private LocalizeStringEvent m_CaptionText;

	[SerializeField]
	private GameObject m_Arrow;

	[SerializeField]
	private Image m_CaptionImage;

	[SerializeField]
	private Graphic m_Placeholder;

	[Space]
	public bool m_UseCommonText;

	public bool m_ExpendUp;

	[SerializeField]
	private LocalizeStringEvent m_ItemText;

	[SerializeField]
	private Image m_ItemImage;

	[Space]
	[SerializeField]
	private int m_Value;

	[Space]
	[SerializeField]
	private OptionDataList m_Options = new OptionDataList();

	[Space]
	[Header("音效相关")]
	public AudioEventReference showSound;

	public AudioEventReference hideSound;

	public AudioEventReference itemClickSound;

	[SerializeField]
	private DropdownEvent m_OnValueChanged = new DropdownEvent();

	[SerializeField]
	private UnityEvent m_OnShow = new UnityEvent();

	private UnityEvent m_OnPostShow = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnHide = new UnityEvent();

	[SerializeField]
	private UnityEvent m_OnClick = new UnityEvent();

	[SerializeField]
	private float m_AlphaFadeSpeed = 0.15f;

	private GameObject m_Dropdown;

	private GameObject m_Blocker;

	private List<DropdownItem> m_Items = new List<DropdownItem>();

	private TweenerCore<float, float, FloatOptions> m_AlphaTweenRunner;

	private bool validTemplate;

	private Coroutine m_Coroutine;

	private static OptionData s_NoOptionData = new OptionData();

	private Matrix4x4 m_ReversMatrix = Matrix4x4.Scale(new Vector3(1f, -1f, 1f));

	public RectTransform template
	{
		get
		{
			return m_Template;
		}
		set
		{
			m_Template = value;
			RefreshShownValue();
		}
	}

	public GameObject Arrow
	{
		get
		{
			return m_Arrow;
		}
		set
		{
			m_Arrow = value;
		}
	}

	public LocalizeStringEvent captionText
	{
		get
		{
			return m_CaptionText;
		}
		set
		{
			m_CaptionText = value;
			RefreshShownValue();
		}
	}

	public Image captionImage
	{
		get
		{
			return m_CaptionImage;
		}
		set
		{
			m_CaptionImage = value;
			RefreshShownValue();
		}
	}

	public Graphic placeholder
	{
		get
		{
			return m_Placeholder;
		}
		set
		{
			m_Placeholder = value;
			RefreshShownValue();
		}
	}

	public LocalizeStringEvent itemText
	{
		get
		{
			return m_ItemText;
		}
		set
		{
			m_ItemText = value;
			RefreshShownValue();
		}
	}

	public Image itemImage
	{
		get
		{
			return m_ItemImage;
		}
		set
		{
			m_ItemImage = value;
			RefreshShownValue();
		}
	}

	public List<OptionData> options
	{
		get
		{
			return m_Options.options;
		}
		set
		{
			m_Options.options = value;
			RefreshShownValue();
		}
	}

	public DropdownEvent onValueChanged
	{
		get
		{
			return m_OnValueChanged;
		}
		set
		{
			m_OnValueChanged = value;
		}
	}

	public UnityEvent onShow
	{
		get
		{
			return m_OnShow;
		}
		set
		{
			m_OnShow = value;
		}
	}

	public UnityEvent onPostShow
	{
		get
		{
			return m_OnPostShow;
		}
		set
		{
			m_OnPostShow = value;
		}
	}

	public UnityEvent onHide
	{
		get
		{
			return m_OnHide;
		}
		set
		{
			m_OnHide = value;
		}
	}

	public UnityEvent onClick
	{
		get
		{
			return m_OnClick;
		}
		set
		{
			m_OnClick = value;
		}
	}

	public float alphaFadeSpeed
	{
		get
		{
			return m_AlphaFadeSpeed;
		}
		set
		{
			m_AlphaFadeSpeed = value;
		}
	}

	public int value
	{
		get
		{
			return m_Value;
		}
		set
		{
			SetValue(value);
		}
	}

	public bool IsExpanded => m_Dropdown != null;

	public event Action<OptionData, DropdownItem> onAddItem;

	private void PlayConfiguredSound(AudioEventReference sound)
	{
		if (!sound.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(sound);
		}
	}

	public void SetValueWithoutNotify(int input)
	{
		SetValue(input, sendCallback: false);
	}

	private void SetValue(int value, bool sendCallback = true)
	{
		if (!Application.isPlaying || (value != m_Value && options.Count != 0))
		{
			m_Value = Mathf.Clamp(value, m_Placeholder ? (-1) : 0, options.Count - 1);
			RefreshShownValue();
			if (sendCallback)
			{
				UISystemProfilerApi.AddMarker("Dropdown.value", this);
				m_OnValueChanged.Invoke(m_Value);
			}
		}
	}

	protected LocalizeTMP_Dropdown()
	{
	}

	protected override void Awake()
	{
		if ((bool)m_CaptionImage)
		{
			m_CaptionImage.enabled = m_CaptionImage.sprite != null;
		}
		if ((bool)m_Template)
		{
			m_Template.gameObject.SetActive(value: false);
		}
	}

	protected override void Start()
	{
		base.Start();
		RefreshShownValue();
		if (m_ExpendUp)
		{
			GameObject gameObject = m_Template.gameObject;
			gameObject.GetComponent<RectTransform>().pivot = new Vector2(0.5f, 0f);
			gameObject.GetComponent<RectTransform>().anchorMin = new Vector2(0f, 1f);
			gameObject.GetComponent<RectTransform>().anchorMax = Vector2.one;
			gameObject.GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
		}
	}

	protected override void OnDisable()
	{
		ImmediateDestroyDropdownList();
		if (m_Blocker != null)
		{
			DestroyBlocker(m_Blocker);
		}
		m_Blocker = null;
		base.OnDisable();
	}

	public void RefreshShownValue()
	{
		OptionData optionData = s_NoOptionData;
		if (options.Count > 0 && m_Value >= 0)
		{
			optionData = options[Mathf.Clamp(m_Value, 0, options.Count - 1)];
		}
		if ((bool)m_CaptionText)
		{
			if (optionData != null && m_UseCommonText)
			{
				m_CaptionText.OnUpdateString.Invoke(optionData.CommonText);
			}
			else if (optionData != null && optionData.text != null)
			{
				m_CaptionText.StringReference = optionData.text;
			}
		}
		if ((bool)m_CaptionImage)
		{
			if (optionData != null)
			{
				m_CaptionImage.sprite = optionData.image;
			}
			else
			{
				m_CaptionImage.sprite = null;
			}
			m_CaptionImage.enabled = m_CaptionImage.sprite != null;
		}
		if ((bool)m_Placeholder)
		{
			m_Placeholder.enabled = options.Count == 0 || m_Value == -1;
		}
	}

	public void AddOptions(List<OptionData> options)
	{
		this.options.AddRange(options);
		RefreshShownValue();
	}

	public void AddOptions(List<LocalizedString> options)
	{
		for (int i = 0; i < options.Count; i++)
		{
			this.options.Add(new OptionData(options[i]));
		}
		RefreshShownValue();
	}

	public void AddOptions(List<Sprite> options)
	{
		for (int i = 0; i < options.Count; i++)
		{
			this.options.Add(new OptionData(options[i]));
		}
		RefreshShownValue();
	}

	public void ClearOptions()
	{
		options.Clear();
		m_Value = (m_Placeholder ? (-1) : 0);
		RefreshShownValue();
	}

	private void SetupTemplate()
	{
		validTemplate = false;
		if (!m_Template)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("The dropdown template is not assigned. The template needs to be assigned and must have a child GameObject with a Toggle component serving as the item.", this);
			}
			return;
		}
		GameObject gameObject = m_Template.gameObject;
		gameObject.SetActive(value: true);
		Toggle componentInChildren = m_Template.GetComponentInChildren<Toggle>();
		validTemplate = true;
		if (!componentInChildren || componentInChildren.transform == template)
		{
			validTemplate = false;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("The dropdown template is not valid. The template must have a child GameObject with a Toggle component serving as the item.", template);
			}
		}
		else if (!(componentInChildren.transform.parent is RectTransform))
		{
			validTemplate = false;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("The dropdown template is not valid. The child GameObject with a Toggle component (the item) must have a RectTransform on its parent.", template);
			}
		}
		else if (itemText != null && !itemText.transform.IsChildOf(componentInChildren.transform))
		{
			validTemplate = false;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("The dropdown template is not valid. The Item Text must be on the item GameObject or children of it.", template);
			}
		}
		else if (itemImage != null && !itemImage.transform.IsChildOf(componentInChildren.transform))
		{
			validTemplate = false;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("The dropdown template is not valid. The Item Image must be on the item GameObject or children of it.", template);
			}
		}
		if (!validTemplate)
		{
			gameObject.SetActive(value: false);
			return;
		}
		DropdownItem dropdownItem = componentInChildren.gameObject.AddComponent<DropdownItem>();
		dropdownItem.text = m_ItemText;
		dropdownItem.image = m_ItemImage;
		dropdownItem.toggle = componentInChildren;
		dropdownItem.rectTransform = (RectTransform)componentInChildren.transform;
		Canvas canvas = null;
		Transform parent = m_Template.parent;
		while (parent != null)
		{
			canvas = parent.GetComponent<Canvas>();
			if (canvas != null)
			{
				break;
			}
			parent = parent.parent;
		}
		if (canvas != null)
		{
			Component[] components = canvas.GetComponents<BaseRaycaster>();
			Component[] array = components;
			for (int i = 0; i < array.Length; i++)
			{
				Type type = array[i].GetType();
				if (gameObject.GetComponent(type) == null)
				{
					gameObject.AddComponent(type);
				}
			}
		}
		else
		{
			GetOrAddComponent<GraphicRaycaster>(gameObject);
		}
		GetOrAddComponent<CanvasGroup>(gameObject);
		gameObject.SetActive(value: false);
		validTemplate = true;
	}

	private static T GetOrAddComponent<T>(GameObject go) where T : Component
	{
		T val = go.GetComponent<T>();
		if (!val)
		{
			val = go.AddComponent<T>();
		}
		return val;
	}

	public virtual void OnPointerClick(PointerEventData eventData)
	{
		if (!IsPartOfDropdown(eventData.pointerCurrentRaycast.gameObject))
		{
			Hide();
		}
		onClick?.Invoke();
		Show();
	}

	private bool IsPartOfDropdown(GameObject obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (!obj.transform.IsChildOf(transform))
		{
			return obj == gameObject;
		}
		return true;
	}

	public virtual void OnSubmit(BaseEventData eventData)
	{
		onClick?.Invoke();
		Show();
	}

	public virtual void OnCancel(BaseEventData eventData)
	{
		Hide();
	}

	public void Show()
	{
		if (m_Coroutine != null)
		{
			StopCoroutine(m_Coroutine);
			ImmediateDestroyDropdownList();
		}
		if ((bool)m_Arrow)
		{
			m_Arrow.transform.localScale = m_ReversMatrix * m_Arrow.transform.localScale;
		}
		if (!IsActive() || !IsInteractable() || m_Dropdown != null)
		{
			return;
		}
		List<Canvas> list = ListPool<Canvas>.Get();
		gameObject.GetComponentsInParent(includeInactive: false, list);
		if (list.Count == 0)
		{
			return;
		}
		Canvas canvas = list[list.Count - 1];
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].isRootCanvas)
			{
				canvas = list[i];
				break;
			}
		}
		ListPool<Canvas>.Release(list);
		if (!validTemplate)
		{
			SetupTemplate();
			if (!validTemplate)
			{
				return;
			}
		}
		m_Template.gameObject.SetActive(value: true);
		PlayConfiguredSound(showSound);
		onShow?.Invoke();
		m_Dropdown = CreateDropdownList(m_Template.gameObject);
		m_Dropdown.name = "Dropdown List";
		m_Dropdown.SetActive(value: true);
		RectTransform rectTransform = m_Dropdown.transform as RectTransform;
		rectTransform.SetParent(m_Template.transform.parent, worldPositionStays: false);
		DropdownItem componentInChildren = m_Dropdown.GetComponentInChildren<DropdownItem>();
		RectTransform rectTransform2 = componentInChildren.rectTransform.parent.gameObject.transform as RectTransform;
		componentInChildren.rectTransform.gameObject.SetActive(value: true);
		Rect rect = rectTransform2.rect;
		Rect rect2 = componentInChildren.rectTransform.rect;
		Vector2 vector = rect2.min - rect.min + (Vector2)componentInChildren.rectTransform.localPosition;
		Vector2 vector2 = rect2.max - rect.max + (Vector2)componentInChildren.rectTransform.localPosition;
		Vector2 size = rect2.size;
		m_Items.Clear();
		Toggle toggle = null;
		for (int j = 0; j < options.Count; j++)
		{
			OptionData optionData = options[j];
			DropdownItem item = AddItem(optionData, value == j, componentInChildren, m_Items);
			if (item == null)
			{
				continue;
			}
			if (!string.IsNullOrEmpty(optionData.RedDefine))
			{
				RedDotItem componentInChildren2 = item.gameObject.GetComponentInChildren<RedDotItem>(includeInactive: true);
				if (componentInChildren2 != null)
				{
					componentInChildren2.InitRedDot(optionData.RedDefine);
				}
			}
			item.toggle.isOn = value == j;
			item.toggle.onValueChanged.AddListener((bool x) =>
			{
				OnSelectItem(item.toggle);
			});
			if (item.toggle.isOn)
			{
				item.toggle.Select();
			}
			if (toggle != null)
			{
				Navigation navigation = toggle.navigation;
				Navigation navigation2 = item.toggle.navigation;
				navigation.mode = Navigation.Mode.Explicit;
				navigation2.mode = Navigation.Mode.Explicit;
				navigation.selectOnDown = item.toggle;
				navigation.selectOnRight = item.toggle;
				navigation2.selectOnLeft = toggle;
				navigation2.selectOnUp = toggle;
				toggle.navigation = navigation;
				item.toggle.navigation = navigation2;
			}
			toggle = item.toggle;
		}
		Vector2 sizeDelta = rectTransform2.sizeDelta;
		sizeDelta.y = size.y * (float)m_Items.Count + vector.y - vector2.y;
		rectTransform2.sizeDelta = sizeDelta;
		float num = rectTransform.rect.height - rectTransform2.rect.height;
		if (num > 0f)
		{
			rectTransform.sizeDelta = new Vector2(rectTransform.sizeDelta.x, rectTransform.sizeDelta.y - num);
		}
		Vector3[] array = new Vector3[4];
		rectTransform.GetWorldCorners(array);
		RectTransform rectTransform3 = canvas.transform as RectTransform;
		Rect rect3 = rectTransform3.rect;
		for (int num2 = 0; num2 < 2; num2++)
		{
			bool flag = false;
			for (int num3 = 0; num3 < 4; num3++)
			{
				Vector3 vector3 = rectTransform3.InverseTransformPoint(array[num3]);
				if ((vector3[num2] < rect3.min[num2] && !Mathf.Approximately(vector3[num2], rect3.min[num2])) || (vector3[num2] > rect3.max[num2] && !Mathf.Approximately(vector3[num2], rect3.max[num2])))
				{
					flag = true;
					break;
				}
			}
			if (flag)
			{
				RectTransformUtility.FlipLayoutOnAxis(rectTransform, num2, keepPositioning: false, recursive: false);
			}
		}
		for (int num4 = 0; num4 < m_Items.Count; num4++)
		{
			RectTransform rectTransform4 = m_Items[num4].rectTransform;
			rectTransform4.anchorMin = new Vector2(rectTransform4.anchorMin.x, 0f);
			rectTransform4.anchorMax = new Vector2(rectTransform4.anchorMax.x, 0f);
			rectTransform4.anchoredPosition = new Vector2(rectTransform4.anchoredPosition.x, vector.y + size.y * (float)(m_Items.Count - 1 - num4) + size.y * rectTransform4.pivot.y);
			rectTransform4.sizeDelta = new Vector2(rectTransform4.sizeDelta.x, size.y);
		}
		AlphaFadeList(m_AlphaFadeSpeed, 0f, 1f);
		m_Template.gameObject.SetActive(value: false);
		componentInChildren.gameObject.SetActive(value: false);
		m_Blocker = CreateBlocker(canvas);
		onPostShow?.Invoke();
	}

	protected virtual GameObject CreateBlocker(Canvas rootCanvas)
	{
		GameObject gameObject = new GameObject("Blocker");
		RectTransform rectTransform = gameObject.AddComponent<RectTransform>();
		rectTransform.SetParent(rootCanvas.transform, worldPositionStays: false);
		rectTransform.anchorMin = Vector3.zero;
		rectTransform.anchorMax = Vector3.one;
		rectTransform.sizeDelta = Vector2.zero;
		Canvas canvas = gameObject.AddComponent<Canvas>();
		canvas.overrideSorting = true;
		Canvas component = m_Dropdown.GetComponent<Canvas>();
		canvas.sortingLayerID = component.sortingLayerID;
		canvas.sortingOrder = component.sortingOrder - 1;
		Canvas canvas2 = null;
		Transform parent = m_Template.parent;
		while (parent != null)
		{
			canvas2 = parent.GetComponent<Canvas>();
			if (canvas2 != null)
			{
				break;
			}
			parent = parent.parent;
		}
		if (canvas2 != null)
		{
			Component[] components = canvas2.GetComponents<BaseRaycaster>();
			Component[] array = components;
			for (int i = 0; i < array.Length; i++)
			{
				Type type = array[i].GetType();
				if (gameObject.GetComponent(type) == null)
				{
					gameObject.AddComponent(type);
				}
			}
		}
		else
		{
			GetOrAddComponent<GraphicRaycaster>(gameObject);
		}
		gameObject.AddComponent<Image>().color = Color.clear;
		gameObject.AddComponent<Button>().onClick.AddListener(Hide);
		return gameObject;
	}

	protected virtual void DestroyBlocker(GameObject blocker)
	{
		UnityEngine.Object.Destroy(blocker);
	}

	protected virtual GameObject CreateDropdownList(GameObject template)
	{
		return UnityEngine.Object.Instantiate(template);
	}

	protected virtual void DestroyDropdownList(GameObject dropdownList)
	{
		UnityEngine.Object.Destroy(dropdownList);
	}

	protected virtual DropdownItem CreateItem(DropdownItem itemTemplate)
	{
		return UnityEngine.Object.Instantiate(itemTemplate);
	}

	protected virtual void DestroyItem(DropdownItem item)
	{
	}

	private DropdownItem AddItem(OptionData data, bool selected, DropdownItem itemTemplate, List<DropdownItem> items)
	{
		DropdownItem dropdownItem = CreateItem(itemTemplate);
		dropdownItem.rectTransform.SetParent(itemTemplate.rectTransform.parent, worldPositionStays: false);
		dropdownItem.gameObject.SetActive(value: true);
		ACT.ViewControl.SelectableEx component = dropdownItem.GetComponent<ACT.ViewControl.SelectableEx>();
		if (component != null)
		{
			component.enabled = true;
		}
		if (dropdownItem.toggle != null)
		{
			dropdownItem.toggle.isOn = false;
		}
		if ((bool)dropdownItem.text)
		{
			if (m_UseCommonText)
			{
				dropdownItem.text.OnUpdateString.Invoke(data.CommonText);
			}
			else
			{
				dropdownItem.text.StringReference = data.text;
			}
		}
		if ((bool)dropdownItem.image)
		{
			dropdownItem.image.sprite = data.image;
			dropdownItem.image.enabled = dropdownItem.image.sprite != null;
		}
		onAddItem?.Invoke(data, dropdownItem);
		items.Add(dropdownItem);
		return dropdownItem;
	}

	private void AlphaFadeList(float duration, float alpha)
	{
		CanvasGroup component = m_Dropdown.GetComponent<CanvasGroup>();
		AlphaFadeList(duration, component.alpha, alpha);
	}

	private void AlphaFadeList(float duration, float start, float end)
	{
		if (!end.Equals(start))
		{
			CanvasGroup group = m_Dropdown.GetComponent<CanvasGroup>();
			group.alpha = start;
			m_AlphaTweenRunner = DOTween.To(() => group.alpha, SetAlpha, end, duration);
		}
	}

	private void SetAlpha(float alpha)
	{
		if ((bool)m_Dropdown)
		{
			m_Dropdown.GetComponent<CanvasGroup>().alpha = alpha;
		}
	}

	public void Hide()
	{
		if (m_Coroutine != null)
		{
			return;
		}
		if (m_Dropdown != null)
		{
			PlayConfiguredSound(hideSound);
			AlphaFadeList(m_AlphaFadeSpeed, 0f);
			if (IsActive())
			{
				m_Coroutine = StartCoroutine(DelayedDestroyDropdownList(m_AlphaFadeSpeed));
			}
		}
		if (m_Blocker != null)
		{
			DestroyBlocker(m_Blocker);
		}
		m_Blocker = null;
		Select();
		if ((bool)m_Arrow)
		{
			m_Arrow.transform.localScale = m_ReversMatrix * m_Arrow.transform.localScale;
		}
		onHide?.Invoke();
	}

	private IEnumerator DelayedDestroyDropdownList(float delay)
	{
		yield return new WaitForSecondsRealtime(delay);
		ImmediateDestroyDropdownList();
	}

	private void ImmediateDestroyDropdownList()
	{
		for (int i = 0; i < m_Items.Count; i++)
		{
			if (m_Items[i] != null)
			{
				DestroyItem(m_Items[i]);
			}
		}
		m_Items.Clear();
		if (m_Dropdown != null)
		{
			DestroyDropdownList(m_Dropdown);
		}
		if (m_AlphaTweenRunner != null)
		{
			m_AlphaTweenRunner.Kill();
		}
		m_Dropdown = null;
		m_Coroutine = null;
	}

	private void OnSelectItem(Toggle toggle)
	{
		if (!toggle.isOn)
		{
			toggle.isOn = true;
		}
		int num = -1;
		Transform transform = toggle.transform;
		Transform parent = transform.parent;
		for (int i = 0; i < parent.childCount; i++)
		{
			if (parent.GetChild(i) == transform)
			{
				num = i - 1;
				break;
			}
		}
		if (num >= 0)
		{
			PlayConfiguredSound(itemClickSound);
			value = num;
			Hide();
		}
	}
}
