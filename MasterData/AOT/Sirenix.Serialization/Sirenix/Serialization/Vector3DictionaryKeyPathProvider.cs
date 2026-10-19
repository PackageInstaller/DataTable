using System.Globalization;
using UnityEngine;

namespace Sirenix.Serialization;

public sealed class Vector3DictionaryKeyPathProvider : BaseDictionaryKeyPathProvider<Vector3>
{
	public override string ProviderID => "v3";

	public override int Compare(Vector3 x, Vector3 y)
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
		return num;
	}

	public override Vector3 GetKeyFromPathString(string pathStr)
	{
		int num = pathStr.IndexOf('|');
		int num2 = pathStr.IndexOf('|', num + 1);
		string s = pathStr.Substring(1, num - 1).Trim();
		string s2 = pathStr.Substring(num + 1, num2 - (num + 1)).Trim();
		string s3 = pathStr.Substring(num2 + 1, pathStr.Length - (num2 + 2)).Trim();
		return new Vector3(float.Parse(s), float.Parse(s2), float.Parse(s3));
	}

	public override string GetPathStringFromKey(Vector3 key)
	{
		string text = key.x.ToString("R", CultureInfo.InvariantCulture);
		string text2 = key.y.ToString("R", CultureInfo.InvariantCulture);
		string text3 = key.z.ToString("R", CultureInfo.InvariantCulture);
		return ("(" + text + "|" + text2 + "|" + text3 + ")").Replace('.', ',');
	}
}
