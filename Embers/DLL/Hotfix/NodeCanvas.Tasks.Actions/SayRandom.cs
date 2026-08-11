using System.Collections.Generic;
using NodeCanvas.DialogueTrees;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Dialogue")]
[Icon("Dialogue", false, "")]
[Description("A random statement will be chosen each time for the actor to say")]
public class SayRandom : ActionTask<IDialogueActor>
{
	public List<Statement> statements = new List<Statement>();

	protected override void OnExecute()
	{
		int index = Random.Range(0, statements.Count);
		IStatement statement = statements[index].BlackboardReplace(base.blackboard);
		DialogueTree.RequestSubtitles(new SubtitlesRequestInfo(base.agent, statement, base.EndAction));
	}
}
