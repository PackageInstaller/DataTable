using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Resources;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.ExceptionServices;
using System.Runtime.Remoting;
using System.Runtime.Serialization;
using System.Security;
using System.Security.Cryptography;
using System.Threading;

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
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static extern IntPtr AllocHGlobal(IntPtr cb);

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static IntPtr AllocHGlobal(int cb)
	{
		return AllocHGlobal((IntPtr)cb);
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

	private static void ClearUnicode(IntPtr ptr)
	{
		for (int i = 0; ReadInt16(ptr, i) != 0; i += 2)
		{
			WriteInt16(ptr, i, 0);
		}
	}

	public static void ZeroFreeGlobalAllocUnicode(IntPtr s)
	{
		ClearUnicode(s);
		FreeHGlobal(s);
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
	public static extern bool IsComObject(object o);

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern int GetLastWin32Error();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr OffsetOf(Type t, string fieldName);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringAnsi(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringAnsi(IntPtr ptr, int len);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string PtrToStringUni(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	[ComVisible(true)]
	public static extern object PtrToStructure(IntPtr ptr, Type structureType);

	public static T PtrToStructure<T>(IntPtr ptr)
	{
		return (T)PtrToStructure(ptr, typeof(T));
	}

	public unsafe static byte ReadByte(IntPtr ptr, int ofs)
	{
		return ((byte*)(void*)ptr)[ofs];
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
	public static IntPtr ReadIntPtr(IntPtr ptr, int ofs)
	{
		if (IntPtr.Size == 4)
		{
			return (IntPtr)ReadInt32(ptr, ofs);
		}
		return (IntPtr)ReadInt64(ptr, ofs);
	}

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
	public static extern int SizeOf(Type t);

	public static int SizeOf<T>()
	{
		return SizeOf(typeof(T));
	}

	public static int SizeOf<T>(T structure)
	{
		return SizeOf(structure.GetType());
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

	internal static IntPtr SecureStringGlobalAllocator(int len)
	{
		return AllocHGlobal(len);
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

	public static IntPtr SecureStringToGlobalAllocUnicode(SecureString s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		return SecureStringToUnicode(s, SecureStringGlobalAllocator);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ComVisible(true)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
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

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr BufferToBSTR(char* ptr, int slen);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern IntPtr UnsafeAddrOfPinnedArrayElement(Array arr, int index);

	public static IntPtr UnsafeAddrOfPinnedArrayElement<T>(T[] arr, int index)
	{
		return UnsafeAddrOfPinnedArrayElement((Array)arr, index);
	}

	public unsafe static void WriteByte(IntPtr ptr, int ofs, byte val)
	{
		*(byte*)(void*)IntPtr.Add(ptr, ofs) = val;
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
}
