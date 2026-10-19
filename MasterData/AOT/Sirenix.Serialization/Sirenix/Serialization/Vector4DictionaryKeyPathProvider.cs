using System.Globalization;
using UnityEngine;

namespace Sirenix.Serialization;

public sealed class Vector4DictionaryKeyPathProvider : BaseDictionaryKeyPathProvider<Vector4>
{
	public override string ProviderID => "v4";

	public override int Compare(Vector4 x, Vector4 y)
	{
		int num = x.x.CompareTo(y.x);
		if (num == 0)
		{
			num = x.y.CompareTo(y.y);
		}
		if (num == 0)
		{
			num = x.z.CompareTo(y.z);
		}
		if (num == 0)
		{
			num = x.w.CompareTo(y.w);
		}
		return num;
	}

	public override Vector4 GetKeyFromPathString(string pathStr)
	{
		int num = pathStr.IndexOf('|');
		int num2 = pathStr.IndexOf('|', num + 1);
		int num3 = pathStr.IndexOf('|', num2 + 1);
		string s = pathStr.Substring(1, num - 1).Trim();
		string s2 = pathStr.Substring(num + 1, num2 - (num + 1)).Trim();
		string s3 = pathStr.Substring(num2 + 1, num3 - (num2 + 1)).Trim();
		string s4 = pathStr.Substring(num3 + 1, pathStr.Length - (num3 + 2)).Trim();
		return new Vector4(float.Parse(s), float.Parse(s2), float.Parse(s3), float.Parse(s4));
	}

	public override string GetPathStringFromKey(Vector4 key)
	{
		string text = key.x.ToString("R", CultureInfo.InvariantCulture);
		string text2 = key.y.ToString("R", CultureInfo.InvariantCulture);
		string text3 = key.z.ToString("R", CultureInfo.InvariantCulture);
		string text4 = key.w.ToString("R", CultureInfo.InvariantCulture);
		return ("(" + text + "|" + text2 + "|" + text3 + "|" + text4 + ")").Replace('.', ',');
	}
}
