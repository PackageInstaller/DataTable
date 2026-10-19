using System;

namespace ACT.Config;

[Serializable]
public class DialogueAsideData
{
	public readonly long id;

	public readonly int speakerId;

	public readonly int content;

	public readonly int maleContent;

	public readonly bool disableResumeAfterInterrupt;

	public DialogueAsideData(long id, int speakerId, int content, int maleContent, bool disableResumeAfterInterrupt)
	{
		this.id = id;
		this.speakerId = speakerId;
		this.content = content;
		this.maleContent = maleContent;
		this.disableResumeAfterInterrupt = disableResumeAfterInterrupt;
	}
}
