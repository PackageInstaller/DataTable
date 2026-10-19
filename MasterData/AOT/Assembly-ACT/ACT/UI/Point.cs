using System;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class Point : MonoBehaviour
{
	private int m_StartIndex;

	private int m_EndIndex;

	[SerializeField]
	private Color _segmentDefaultColor;

	[SerializeField]
	private Color _segmentClearColor;

	[SerializeField]
	private ActButton pointBtn;

	[SerializeField]
	public LineRenderer lineRenderer;

	public RectTransform rectTransform;

	[SerializeField]
	private Sprite _unSelectedSprite;

	[SerializeField]
	private Sprite _selectedSprite;

	[SerializeField]
	private float _rotationSpeed = 30f;

	[SerializeField]
	private float _selectRotationSpeed = 300f;

	[SerializeField]
	private bool _clockwise = true;

	[SerializeField]
	private float _textureRate = 1f;

	[SerializeField]
	private GameObject _completeEffect;

	private bool _isSelected;

	public int EndSegmentIndex
	{
		get
		{
			if (StartSegmentIndex != m_StartIndex)
			{
				return StartSegmentIndex - 1;
			}
			return m_EndIndex;
		}
	}

	public int StartSegmentIndex { get; private set; }

	public int Index { get; private set; }

	public Vector3 Pos
	{
		get
		{
			return transform.position;
		}
		set
		{
			transform.position = value;
		}
	}

	public void Init(int i, int startIndex, int endIndex, Vector3 value, Action<int> onClick)
	{
		_completeEffect.SetActive(value: false);
		gameObject.SetActive(value: true);
		Index = i;
		StartSegmentIndex = i;
		m_StartIndex = startIndex;
		m_EndIndex = endIndex;
		rectTransform.anchoredPosition = value;
		pointBtn.SetBtnClick(() =>
		{
			onClick(i);
		}, "event:/UI/Interface/UAV/UAV_Click");
		Select(active: false);
	}

	public void Select(bool active)
	{
		_isSelected = active;
		pointBtn.image.sprite = (active ? _selectedSprite : _unSelectedSprite);
		pointBtn.image.SetNativeSize();
	}

	public void SetSegmentIntersectState(bool active)
	{
		lineRenderer.startColor = (active ? _segmentDefaultColor : _segmentClearColor);
		lineRenderer.endColor = (active ? _segmentDefaultColor : _segmentClearColor);
	}

	public void RefreshSegmentPos(Vector3 pos1, Vector3 pos2)
	{
		lineRenderer.SetPosition(0, pos1);
		lineRenderer.SetPosition(1, pos2);
	}

	public void SetLineRenderer(LineRenderer lineRenderer)
	{
		this.lineRenderer = lineRenderer;
	}

	private void Update()
	{
		float num = (_clockwise ? (-1f) : 1f);
		float zAngle = (_isSelected ? _selectRotationSpeed : _rotationSpeed) * Time.deltaTime * num;
		pointBtn.transform.Rotate(0f, 0f, zAngle);
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}

	public void CompleteEffect()
	{
		_completeEffect.SetActive(value: true);
	}
}
