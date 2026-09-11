using UnityEngine;
using UnityEngine.UI;

namespace P08.Quiz;

public class QNickName : MonoBehaviour
{
	public Text txt_nick;

	public Transform target;

	private Canvas m_Canvas;

	public static QNickName Create(string uiPath)
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		if (gameObject == null)
		{
			return null;
		}
		GameObject gameObject2 = Asset.InstantiateWithoutCache(uiPath, gameObject.transform);
		if (gameObject2 != null)
		{
			QNickName component = gameObject2.GetComponent<QNickName>();
			component.m_Canvas = gameObject.GetComponent<Canvas>();
			return component;
		}
		return null;
	}

	public void SetNickName(string nickName, Transform target)
	{
		txt_nick.text = nickName;
		this.target = target;
	}

	private void LateUpdate()
	{
		if (target != null && target.gameObject.activeInHierarchy)
		{
			Camera cam = ((m_Canvas != null) ? m_Canvas.worldCamera : null);
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, target.position);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(m_Canvas.transform as RectTransform, screenPoint, cam, out var localPoint))
			{
				base.transform.localPosition = localPoint;
			}
		}
		if (!txt_nick.enabled)
		{
			if (target != null && target.gameObject.activeInHierarchy)
			{
				txt_nick.enabled = true;
			}
		}
		else if (target == null || !target.gameObject.activeInHierarchy)
		{
			txt_nick.enabled = false;
		}
	}
}
