using System;
using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class PassEventUI : MonoBehaviour
{
	public Action action;

	private Camera mainCamera;

	public Vector2 touchSizeOffset;

	private RectTransform target;

	private Vector2 oldPos;

	private List<Vector2> _posList = new List<Vector2>();

	private bool InArea(Vector2 pos)
	{
		if (mainCamera == null)
		{
			mainCamera = CanvasManager.Instance.uiCamera;
		}
		RectTransform obj = base.transform as RectTransform;
		RectTransformUtility.ScreenPointToLocalPointInRectangle(obj, pos, mainCamera, out var localPoint);
		float num = obj.sizeDelta.x / 2f + touchSizeOffset.x;
		float num2 = obj.sizeDelta.y / 2f + touchSizeOffset.y;
		if (localPoint.x > -1f * num && localPoint.x < num && localPoint.y > -1f * num2)
		{
			return localPoint.y < num2;
		}
		return false;
	}

	private void UpdateTouch(List<Vector2> posList)
	{
		Touch[] touches = Input.touches;
		for (int i = 0; i < touches.Length; i++)
		{
			Touch touch = touches[i];
			if (touch.phase == TouchPhase.Began)
			{
				posList.Add(touch.position);
			}
		}
	}

	private void Update()
	{
		_posList.Clear();
		if (Input.GetMouseButtonDown(0))
		{
			_posList.Add(Input.mousePosition);
		}
		UpdateTouch(_posList);
		HIDButton.GetSimClickPosList(_posList);
		foreach (Vector2 pos in _posList)
		{
			if (InArea(pos))
			{
				action?.Invoke();
				break;
			}
		}
		if (target != null && (target.anchoredPosition - oldPos).sqrMagnitude > 100f)
		{
			(base.transform as RectTransform).anchoredPosition += target.anchoredPosition - oldPos;
			oldPos = target.anchoredPosition;
		}
	}

	private void OnDisable()
	{
		Update();
		target = null;
	}

	public void SetTarget(RectTransform target)
	{
		this.target = target;
		oldPos = target.anchoredPosition;
	}
}
