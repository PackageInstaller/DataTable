using System;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Logic Operators")]
[Description("Returns whether the input object is of type T as well as the object itself for convenience.")]
public class IsOfType : PureFunctionNode<bool, object, Type>
{
	public object OBJECT { get; private set; }

	public override bool Invoke(object OBJECT, Type type)
	{
		this.OBJECT = OBJECT;
		if (OBJECT != null)
		{
			return type.RTIsAssignableFrom(OBJECT.GetType());
		}
		return false;
	}
}
