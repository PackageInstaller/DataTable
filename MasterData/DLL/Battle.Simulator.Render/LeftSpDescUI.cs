using UnityEngine;
using UnityEngine.UI;

public class LeftSpDescUI : MonoBehaviour
{
	public Text titleComponent;

	public Text contentComponent;

	public Image image;

	public void Init(string imagePath, string title, string content)
	{
		if (image != null)
		{
			image.sprite = AtlasManager.GetSpriteWithoutAtlas(imagePath);
		}
		if (contentComponent != null)
		{
			contentComponent.text = content;
		}
		if (titleComponent != null)
		{
			titleComponent.text = title;
		}
	}
}
