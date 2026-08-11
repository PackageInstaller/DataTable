#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using UnityEngine.Events;

namespace UnityEngine.UI.Extensions;

[RequireComponent(typeof(ScrollRect))]
[AddComponentMenu("Layout/Extensions/Vertical Scroller")]
public class UIVerticalScroller : MonoBehaviour
{
	[Serializable]
	public class IntEvent : UnityEvent<int>
	{
	}

	[Tooltip("desired ScrollRect")]
	public ScrollRect scrollRect;

	[Tooltip("Center display area (position of zoomed content)")]
	public RectTransform center;

	[Tooltip("Size / spacing of elements")]
	public RectTransform elementSize;

	[Tooltip("Scale = 1/ (1+distance from center * shrinkage)")]
	public Vector2 elementShrinkage = new Vector2(0.005f, 0.005f);

	[Tooltip("Minimum element scale (furthest from center)")]
	public Vector2 minScale = new Vector2(0.7f, 0.7f);

	[Tooltip("Select the item to be in center on start.")]
	public int startingIndex = -1;

	[Tooltip("Stop scrolling past last element from inertia.")]
	public bool stopMomentumOnEnd = true;

	[Tooltip("Set Items out of center to not interactible.")]
	public bool disableUnfocused = true;

	[Tooltip("Button to go to the next page. (optional)")]
	public GameObject scrollUpButton;

	[Tooltip("Button to go to the previous page. (optional)")]
	public GameObject scrollDownButton;

	[Tooltip("Event fired when a specific item is clicked, exposes index number of item. (optional)")]
	public IntEvent OnButtonClicked;

	[Tooltip("Event fired when the focused item is Changed. (optional)")]
	public IntEvent OnFocusChanged;

	[HideInInspector]
	public GameObject[] _arrayOfElements;

	private float[] distReposition;

	private float[] distance;

	public int focusedElementIndex { get; private set; }

	public string result { get; private set; }

	[HideInInspector]
	public RectTransform scrollingPanel => scrollRect.content;

	public UIVerticalScroller()
	{
	}

	public UIVerticalScroller(RectTransform center, RectTransform elementSize, ScrollRect scrollRect, GameObject[] arrayOfElements)
	{
		this.center = center;
		this.elementSize = elementSize;
		this.scrollRect = scrollRect;
		_arrayOfElements = arrayOfElements;
	}

	public void Awake()
	{
		if (!scrollRect)
		{
			scrollRect = GetComponent<ScrollRect>();
		}
		if (!center)
		{
			Log.Error("Please define the RectTransform for the Center viewport of the scrollable area");
		}
		if (!elementSize)
		{
			elementSize = center;
		}
		if (_arrayOfElements == null || _arrayOfElements.Length == 0)
		{
			_arrayOfElements = new GameObject[scrollingPanel.childCount];
			for (int i = 0; i < scrollingPanel.childCount; i++)
			{
				_arrayOfElements[i] = scrollingPanel.GetChild(i).gameObject;
			}
		}
	}

	public void updateChildren(int startingIndex = -1, GameObject[] arrayOfElements = null)
	{
		if (arrayOfElements != null)
		{
			_arrayOfElements = arrayOfElements;
		}
		else
		{
			_arrayOfElements = new GameObject[scrollingPanel.childCount];
			for (int i = 0; i < scrollingPanel.childCount; i++)
			{
				_arrayOfElements[i] = scrollingPanel.GetChild(i).gameObject;
			}
		}
		for (int j = 0; j < _arrayOfElements.Length; j++)
		{
			int j2 = j;
			_arrayOfElements[j].GetComponent<Button>().onClick.RemoveAllListeners();
			if (OnButtonClicked != null)
			{
				_arrayOfElements[j].GetComponent<Button>().onClick.AddListener(delegate
				{
					OnButtonClicked.Invoke(j2);
				});
			}
			RectTransform component = _arrayOfElements[j].GetComponent<RectTransform>();
			Vector2 vector = (component.pivot = new Vector2(0.5f, 0.5f));
			Vector2 anchorMax = (component.anchorMin = vector);
			component.anchorMax = anchorMax;
			component.localPosition = new Vector2(0f, (float)j * elementSize.rect.size.y);
			component.sizeDelta = elementSize.rect.size;
		}
		distance = new float[_arrayOfElements.Length];
		distReposition = new float[_arrayOfElements.Length];
		focusedElementIndex = -1;
		if (startingIndex > -1)
		{
			startingIndex = ((startingIndex > _arrayOfElements.Length) ? (_arrayOfElements.Length - 1) : startingIndex);
			SnapToElement(startingIndex);
		}
	}

	public void Start()
	{
		if ((bool)scrollUpButton)
		{
			scrollUpButton.GetComponent<Button>().onClick.AddListener(delegate
			{
				ScrollUp();
			});
		}
		if ((bool)scrollDownButton)
		{
			scrollDownButton.GetComponent<Button>().onClick.AddListener(delegate
			{
				ScrollDown();
			});
		}
		updateChildren(startingIndex, _arrayOfElements);
	}

	public void Update()
	{
		if (_arrayOfElements.Length < 1)
		{
			return;
		}
		for (int i = 0; i < _arrayOfElements.Length; i++)
		{
			distReposition[i] = center.GetComponent<RectTransform>().position.y - _arrayOfElements[i].GetComponent<RectTransform>().position.y;
			distance[i] = Mathf.Abs(distReposition[i]);
			Vector2 vector = Vector2.Max(minScale, new Vector2(1f / (1f + distance[i] * elementShrinkage.x), 1f / (1f + distance[i] * elementShrinkage.y)));
			_arrayOfElements[i].GetComponent<RectTransform>().transform.localScale = new Vector3(vector.x, vector.y, 1f);
		}
		float num = Mathf.Min(distance);
		int num2 = focusedElementIndex;
		for (int j = 0; j < _arrayOfElements.Length; j++)
		{
			_arrayOfElements[j].GetComponent<CanvasGroup>().interactable = !disableUnfocused || num == distance[j];
			if (num == distance[j])
			{
				focusedElementIndex = j;
				result = _arrayOfElements[j].GetComponentInChildren<Text>().text;
			}
		}
		if (focusedElementIndex != num2 && OnFocusChanged != null)
		{
			OnFocusChanged.Invoke(focusedElementIndex);
		}
		if (!UIExtensionsInputManager.GetMouseButton(0))
		{
			ScrollingElements();
		}
		if (stopMomentumOnEnd && (_arrayOfElements[0].GetComponent<RectTransform>().position.y > center.position.y || _arrayOfElements[_arrayOfElements.Length - 1].GetComponent<RectTransform>().position.y < center.position.y))
		{
			scrollRect.velocity = Vector2.zero;
		}
	}

	private void ScrollingElements()
	{
		float y = Mathf.Lerp(scrollingPanel.anchoredPosition.y, scrollingPanel.anchoredPosition.y + distReposition[focusedElementIndex], Time.deltaTime * 2f);
		Vector2 anchoredPosition = new Vector2(scrollingPanel.anchoredPosition.x, y);
		scrollingPanel.anchoredPosition = anchoredPosition;
	}

	public void SnapToElement(int element)
	{
		float num = elementSize.rect.height * (float)element;
		Vector2 anchoredPosition = new Vector2(scrollingPanel.anchoredPosition.x, 0f - num);
		scrollingPanel.anchoredPosition = anchoredPosition;
	}

	public void ScrollUp()
	{
		float num = elementSize.rect.height / 1.2f;
		Vector2 b = new Vector2(scrollingPanel.anchoredPosition.x, scrollingPanel.anchoredPosition.y - num);
		scrollingPanel.anchoredPosition = Vector2.Lerp(scrollingPanel.anchoredPosition, b, 1f);
	}

	public void ScrollDown()
	{
		float num = elementSize.rect.height / 1.2f;
		Vector2 anchoredPosition = new Vector2(scrollingPanel.anchoredPosition.x, scrollingPanel.anchoredPosition.y + num);
		scrollingPanel.anchoredPosition = anchoredPosition;
	}
}
