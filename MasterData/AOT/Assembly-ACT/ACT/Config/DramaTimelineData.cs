using System;

namespace ACT.Config;

[Serializable]
public class DramaTimelineData
{
	public readonly int id;

	public readonly string content = "";

	public readonly string eventAddress = "";

	public readonly int skipText;

	public DramaTimelineData(int id, string content, string eventAddress, int skipText)
	{
		this.id = id;
		this.content = content;
		this.eventAddress = eventAddress;
		this.skipText = skipText;
	}
}
