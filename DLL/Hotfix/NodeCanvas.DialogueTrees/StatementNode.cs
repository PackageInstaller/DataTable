using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Name("Say", 0)]
[Description("Make the selected Dialogue Actor talk. You can make the text more dynamic by using variable names in square brackets\ne.g. [myVarName] or [Global/myVarName]")]
public class StatementNode : DTNode
{
	[SerializeField]
	public Statement statement = new Statement("This is a dialogue text");

	public override bool requireActorSelection => true;

	protected override Status OnExecute(Component agent, IBlackboard bb)
	{
		IStatement statement = this.statement.BlackboardReplace(bb);
		DialogueTree.RequestSubtitles(new SubtitlesRequestInfo(base.finalActor, statement, OnStatementFinish));
		return Status.Running;
	}

	private void OnStatementFinish()
	{
		base.status = Status.Success;
		base.DLGTree.Continue();
	}
}
