using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.DebugGUI;

public class TraceMonitor : EntityBehaveMonitor
{
	private Vector3 lastPos;

	public override void OnUpdate()
	{
		CompTransform compTransform = eb.GetCompTransform();
		if (DebugWindowManager.instance.debugTrace)
		{
			Debug.DrawLine(compTransform.colliderPosition, lastPos, DebugWindowManager.instance.traceColor, DebugWindowManager.instance.traceTime);
		}
		lastPos = compTransform.colliderPosition;
	}
}
