using System;

namespace NodeCanvas.DialogueTrees;

public class SubtitlesRequestInfo
{
	public IDialogueActor actor;

	public IStatement statement;

	public Action Continue;

	public SubtitlesRequestInfo(IDialogueActor actor, IStatement statement, Action callback)
	{
		this.actor = actor;
		this.statement = statement;
		Continue = callback;
	}
}
