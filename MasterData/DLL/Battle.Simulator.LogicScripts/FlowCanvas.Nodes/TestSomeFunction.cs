using UnityEngine;

namespace FlowCanvas.Nodes;

public class TestSomeFunction : FlowNode
{
	protected override void RegisterPorts()
	{
		AddFlowInput("", delegate
		{
			int mCurrentAliveMonsterCount = CommonProcessor.GetWorldState().mCurrentAliveMonsterCount;
			Debug.Log("活着的敌人数量(hp > 0) = " + mCurrentAliveMonsterCount);
		});
	}
}
