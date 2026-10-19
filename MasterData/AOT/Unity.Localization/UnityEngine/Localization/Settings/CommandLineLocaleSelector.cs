using System;

namespace UnityEngine.Localization.Settings;

[Serializable]
public class CommandLineLocaleSelector : IStartupLocaleSelector
{
	[SerializeField]
	private string m_CommandLineArgument = "-language=";

	public string CommandLineArgument
	{
		get
		{
			return m_CommandLineArgument;
		}
		set
		{
			m_CommandLineArgument = value;
		}
	}

	public Locale GetStartupLocale(ILocalesProvider availableLocales)
	{
		if (string.IsNullOrEmpty(m_CommandLineArgument))
		{
			return null;
		}
		string[] commandLineArgs = Environment.GetCommandLineArgs();
		foreach (string text in commandLineArgs)
		{
			if (text.StartsWith(m_CommandLineArgument, StringComparison.OrdinalIgnoreCase))
			{
				string text2 = text.Substring(m_CommandLineArgument.Length);
				Locale locale = availableLocales.GetLocale(text2);
				if (locale != null)
				{
					Debug.LogFormat("Found a matching locale({0}) for command line argument: `{1}`.", text2, locale);
				}
				else
				{
					Debug.LogWarningFormat("Could not find a matching locale for command line argument: `{0}`", text2);
				}
				return locale;
			}
		}
		return null;
	}
}
