using System;

public class I18NTools
{
	public static string GetPlayModeAseetPath(string editorPath)
	{
		return editorPath.Replace(".png", "").Replace(".jpeg", "").Replace(".jpg", "")
			.Replace(".ttf", "")
			.Replace(".prefab", "")
			.Replace("Assets/ABResources/", "")
			.Replace("Assets/UIResources/UI_AB/", "")
			.Replace(".ys", "");
	}

	public static string GetRawPlayModeAssetPath(string editorPath)
	{
		string playModeAseetPath = GetPlayModeAseetPath(editorPath);
		string assetI18NLanguageTag = GetAssetI18NLanguageTag(playModeAseetPath);
		if (!assetI18NLanguageTag.Equals(string.Empty))
		{
			int num = playModeAseetPath.LastIndexOf(assetI18NLanguageTag);
			if (num != -1 && num == playModeAseetPath.Length - assetI18NLanguageTag.Length)
			{
				return playModeAseetPath.Substring(0, num);
			}
		}
		return playModeAseetPath;
	}

	public static string GetAssetI18NLanguageTag(string editorPath)
	{
		string playModeAseetPath = GetPlayModeAseetPath(editorPath);
		string[] languageSuffixList = I18NConfig.languageSuffixList;
		foreach (string text in languageSuffixList)
		{
			if (playModeAseetPath.EndsWith(text))
			{
				return text;
			}
		}
		return string.Empty;
	}

	public static bool I18NKeyToUniformNumber(string i18NKey, out int splitId)
	{
		splitId = -1;
		bool flag = false;
		string text = string.Empty;
		if (StringIsMd5(i18NKey))
		{
			flag = true;
			text = i18NKey;
		}
		else if (i18NKey.Contains("BattleTips$"))
		{
			flag = true;
			text = i18NKey.Replace("BattleTips$", "");
		}
		if (!flag)
		{
			return false;
		}
		Span<ulong> span = stackalloc ulong[4];
		for (int i = 0; i < 4; i++)
		{
			int num = i * 8;
			string value = ((num + 8 > text.Length) ? "0" : text.Substring(num, 8));
			span[i] = Convert.ToUInt64(value, 16);
		}
		ulong num2 = span[0] ^ span[1] ^ span[2] ^ span[3];
		splitId = (int)(num2 % (ulong)I18NConfig.MAX_NUMBER_OF_SPLIT_TRANSLATE_DATA);
		return true;
	}

	public static bool SplitI18NKeyToUlongs(string i18NKey, out ulong hash1, out ulong hash2)
	{
		hash1 = 0uL;
		hash2 = 0uL;
		bool result = false;
		if (StringIsMd5(i18NKey))
		{
			Span<byte> span = stackalloc byte[16];
			for (int i = 0; i < 32; i += 2)
			{
				span[i / 2] = Convert.ToByte(i18NKey.Substring(i, 2), 16);
			}
			hash1 = BitConverter.ToUInt64(span.Slice(0, 8));
			hash2 = BitConverter.ToUInt64(span.Slice(8, 8));
			result = true;
		}
		else if (i18NKey.Contains("BattleTips$"))
		{
			i18NKey = i18NKey.Replace("BattleTips$", "");
			hash1 = Convert.ToUInt64(i18NKey);
			hash2 = 0uL;
			result = true;
		}
		return result;
	}

	public static bool StringIsMd5(string input)
	{
		if (string.IsNullOrEmpty(input))
		{
			return false;
		}
		if (input.Length != 32)
		{
			return false;
		}
		foreach (char c in input)
		{
			if ((c < '0' || c > '9') && (c < 'a' || c > 'f') && (c < 'A' || c > 'F'))
			{
				return false;
			}
		}
		return true;
	}
}
