using System;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;

namespace MessagePack.Internal;

internal static class ILGeneratorExtensions
{
	public static void EmitLdloc(this ILGenerator il, int index)
	{
		switch (index)
		{
		case 0:
			il.Emit(OpCodes.Ldloc_0);
			return;
		case 1:
			il.Emit(OpCodes.Ldloc_1);
			return;
		case 2:
			il.Emit(OpCodes.Ldloc_2);
			return;
		case 3:
			il.Emit(OpCodes.Ldloc_3);
			return;
		}
		if (index <= 255)
		{
			il.Emit(OpCodes.Ldloc_S, (byte)index);
		}
		else
		{
			il.Emit(OpCodes.Ldloc, (short)index);
		}
	}

	public static void EmitLdloc(this ILGenerator il, LocalBuilder local)
	{
		il.EmitLdloc(local.LocalIndex);
	}

	public static void EmitStloc(this ILGenerator il, int index)
	{
		switch (index)
		{
		case 0:
			il.Emit(OpCodes.Stloc_0);
			return;
		case 1:
			il.Emit(OpCodes.Stloc_1);
			return;
		case 2:
			il.Emit(OpCodes.Stloc_2);
			return;
		case 3:
			il.Emit(OpCodes.Stloc_3);
			return;
		}
		if (index <= 255)
		{
			il.Emit(OpCodes.Stloc_S, (byte)index);
		}
		else
		{
			il.Emit(OpCodes.Stloc, (short)index);
		}
	}

	public static void EmitStloc(this ILGenerator il, LocalBuilder local)
	{
		il.EmitStloc(local.LocalIndex);
	}

	public static void EmitLdloca(this ILGenerator il, int index)
	{
		if (index <= 255)
		{
			il.Emit(OpCodes.Ldloca_S, (byte)index);
		}
		else
		{
			il.Emit(OpCodes.Ldloca, (short)index);
		}
	}

	public static void EmitLdloca(this ILGenerator il, LocalBuilder local)
	{
		il.EmitLdloca(local.LocalIndex);
	}

	public static void EmitTrue(this ILGenerator il)
	{
		il.EmitBoolean(value: true);
	}

	public static void EmitFalse(this ILGenerator il)
	{
		il.EmitBoolean(value: false);
	}

	public static void EmitBoolean(this ILGenerator il, bool value)
	{
		il.EmitLdc_I4(value ? 1 : 0);
	}

	public static void EmitLdc_I4(this ILGenerator il, int value)
	{
		switch (value)
		{
		case -1:
			il.Emit(OpCodes.Ldc_I4_M1);
			return;
		case 0:
			il.Emit(OpCodes.Ldc_I4_0);
			return;
		case 1:
			il.Emit(OpCodes.Ldc_I4_1);
			return;
		case 2:
			il.Emit(OpCodes.Ldc_I4_2);
			return;
		case 3:
			il.Emit(OpCodes.Ldc_I4_3);
			return;
		case 4:
			il.Emit(OpCodes.Ldc_I4_4);
			return;
		case 5:
			il.Emit(OpCodes.Ldc_I4_5);
			return;
		case 6:
			il.Emit(OpCodes.Ldc_I4_6);
			return;
		case 7:
			il.Emit(OpCodes.Ldc_I4_7);
			return;
		case 8:
			il.Emit(OpCodes.Ldc_I4_8);
			return;
		}
		if (value >= -128 && value <= 127)
		{
			il.Emit(OpCodes.Ldc_I4_S, (sbyte)value);
		}
		else
		{
			il.Emit(OpCodes.Ldc_I4, value);
		}
	}

	public static void EmitUnboxOrCast(this ILGenerator il, Type type)
	{
		if (type.GetTypeInfo().IsValueType)
		{
			il.Emit(OpCodes.Unbox_Any, type);
		}
		else
		{
			il.Emit(OpCodes.Castclass, type);
		}
	}

	public static void EmitBoxOrDoNothing(this ILGenerator il, Type type)
	{
		if (type.GetTypeInfo().IsValueType)
		{
			il.Emit(OpCodes.Box, type);
		}
	}

	public static void EmitLdarg(this ILGenerator il, int index)
	{
		switch (index)
		{
		case 0:
			il.Emit(OpCodes.Ldarg_0);
			return;
		case 1:
			il.Emit(OpCodes.Ldarg_1);
			return;
		case 2:
			il.Emit(OpCodes.Ldarg_2);
			return;
		case 3:
			il.Emit(OpCodes.Ldarg_3);
			return;
		}
		if (index <= 255)
		{
			il.Emit(OpCodes.Ldarg_S, (byte)index);
		}
		else
		{
			il.Emit(OpCodes.Ldarg, index);
		}
	}

	public static void EmitLoadThis(this ILGenerator il)
	{
		il.EmitLdarg(0);
	}

	public static void EmitLdarga(this ILGenerator il, int index)
	{
		if (index <= 255)
		{
			il.Emit(OpCodes.Ldarga_S, (byte)index);
		}
		else
		{
			il.Emit(OpCodes.Ldarga, index);
		}
	}

	public static void EmitStarg(this ILGenerator il, int index)
	{
		if (index <= 255)
		{
			il.Emit(OpCodes.Starg_S, (byte)index);
		}
		else
		{
			il.Emit(OpCodes.Starg, index);
		}
	}

	public static void EmitPop(this ILGenerator il, int count)
	{
		for (int i = 0; i < count; i++)
		{
			il.Emit(OpCodes.Pop);
		}
	}

	public static void EmitCall(this ILGenerator il, MethodInfo methodInfo)
	{
		if (methodInfo.IsFinal || !methodInfo.IsVirtual)
		{
			il.Emit(OpCodes.Call, methodInfo);
		}
		else
		{
			il.Emit(OpCodes.Callvirt, methodInfo);
		}
	}

	public static void EmitLdfld(this ILGenerator il, FieldInfo fieldInfo)
	{
		il.Emit(OpCodes.Ldfld, fieldInfo);
	}

	public static void EmitLdsfld(this ILGenerator il, FieldInfo fieldInfo)
	{
		il.Emit(OpCodes.Ldsfld, fieldInfo);
	}

	public static void EmitRet(this ILGenerator il)
	{
		il.Emit(OpCodes.Ret);
	}

	public static void EmitIntZeroReturn(this ILGenerator il)
	{
		il.EmitLdc_I4(0);
		il.Emit(OpCodes.Ret);
	}

	public static void EmitNullReturn(this ILGenerator il)
	{
		il.Emit(OpCodes.Ldnull);
		il.Emit(OpCodes.Ret);
	}

	public static void EmitULong(this ILGenerator il, ulong value)
	{
		il.Emit(OpCodes.Ldc_I8, (long)value);
	}

	public static void EmitThrowNotimplemented(this ILGenerator il)
	{
		il.Emit(OpCodes.Newobj, typeof(NotImplementedException).GetTypeInfo().DeclaredConstructors.First((ConstructorInfo x) => x.GetParameters().Length == 0));
		il.Emit(OpCodes.Throw);
	}

	public static void EmitIncrementFor(this ILGenerator il, LocalBuilder conditionGreater, Action<LocalBuilder> emitBody)
	{
		Label label = il.DefineLabel();
		Label label2 = il.DefineLabel();
		LocalBuilder localBuilder = il.DeclareLocal(typeof(int));
		il.EmitLdc_I4(0);
		il.EmitStloc(localBuilder);
		il.Emit(OpCodes.Br, label2);
		il.MarkLabel(label);
		emitBody(localBuilder);
		il.EmitLdloc(localBuilder);
		il.EmitLdc_I4(1);
		il.Emit(OpCodes.Add);
		il.EmitStloc(localBuilder);
		il.MarkLabel(label2);
		il.EmitLdloc(localBuilder);
		il.EmitLdloc(conditionGreater);
		il.Emit(OpCodes.Blt, label);
	}
}
