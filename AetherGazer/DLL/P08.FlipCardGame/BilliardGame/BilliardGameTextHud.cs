using UnityEngine;
using UnityEngine.UI;

namespace BilliardGame;

public class BilliardGameTextHud : BilliardGameHud
{
	public Text text;

	public UITextTool uiTextTool;

	public Animator animator;

	public override void UpdatePos()
	{
	}

	public override void Show(bool isShow)
	{
		canvasGroup.alpha = (isShow ? 1f : 0f);
		base.isShow = isShow;
		if (isShow)
		{
			animator.Play("burnt 1", -1, 0f);
		}
	}

	public void SetData(int number, Transform trs)
	{
		text.text = number.ToString("+#;-#;0");
		Color color;
		if (number >= 0)
		{
			ColorUtility.TryParseHtmlString("#5BA672", out color);
		}
		else
		{
			ColorUtility.TryParseHtmlString("#C77B63", out color);
		}
		uiTextTool._FontColor = color;
		_ = Random.value;
		_ = Random.value;
		Vector2 vector = RectTransformUtility.WorldToScreenPoint(Camera.main, trs.position);
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.transform as RectTransform, new Vector2(vector.x, vector.y), base.uiCamera, out var localPoint))
		{
			base.transform.localPosition = localPoint;
		}
	}

	public void Finish()
	{
		Show(isShow: false);
	}
}
