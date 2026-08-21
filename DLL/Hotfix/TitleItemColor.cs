using UnityEngine;
using UnityEngine.UI;

public class TitleItemColor : MonoBehaviour
{
	[SerializeField]
	private Image imgUserTitle;

	public Image ImgUserTitle => imgUserTitle;

	public void SetImageColor(bool isLock)
	{
		Color color = imgUserTitle.color;
		if (!isLock)
		{
			color = Color.white;
			imgUserTitle.color = new Color(color.r, color.g, color.b, 1f);
		}
		else
		{
			ColorUtility.TryParseHtmlString("#3F3F3F", out color);
			imgUserTitle.color = new Color(color.r, color.g, color.b, 0.4f);
		}
	}
}
