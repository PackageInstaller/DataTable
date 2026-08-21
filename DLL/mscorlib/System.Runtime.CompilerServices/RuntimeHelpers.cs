using System.Runtime.ConstrainedExecution;
using System.Runtime.Serialization;

namespace System.Runtime.CompilerServices;

public static class RuntimeHelpers
{
	public delegate void TryCode(object userData);

	public delegate void CleanupCode(object userData, bool exceptionThrown);

	public static extern int OffsetToStringData
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InitializeArray(Array array, IntPtr fldHandle);

	public static void InitializeArray(Array array, RuntimeFieldHandle fldHandle)
	{
		if (array == null || fldHandle.Value == IntPtr.Zero)
		{
			throw new ArgumentNullException();
		}
		InitializeArray(array, fldHandle.Value);
	}

	public static int GetHashCode(object o)
	{
		return object.InternalGetHashCode(o);
	}

	public new static bool Equals(object o1, object o2)
	{
		if (o1 == o2)
		{
			return true;
		}
		if (o1 == null || o2 == null)
		{
			return false;
		}
		if (o1 is ValueType)
		{
			return ValueType.DefaultEquals(o1, o2);
		}
		return object.Equals(o1, o2);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern object GetObjectValue(object obj);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RunClassConstructor(IntPtr type);

	public static void RunClassConstructor(RuntimeTypeHandle type)
	{
		if (type.Value == IntPtr.Zero)
		{
			throw new ArgumentException("Handle is not initialized.", "type");
		}
		RunClassConstructor(type.Value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool SufficientExecutionStack();

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static void EnsureSufficientExecutionStack()
	{
		if (SufficientExecutionStack())
		{
			return;
		}
		throw new InsufficientExecutionStackException();
	}

	public static bool TryEnsureSufficientExecutionStack()
	{
		return SufficientExecutionStack();
	}

	public static void ExecuteCodeWithGuaranteedCleanup(TryCode code, CleanupCode backoutCode, object userData)
	{
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static void PrepareConstrainedRegions()
	{
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static void PrepareConstrainedRegionsNoOP()
	{
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static void ProbeForSufficientStack()
	{
	}

	public static void PrepareDelegate(Delegate d)
	{
	}

	public static void PrepareContractedDelegate(Delegate d)
	{
	}

	public static void PrepareMethod(RuntimeMethodHandle method)
	{
	}

	public static void PrepareMethod(RuntimeMethodHandle method, RuntimeTypeHandle[] instantiation)
	{
	}

	public static void RunModuleConstructor(ModuleHandle module)
	{
		if (module == ModuleHandle.EmptyHandle)
		{
			throw new ArgumentException("Handle is not initialized.", "module");
		}
		RunModuleConstructor(module.Value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RunModuleConstructor(IntPtr module);

	public static bool IsReferenceOrContainsReferences<T>()
	{
		if (typeof(T).IsValueType)
		{
			return RuntimeTypeHandle.HasReferences(typeof(T) as RuntimeType);
		}
		return true;
	}

	public static object GetUninitializedObject(Type type)
	{
		return FormatterServices.GetUninitializedObject(type);
	}

	public static T[] GetSubArray<T>(T[] array, Range range)
	{
		Type elementType = array.GetType().GetElementType();
		Span<T> span = array.AsSpan(range);
		if (elementType.IsValueType)
		{
			return span.ToArray();
		}
		T[] array2 = (T[])Array.CreateInstance(elementType, span.Length);
		span.CopyTo(array2);
		return array2;
	}
}
