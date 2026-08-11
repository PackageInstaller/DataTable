#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class HCSLayerItem : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler, IDragHandler
{
	private int curLayer;

	public Button btn;

	public Button screenBtn;

	public List<GameObject> layers;

	private Action<int> changeLayer;

	private Action<float> drag;

	private float minSpeed = 20f;

	private bool isDrag;

	private float beginDragY;

	private float timer;

	public int CurLayer
	{
		get
		{
			return curLayer;
		}
		set
		{
			curLayer = value;
			SetLayer();
		}
	}

	private void Start()
	{
		btn.onClick.AddListener(OnOpenSmall);
	}

	public void AddLayerChangeAction(Action<int> action)
	{
		changeLayer = (Action<int>)Delegate.Combine(changeLayer, action);
	}

	private void OnOpenSmall()
	{
		changeLayer(0);
	}

	private void SetLayer()
	{
		if (layers == null)
		{
			Log.Error("找不到页面按钮配置");
		}
		if (curLayer != 0)
		{
			for (int i = 0; i < layers.Count; i++)
			{
				layers[i].SetActive(i + 1 == CurLayer);
			}
		}
	}

	private void ChangePage(int page)
	{
		page = Mathf.Clamp(page, 1, layers.Count);
		if (page == curLayer)
		{
			drag(0f);
		}
		else
		{
			changeLayer(page);
		}
	}

	public void Update()
	{
		if (isDrag)
		{
			timer += Time.deltaTime;
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		isDrag = true;
		beginDragY = eventData.position.y;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		float num = (eventData.position.y - beginDragY) / timer;
		if (Mathf.Abs(num) > minSpeed)
		{
			if (num > 0f)
			{
				ChangePage(curLayer + 1);
			}
			else
			{
				ChangePage(curLayer - 1);
			}
		}
		isDrag = false;
		timer = 0f;
	}

	public void OnDrag(PointerEventData eventData)
	{
		float obj = eventData.position.y - beginDragY;
		drag(obj);
	}

	public void AddDragAction(Action<float> dragAction)
	{
		drag = (Action<float>)Delegate.Combine(drag, dragAction);
	}
}
