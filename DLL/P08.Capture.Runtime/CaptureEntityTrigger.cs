using System;
using Capture.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;

public class CaptureEntityTrigger : MonoBehaviour
{
	public LuaHelper.ETLCallBack1 onPointerClick;

	public LuaHelper.ETLCallBack1 onDrag;

	public LuaHelper.ETLCallBack1 onBeginDrag;

	private void Awake()
	{
		if (WorldManager.Instance != null)
		{
			WorldManager.Instance.GetGameContext().AddTrigger(this);
		}
	}

	private void OnDestroy()
	{
		if (WorldManager.Instance != null)
		{
			WorldManager.Instance.GetGameContext().RemoveTrigger(this);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (onDrag != null)
		{
			try
			{
				onDrag(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnDrag:" + ex);
			}
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (onBeginDrag != null)
		{
			try
			{
				onBeginDrag(base.gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnBeginDrag:" + ex);
			}
		}
	}

	public void OnPointerClick(GameObject gameObject, PointerEventData eventData)
	{
		if (onPointerClick != null)
		{
			try
			{
				onPointerClick(gameObject, eventData);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerClick:" + ex);
			}
		}
	}

	public void RemoveAllListeners()
	{
		onPointerClick = null;
		onDrag = null;
		onBeginDrag = null;
	}
}
