using System;

namespace ACT.Config;

[Serializable]
public class DialogueStoryGroupData
{
	public readonly int id;

	public readonly int mode;

	public readonly string path = "";

	public readonly int storySummary;

	public readonly string voiceAddress = "";

	public readonly string maleVoiceAddress = "";

	public DialogueStoryGroupData(int id, int mode, string path, int storySummary, string voiceAddress, string maleVoiceAddress)
	{
		this.id = id;
		this.mode = mode;
		this.path = path;
		this.storySummary = storySummary;
		this.voiceAddress = voiceAddress;
		this.maleVoiceAddress = maleVoiceAddress;
	}
}
