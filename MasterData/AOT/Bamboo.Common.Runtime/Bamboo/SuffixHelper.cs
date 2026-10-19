namespace Bamboo;

public static class SuffixHelper
{
	public static string WithSuffix(string name, string suffix)
	{
		if (string.IsNullOrEmpty(name))
		{
			return string.Empty;
		}
		if (string.IsNullOrEmpty(suffix))
		{
			return name;
		}
		if (!name.EndsWith(suffix))
		{
			return name + suffix;
		}
		return name;
	}

	public static string WithoutSuffix(string name, string suffix)
	{
		if (string.IsNullOrEmpty(name))
		{
			return string.Empty;
		}
		if (string.IsNullOrEmpty(suffix))
		{
			return name;
		}
		if (!name.EndsWith(suffix))
		{
			return name;
		}
		return name.Substring(0, name.Length - suffix.Length);
	}
}
