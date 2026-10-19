using System;

namespace ACT.Config;

[Serializable]
public class VoiceLanguageData
{
	public readonly int id;

	public readonly int languageName;

	public VoiceLanguageData(int id, int languageName)
	{
		this.id = id;
		this.languageName = languageName;
	}
}
