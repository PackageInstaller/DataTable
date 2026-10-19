using System;

namespace ACT.DialogueSystem;

public class CustomNodeItemDrawerAttribute : Attribute
{
	public Type targetNodeType;

	public CustomNodeItemDrawerAttribute(Type targetNodeType)
	{
		this.targetNodeType = targetNodeType;
	}
}
