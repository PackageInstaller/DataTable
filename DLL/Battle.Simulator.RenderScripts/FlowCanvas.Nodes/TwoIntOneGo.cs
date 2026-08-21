using UnityEngine;

namespace FlowCanvas.Nodes;

public class TwoIntOneGo : IFramePooledObject
{
	public int Int1;

	public int Int2;

	public GameObject Go;

	public void OnEnterPool()
	{
		Int1 = 0;
		Int2 = 0;
		Go = null;
	}
}
