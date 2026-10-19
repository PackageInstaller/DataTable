using System;

namespace ACT.Config;

[Serializable]
public class DialogueMissionAVGData
{
	public readonly long id;

	public readonly int speaker;

	public readonly int speakerId;

	public readonly int speakerIsPlayer;

	public readonly int content;

	public readonly int[] keyWords = new int[0];

	public readonly int maleContent;

	public DialogueMissionAVGData(long id, int speaker, int speakerId, int speakerIsPlayer, int content, int[] keyWords, int maleContent)
	{
		this.id = id;
		this.speaker = speaker;
		this.speakerId = speakerId;
		this.speakerIsPlayer = speakerIsPlayer;
		this.content = content;
		this.keyWords = keyWords;
		this.maleContent = maleContent;
	}
}
