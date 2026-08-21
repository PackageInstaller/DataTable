using System;
using System.Globalization;

namespace Yarn.Unity;

[Serializable]
public struct Culture
{
	public string Name;

	public string DisplayName;

	public string NativeName;

	public bool IsNeutralCulture;

	internal CultureInfo CultureInfo
	{
		get
		{
			try
			{
				return CultureInfo.GetCultureInfo(Name);
			}
			catch (CultureNotFoundException)
			{
				return null;
			}
		}
	}

	public Culture(CultureInfo cultureInfo)
	{
		Name = cultureInfo.Name;
		DisplayName = cultureInfo.DisplayName;
		NativeName = cultureInfo.NativeName;
		IsNeutralCulture = cultureInfo.IsNeutralCulture;
	}
}
