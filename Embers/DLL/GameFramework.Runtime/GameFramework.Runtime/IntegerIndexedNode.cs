using System;
using System.Text;

namespace GameFramework.Runtime;

[Serializable]
public class IntegerIndexedNode : IndexedNode<int>
{
	public IntegerIndexedNode(int indexValue)
		: base(indexValue)
	{
	}

	public override void AppendTo(StringBuilder output)
	{
		output.AppendFormat("[{0}]", base.Value);
	}
}
