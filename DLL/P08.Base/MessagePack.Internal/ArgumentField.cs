using System;
using System.Reflection;
using System.Reflection.Emit;

namespace MessagePack.Internal;

internal struct ArgumentField
{
	private readonly int i;

	private readonly bool @ref;

	private readonly ILGenerator il;

	public ArgumentField(ILGenerator il, int i, bool @ref = false)
	{
		this.il = il;
		this.i = i;
		this.@ref = @ref;
	}

	public ArgumentField(ILGenerator il, int i, Type type)
	{
		this.il = il;
		this.i = i;
		TypeInfo typeInfo = type.GetTypeInfo();
		@ref = ((!typeInfo.IsClass && !typeInfo.IsInterface && !typeInfo.IsAbstract) ? true : false);
	}

	public void EmitLoad()
	{
		if (@ref)
		{
			il.EmitLdarga(i);
		}
		else
		{
			il.EmitLdarg(i);
		}
	}

	public void EmitLdarg()
	{
		il.EmitLdarg(i);
	}

	public void EmitLdarga()
	{
		il.EmitLdarga(i);
	}

	public void EmitStore()
	{
		il.EmitStarg(i);
	}
}
