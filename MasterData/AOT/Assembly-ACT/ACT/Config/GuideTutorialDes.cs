using System;

namespace ACT.Config;

[Serializable]
public class GuideTutorialDes
{
	public readonly int id;

	public readonly int type;

	public readonly int tutorialTitle;

	public readonly string[] actionPrompt = new string[0];

	public GuideTutorialDes(int id, int type, int tutorialTitle, string[] actionPrompt)
	{
		this.id = id;
		this.type = type;
		this.tutorialTitle = tutorialTitle;
		this.actionPrompt = actionPrompt;
	}
}
