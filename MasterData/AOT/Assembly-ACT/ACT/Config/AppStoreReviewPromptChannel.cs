using System;

namespace ACT.Config;

[Serializable]
public class AppStoreReviewPromptChannel
{
	public readonly int id;

	public readonly string promptPlatform = "";

	public readonly string promptChannel = "";

	public AppStoreReviewPromptChannel(int id, string promptPlatform, string promptChannel)
	{
		this.id = id;
		this.promptPlatform = promptPlatform;
		this.promptChannel = promptChannel;
	}
}
