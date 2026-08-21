using NodeCanvas.DialogueTrees;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("Dialogue")]
[Description("You can use a variable inline with the text by using brackets likeso: [myVarName] or [Global/myVarName].\nThe bracket will be replaced with the variable value ToString")]
[Icon("Dialogue", false, "")]
public class Say : ActionTask<IDialogueActor>
{
	public Statement statement = new Statement("This is a dialogue text...");

	protected override string info => $"<i>' {statement.text.CapLength(30)} '</i>";

	protected override void OnExecute()
	{
		IStatement statement = this.statement.BlackboardReplace(base.blackboard);
		DialogueTree.RequestSubtitles(new SubtitlesRequestInfo(base.agent, statement, base.EndAction));
	}
}
