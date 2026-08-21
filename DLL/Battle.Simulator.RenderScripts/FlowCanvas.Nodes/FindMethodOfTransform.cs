using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Transform的Find", 0)]
[Category("Render/Asset")]
[Description("封装一下Transform的Find的find方法,屏蔽2017和2018的不同")]
public class FindMethodOfTransform : PureFunctionNode<Transform, string, Transform>
{
	public override Transform Invoke(string name, Transform parent)
	{
		if (parent == null)
		{
			return null;
		}
		return parent.Find(name);
	}
}
