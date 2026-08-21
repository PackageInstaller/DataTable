using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Utility")]
[Description("Force Finish the current graph this Task is assigned to.")]
public class ForceFinishGraph : ActionTask
{
	public CompactStatus finishStatus = CompactStatus.Success;

	protected override void OnExecute()
	{
		Graph graph = base.ownerSystem as Graph;
		if (graph != null)
		{
			graph.Stop(finishStatus == CompactStatus.Success);
		}
		EndAction(finishStatus == CompactStatus.Success);
	}
}
