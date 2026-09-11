using UnityEngine;
using UnityEngine.UI;

public class MapTargetBGUI : MonoBehaviour
{
	public Text textTitle;

	public void SetTitle(string s)
	{
		if (textTitle != null)
		{
			textTitle.text = s;
		}
	}
}
