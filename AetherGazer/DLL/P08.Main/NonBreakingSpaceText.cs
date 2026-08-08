using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Text))]
public class NonBreakingSpaceText : MonoBehaviour
{
	private Text txt;

	private const string NonBreakingSpace = "\u00a0";

	private void Awake()
	{
		txt = GetComponent<Text>();
		OnTextChange();
		txt.RegisterDirtyLayoutCallback(OnTextChange);
	}

	private void OnTextChange()
	{
		if (txt.text.Contains(" "))
		{
			txt.text = txt.text.Replace(" ", "\u00a0");
		}
	}
}
