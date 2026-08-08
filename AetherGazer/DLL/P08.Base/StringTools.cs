using System;
using System.Collections.Generic;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

public class StringTools
{
	public static CultureInfo sCultureInfo = new CultureInfo("en-US", useUserOverride: false);

	public static bool IsNumeric(string value)
	{
		return Regex.IsMatch(value, "^[+-]?\\d*[.]?\\d*$");
	}

	public static bool IsInt(string value)
	{
		return Regex.IsMatch(value, "^[+-]?\\d*$");
	}

	public static bool IsUnsign(string value)
	{
		return Regex.IsMatch(value, "^\\d*[.]?\\d*$");
	}

	public static bool isTel(string strInput)
	{
		return Regex.IsMatch(strInput, "\\d{3}-\\d{8}|\\d{4}-\\d{7}");
	}

	public static string GetFirstMatch(string str, string regexStr)
	{
		if (string.IsNullOrEmpty(str) || string.IsNullOrEmpty(regexStr))
		{
			return null;
		}
		Match match = Regex.Match(str, regexStr);
		if (!string.IsNullOrEmpty(match.ToString()))
		{
			return match.ToString();
		}
		return null;
	}

	public static string Split(string str, string splitStr)
	{
		if (string.IsNullOrEmpty(str) || string.IsNullOrEmpty(splitStr))
		{
			return null;
		}
		string[] array = Regex.Split(str, splitStr);
		string text = string.Empty;
		for (int i = 0; i < array.Length; i++)
		{
			text += text;
		}
		return text;
	}

	public static List<string> Split2(string str, string splitStr)
	{
		if (string.IsNullOrEmpty(str) || string.IsNullOrEmpty(splitStr))
		{
			return null;
		}
		string[] array = Regex.Split(str, splitStr);
		List<string> list = new List<string>();
		for (int i = 0; i < array.Length; i++)
		{
			list.Add(array[i]);
		}
		return list;
	}

	public static string ChangePathFormat(string path)
	{
		return path.Replace('\\', '/');
	}

	public static string ToMD5(string str)
	{
		MD5 mD = MD5.Create();
		byte[] bytes = Encoding.UTF8.GetBytes(str);
		byte[] array = mD.ComputeHash(bytes);
		StringBuilder stringBuilder = new StringBuilder();
		byte[] array2 = array;
		foreach (byte b in array2)
		{
			stringBuilder.Append(b.ToString("x2"));
		}
		return stringBuilder.ToString();
	}

	public static string HexStringToString(string hs, Encoding encode)
	{
		string[] array = hs.Split(new char[1] { '-' }, StringSplitOptions.RemoveEmptyEntries);
		byte[] array2 = new byte[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array2[i] = Convert.ToByte(array[i], 16);
		}
		return encode.GetString(array2);
	}

	private string StringToHexString(string s, Encoding encode)
	{
		byte[] bytes = encode.GetBytes(s);
		string text = string.Empty;
		for (int i = 0; i < bytes.Length; i++)
		{
			text = text + "%" + Convert.ToString(bytes[i], 16);
		}
		return text;
	}

	private static byte[] strToToHexByte(string hexString)
	{
		hexString = hexString.Replace(" ", "");
		if (hexString.Length % 2 != 0)
		{
			hexString += " ";
		}
		byte[] array = new byte[hexString.Length / 2];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
		}
		return array;
	}

	public static string byteToHexStr(byte[] bytes)
	{
		string text = "";
		if (bytes != null)
		{
			for (int i = 0; i < bytes.Length; i++)
			{
				text += bytes[i].ToString("X2");
			}
		}
		return text;
	}

	public static string ToHex(string s, string charset, bool fenge)
	{
		if (s.Length % 2 != 0)
		{
			s += " ";
		}
		byte[] bytes = Encoding.GetEncoding(charset).GetBytes(s);
		string text = "";
		for (int i = 0; i < bytes.Length; i++)
		{
			text += $"{bytes[i]:X}";
			if (fenge && i != bytes.Length - 1)
			{
				text += string.Format("{0}", ",");
			}
		}
		return text.ToLower(sCultureInfo);
	}

	public static string UnHex(string hex, string charset)
	{
		if (hex == null)
		{
			throw new ArgumentNullException("hex");
		}
		hex = hex.Replace(",", "");
		hex = hex.Replace("\n", "");
		hex = hex.Replace("\\", "");
		hex = hex.Replace(" ", "");
		if (hex.Length % 2 != 0)
		{
			hex += "20";
		}
		byte[] array = new byte[hex.Length / 2];
		for (int i = 0; i < array.Length; i++)
		{
			try
			{
				array[i] = byte.Parse(hex.Substring(i * 2, 2), NumberStyles.HexNumber);
			}
			catch
			{
				throw new ArgumentException("hex is not a valid hex number!", "hex");
			}
		}
		return Encoding.GetEncoding(charset).GetString(array);
	}
}
