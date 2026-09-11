using System.Text;

namespace System;

internal class PointerSpec : ModifierSpec
{
	private int pointer_level;

	internal PointerSpec(int pointer_level)
	{
		this.pointer_level = pointer_level;
	}

	public Type Resolve(Type type)
	{
		for (int i = 0; i < pointer_level; i++)
		{
			type = type.MakePointerType();
		}
		return type;
	}

	public StringBuilder Append(StringBuilder sb)
	{
		return sb.Append('*', pointer_level);
	}

	public override string ToString()
	{
		return Append(new StringBuilder()).ToString();
	}
}
