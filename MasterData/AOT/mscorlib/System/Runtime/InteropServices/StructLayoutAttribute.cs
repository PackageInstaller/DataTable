using System.Reflection;

namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct, Inherited = false)]
[ComVisible(true)]
public sealed class StructLayoutAttribute : Attribute
{
	internal LayoutKind _val;

	public int Pack;

	public int Size;

	public CharSet CharSet;

	internal static StructLayoutAttribute GetCustomAttribute(RuntimeType type)
	{
		if (!IsDefined(type))
		{
			return null;
		}
		int packing = 0;
		int size = 0;
		LayoutKind layoutKind = LayoutKind.Auto;
		switch (type.Attributes & TypeAttributes.LayoutMask)
		{
		case TypeAttributes.ExplicitLayout:
			layoutKind = LayoutKind.Explicit;
			break;
		case TypeAttributes.NotPublic:
			layoutKind = LayoutKind.Auto;
			break;
		case TypeAttributes.SequentialLayout:
			layoutKind = LayoutKind.Sequential;
			break;
		}
		CharSet charSet = CharSet.None;
		switch (type.Attributes & TypeAttributes.StringFormatMask)
		{
		case TypeAttributes.NotPublic:
			charSet = CharSet.Ansi;
			break;
		case TypeAttributes.AutoClass:
			charSet = CharSet.Auto;
			break;
		case TypeAttributes.UnicodeClass:
			charSet = CharSet.Unicode;
			break;
		}
		type.GetPacking(out packing, out size);
		if (packing == 0)
		{
			packing = 8;
		}
		return new StructLayoutAttribute(layoutKind, packing, size, charSet);
	}

	internal static bool IsDefined(RuntimeType type)
	{
		if (type.IsInterface || type.HasElementType || type.IsGenericParameter)
		{
			return false;
		}
		return true;
	}

	internal StructLayoutAttribute(LayoutKind layoutKind, int pack, int size, CharSet charSet)
	{
		_val = layoutKind;
		Pack = pack;
		Size = size;
		CharSet = charSet;
	}
}
