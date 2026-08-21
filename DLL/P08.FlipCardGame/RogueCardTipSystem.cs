using System.Collections.Generic;
using UnityEngine.UI;

public static class RogueCardTipSystem
{
	private static Dictionary<string, string> m_Tips;

	private static HashSet<int> richtextMap = new HashSet<int>();

	public static void Init()
	{
		m_Tips = new Dictionary<string, string> { ["ROGUE_CARD_COPY"] = "复制" };
	}

	public static string GetJokerTag(int tagID)
	{
		return GetTip($"ROGUE_CARD_TAG_{tagID}");
	}

	public static string GetTip(string key)
	{
		if (m_Tips.ContainsKey(key))
		{
			return m_Tips[key];
		}
		string text = LuaHelper.CallFunction("GetTips", key)[0].ToString();
		m_Tips.Add(key, text);
		return text;
	}

	public static string GetTip(string key, params string[] formats)
	{
		object[] args;
		if (m_Tips.ContainsKey(key))
		{
			string format = m_Tips[key];
			args = formats;
			return string.Format(format, args);
		}
		string text = LuaHelper.CallFunction("GetTips", key)[0].ToString();
		m_Tips.Add(key, text);
		args = formats;
		return string.Format(text, args);
	}

	public static void SetRichText(Text text, string content)
	{
		LuaHelper.CallFunction("RichTextTools.SetMixedTextWithImage", text, content);
		text.text = content;
	}
}
