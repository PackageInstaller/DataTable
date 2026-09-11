using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Threading;

namespace System;

[Serializable]
[ComVisible(true)]
public struct RuntimeTypeHandle : ISerializable
{
	private IntPtr value;

	public IntPtr Value => value;

	internal RuntimeTypeHandle(IntPtr val)
	{
		value = val;
	}

	internal RuntimeTypeHandle(RuntimeType type)
		: this(type._impl.value)
	{
	}

	private RuntimeTypeHandle(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		RuntimeType runtimeType = (RuntimeType)info.GetValue("TypeObj", typeof(RuntimeType));
		value = runtimeType.TypeHandle.Value;
		if (value == IntPtr.Zero)
		{
			throw new SerializationException("Insufficient state.");
		}
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		if (value == IntPtr.Zero)
		{
			throw new SerializationException("Object fields may not be properly initialized");
		}
		info.AddValue("TypeObj", Type.GetTypeHandle(this), typeof(RuntimeType));
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public override bool Equals(object obj)
	{
		if (obj == null || GetType() != obj.GetType())
		{
			return false;
		}
		return value == ((RuntimeTypeHandle)obj).Value;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public bool Equals(RuntimeTypeHandle handle)
	{
		return value == handle.Value;
	}

	public override int GetHashCode()
	{
		return value.GetHashCode();
	}

	public static bool operator ==(RuntimeTypeHandle left, object right)
	{
		if (right != null && right is RuntimeTypeHandle)
		{
			return left.Equals((RuntimeTypeHandle)right);
		}
		return false;
	}

	public static bool operator !=(RuntimeTypeHandle left, object right)
	{
		if (right != null && right is RuntimeTypeHandle)
		{
			return !left.Equals((RuntimeTypeHandle)right);
		}
		return true;
	}

	public static bool operator ==(object left, RuntimeTypeHandle right)
	{
		if (left != null && left is RuntimeTypeHandle runtimeTypeHandle)
		{
			return runtimeTypeHandle.Equals(right);
		}
		return false;
	}

	public static bool operator !=(object left, RuntimeTypeHandle right)
	{
		if (left != null && left is RuntimeTypeHandle runtimeTypeHandle)
		{
			return !runtimeTypeHandle.Equals(right);
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern TypeAttributes GetAttributes(RuntimeType type);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	[CLSCompliant(false)]
	public ModuleHandle GetModuleHandle()
	{
		if (value == IntPtr.Zero)
		{
			throw new InvalidOperationException("Object fields may not be properly initialized");
		}
		return Type.GetTypeFromHandle(this).Module.ModuleHandle;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetMetadataToken(RuntimeType type);

	internal static int GetToken(RuntimeType type)
	{
		return GetMetadataToken(type);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type GetGenericTypeDefinition_impl(RuntimeType type);

	internal static Type GetGenericTypeDefinition(RuntimeType type)
	{
		return GetGenericTypeDefinition_impl(type);
	}

	internal static bool HasProxyAttribute(RuntimeType type)
	{
		throw new NotImplementedException("HasProxyAttribute");
	}

	internal static bool IsPrimitive(RuntimeType type)
	{
		CorElementType corElementType = GetCorElementType(type);
		if (((int)corElementType < 2 || (int)corElementType > 13) && corElementType != CorElementType.I)
		{
			return corElementType == CorElementType.U;
		}
		return true;
	}

	internal static bool IsByRef(RuntimeType type)
	{
		return GetCorElementType(type) == CorElementType.ByRef;
	}

	internal static bool IsPointer(RuntimeType type)
	{
		return GetCorElementType(type) == CorElementType.Ptr;
	}

	internal static bool IsArray(RuntimeType type)
	{
		CorElementType corElementType = GetCorElementType(type);
		if (corElementType != CorElementType.Array)
		{
			return corElementType == CorElementType.SzArray;
		}
		return true;
	}

	internal static bool IsSzArray(RuntimeType type)
	{
		return GetCorElementType(type) == CorElementType.SzArray;
	}

	internal static bool HasElementType(RuntimeType type)
	{
		CorElementType corElementType = GetCorElementType(type);
		if (corElementType != CorElementType.Array && corElementType != CorElementType.SzArray && corElementType != CorElementType.Ptr)
		{
			return corElementType == CorElementType.ByRef;
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern CorElementType GetCorElementType(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool HasInstantiation(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool IsComObject(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool IsInstanceOfType(RuntimeType type, object o);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool HasReferences(RuntimeType type);

	internal static bool IsComObject(RuntimeType type, bool isGenericCOM)
	{
		if (!isGenericCOM)
		{
			return IsComObject(type);
		}
		return false;
	}

	internal static bool IsContextful(RuntimeType type)
	{
		return typeof(ContextBoundObject).IsAssignableFrom(type);
	}

	internal static bool IsEquivalentTo(RuntimeType rtType1, RuntimeType rtType2)
	{
		return false;
	}

	internal static bool IsInterface(RuntimeType type)
	{
		return (type.Attributes & TypeAttributes.ClassSemanticsMask) == TypeAttributes.ClassSemanticsMask;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int GetArrayRank(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern RuntimeAssembly GetAssembly(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern RuntimeType GetElementType(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern RuntimeModule GetModule(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool IsGenericVariable(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern RuntimeType GetBaseType(RuntimeType type);

	internal static bool CanCastTo(RuntimeType type, RuntimeType target)
	{
		return type_is_assignable_from(target, type);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool type_is_assignable_from(Type a, Type b);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool IsGenericTypeDefinition(RuntimeType type);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern IntPtr GetGenericParameterInfo(RuntimeType type);

	internal static bool IsSubclassOf(RuntimeType childType, RuntimeType baseType)
	{
		return is_subclass_of(childType._impl.Value, baseType._impl.Value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool is_subclass_of(IntPtr childType, IntPtr baseType);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool IsByRefLike(RuntimeType type);

	internal static bool IsTypeDefinition(RuntimeType type)
	{
		if (!type.HasElementType && !type.IsConstructedGenericType)
		{
			return !type.IsGenericParameter;
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern RuntimeType internal_from_name(string name, ref StackCrawlMark stackMark, Assembly callerAssembly, bool throwOnError, bool ignoreCase, bool reflectionOnly);

	internal static RuntimeType GetTypeByName(string typeName, bool throwOnError, bool ignoreCase, bool reflectionOnly, ref StackCrawlMark stackMark, bool loadTypeFromPartialName)
	{
		if (typeName == null)
		{
			throw new ArgumentNullException("typeName");
		}
		if (typeName == string.Empty)
		{
			if (throwOnError)
			{
				throw new TypeLoadException("A null or zero length string does not represent a valid Type.");
			}
			return null;
		}
		if (reflectionOnly)
		{
			int num = typeName.IndexOf(',');
			if (num < 0 || num == 0 || num == typeName.Length - 1)
			{
				throw new ArgumentException("Assembly qualifed type name is required", "typeName");
			}
			string assemblyString = typeName.Substring(num + 1);
			Assembly assembly;
			try
			{
				assembly = Assembly.ReflectionOnlyLoad(assemblyString);
			}
			catch
			{
				if (throwOnError)
				{
					throw;
				}
				return null;
			}
			return (RuntimeType)assembly.GetType(typeName.Substring(0, num), throwOnError, ignoreCase);
		}
		RuntimeType runtimeType = internal_from_name(typeName, ref stackMark, null, throwOnError, ignoreCase, reflectionOnly: false);
		if (throwOnError && runtimeType == null)
		{
			throw new TypeLoadException("Error loading '" + typeName + "'");
		}
		return runtimeType;
	}

	internal static IntPtr[] CopyRuntimeTypeHandles(RuntimeTypeHandle[] inHandles, out int length)
	{
		if (inHandles == null || inHandles.Length == 0)
		{
			length = 0;
			return null;
		}
		IntPtr[] array = new IntPtr[inHandles.Length];
		for (int i = 0; i < inHandles.Length; i++)
		{
			array[i] = inHandles[i].Value;
		}
		length = array.Length;
		return array;
	}
}
