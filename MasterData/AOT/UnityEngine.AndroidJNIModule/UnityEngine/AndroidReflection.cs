using System;
using System.Runtime.InteropServices;

namespace UnityEngine;

internal class AndroidReflection
{
	private static readonly GlobalJavaObjectRef s_ReflectionHelperClass = new GlobalJavaObjectRef(AndroidJNISafe.FindClass("com/unity3d/player/ReflectionHelper"));

	private static readonly IntPtr s_ReflectionHelperGetConstructorID = GetStaticMethodID("com/unity3d/player/ReflectionHelper", "getConstructorID", "(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/reflect/Constructor;");

	private static readonly IntPtr s_ReflectionHelperGetMethodID = GetStaticMethodID("com/unity3d/player/ReflectionHelper", "getMethodID", "(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/reflect/Method;");

	private static readonly IntPtr s_ReflectionHelperGetFieldID = GetStaticMethodID("com/unity3d/player/ReflectionHelper", "getFieldID", "(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/reflect/Field;");

	private static readonly IntPtr s_ReflectionHelperGetFieldSignature = GetStaticMethodID("com/unity3d/player/ReflectionHelper", "getFieldSignature", "(Ljava/lang/reflect/Field;)Ljava/lang/String;");

	private static readonly IntPtr s_ReflectionHelperNewProxyInstance = GetStaticMethodID("com/unity3d/player/ReflectionHelper", "newProxyInstance", "(Lcom/unity3d/player/UnityPlayer;JLjava/lang/Class;)Ljava/lang/Object;");

	private static readonly IntPtr s_ReflectionHelperCeateInvocationError = GetStaticMethodID("com/unity3d/player/ReflectionHelper", "createInvocationError", "(JZ)Ljava/lang/Object;");

	private static readonly IntPtr s_FieldGetDeclaringClass = GetMethodID("java/lang/reflect/Field", "getDeclaringClass", "()Ljava/lang/Class;");

	public static bool IsPrimitive(Type t)
	{
		return t.IsPrimitive;
	}

	public static bool IsAssignableFrom(Type t, Type from)
	{
		return t.IsAssignableFrom(from);
	}

	private static IntPtr GetStaticMethodID(string clazz, string methodName, string signature)
	{
		IntPtr intPtr = AndroidJNISafe.FindClass(clazz);
		try
		{
			return AndroidJNISafe.GetStaticMethodID(intPtr, methodName, signature);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(intPtr);
		}
	}

	private static IntPtr GetMethodID(string clazz, string methodName, string signature)
	{
		IntPtr intPtr = AndroidJNISafe.FindClass(clazz);
		try
		{
			return AndroidJNISafe.GetMethodID(intPtr, methodName, signature);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(intPtr);
		}
	}

	public static IntPtr GetConstructorMember(IntPtr jclass, string signature)
	{
		jvalue[] array = new jvalue[2];
		try
		{
			array[0].l = jclass;
			array[1].l = AndroidJNISafe.NewString(signature);
			return AndroidJNISafe.CallStaticObjectMethod(s_ReflectionHelperClass, s_ReflectionHelperGetConstructorID, array);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(array[1].l);
		}
	}

	public static IntPtr GetMethodMember(IntPtr jclass, string methodName, string signature, bool isStatic)
	{
		jvalue[] array = new jvalue[4];
		try
		{
			array[0].l = jclass;
			array[1].l = AndroidJNISafe.NewString(methodName);
			array[2].l = AndroidJNISafe.NewString(signature);
			array[3].z = isStatic;
			return AndroidJNISafe.CallStaticObjectMethod(s_ReflectionHelperClass, s_ReflectionHelperGetMethodID, array);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(array[1].l);
			AndroidJNISafe.DeleteLocalRef(array[2].l);
		}
	}

	public static IntPtr GetFieldMember(IntPtr jclass, string fieldName, string signature, bool isStatic)
	{
		jvalue[] array = new jvalue[4];
		try
		{
			array[0].l = jclass;
			array[1].l = AndroidJNISafe.NewString(fieldName);
			array[2].l = AndroidJNISafe.NewString(signature);
			array[3].z = isStatic;
			return AndroidJNISafe.CallStaticObjectMethod(s_ReflectionHelperClass, s_ReflectionHelperGetFieldID, array);
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(array[1].l);
			AndroidJNISafe.DeleteLocalRef(array[2].l);
		}
	}

	public static IntPtr GetFieldClass(IntPtr field)
	{
		return AndroidJNISafe.CallObjectMethod(field, s_FieldGetDeclaringClass, null);
	}

	public static string GetFieldSignature(IntPtr field)
	{
		jvalue[] array = new jvalue[1];
		array[0].l = field;
		return AndroidJNISafe.CallStaticStringMethod(s_ReflectionHelperClass, s_ReflectionHelperGetFieldSignature, array);
	}

	public static IntPtr NewProxyInstance(IntPtr player, IntPtr delegateHandle, IntPtr interfaze)
	{
		jvalue[] array = new jvalue[3];
		array[0].l = player;
		array[1].j = delegateHandle.ToInt64();
		array[2].l = interfaze;
		return AndroidJNISafe.CallStaticObjectMethod(s_ReflectionHelperClass, s_ReflectionHelperNewProxyInstance, array);
	}

	internal static IntPtr CreateInvocationError(Exception ex, bool methodNotFound)
	{
		jvalue[] array = new jvalue[2];
		array[0].j = GCHandle.ToIntPtr(GCHandle.Alloc(ex)).ToInt64();
		array[1].z = methodNotFound;
		return AndroidJNISafe.CallStaticObjectMethod(s_ReflectionHelperClass, s_ReflectionHelperCeateInvocationError, array);
	}
}
