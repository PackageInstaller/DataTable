using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[RequireComponent(typeof(ScrollRect))]
public class ScrollPageTool : UIBehaviour, IEndDragHandler, IEventSystemHandler, IBeginDragHandler
{
	public enum eAxis
	{
		Horizontal,
		Vertical
	}

	public RectTransform scrollTransformRect;

	public RectTransform baseRect;

	public float spacing;

	public int dragNum = 5;

	public int durationFrame = 10;

	public AnimationCurve curve = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	public Button backButton;

	public Button nextButton;

	public eAxis mAxis = eAxis.Vertical;

	private int targetIndex;

	private Vector2 baseRectSize;

	public int pageNum => targetIndex;

	public int allPage => scrollTransformRect.gameObject.transform.childCount - 1;

	protected override void Awake()
	{
		baseRectSize = new Vector2(baseRect.rect.width, baseRect.rect.height);
		ChangePage(0, animate: false);
		if (backButton != null)
		{
			backButton.onClick.AddListener(delegate
			{
				OnNextPage();
			});
		}
		if (nextButton != null)
		{
			nextButton.onClick.AddListener(delegate
			{
				OnBackPage();
			});
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		StopAllCoroutines();
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		targetIndex = GetCurrentPositionIndex();
		StartCoroutine(SnapRect());
	}

	private IEnumerator SnapRect()
	{
		float timer = 0f;
		float speed = Mathf.Max(0.01f, 1f / (float)durationFrame);
		int axis = (int)mAxis;
		float oldPosition = scrollTransformRect.anchoredPosition[axis];
		float targetPosition = GetPositionFromIndex(targetIndex)[axis];
		Vector2 targetVector = default(Vector2);
		while (timer < 1f)
		{
			float value = Mathf.Lerp(oldPosition, targetPosition, curve.Evaluate(timer));
			timer += speed;
			targetVector[axis] = value;
			scrollTransformRect.anchoredPosition = targetVector;
			yield return new WaitForEndOfFrame();
		}
		targetVector[axis] = targetPosition;
		scrollTransformRect.anchoredPosition = targetVector;
	}

	private Vector2 GetPositionFromIndex(int i)
	{
		int index = (int)mAxis;
		Vector2 result = new Vector2(0f, 0f);
		int num = ((mAxis != eAxis.Horizontal) ? 1 : (-1));
		result[index] = (baseRectSize[index] + spacing) * (float)i * (float)num;
		return result;
	}

	private int GetCurrentPositionIndex()
	{
		float offset = GetOffset();
		if (mAxis == eAxis.Horizontal && 0f < offset)
		{
			return 0;
		}
		if (eAxis.Vertical == mAxis && 0f > offset)
		{
			return 0;
		}
		float num = Mathf.Abs(offset);
		int num2 = targetIndex;
		float num3 = num % 1f;
		float num4 = Mathf.Min(1f, (float)dragNum / 10f);
		if ((float)targetIndex < num)
		{
			num2 = Mathf.FloorToInt(num);
			if (num3 > num4)
			{
				num2++;
			}
		}
		else if ((float)targetIndex > num)
		{
			num2 = Mathf.CeilToInt(num);
			if (num3 < 1f - num4)
			{
				num2--;
			}
		}
		int max = scrollTransformRect.gameObject.transform.childCount - 1;
		return Mathf.Clamp(num2, 0, max);
	}

	private float GetOffset()
	{
		int index = (int)mAxis;
		return scrollTransformRect.anchoredPosition[index] / (baseRectSize[index] + spacing);
	}

	public void ChangePage(int i, bool animate = true)
	{
		StopAllCoroutines();
		int max = scrollTransformRect.gameObject.transform.childCount - 1;
		targetIndex = Mathf.Clamp(i, 0, max);
		if (!animate)
		{
			Vector2 positionFromIndex = GetPositionFromIndex(i);
			scrollTransformRect.anchoredPosition = positionFromIndex;
		}
		else
		{
			StartCoroutine(SnapRect());
		}
	}

	public void OnNextPage()
	{
		int num = GetCurrentPositionIndex() + 1;
		if (num < scrollTransformRect.gameObject.transform.childCount)
		{
			ChangePage(num);
		}
	}

	public void OnBackPage()
	{
		int num = GetCurrentPositionIndex() - 1;
		if (num >= 0)
		{
			ChangePage(num);
		}
	}
}
