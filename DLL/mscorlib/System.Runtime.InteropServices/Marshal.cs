using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Resources;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices.ComTypes;
using System.Runtime.Remoting;
using System.Runtime.Serialization;
using System.Security;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using Unity;

namespace System.Runtime.InteropServices;

public static class Marshal
{
	internal delegate IntPtr SecureStringAllocator(int len);

	internal class MarshalerInstanceKeyComparer : IEqualityComparer<(Type, string)>
	{
		public bool Equals((Type, string) lhs, (Type, string) rhs)
		{
			return lhs.CompareTo(rhs) == 0;
		}

		public int GetHashCode((Type, string) key)
		{
			return key.GetHashCode();
		}
	}

	public static readonly int SystemMaxDBCSCharSize = 2;

	public static readonly int SystemDefaultCharSize = ((!Environment.IsRunningOnWindows) ? 1 : 2);

	internal static Dictionary<(Type, string), ICustomMarshaler> MarshalerInstanceCache;

	internal static readonly object MarshalerInstanceCacheLock = new object();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int AddRefInternal(IntPtr pUnk);

	public static int AddRef(IntPtr pUnk)
	{
		if (pUnk == IntPtr.Zero)
		{
			throw new ArgumentNullException("pUnk");
		}
		return AddRefInternal(pUnk);
	}

	public static bool AreComObjectsAvailableForCleanup()
	{
		return false;
	}

	public static void CleanupUnusedObjectsInCurrentContext()
	{
		if (Environment.IsRunningOnWindows)
		{
			throw new PlatformNotSupportedException();
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr AllocCoTaskMem(int cb);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern IntPtr AllocCoTaskMemSize(UIntPtr sizet);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static extern IntPtr AllocHGlobal(IntPtr cb);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static IntPtr AllocHGlobal(int cb)
	{
		return AllocHGlobal((IntPtr)cb);
	}

	public static object BindToMoniker(string monikerName)
	{
		throw new NotImplementedException();
	}

	public static void ChangeWrapperHandleStrength(object otp, bool fIsWeak)
	{
		throw new NotImplementedException();
	}

	internal unsafe static void copy_to_unmanaged(Array source, int startIndex, IntPtr destination, int length)
	{
		copy_to_unmanaged_fixed(source, startIndex, destination, length, null);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void copy_to_unmanaged_fixed(Array source, int startIndex, IntPtr destination, int length, void* fixed_source_element);

	private static bool skip_fixed(Array array, int startIndex)
	{
		if (startIndex >= 0)
		{
			return startIndex >= array.Length;
		}
		return true;
	}

	internal unsafe static void copy_to_unmanaged(byte[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged_fixed(source, startIndex, destination, length, null);
			return;
		}
		fixed (byte* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	internal unsafe static void copy_to_unmanaged(char[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged_fixed(source, startIndex, destination, length, null);
			return;
		}
		fixed (char* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(byte[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (byte* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(char[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (char* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(short[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (short* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(int[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (int* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(long[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (long* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(float[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (float* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(double[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (double* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	public unsafe static void Copy(IntPtr[] source, int startIndex, IntPtr destination, int length)
	{
		if (skip_fixed(source, startIndex))
		{
			copy_to_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (IntPtr* ptr = &source[startIndex])
		{
			void* fixed_source_element = ptr;
			copy_to_unmanaged_fixed(source, startIndex, destination, length, fixed_source_element);
		}
	}

	internal unsafe static void copy_from_unmanaged(IntPtr source, int startIndex, Array destination, int length)
	{
		copy_from_unmanaged_fixed(source, startIndex, destination, length, null);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void copy_from_unmanaged_fixed(IntPtr source, int startIndex, Array destination, int length, void* fixed_destination_element);

	public unsafe static void Copy(IntPtr source, byte[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (byte* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, char[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (char* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, short[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (short* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, int[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (int* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, long[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (long* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, float[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (float* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, double[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (double* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public unsafe static void Copy(IntPtr source, IntPtr[] destination, int startIndex, int length)
	{
		if (skip_fixed(destination, startIndex))
		{
			copy_from_unmanaged(source, startIndex, destination, length);
			return;
		}
		fixed (IntPtr* ptr = &destination[startIndex])
		{
			void* fixed_destination_element = ptr;
			copy_from_unmanaged_fixed(source, startIndex, destination, length, fixed_destination_element);
		}
	}

	public static IntPtr CreateAggregatedObject(IntPtr pOuter, object o)
	{
		throw new NotImplementedException();
	}

	public static IntPtr CreateAggregatedObject<T>(IntPtr pOuter, T o)
	{
		return CreateAggregatedObject(pOuter, (object)o);
	}

	public static object CreateWrapperOfType(object o, Type t)
	{
		throw new NotImplementedException("Marshal.CreateWrapperOfType is not implemented.");
	}

	public static TWrapper CreateWrapperOfType<T, TWrapper>(T o)
	{
		return (TWrapper)CreateWrapperOfType(o, typeof(TWrapper));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ComVisible(true)]
	public static extern void DestroyStructure(IntPtr ptr, Type structuretype);

	public static void DestroyStructure<T>(IntPtr ptr)
	{
		DestroyStructure(ptr, typeof(T));
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void FreeBSTR(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void FreeCoTaskMem(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern void FreeHGlobal(IntPtr hglobal);

	private static void ClearBSTR(IntPtr ptr)
	{
		int num = ReadInt32(ptr, -4);
		for (int i = 0; i < num; i++)
		{
			WriteByte(ptr, i, 0);
		}
	}

	public static void ZeroFreeBSTR(IntPtr s)
	{
		ClearBSTR(s);
		FreeBSTR(s);
	}

	private static void ClearAnsi(IntPtr ptr)
	{
		for (int i = 0; ReadByte(ptr, i) != 0; i++)
		{
			WriteByte(ptr, i, 0);
		}
	}

	private static void ClearUnicode(IntPtr ptr)
	{
		for (int i = 0; ReadInt16(ptr, i) != 0; i += 2)
		{
			WriteInt16(ptr, i, 0);
		}
	}

	public static void ZeroFreeCoTaskMemAnsi(IntPtr s)
	{
		ClearAnsi(s);
		FreeCoTaskMem(s);
	}

	public static void ZeroFreeCoTaskMemUnicode(IntPtr s)
	{
		ClearUnicode(s);
		FreeCoTaskMem(s);
	}

	public static void ZeroFreeCoTaskMemUTF8(IntPtr s)
	{
		ClearAnsi(s);
		FreeCoTaskMem(s);
	}

	public static void ZeroFreeGlobalAllocAnsi(IntPtr s)
	{
		ClearAnsi(s);
		FreeHGlobal(s);
	}

	public static void ZeroFreeGlobalAllocUnicode(IntPtr s)
	{
		ClearUnicode(s);
		FreeHGlobal(s);
	}

	public static Guid GenerateGuidForType(Type type)
	{
		return type.GUID;
	}

	public static string GenerateProgIdForType(Type type)
	{
		foreach (CustomAttributeData customAttribute in CustomAttributeData.GetCustomAttributes(type))
		{
			if (customAttribute.Constructor.DeclaringType.Name == "ProgIdAttribute")
			{
				_ = customAttribute.ConstructorArguments;
				string text = customAttribute.ConstructorArguments[0].Value as string;
				if (text == null)
				{
					text = string.Empty;
				}
				return text;
			}
		}
		return type.FullName;
	}

	public static object GetActiveObject(string progID)
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetCCW(object o, Type T);

	private static IntPtr GetComInterfaceForObjectInternal(object o, Type T)
	{
		return GetCCW(o, T);
	}

	public static IntPtr GetComInterfaceForObject(object o, Type T)
	{
		IntPtr comInterfaceForObjectInternal = GetComInterfaceForObjectInternal(o, T);
		AddRef(comInterfaceForObjectInternal);
		return comInterfaceForObjectInternal;
	}

	public static IntPtr GetComInterfaceForObject(object o, Type T, CustomQueryInterfaceMode mode)
	{
		throw new NotImplementedException();
	}

	public static IntPtr GetComInterfaceForObject<T, TInterface>(T o)
	{
		return GetComInterfaceForObject(o, typeof(T));
	}

	public static IntPtr GetComInterfaceForObjectInContext(object o, Type t)
	{
		throw new NotImplementedException();
	}

	public static object GetComObjectData(object obj, object key)
	{
		throw new NotSupportedException("MSDN states user code should never need to call this method.");
	}

	public static int GetComSlotForMethodInfo(MemberInfo m)
	{
		throw new NotImplementedException();
	}

	public static int GetEndComSlot(Type t)
	{
		throw new NotImplementedException();
	}

	[ComVisible(true)]
	public static IntPtr GetExceptionPointers()
	{
		throw new NotImplementedException();
	}

	public static IntPtr GetHINSTANCE(Module m)
	{
		if (m == null)
		{
			throw new ArgumentNullException("m");
		}
		if (m is RuntimeModule runtimeModule)
		{
			return RuntimeModule.GetHINSTANCE(runtimeModule.MonoModule);
		}
		return (IntPtr)(-1);
	}

	public static int GetExceptionCode()
	{
		throw new PlatformNotSupportedException();
	}

	public static int GetHRForException(Exception e)
	{
		return e?._HResult ?? 0;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static int GetHRForLastWin32Error()
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetIDispatchForObjectInternal(object o);

	public static IntPtr GetIDispatchForObject(object o)
	{
		IntPtr iDispatchForObjectInternal = GetIDispatchForObjectInternal(o);
		AddRef(iDispatchForObjectInternal);
		return iDispatchForObjectInternal;
	}

	public static IntPtr GetIDispatchForObjectInContext(object o)
	{
		throw new NotImplementedException();
	}

	public static IntPtr GetITypeInfoForType(Type t)
	{
		throw new NotImplementedException();
	}

	public static IntPtr GetIUnknownForObjectInContext(object o)
	{
		throw new NotImplementedException();
	}

	[Obsolete("This method has been deprecated")]
	public static IntPtr GetManagedThunkForUnmanagedMethodPtr(IntPtr pfnMethodToWrap, IntPtr pbSignature, int cbSignature)
	{
		throw new NotImplementedException();
	}

	public static MemberInfo GetMethodInfoForComSlot(Type t, int slot, ref ComMemberType memberType)
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetIUnknownForObjectInternal(object o);

	public static IntPtr GetIUnknownForObject(object o)
	{
		IntPtr iUnknownForObjectInternal = GetIUnknownForObjectInternal(o);
		AddRef(iUnknownForObjectInternal);
		return iUnknownForObjectInternal;
	}

	public static void GetNativeVariantForObject(object obj, IntPtr pDstNativeVariant)
	{
		Variant structure = default(Variant);
		structure.SetValue(obj);
		StructureToPtr(structure, pDstNativeVariant, fDeleteOld: false);
	}

	public static void GetNativeVariantForObject<T>(T obj, IntPtr pDstNativeVariant)
	{
		GetNativeVariantForObject((object)obj, pDstNativeVariant);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern object GetObjectForCCW(IntPtr pUnk);

	public static object GetObjectForIUnknown(IntPtr pUnk)
	{
		return GetObjectForCCW(pUnk);
	}

	public static object GetObjectForNativeVariant(IntPtr pSrcNativeVariant)
	{
		return ((Variant)PtrToStructure(pSrcNativeVariant, typeof(Variant))).GetValue();
	}

	public static T GetObjectForNativeVariant<T>(IntPtr pSrcNativeVariant)
	{
		return (T)((Variant)PtrToStructure(pSrcNativeVariant, typeof(Variant))).GetValue();
	}

	public static object[] GetObjectsForNativeVariants(IntPtr aSrcNativeVariant, int cVars)
	{
		if (cVars < 0)
		{
			throw new ArgumentOutOfRangeException("cVars", "cVars cannot be a negative number.");
		}
		object[] array = new object[cVars];
		for (int i = 0; i < cVars; i++)
		{
			array[i] = GetObjectForNativeVariant((IntPtr)(aSrcNativeVariant.ToInt64() + i * SizeOf(typeof(Variant))));
		}
		return array;
	}

	public static T[] GetObjectsForNativeVariants<T>(IntPtr aSrcNativeVariant, int cVars)
	{
		throw new PlatformNotSupportedException();
	}

	public static int GetStartComSlot(Type t)
	{
		throw new NotImplementedException();
	}

	public static Type GetTypeFromCLSID(Guid clsid)
	{
		throw new PlatformNotSupportedException();
	}

	public static string GetTypeInfoName(ITypeInfo typeInfo)
	{
		throw new PlatformNotSupportedException();
	}

	public static object GetUniqueObjectForIUnknown(IntPtr unknown)
	{
		throw new PlatformNotSupportedException();
	}

	public static bool IsComObject(object o)
	{
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int GetLastWin32Error();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr OffsetOf(Type t, string fieldName);

	public static IntPtr OffsetOf<T>(string fieldName)
	{
		return OffsetOf(typeof(T), fieldName);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void Prelink(MethodInfo m);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void PrelinkAll(Type c);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringAnsi(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringAnsi(IntPtr ptr, int len);

	public static string PtrToStringUTF8(IntPtr ptr)
	{
		return PtrToStringAnsi(ptr);
	}

	public static string PtrToStringUTF8(IntPtr ptr, int byteLen)
	{
		return PtrToStringAnsi(ptr, byteLen);
	}

	public static string PtrToStringAuto(IntPtr ptr)
	{
		if (SystemDefaultCharSize != 2)
		{
			return PtrToStringAnsi(ptr);
		}
		return PtrToStringUni(ptr);
	}

	public static string PtrToStringAuto(IntPtr ptr, int len)
	{
		if (SystemDefaultCharSize != 2)
		{
			return PtrToStringAnsi(ptr, len);
		}
		return PtrToStringUni(ptr, len);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringUni(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringUni(IntPtr ptr, int len);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringBSTR(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	[ComVisible(true)]
	public static extern void PtrToStructure(IntPtr ptr, object structure);

	[MethodImpl((MethodImplOptions)4096)]
	[ComVisible(true)]
	public static extern object PtrToStructure(IntPtr ptr, Type structureType);

	public static void PtrToStructure<T>(IntPtr ptr, T structure)
	{
		PtrToStructure(ptr, (object)structure);
	}

	public static T PtrToStructure<T>(IntPtr ptr)
	{
		return (T)PtrToStructure(ptr, typeof(T));
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int QueryInterfaceInternal(IntPtr pUnk, ref Guid iid, out IntPtr ppv);

	public static int QueryInterface(IntPtr pUnk, ref Guid iid, out IntPtr ppv)
	{
		if (pUnk == IntPtr.Zero)
		{
			throw new ArgumentNullException("pUnk");
		}
		return QueryInterfaceInternal(pUnk, ref iid, out ppv);
	}

	public unsafe static byte ReadByte(IntPtr ptr)
	{
		return *(byte*)(void*)ptr;
	}

	public unsafe static byte ReadByte(IntPtr ptr, int ofs)
	{
		return ((byte*)(void*)ptr)[ofs];
	}

	public static byte ReadByte([In][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs)
	{
		throw new NotImplementedException();
	}

	public unsafe static short ReadInt16(IntPtr ptr)
	{
		byte* ptr2 = (byte*)(void*)ptr;
		if (((int)ptr2 & 1) == 0)
		{
			return *(short*)ptr2;
		}
		short result = default(short);
		Buffer.Memcpy((byte*)(&result), (byte*)(void*)ptr, 2);
		return result;
	}

	public unsafe static short ReadInt16(IntPtr ptr, int ofs)
	{
		byte* ptr2 = (byte*)(void*)ptr + ofs;
		if (((int)ptr2 & 1) == 0)
		{
			return *(short*)ptr2;
		}
		short result = default(short);
		Buffer.Memcpy((byte*)(&result), ptr2, 2);
		return result;
	}

	public static short ReadInt16([In][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs)
	{
		throw new NotImplementedException();
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe static int ReadInt32(IntPtr ptr)
	{
		byte* ptr2 = (byte*)(void*)ptr;
		if (((int)ptr2 & 3) == 0)
		{
			return *(int*)ptr2;
		}
		int result = default(int);
		Buffer.Memcpy((byte*)(&result), ptr2, 4);
		return result;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe static int ReadInt32(IntPtr ptr, int ofs)
	{
		byte* ptr2 = (byte*)(void*)ptr + ofs;
		if (((int)ptr2 & 3) == 0)
		{
			return *(int*)ptr2;
		}
		int result = default(int);
		Buffer.Memcpy((byte*)(&result), ptr2, 4);
		return result;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static int ReadInt32([In][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs)
	{
		throw new NotImplementedException();
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public unsafe static long ReadInt64(IntPtr ptr)
	{
		byte* ptr2 = (byte*)(void*)ptr;
		if (((int)ptr2 & 7) == 0)
		{
			return *(long*)(void*)ptr;
		}
		long result = default(long);
		Buffer.Memcpy((byte*)(&result), ptr2, 8);
		return result;
	}

	public unsafe static long ReadInt64(IntPtr ptr, int ofs)
	{
		byte* ptr2 = (byte*)(void*)ptr + ofs;
		if (((int)ptr2 & 7) == 0)
		{
			return *(long*)ptr2;
		}
		long result = default(long);
		Buffer.Memcpy((byte*)(&result), ptr2, 8);
		return result;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static long ReadInt64([In][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs)
	{
		throw new NotImplementedException();
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static IntPtr ReadIntPtr(IntPtr ptr)
	{
		if (IntPtr.Size == 4)
		{
			return (IntPtr)ReadInt32(ptr);
		}
		return (IntPtr)ReadInt64(ptr);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static IntPtr ReadIntPtr(IntPtr ptr, int ofs)
	{
		if (IntPtr.Size == 4)
		{
			return (IntPtr)ReadInt32(ptr, ofs);
		}
		return (IntPtr)ReadInt64(ptr, ofs);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static IntPtr ReadIntPtr([In][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs)
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr ReAllocCoTaskMem(IntPtr pv, int cb);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr ReAllocHGlobal(IntPtr pv, IntPtr cb);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	private static extern int ReleaseInternal(IntPtr pUnk);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static int Release(IntPtr pUnk)
	{
		if (pUnk == IntPtr.Zero)
		{
			throw new ArgumentNullException("pUnk");
		}
		return ReleaseInternal(pUnk);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int ReleaseComObjectInternal(object co);

	public static int ReleaseComObject(object o)
	{
		if (o == null)
		{
			throw new ArgumentException("Value cannot be null.", "o");
		}
		if (!IsComObject(o))
		{
			throw new ArgumentException("Value must be a Com object.", "o");
		}
		return ReleaseComObjectInternal(o);
	}

	[ComVisible(true)]
	public static int SizeOf(object structure)
	{
		return SizeOf(structure.GetType());
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern int SizeOf(Type t);

	public static int SizeOf<T>()
	{
		return SizeOf(typeof(T));
	}

	public static int SizeOf<T>(T structure)
	{
		return SizeOf(structure.GetType());
	}

	internal static uint SizeOfType(Type type)
	{
		return (uint)SizeOf(type);
	}

	internal static uint AlignedSizeOf<T>() where T : struct
	{
		uint num = SizeOfType(typeof(T));
		if (num == 1 || num == 2)
		{
			return num;
		}
		if (IntPtr.Size == 8 && num == 4)
		{
			return num;
		}
		return (num + 3) & 0xFFFFFFFCu;
	}

	public unsafe static IntPtr StringToBSTR(string s)
	{
		if (s == null)
		{
			return IntPtr.Zero;
		}
		fixed (char* ptr = s)
		{
			return BufferToBSTR(ptr, s.Length);
		}
	}

	public static IntPtr StringToCoTaskMemAnsi(string s)
	{
		return StringToAllocatedMemoryUTF8(s);
	}

	public static IntPtr StringToCoTaskMemAuto(string s)
	{
		if (SystemDefaultCharSize != 2)
		{
			return StringToCoTaskMemAnsi(s);
		}
		return StringToCoTaskMemUni(s);
	}

	public static IntPtr StringToCoTaskMemUni(string s)
	{
		int num = s.Length + 1;
		IntPtr intPtr = AllocCoTaskMem(num * 2);
		char[] array = new char[num];
		s.CopyTo(0, array, 0, s.Length);
		array[s.Length] = '\0';
		copy_to_unmanaged(array, 0, intPtr, num);
		return intPtr;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr StringToHGlobalAnsi(char* s, int length);

	public unsafe static IntPtr StringToHGlobalAnsi(string s)
	{
		fixed (char* s2 = s)
		{
			return StringToHGlobalAnsi(s2, s?.Length ?? 0);
		}
	}

	public unsafe static IntPtr StringToAllocatedMemoryUTF8(string s)
	{
		if (s == null)
		{
			return IntPtr.Zero;
		}
		int num = (s.Length + 1) * 3;
		if (num < s.Length)
		{
			throw new ArgumentOutOfRangeException("s");
		}
		IntPtr intPtr = AllocCoTaskMemSize(new UIntPtr((uint)(num + 1)));
		if (intPtr == IntPtr.Zero)
		{
			throw new OutOfMemoryException();
		}
		byte* ptr = (byte*)(void*)intPtr;
		fixed (char* chars = s)
		{
			int bytes = Encoding.UTF8.GetBytes(chars, s.Length, ptr, num);
			ptr[bytes] = 0;
		}
		return intPtr;
	}

	public static IntPtr StringToHGlobalAuto(string s)
	{
		if (SystemDefaultCharSize != 2)
		{
			return StringToHGlobalAnsi(s);
		}
		return StringToHGlobalUni(s);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr StringToHGlobalUni(char* s, int length);

	public unsafe static IntPtr StringToHGlobalUni(string s)
	{
		fixed (char* s2 = s)
		{
			return StringToHGlobalUni(s2, s?.Length ?? 0);
		}
	}

	public unsafe static IntPtr SecureStringToBSTR(SecureString s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		byte[] buffer = s.GetBuffer();
		int length = s.Length;
		if (BitConverter.IsLittleEndian)
		{
			for (int i = 0; i < buffer.Length; i += 2)
			{
				byte b = buffer[i];
				buffer[i] = buffer[i + 1];
				buffer[i + 1] = b;
			}
		}
		fixed (byte* ptr = buffer)
		{
			return BufferToBSTR((char*)ptr, length);
		}
	}

	internal static IntPtr SecureStringCoTaskMemAllocator(int len)
	{
		return AllocCoTaskMem(len);
	}

	internal static IntPtr SecureStringGlobalAllocator(int len)
	{
		return AllocHGlobal(len);
	}

	internal static IntPtr SecureStringToAnsi(SecureString s, SecureStringAllocator allocator)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		int length = s.Length;
		IntPtr intPtr = allocator(length + 1);
		byte[] array = new byte[length + 1];
		try
		{
			byte[] buffer = s.GetBuffer();
			int num = 0;
			int num2 = 0;
			while (num < length)
			{
				array[num] = buffer[num2 + 1];
				buffer[num2] = 0;
				buffer[num2 + 1] = 0;
				num++;
				num2 += 2;
			}
			array[num] = 0;
			copy_to_unmanaged(array, 0, intPtr, length + 1);
			return intPtr;
		}
		finally
		{
			int num3 = length;
			while (num3 > 0)
			{
				num3--;
				array[num3] = 0;
			}
		}
	}

	internal static IntPtr SecureStringToUnicode(SecureString s, SecureStringAllocator allocator)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		int length = s.Length;
		IntPtr intPtr = allocator(length * 2 + 2);
		byte[] array = null;
		try
		{
			array = s.GetBuffer();
			for (int i = 0; i < length; i++)
			{
				WriteInt16(intPtr, i * 2, (short)((array[i * 2] << 8) | array[i * 2 + 1]));
			}
			WriteInt16(intPtr, array.Length, 0);
			return intPtr;
		}
		finally
		{
			if (array != null)
			{
				int num = array.Length;
				while (num > 0)
				{
					num--;
					array[num] = 0;
				}
			}
		}
	}

	public static IntPtr SecureStringToCoTaskMemAnsi(SecureString s)
	{
		return SecureStringToAnsi(s, SecureStringCoTaskMemAllocator);
	}

	public static IntPtr SecureStringToCoTaskMemUnicode(SecureString s)
	{
		return SecureStringToUnicode(s, SecureStringCoTaskMemAllocator);
	}

	public static IntPtr SecureStringToGlobalAllocAnsi(SecureString s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		return SecureStringToAnsi(s, SecureStringGlobalAllocator);
	}

	public static IntPtr SecureStringToGlobalAllocUnicode(SecureString s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		return SecureStringToUnicode(s, SecureStringGlobalAllocator);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	[ComVisible(true)]
	public static extern void StructureToPtr(object structure, IntPtr ptr, bool fDeleteOld);

	public static void StructureToPtr<T>(T structure, IntPtr ptr, bool fDeleteOld)
	{
		StructureToPtr((object)structure, ptr, fDeleteOld);
	}

	public static void ThrowExceptionForHR(int errorCode)
	{
		Exception exceptionForHR = GetExceptionForHR(errorCode);
		if (exceptionForHR != null)
		{
			throw exceptionForHR;
		}
	}

	public static void ThrowExceptionForHR(int errorCode, IntPtr errorInfo)
	{
		Exception exceptionForHR = GetExceptionForHR(errorCode, errorInfo);
		if (exceptionForHR != null)
		{
			throw exceptionForHR;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr BufferToBSTR(char* ptr, int slen);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr UnsafeAddrOfPinnedArrayElement(Array arr, int index);

	public static IntPtr UnsafeAddrOfPinnedArrayElement<T>(T[] arr, int index)
	{
		return UnsafeAddrOfPinnedArrayElement((Array)arr, index);
	}

	public unsafe static void WriteByte(IntPtr ptr, byte val)
	{
		*(byte*)(void*)ptr = val;
	}

	public unsafe static void WriteByte(IntPtr ptr, int ofs, byte val)
	{
		*(byte*)(void*)IntPtr.Add(ptr, ofs) = val;
	}

	public static void WriteByte([In][Out][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs, byte val)
	{
		throw new NotImplementedException();
	}

	public unsafe static void WriteInt16(IntPtr ptr, short val)
	{
		byte* ptr2 = (byte*)(void*)ptr;
		if (((int)ptr2 & 1) == 0)
		{
			*(short*)ptr2 = val;
		}
		else
		{
			Buffer.Memcpy(ptr2, (byte*)(&val), 2);
		}
	}

	public unsafe static void WriteInt16(IntPtr ptr, int ofs, short val)
	{
		byte* ptr2 = (byte*)(void*)ptr + ofs;
		if (((int)ptr2 & 1) == 0)
		{
			*(short*)ptr2 = val;
		}
		else
		{
			Buffer.Memcpy(ptr2, (byte*)(&val), 2);
		}
	}

	public static void WriteInt16([In][Out][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs, short val)
	{
		throw new NotImplementedException();
	}

	public static void WriteInt16(IntPtr ptr, char val)
	{
		WriteInt16(ptr, 0, (short)val);
	}

	public static void WriteInt16(IntPtr ptr, int ofs, char val)
	{
		WriteInt16(ptr, ofs, (short)val);
	}

	public static void WriteInt16([In][Out] object ptr, int ofs, char val)
	{
		throw new NotImplementedException();
	}

	public unsafe static void WriteInt32(IntPtr ptr, int val)
	{
		byte* ptr2 = (byte*)(void*)ptr;
		if (((int)ptr2 & 3) == 0)
		{
			*(int*)ptr2 = val;
		}
		else
		{
			Buffer.Memcpy(ptr2, (byte*)(&val), 4);
		}
	}

	public unsafe static void WriteInt32(IntPtr ptr, int ofs, int val)
	{
		byte* ptr2 = (byte*)(void*)ptr + ofs;
		if (((int)ptr2 & 3) == 0)
		{
			*(int*)ptr2 = val;
		}
		else
		{
			Buffer.Memcpy(ptr2, (byte*)(&val), 4);
		}
	}

	public static void WriteInt32([In][Out][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs, int val)
	{
		throw new NotImplementedException();
	}

	public unsafe static void WriteInt64(IntPtr ptr, long val)
	{
		byte* ptr2 = (byte*)(void*)ptr;
		if (((int)ptr2 & 7) == 0)
		{
			*(long*)ptr2 = val;
		}
		else
		{
			Buffer.Memcpy(ptr2, (byte*)(&val), 8);
		}
	}

	public unsafe static void WriteInt64(IntPtr ptr, int ofs, long val)
	{
		byte* ptr2 = (byte*)(void*)ptr + ofs;
		if (((int)ptr2 & 7) == 0)
		{
			*(long*)ptr2 = val;
		}
		else
		{
			Buffer.Memcpy(ptr2, (byte*)(&val), 8);
		}
	}

	public static void WriteInt64([In][Out][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs, long val)
	{
		throw new NotImplementedException();
	}

	public static void WriteIntPtr(IntPtr ptr, IntPtr val)
	{
		if (IntPtr.Size == 4)
		{
			WriteInt32(ptr, (int)val);
		}
		else
		{
			WriteInt64(ptr, (long)val);
		}
	}

	public static void WriteIntPtr(IntPtr ptr, int ofs, IntPtr val)
	{
		if (IntPtr.Size == 4)
		{
			WriteInt32(ptr, ofs, (int)val);
		}
		else
		{
			WriteInt64(ptr, ofs, (long)val);
		}
	}

	public static void WriteIntPtr([In][Out][MarshalAs(UnmanagedType.AsAny)] object ptr, int ofs, IntPtr val)
	{
		throw new NotImplementedException();
	}

	private static Exception ConvertHrToException(int errorCode)
	{
		switch (errorCode)
		{
		case -2146234348:
			return new AppDomainUnloadedException();
		case -2146232832:
			return new ApplicationException();
		case -2147024809:
			return new ArgumentException();
		case -2146233086:
			return new ArgumentOutOfRangeException();
		case -2147024362:
			return new ArithmeticException();
		case -2146233085:
			return new ArrayTypeMismatchException();
		case -2147024885:
		case 11:
			return new BadImageFormatException();
		case -2146233084:
			return new ContextMarshalException();
		case -2146893792:
			return new CryptographicException();
		case -2147024893:
		case 3:
			return new DirectoryNotFoundException();
		case -2147352558:
			return new DivideByZeroException();
		case -2146233047:
			return new DuplicateWaitObjectException();
		case -2147024858:
			return new EndOfStreamException();
		case -2146233088:
			return new Exception();
		case -2146233082:
			return new ExecutionEngineException();
		case -2146233081:
			return new FieldAccessException();
		case -2147024894:
		case 2:
			return new FileNotFoundException();
		case -2146233033:
			return new FormatException();
		case -2146233080:
			return new IndexOutOfRangeException();
		case -2147467262:
			return new InvalidCastException();
		case -2146233049:
			return new InvalidComObjectException();
		case -2146232831:
			return new InvalidFilterCriteriaException();
		case -2146233039:
			return new InvalidOleVariantTypeException();
		case -2146233079:
			return new InvalidOperationException();
		case -2146232800:
			return new IOException();
		case -2146233062:
			return new MemberAccessException();
		case -2146233072:
			return new MethodAccessException();
		case -2146233071:
			return new MissingFieldException();
		case -2146233038:
			return new MissingManifestResourceException();
		case -2146233070:
			return new MissingMemberException();
		case -2146233069:
			return new MissingMethodException();
		case -2146233068:
			return new MulticastNotSupportedException();
		case -2146233048:
			return new NotFiniteNumberException();
		case -2147467263:
			return new NotImplementedException();
		case -2146233067:
			return new NotSupportedException();
		case -2147467261:
			return new NullReferenceException();
		case -2147024882:
			return new OutOfMemoryException();
		case -2146233066:
			return new OverflowException();
		case -2147024690:
		case 206:
			return new PathTooLongException();
		case -2146233065:
			return new RankException();
		case -2146232830:
			return new ReflectionTypeLoadException(new Type[0], new Exception[0]);
		case -2146233077:
			return new RemotingException();
		case -2146233037:
			return new SafeArrayTypeMismatchException();
		case -2146233078:
			return new SecurityException();
		case -2146233076:
			return new SerializationException();
		case -2147023895:
		case 1001:
			return new StackOverflowException();
		case -2146233064:
			return new SynchronizationLockException();
		case -2146233087:
			return new SystemException();
		case -2146232829:
			return new TargetException();
		case -2146232828:
			return new TargetInvocationException(null);
		case -2147352562:
			return new TargetParameterCountException();
		case -2146233063:
			return new ThreadInterruptedException();
		case -2146233056:
			return new ThreadStateException();
		case -2146233054:
			return new TypeLoadException();
		case -2146233036:
			return new TypeInitializationException("", null);
		case -2146233075:
			return new VerificationException();
		default:
			if (errorCode < 0)
			{
				return new COMException("", errorCode);
			}
			return null;
		}
	}

	public static Exception GetExceptionForHR(int errorCode)
	{
		return GetExceptionForHR(errorCode, IntPtr.Zero);
	}

	public static Exception GetExceptionForHR(int errorCode, IntPtr errorInfo)
	{
		return ConvertHrToException(errorCode);
	}

	public static int FinalReleaseComObject(object o)
	{
		while (ReleaseComObject(o) != 0)
		{
		}
		return 0;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Delegate GetDelegateForFunctionPointerInternal(IntPtr ptr, Type t);

	public static Delegate GetDelegateForFunctionPointer(IntPtr ptr, Type t)
	{
		if (t == null)
		{
			throw new ArgumentNullException("t");
		}
		if (!t.IsSubclassOf(typeof(MulticastDelegate)) || t == typeof(MulticastDelegate))
		{
			throw new ArgumentException("Type is not a delegate", "t");
		}
		if (t.IsGenericType)
		{
			throw new ArgumentException("The specified Type must not be a generic type definition.");
		}
		if (ptr == IntPtr.Zero)
		{
			throw new ArgumentNullException("ptr");
		}
		return GetDelegateForFunctionPointerInternal(ptr, t);
	}

	public static TDelegate GetDelegateForFunctionPointer<TDelegate>(IntPtr ptr)
	{
		return (TDelegate)(object)GetDelegateForFunctionPointer(ptr, typeof(TDelegate));
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetFunctionPointerForDelegateInternal(Delegate d);

	public static IntPtr GetFunctionPointerForDelegate(Delegate d)
	{
		if ((object)d == null)
		{
			throw new ArgumentNullException("d");
		}
		return GetFunctionPointerForDelegateInternal(d);
	}

	public static IntPtr GetFunctionPointerForDelegate<TDelegate>(TDelegate d)
	{
		if (d == null)
		{
			throw new ArgumentNullException("d");
		}
		return GetFunctionPointerForDelegateInternal((Delegate)(object)d);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void SetLastWin32Error(int error);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern IntPtr GetRawIUnknownForComObjectNoAddRef(object o);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int GetHRForException_WinRT(Exception e);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern object GetNativeActivationFactory(Type type);

	internal static ICustomMarshaler GetCustomMarshalerInstance(Type type, string cookie)
	{
		(Type, string) key = (type, cookie);
		LazyInitializer.EnsureInitialized(ref MarshalerInstanceCache, () => new Dictionary<(Type, string), ICustomMarshaler>(new MarshalerInstanceKeyComparer()));
		bool flag;
		ICustomMarshaler value;
		lock (MarshalerInstanceCacheLock)
		{
			flag = MarshalerInstanceCache.TryGetValue(key, out value);
		}
		if (!flag)
		{
			RuntimeMethodInfo runtimeMethodInfo;
			try
			{
				runtimeMethodInfo = (RuntimeMethodInfo)type.GetMethod("GetInstance", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.InvokeMethod, null, new Type[1] { typeof(string) }, null);
			}
			catch (AmbiguousMatchException)
			{
				throw new ApplicationException("Custom marshaler '" + type.FullName + "' implements multiple static GetInstance methods that take a single string parameter.");
			}
			if (runtimeMethodInfo == null || runtimeMethodInfo.ReturnType != typeof(ICustomMarshaler))
			{
				throw new ApplicationException("Custom marshaler '" + type.FullName + "' does not implement a static GetInstance method that takes a single string parameter and returns an ICustomMarshaler.");
			}
			Exception exc;
			try
			{
				value = (ICustomMarshaler)runtimeMethodInfo.InternalInvoke(null, new object[1] { cookie }, out exc);
			}
			catch (Exception ex2)
			{
				exc = ex2;
				value = null;
			}
			if (exc != null)
			{
				ExceptionDispatchInfo.Capture(exc).Throw();
			}
			if (value == null)
			{
				throw new ApplicationException("A call to GetInstance() for custom marshaler '" + type.FullName + "' returned null, which is not allowed.");
			}
			lock (MarshalerInstanceCacheLock)
			{
				MarshalerInstanceCache[key] = value;
			}
		}
		return value;
	}

	public unsafe static IntPtr StringToCoTaskMemUTF8(string s)
	{
		if (s == null)
		{
			return IntPtr.Zero;
		}
		int maxByteCount = Encoding.UTF8.GetMaxByteCount(s.Length);
		IntPtr intPtr = AllocCoTaskMem(maxByteCount + 1);
		byte* ptr = (byte*)(void*)intPtr;
		int bytes;
		fixed (char* chars = s)
		{
			bytes = Encoding.UTF8.GetBytes(chars, s.Length, ptr, maxByteCount);
		}
		ptr[bytes] = 0;
		return intPtr;
	}

	[Obsolete("The GetThreadFromFiberCookie method has been deprecated.  Use the hosting API to perform this operation.", false)]
	public static Thread GetThreadFromFiberCookie(int cookie)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	public static object GetTypedObjectForIUnknown(IntPtr pUnk, Type t)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	public static Type GetTypeForITypeInfo(IntPtr piTypeInfo)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	[Obsolete("Use System.Runtime.InteropServices.Marshal.GetTypeInfoName(ITypeInfo pTLB) instead. http://go.microsoft.com/fwlink/?linkid=14202&ID=0000011.", false)]
	public static string GetTypeInfoName(UCOMITypeInfo pTI)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	public static Guid GetTypeLibGuid(ITypeLib typelib)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(Guid);
	}

	[Obsolete("Use System.Runtime.InteropServices.Marshal.GetTypeLibGuid(ITypeLib pTLB) instead. http://go.microsoft.com/fwlink/?linkid=14202&ID=0000011.", false)]
	public static Guid GetTypeLibGuid(UCOMITypeLib pTLB)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(Guid);
	}

	public static Guid GetTypeLibGuidForAssembly(Assembly asm)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(Guid);
	}

	public static int GetTypeLibLcid(ITypeLib typelib)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(int);
	}

	[Obsolete("Use System.Runtime.InteropServices.Marshal.GetTypeLibLcid(ITypeLib pTLB) instead. http://go.microsoft.com/fwlink/?linkid=14202&ID=0000011.", false)]
	public static int GetTypeLibLcid(UCOMITypeLib pTLB)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(int);
	}

	public static string GetTypeLibName(ITypeLib typelib)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	[Obsolete("Use System.Runtime.InteropServices.Marshal.GetTypeLibName(ITypeLib pTLB) instead. http://go.microsoft.com/fwlink/?linkid=14202&ID=0000011.", false)]
	public static string GetTypeLibName(UCOMITypeLib pTLB)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	public static void GetTypeLibVersionForAssembly(Assembly inputAssembly, out int majorVersion, out int minorVersion)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	[Obsolete("The GetUnmanagedThunkForManagedMethodPtr method has been deprecated and will be removed in a future release.", false)]
	public static IntPtr GetUnmanagedThunkForManagedMethodPtr(IntPtr pfnMethodToWrap, IntPtr pbSignature, int cbSignature)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(IntPtr);
	}

	public static bool IsTypeVisibleFromCom(Type t)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(bool);
	}

	public static int NumParamBytes(MethodInfo m)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(int);
	}

	[Obsolete("This API did not perform any operation and will be removed in future versions of the CLR.", false)]
	public static void ReleaseThreadCache()
	{
		ThrowStub.ThrowNotSupportedException();
	}

	public static bool SetComObjectData(object obj, object key, object data)
	{
		ThrowStub.ThrowNotSupportedException();
		return default(bool);
	}
}
