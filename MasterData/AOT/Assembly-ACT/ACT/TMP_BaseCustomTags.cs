using ACT.DialogueSystem;
using UnityEngine;

namespace ACT;

public class TMP_BaseCustomTags : MonoBehaviour
{
	[Header("识别玩家昵称")]
	public bool enablePlayerName;

	[Header("禁用富文本")]
	public bool disableRichText;

	protected string ProcessText(string rawText)
	{
		string text = rawText;
		if (enablePlayerName)
		{
			text = (disableRichText ? LuminDialogueUtility.ProcessPurePlayerName(text) : LuminDialogueUtility.ProcessPlayerName(text));
		}
		return text;
	}
}
