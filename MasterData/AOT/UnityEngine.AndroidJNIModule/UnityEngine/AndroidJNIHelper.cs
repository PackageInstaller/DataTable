using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Android;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeConditional("PLATFORM_ANDROID")]
[NativeHeader("Modules/AndroidJNI/Public/AndroidJNIBindingsHelpers.h")]
[UsedByNativeCode]
[StaticAccessor("AndroidJNIBindingsHelpers", StaticAccessorType.DoubleColon)]
public static class AndroidJNIHelper
{
	public static extern bool debug
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static IntPtr GetConstructorID(IntPtr javaClass)
	{
		return GetConstructorID(javaClass, "");
	}

	public static IntPtr GetConstructorID(IntPtr javaClass, [DefaultValue("")] string signature)
	{
		return _AndroidJNIHelper.GetConstructorID(javaClass, signature);
	}

	public static IntPtr GetMethodID(IntPtr javaClass, string methodName)
	{
		return GetMethodID(javaClass, methodName, "", isStatic: false);
	}

	public static IntPtr GetMethodID(IntPtr javaClass, string methodName, [DefaultValue("")] string signature)
	{
		return GetMethodID(javaClass, methodName, signature, isStatic: false);
	}

	public static IntPtr GetMethodID(IntPtr javaClass, string methodName, [DefaultValue("")] string signature, [DefaultValue("false")] bool isStatic)
	{
		return _AndroidJNIHelper.GetMethodID(javaClass, methodName, signature, isStatic);
	}

	public static IntPtr GetFieldID(IntPtr javaClass, string fieldName)
	{
		return GetFieldID(javaClass, fieldName, "", isStatic: false);
	}

	public static IntPtr GetFieldID(IntPtr javaClass, string fieldName, [DefaultValue("")] string signature)
	{
		return GetFieldID(javaClass, fieldName, signature, isStatic: false);
	}

	public static IntPtr GetFieldID(IntPtr javaClass, string fieldName, [DefaultValue("")] string signature, [DefaultValue("false")] bool isStatic)
	{
		return _AndroidJNIHelper.GetFieldID(javaClass, fieldName, signature, isStatic);
	}

	public static IntPtr CreateJavaRunnable(AndroidJavaRunnable jrunnable)
	{
		return _AndroidJNIHelper.CreateJavaRunnable(jrunnable);
	}

	public static IntPtr CreateJavaProxy(AndroidJavaProxy proxy)
	{
		GCHandle value = GCHandle.Alloc(proxy);
		try
		{
			return _AndroidJNIHelper.CreateJavaProxy(AndroidApp.UnityPlayerRaw, GCHandle.ToIntPtr(value), proxy);
		}
		catch
		{
			value.Free();
			throw;
		}
	}

	public static IntPtr ConvertToJNIArray(Array array)
	{
		return _AndroidJNIHelper.ConvertToJNIArray(array);
	}

	public static jvalue[] CreateJNIArgArray(object[] args)
	{
		jvalue[] array = new jvalue[args.Length];
		_AndroidJNIHelper.CreateJNIArgArray(args, array);
		return array;
	}

	public static void CreateJNIArgArray(object[] args, Span<jvalue> jniArgs)
	{
		if (args.Length != jniArgs.Length)
		{
			throw new ArgumentException($"Both arrays must be of the same length, but are {args.Length} and {jniArgs.Length}");
		}
		_AndroidJNIHelper.CreateJNIArgArray(args, jniArgs);
	}

	public static void DeleteJNIArgArray(object[] args, jvalue[] jniArgs)
	{
		_AndroidJNIHelper.DeleteJNIArgArray(args, jniArgs);
	}

	public static void DeleteJNIArgArray(object[] args, Span<jvalue> jniArgs)
	{
		_AndroidJNIHelper.DeleteJNIArgArray(args, jniArgs);
	}

	public static IntPtr GetConstructorID(IntPtr jclass, object[] args)
	{
		return _AndroidJNIHelper.GetConstructorID(jclass, args);
	}

	public static IntPtr GetMethodID(IntPtr jclass, string methodName, object[] args, bool isStatic)
	{
		return _AndroidJNIHelper.GetMethodID(jclass, methodName, args, isStatic);
	}

	public static string GetSignature(object obj)
	{
		return _AndroidJNIHelper.GetSignature(obj);
	}

	public static string GetSignature(object[] args)
	{
		return _AndroidJNIHelper.GetSignature(args);
	}

	public static ArrayType ConvertFromJNIArray<ArrayType>(IntPtr array)
	{
		return _AndroidJNIHelper.ConvertFromJNIArray<ArrayType>(array);
	}

	public static IntPtr GetMethodID<ReturnType>(IntPtr jclass, string methodName, object[] args, bool isStatic)
	{
		return _AndroidJNIHelper.GetMethodID<ReturnType>(jclass, methodName, args, isStatic);
	}

	public static IntPtr GetFieldID<FieldType>(IntPtr jclass, string fieldName, bool isStatic)
	{
		return _AndroidJNIHelper.GetFieldID<FieldType>(jclass, fieldName, isStatic);
	}

	public static string GetSignature<ReturnType>(object[] args)
	{
		return _AndroidJNIHelper.GetSignature<ReturnType>(args);
	}

	private unsafe static IntPtr Box(jvalue val, string boxedClass, string signature)
	{
		IntPtr intPtr = AndroidJNISafe.FindClass(boxedClass);
		try
		{
			IntPtr staticMethodID = AndroidJNISafe.GetStaticMethodID(intPtr, "valueOf", signature);
			Span<jvalue> args = new Span<jvalue>(&val, 1);
			return AndroidJNISafe.CallStaticObjectMethod(intPtr, staticMethodID, args);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(intPtr);
		}
	}

	public static IntPtr Box(sbyte value)
	{
		return Box(new jvalue
		{
			b = value
		}, "java/lang/Byte", "(B)Ljava/lang/Byte;");
	}

	public static IntPtr Box(short value)
	{
		return Box(new jvalue
		{
			s = value
		}, "java/lang/Short", "(S)Ljava/lang/Short;");
	}

	public static IntPtr Box(int value)
	{
		return Box(new jvalue
		{
			i = value
		}, "java/lang/Integer", "(I)Ljava/lang/Integer;");
	}

	public static IntPtr Box(long value)
	{
		return Box(new jvalue
		{
			j = value
		}, "java/lang/Long", "(J)Ljava/lang/Long;");
	}

	public static IntPtr Box(float value)
	{
		return Box(new jvalue
		{
			f = value
		}, "java/lang/Float", "(F)Ljava/lang/Float;");
	}

	public static IntPtr Box(double value)
	{
		return Box(new jvalue
		{
			d = value
		}, "java/lang/Double", "(D)Ljava/lang/Double;");
	}

	public static IntPtr Box(char value)
	{
		return Box(new jvalue
		{
			c = value
		}, "java/lang/Character", "(C)Ljava/lang/Character;");
	}

	public static IntPtr Box(bool value)
	{
		return Box(new jvalue
		{
			z = value
		}, "java/lang/Boolean", "(Z)Ljava/lang/Boolean;");
	}

	private static IntPtr GetUnboxMethod(IntPtr obj, string methodName, string signature)
	{
		IntPtr objectClass = AndroidJNISafe.GetObjectClass(obj);
		try
		{
			return AndroidJNISafe.GetMethodID(objectClass, methodName, signature);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(objectClass);
		}
	}

	public static void Unbox(IntPtr obj, out sbyte value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "byteValue", "()B");
		value = AndroidJNISafe.CallSByteMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out short value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "shortValue", "()S");
		value = AndroidJNISafe.CallShortMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out int value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "intValue", "()I");
		value = AndroidJNISafe.CallIntMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out long value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "longValue", "()J");
		value = AndroidJNISafe.CallLongMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out float value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "floatValue", "()F");
		value = AndroidJNISafe.CallFloatMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out double value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "doubleValue", "()D");
		value = AndroidJNISafe.CallDoubleMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out char value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "charValue", "()C");
		value = AndroidJNISafe.CallCharMethod(obj, unboxMethod, default);
	}

	public static void Unbox(IntPtr obj, out bool value)
	{
		IntPtr unboxMethod = GetUnboxMethod(obj, "booleanValue", "()Z");
		value = AndroidJNISafe.CallBooleanMethod(obj, unboxMethod, default);
	}
}
