using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Pool;
using UnityEngine.UI.CoroutineTween;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Legacy/Dropdown", 102)]
[RequireComponent(typeof(RectTransform))]
public class Dropdown : Selectable, IPointerClickHandler, IEventSystemHandler, ISubmitHandler, ICancelHandler
{
	protected internal class DropdownItem : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, ICancelHandler
	{
		[SerializeField]
		private Text m_Text;

		[SerializeField]
		private Image m_Image;

		[SerializeField]
		private RectTransform m_RectTransform;

		[SerializeField]
		private Toggle m_Toggle;

		public Text text
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
			EventSystem.current.SetSelectedGameObject(base.gameObject);
		}

		public virtual void OnCancel(BaseEventData eventData)
		{
			Dropdown componentInParent = GetComponentInParent<Dropdown>();
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
		private string m_Text;

		[SerializeField]
		private Sprite m_Image;

		public string text
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

		public OptionData()
		{
		}

		public OptionData(string text)
		{
			this.text = text;
		}

		public OptionData(Sprite image)
		{
			this.image = image;
		}

		public OptionData(string text, Sprite image)
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
	private Text m_CaptionText;

	[SerializeField]
	private Image m_CaptionImage;

	[Space]
	[SerializeField]
	private Text m_ItemText;

	[SerializeField]
	private Image m_ItemImage;

	[Space]
	[SerializeField]
	private int m_Value;

	[Space]
	[SerializeField]
	private OptionDataList m_Options = new OptionDataList();

	[Space]
	[SerializeField]
	private DropdownEvent m_OnValueChanged = new DropdownEvent();

	[SerializeField]
	private float m_AlphaFadeSpeed = 0.15f;

	private GameObject m_Dropdown;

	private GameObject m_Blocker;

	private List<DropdownItem> m_Items = new List<DropdownItem>();

	private TweenRunner<FloatTween> m_AlphaTweenRunner;

	private bool validTemplate;

	private const int kHighSortingLayer = 30000;

	private static OptionData s_NoOptionData = new OptionData();

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

	public Text captionText
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

	public Text itemText
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
			Set(value);
		}
	}

	public void SetValueWithoutNotify(int input)
	{
		Set(input, sendCallback: false);
	}

	private void Set(int value, bool sendCallback = true)
	{
		if (!Application.isPlaying || (value != m_Value && options.Count != 0))
		{
			m_Value = Mathf.Clamp(value, 0, options.Count - 1);
			RefreshShownValue();
			if (sendCallback)
			{
				UISystemProfilerApi.AddMarker("Dropdown.value", (Object)this);
				m_OnValueChanged.Invoke(m_Value);
			}
		}
	}

	protected Dropdown()
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
		m_AlphaTweenRunner = new TweenRunner<FloatTween>();
		m_AlphaTweenRunner.Init(this);
		base.Start();
		RefreshShownValue();
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
		if (options.Count > 0)
		{
			optionData = options[Mathf.Clamp(m_Value, 0, options.Count - 1)];
		}
		if ((bool)m_CaptionText)
		{
			if (optionData != null && optionData.text != null)
			{
				m_CaptionText.text = optionData.text;
			}
			else
			{
				m_CaptionText.text = "";
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
	}

	public void AddOptions(List<OptionData> options)
	{
		this.options.AddRange(options);
		RefreshShownValue();
	}

	public void AddOptions(List<string> options)
	{
		int count = options.Count;
		for (int i = 0; i < count; i++)
		{
			this.options.Add(new OptionData(options[i]));
		}
		RefreshShownValue();
	}

	public void AddOptions(List<Sprite> options)
	{
		int count = options.Count;
		for (int i = 0; i < count; i++)
		{
			this.options.Add(new OptionData(options[i]));
		}
		RefreshShownValue();
	}

	public void ClearOptions()
	{
		options.Clear();
		m_Value = 0;
		RefreshShownValue();
	}

	private void SetupTemplate(Canvas rootCanvas)
	{
		validTemplate = false;
		if (!m_Template)
		{
			Debug.LogError("The dropdown template is not assigned. The template needs to be assigned and must have a child GameObject with a Toggle component serving as the item.", this);
			return;
		}
		GameObject gameObject = m_Template.gameObject;
		gameObject.SetActive(value: true);
		Toggle componentInChildren = m_Template.GetComponentInChildren<Toggle>();
		validTemplate = true;
		if (!componentInChildren || componentInChildren.transform == template)
		{
			validTemplate = false;
			Debug.LogError("The dropdown template is not valid. The template must have a child GameObject with a Toggle component serving as the item.", template);
		}
		else if (!(componentInChildren.transform.parent is RectTransform))
		{
			validTemplate = false;
			Debug.LogError("The dropdown template is not valid. The child GameObject with a Toggle component (the item) must have a RectTransform on its parent.", template);
		}
		else if (itemText != null && !itemText.transform.IsChildOf(componentInChildren.transform))
		{
			validTemplate = false;
			Debug.LogError("The dropdown template is not valid. The Item Text must be on the item GameObject or children of it.", template);
		}
		else if (itemImage != null && !itemImage.transform.IsChildOf(componentInChildren.transform))
		{
			validTemplate = false;
			Debug.LogError("The dropdown template is not valid. The Item Image must be on the item GameObject or children of it.", template);
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
		Canvas val = null;
		Transform parent = m_Template.parent;
		while (parent != null)
		{
			val = parent.GetComponent<Canvas>();
			if ((Object)(object)val != null)
			{
				break;
			}
			parent = parent.parent;
		}
		if (!gameObject.TryGetComponent<Canvas>(out var _))
		{
			Canvas obj = gameObject.AddComponent<Canvas>();
			obj.overrideSorting = true;
			obj.sortingOrder = 30000;
			obj.sortingLayerID = rootCanvas.sortingLayerID;
		}
		if ((Object)(object)val != null)
		{
			Component[] components = ((Component)(object)val).GetComponents<BaseRaycaster>();
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
		Show();
	}

	public virtual void OnSubmit(BaseEventData eventData)
	{
		Show();
	}

	public virtual void OnCancel(BaseEventData eventData)
	{
		Hide();
	}

	public void Show()
	{
		if (!IsActive() || !IsInteractable() || m_Dropdown != null)
		{
			return;
		}
		List<Canvas> list = CollectionPool<List<Canvas>, Canvas>.Get();
		base.gameObject.GetComponentsInParent(includeInactive: false, list);
		if (list.Count == 0)
		{
			return;
		}
		int count = list.Count;
		Canvas val = list[count - 1];
		for (int i = 0; i < count; i++)
		{
			if (list[i].isRootCanvas || list[i].overrideSorting)
			{
				val = list[i];
				break;
			}
		}
		CollectionPool<List<Canvas>, Canvas>.Release(list);
		if (!validTemplate)
		{
			SetupTemplate(val);
			if (!validTemplate)
			{
				return;
			}
		}
		m_Template.gameObject.SetActive(value: true);
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
		int count2 = options.Count;
		for (int j = 0; j < count2; j++)
		{
			OptionData data = options[j];
			DropdownItem item = AddItem(data, value == j, componentInChildren, m_Items);
			if (!(item == null))
			{
				item.toggle.isOn = value == j;
				item.toggle.onValueChanged.AddListener(delegate
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
		RectTransform rectTransform3 = ((Component)(object)val).transform as RectTransform;
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
				RectTransformUtility.FlipLayoutOnAxis(rectTransform, num2, false, false);
			}
		}
		int count3 = m_Items.Count;
		for (int num4 = 0; num4 < count3; num4++)
		{
			RectTransform rectTransform4 = m_Items[num4].rectTransform;
			rectTransform4.anchorMin = new Vector2(rectTransform4.anchorMin.x, 0f);
			rectTransform4.anchorMax = new Vector2(rectTransform4.anchorMax.x, 0f);
			rectTransform4.anchoredPosition = new Vector2(rectTransform4.anchoredPosition.x, vector.y + size.y * (float)(count3 - 1 - num4) + size.y * rectTransform4.pivot.y);
			rectTransform4.sizeDelta = new Vector2(rectTransform4.sizeDelta.x, size.y);
		}
		AlphaFadeList(m_AlphaFadeSpeed, 0f, 1f);
		m_Template.gameObject.SetActive(value: false);
		componentInChildren.gameObject.SetActive(value: false);
		m_Blocker = CreateBlocker(val);
	}

	protected virtual GameObject CreateBlocker(Canvas rootCanvas)
	{
		GameObject gameObject = new GameObject("Blocker");
		RectTransform rectTransform = gameObject.AddComponent<RectTransform>();
		rectTransform.SetParent(((Component)(object)rootCanvas).transform, worldPositionStays: false);
		rectTransform.anchorMin = Vector3.zero;
		rectTransform.anchorMax = Vector3.one;
		rectTransform.sizeDelta = Vector2.zero;
		Canvas obj = gameObject.AddComponent<Canvas>();
		obj.overrideSorting = true;
		Canvas component = m_Dropdown.GetComponent<Canvas>();
		obj.sortingLayerID = component.sortingLayerID;
		obj.sortingOrder = component.sortingOrder - 1;
		Canvas val = null;
		Transform parent = m_Template.parent;
		while (parent != null)
		{
			val = parent.GetComponent<Canvas>();
			if ((Object)(object)val != null)
			{
				break;
			}
			parent = parent.parent;
		}
		if ((Object)(object)val != null)
		{
			Component[] components = ((Component)(object)val).GetComponents<BaseRaycaster>();
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
		Object.Destroy(blocker);
	}

	protected virtual GameObject CreateDropdownList(GameObject template)
	{
		return Object.Instantiate(template);
	}

	protected virtual void DestroyDropdownList(GameObject dropdownList)
	{
		Object.Destroy(dropdownList);
	}

	protected virtual DropdownItem CreateItem(DropdownItem itemTemplate)
	{
		return Object.Instantiate(itemTemplate);
	}

	protected virtual void DestroyItem(DropdownItem item)
	{
	}

	private DropdownItem AddItem(OptionData data, bool selected, DropdownItem itemTemplate, List<DropdownItem> items)
	{
		DropdownItem dropdownItem = CreateItem(itemTemplate);
		dropdownItem.rectTransform.SetParent(itemTemplate.rectTransform.parent, worldPositionStays: false);
		dropdownItem.gameObject.SetActive(value: true);
		dropdownItem.gameObject.name = "Item " + items.Count + ((data.text != null) ? (": " + data.text) : "");
		if (dropdownItem.toggle != null)
		{
			dropdownItem.toggle.isOn = false;
		}
		if ((bool)dropdownItem.text)
		{
			dropdownItem.text.text = data.text;
		}
		if ((bool)dropdownItem.image)
		{
			dropdownItem.image.sprite = data.image;
			dropdownItem.image.enabled = dropdownItem.image.sprite != null;
		}
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
			FloatTween info = new FloatTween
			{
				duration = duration,
				startValue = start,
				targetValue = end
			};
			info.AddOnChangedCallback(SetAlpha);
			info.ignoreTimeScale = true;
			m_AlphaTweenRunner.StartTween(info);
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
		if (m_Dropdown != null)
		{
			AlphaFadeList(m_AlphaFadeSpeed, 0f);
			if (IsActive())
			{
				StartCoroutine(DelayedDestroyDropdownList(m_AlphaFadeSpeed));
			}
		}
		if (m_Blocker != null)
		{
			DestroyBlocker(m_Blocker);
		}
		m_Blocker = null;
		Select();
	}

	private IEnumerator DelayedDestroyDropdownList(float delay)
	{
		yield return new WaitForSecondsRealtime(delay);
		ImmediateDestroyDropdownList();
	}

	private void ImmediateDestroyDropdownList()
	{
		int count = m_Items.Count;
		for (int i = 0; i < count; i++)
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
		m_Dropdown = null;
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
			value = num;
			Hide();
		}
	}
}
