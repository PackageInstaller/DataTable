using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("从List<float>中取出最小值(Min)", 0)]
[Category("Common/Math")]
[Description("从List<float>中取出最小值,如果长度为0,则取出的值为 float.MaxValue")]
public class MinFormList : PureFunctionNode<float, List<float>>
{
	public override float Invoke(List<float> floatList)
	{
		float num = float.MaxValue;
		for (int i = 0; i < floatList.Count; i++)
		{
			if (floatList[i] < num)
			{
				num = floatList[i];
			}
		}
		return num;
	}
}
