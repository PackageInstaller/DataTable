using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class VerticalCenterOnChild : MonoBehaviour, IEndDragHandler, IEventSystemHandler, IBeginDragHandler
{
	public float centerSpeed = 9f;

	public int childCount;

	public float childPosY;

	public float deltaY;

	public int current;

	public LuaHelper.ETLCallBack1 onBeginDrag;

	public LuaHelper.ETLCallBack1 onEndDrag;

	private ScrollRect _scrollView;

	private Transform _container;

	private float _targetPos;

	private bool _centering;

	private void Awake()
	{
		_scrollView = GetComponent<ScrollRect>();
		if (_scrollView == null)
		{
			Debug.LogError("CenterOnChild: No ScrollRect");
			return;
		}
		_container = _scrollView.content;
		_scrollView.movementType = ScrollRect.MovementType.Unrestricted;
		_scrollView.vertical = true;
		_scrollView.horizontal = false;
		childCount = _container.childCount;
		GridLayoutGroup component = _container.GetComponent<GridLayoutGroup>();
		if (component != null)
		{
			childPosY = component.cellSize.y * 0.5f;
			deltaY = component.cellSize.y + component.spacing.y;
		}
	}

	private void Update()
	{
		if (_centering)
		{
			Vector3 localPosition = _container.localPosition;
			localPosition.y = Mathf.Lerp(_container.localPosition.y, _targetPos, centerSpeed * Time.deltaTime);
			_container.localPosition = localPosition;
			if (Mathf.Abs(_container.localPosition.y - _targetPos) < 0.01f)
			{
				_centering = false;
			}
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		_centering = true;
		_targetPos = FindClosestPos(_container.localPosition.y);
		if (onEndDrag != null)
		{
			onEndDrag(base.gameObject, eventData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		_centering = false;
		if (onBeginDrag != null)
		{
			onBeginDrag(base.gameObject, eventData);
		}
	}

	public void RemoveAllListeners()
	{
		onBeginDrag = null;
		onEndDrag = null;
	}

	private float FindClosestPos(float currentPos)
	{
		int num = 0;
		float result = 0f;
		float num2 = float.PositiveInfinity;
		for (int i = 0; i < childCount; i++)
		{
			float num3 = childPosY + (float)i * deltaY;
			float num4 = Mathf.Abs(num3 - currentPos);
			if (num4 < num2)
			{
				num2 = num4;
				result = num3;
				num = i;
			}
		}
		current = num;
		return result;
	}

	public void MoveToIndex(int index)
	{
		Vector3 localPosition = _container.localPosition;
		localPosition.y = childPosY + (float)index * deltaY;
		_container.localPosition = localPosition;
	}
}
