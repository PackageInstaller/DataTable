using UnityEngine;

public interface IBubbleHost
{
	Bounds Bounds { get; }

	int BubbleRootCnt { get; }

	bool QueryBubbleRoot(int bubbleHandle, out Transform rootTrs, out Vector3 offset);
}
