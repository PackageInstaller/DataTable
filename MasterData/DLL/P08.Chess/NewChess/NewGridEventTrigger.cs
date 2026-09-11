using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace NewChess;

public class NewGridEventTrigger : EventTrigger
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
