using System;

namespace ACT.Config;

[Serializable]
public class TextLanguageData
{
	public readonly int id;

	public readonly string languageName = "";

	public readonly string languageMarker = "";

	public TextLanguageData(int id, string languageName, string languageMarker)
	{
		this.id = id;
		this.languageName = languageName;
		this.languageMarker = languageMarker;
	}
}
