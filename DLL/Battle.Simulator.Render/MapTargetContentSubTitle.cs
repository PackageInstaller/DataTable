using UnityEngine;
using UnityEngine.UI;

public class MapTargetContentSubTitle : MonoBehaviour
{
	public Text content;

	public void SetContent(string content)
	{
		if (this.content != null)
		{
			this.content.text = content;
		}
	}
}
