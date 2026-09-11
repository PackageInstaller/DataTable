using System.Collections.Generic;
using UnityEngine;

namespace FlowCanvas.Nodes;

public class IntCurve
{
	public List<Int2> frame = new List<Int2>();

	public IntCurve(List<Int2> p)
	{
		if (p != null)
		{
			frame = p;
		}
	}

	public IntCurve()
	{
	}

	public int Evaluate(int x)
	{
		if (frame == null && frame.Count == 0)
		{
			return 0;
		}
		if (x < frame[0].x)
		{
			return frame[0].y;
		}
		int num = frame.Count - 1;
		for (int i = 0; i < num; i++)
		{
			Int2 @int = frame[i];
			Int2 int2 = frame[i + 1];
			if (@int.x <= x && x < int2.x)
			{
				long num2 = ((long)int2.y - (long)@int.y) * ((long)x - (long)@int.x) / ((long)int2.x - (long)@int.x);
				return (int)(@int.y + num2);
			}
		}
		return frame[num].y;
	}

	public void ParseToAnimationCurve(AnimationCurve animationCurve)
	{
	}

	public void ParseFromAnimationCurve(AnimationCurve animationCurve)
	{
	}
}
