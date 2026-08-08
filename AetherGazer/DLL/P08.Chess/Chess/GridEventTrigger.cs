using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Chess;

public class GridEventTrigger : EventTrigger
{
	public Action<GameObject> onPointerClick;

	public GameObject callBackGo;

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (onPointerClick != null)
		{
			try
			{
				onPointerClick(callBackGo);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("OnPointerClick:" + ex);
			}
		}
	}
}
