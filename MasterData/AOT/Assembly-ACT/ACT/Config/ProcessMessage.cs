using System;

namespace ACT.Config;

[Serializable]
public class ProcessMessage
{
	public readonly int id;

	public readonly int processTitle;

	public readonly int processText;

	public ProcessMessage(int id, int processTitle, int processText)
	{
		this.id = id;
		this.processTitle = processTitle;
		this.processText = processText;
	}
}
