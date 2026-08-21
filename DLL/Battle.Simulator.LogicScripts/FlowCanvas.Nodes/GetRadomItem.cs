using System;
using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("在list<int>中随机获取一个值", 0)]
[Category("Logic/Random")]
[Description("在list中随机获取一个值")]
public class GetRadomItem : CallableFunctionNode<int, List<int>>
{
	public override int Invoke(List<int> list)
	{
		try
		{
			int index = (int)DRandom.Random((uint)list.Count);
			return list[index];
		}
		catch (Exception)
		{
			Debug.Log("List为空");
			return 0;
		}
	}
}
