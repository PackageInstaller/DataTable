using UnityEngine;
using UnityEngine.UI;

namespace BilliardGame;

public class BilliardGameSkillHud : BilliardGameHud
{
	public Text text;

	public Animator animator;

	public override void Init(Transform targetTrs = null)
	{
		if (targetTrs != null)
		{
			target = targetTrs;
		}
		canvas = GameObject.Find("UICamera/Canvas");
		base.uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		isShow = false;
	}

	public override void UpdatePos()
	{
		if (!(null == target) && isShow)
		{
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, target.position);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, screenPoint, base.uiCamera, out var localPoint))
			{
				base.transform.localPosition = localPoint;
			}
		}
	}

	public override void Show(bool isShow)
	{
		base.isShow = isShow;
		base.transform.SetActive(isShow);
	}

	public void SetData(string skillText, Transform trs)
	{
		text.text = skillText;
		target = trs;
	}

	public void Finish()
	{
		Show(isShow: false);
	}
}
