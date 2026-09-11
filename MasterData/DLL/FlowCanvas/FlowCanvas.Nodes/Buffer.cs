using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Time")]
[Description("Input values are buffered and returned in order of buffering once the buffered amount reaches the buffer size. In practice this creates a delayed value output when the node is constantly updated per-frame.\nWhen the node ceases to update, a new buffer is created.")]
[ExposeAsDefinition]
public class Buffer<T> : PureFunctionNode<T, T, int>
{
	private int lastFrame = -10;

	private Queue<T> q;

	public override T Invoke(T value, int size = 60)
	{
		int frameCount = Time.frameCount;
		if (frameCount - lastFrame > 1)
		{
			q = new Queue<T>();
		}
		lastFrame = frameCount;
		q.Enqueue(value);
		if (q.Count < size)
		{
			return q.Peek();
		}
		return q.Dequeue();
	}
}
