using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("生成一个Int3(y = 0)", 0)]
[Category("Logic/Random")]
[Description("随机生成一个Int3,xz都在正负给定范围内,y = 0,范围必须大于0")]
public class GetRandomInt2 : PureFunctionNode<Int3, int>
{
	public override Int3 Invoke(int range)
	{
		try
		{
			int x = (int)DRandom.Random((uint)(range * 2)) - range;
			int z = (int)DRandom.Random((uint)(range * 2)) - range;
			return new Int3(x, 0, z);
		}
		catch (Exception)
		{
			Debug.Log("生成一个Int3----范围要大于0");
			return default(Int3);
		}
	}
}
