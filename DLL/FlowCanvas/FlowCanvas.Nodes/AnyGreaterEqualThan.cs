using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators/Any")]
[Name("≥", 0)]
[Description("Any Greater Or Equal Than")]
public class AnyGreaterEqualThan : PureFunctionNode<bool, IComparable, IComparable>
{
	public override bool Invoke(IComparable a, IComparable b)
	{
		if (a.CompareTo(b) != 1)
		{
			return object.Equals(a, b);
		}
		return true;
	}
}
