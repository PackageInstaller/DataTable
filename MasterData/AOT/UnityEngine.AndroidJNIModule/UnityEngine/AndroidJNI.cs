using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;

namespace UnityEngine;

[StaticAccessor("AndroidJNIBindingsHelpers", StaticAccessorType.DoubleColon)]
[NativeConditional("PLATFORM_ANDROID")]
[NativeHeader("Modules/AndroidJNI/Public/AndroidJNIBindingsHelpers.h")]
public static class AndroidJNI
{
	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor("jni", StaticAccessorType.DoubleColon)]
	[ThreadSafe]
	public static extern IntPtr GetJavaVM();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int AttachCurrentThread();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int DetachCurrentThread();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetVersion();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr FindClass(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr FromReflectedMethod(IntPtr refMethod);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr FromReflectedField(IntPtr refField);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr ToReflectedMethod(IntPtr clazz, IntPtr methodID, bool isStatic);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr ToReflectedField(IntPtr clazz, IntPtr fieldID, bool isStatic);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetSuperclass(IntPtr clazz);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool IsAssignableFrom(IntPtr clazz1, IntPtr clazz2);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int Throw(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int ThrowNew(IntPtr clazz, string message);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr ExceptionOccurred();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void ExceptionDescribe();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void ExceptionClear();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void FatalError(string message);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int PushLocalFrame(int capacity);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr PopLocalFrame(IntPtr ptr);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewGlobalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void DeleteGlobalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal static extern void QueueDeleteGlobalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	internal static extern uint GetQueueGlobalRefsCount();

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewWeakGlobalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void DeleteWeakGlobalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewLocalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void DeleteLocalRef(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool IsSameObject(IntPtr obj1, IntPtr obj2);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int EnsureLocalCapacity(int capacity);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr AllocObject(IntPtr clazz);

	public static IntPtr NewObject(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return NewObject(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static IntPtr NewObject(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return NewObjectA(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr NewObjectA(IntPtr clazz, IntPtr methodID, jvalue* args);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetObjectClass(IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool IsInstanceOf(IntPtr obj, IntPtr clazz);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetMethodID(IntPtr clazz, string name, string sig);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetFieldID(IntPtr clazz, string name, string sig);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetStaticMethodID(IntPtr clazz, string name, string sig);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetStaticFieldID(IntPtr clazz, string name, string sig);

	public static IntPtr NewString(string chars)
	{
		return NewStringFromStr(chars);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private static extern IntPtr NewStringFromStr(string chars);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewString(char[] chars);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewStringUTF(string bytes);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern string GetStringChars(IntPtr str);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetStringLength(IntPtr str);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetStringUTFLength(IntPtr str);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern string GetStringUTFChars(IntPtr str);

	public static string CallStringMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallStringMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static string CallStringMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStringMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern string CallStringMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static IntPtr CallObjectMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallObjectMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static IntPtr CallObjectMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallObjectMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr CallObjectMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static int CallIntMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallIntMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static int CallIntMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallIntMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern int CallIntMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static bool CallBooleanMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallBooleanMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static bool CallBooleanMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallBooleanMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern bool CallBooleanMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static short CallShortMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallShortMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static short CallShortMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallShortMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern short CallShortMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	[Obsolete("AndroidJNI.CallByteMethod is obsolete. Use AndroidJNI.CallSByteMethod method instead")]
	public static byte CallByteMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return (byte)CallSByteMethod(obj, methodID, args);
	}

	public static sbyte CallSByteMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallSByteMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static sbyte CallSByteMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallSByteMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern sbyte CallSByteMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static char CallCharMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallCharMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static char CallCharMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallCharMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern char CallCharMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static float CallFloatMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallFloatMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static float CallFloatMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallFloatMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern float CallFloatMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static double CallDoubleMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallDoubleMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static double CallDoubleMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallDoubleMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern double CallDoubleMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static long CallLongMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		return CallLongMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static long CallLongMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallLongMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern long CallLongMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	public static void CallVoidMethod(IntPtr obj, IntPtr methodID, jvalue[] args)
	{
		CallVoidMethod(obj, methodID, new Span<jvalue>(args));
	}

	public unsafe static void CallVoidMethod(IntPtr obj, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			CallVoidMethodUnsafe(obj, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern void CallVoidMethodUnsafe(IntPtr obj, IntPtr methodID, jvalue* args);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern string GetStringField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetObjectField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool GetBooleanField(IntPtr obj, IntPtr fieldID);

	[Obsolete("AndroidJNI.GetByteField is obsolete. Use AndroidJNI.GetSByteField method instead")]
	public static byte GetByteField(IntPtr obj, IntPtr fieldID)
	{
		return (byte)GetSByteField(obj, fieldID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern sbyte GetSByteField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern char GetCharField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern short GetShortField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetIntField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern long GetLongField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern float GetFloatField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern double GetDoubleField(IntPtr obj, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStringField(IntPtr obj, IntPtr fieldID, string val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetObjectField(IntPtr obj, IntPtr fieldID, IntPtr val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetBooleanField(IntPtr obj, IntPtr fieldID, bool val);

	[Obsolete("AndroidJNI.SetByteField is obsolete. Use AndroidJNI.SetSByteField method instead")]
	public static void SetByteField(IntPtr obj, IntPtr fieldID, byte val)
	{
		SetSByteField(obj, fieldID, (sbyte)val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetSByteField(IntPtr obj, IntPtr fieldID, sbyte val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetCharField(IntPtr obj, IntPtr fieldID, char val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetShortField(IntPtr obj, IntPtr fieldID, short val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetIntField(IntPtr obj, IntPtr fieldID, int val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetLongField(IntPtr obj, IntPtr fieldID, long val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetFloatField(IntPtr obj, IntPtr fieldID, float val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetDoubleField(IntPtr obj, IntPtr fieldID, double val);

	public static string CallStaticStringMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticStringMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static string CallStaticStringMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticStringMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern string CallStaticStringMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static IntPtr CallStaticObjectMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticObjectMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static IntPtr CallStaticObjectMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticObjectMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr CallStaticObjectMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static int CallStaticIntMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticIntMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static int CallStaticIntMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticIntMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern int CallStaticIntMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static bool CallStaticBooleanMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticBooleanMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static bool CallStaticBooleanMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticBooleanMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern bool CallStaticBooleanMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static short CallStaticShortMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticShortMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static short CallStaticShortMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticShortMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern short CallStaticShortMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	[Obsolete("AndroidJNI.CallStaticByteMethod is obsolete. Use AndroidJNI.CallStaticSByteMethod method instead")]
	public static byte CallStaticByteMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return (byte)CallStaticSByteMethod(clazz, methodID, args);
	}

	public static sbyte CallStaticSByteMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticSByteMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static sbyte CallStaticSByteMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticSByteMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern sbyte CallStaticSByteMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static char CallStaticCharMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticCharMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static char CallStaticCharMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticCharMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern char CallStaticCharMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static float CallStaticFloatMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticFloatMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static float CallStaticFloatMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticFloatMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern float CallStaticFloatMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static double CallStaticDoubleMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticDoubleMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static double CallStaticDoubleMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticDoubleMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern double CallStaticDoubleMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static long CallStaticLongMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		return CallStaticLongMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static long CallStaticLongMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			return CallStaticLongMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern long CallStaticLongMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	public static void CallStaticVoidMethod(IntPtr clazz, IntPtr methodID, jvalue[] args)
	{
		CallStaticVoidMethod(clazz, methodID, new Span<jvalue>(args));
	}

	public unsafe static void CallStaticVoidMethod(IntPtr clazz, IntPtr methodID, Span<jvalue> args)
	{
		fixed (jvalue* args2 = args)
		{
			CallStaticVoidMethodUnsafe(clazz, methodID, args2);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern void CallStaticVoidMethodUnsafe(IntPtr clazz, IntPtr methodID, jvalue* args);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern string GetStaticStringField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetStaticObjectField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool GetStaticBooleanField(IntPtr clazz, IntPtr fieldID);

	[Obsolete("AndroidJNI.GetStaticByteField is obsolete. Use AndroidJNI.GetStaticSByteField method instead")]
	public static byte GetStaticByteField(IntPtr clazz, IntPtr fieldID)
	{
		return (byte)GetStaticSByteField(clazz, fieldID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern sbyte GetStaticSByteField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern char GetStaticCharField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern short GetStaticShortField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetStaticIntField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern long GetStaticLongField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern float GetStaticFloatField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern double GetStaticDoubleField(IntPtr clazz, IntPtr fieldID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticStringField(IntPtr clazz, IntPtr fieldID, string val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticObjectField(IntPtr clazz, IntPtr fieldID, IntPtr val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticBooleanField(IntPtr clazz, IntPtr fieldID, bool val);

	[Obsolete("AndroidJNI.SetStaticByteField is obsolete. Use AndroidJNI.SetStaticSByteField method instead")]
	public static void SetStaticByteField(IntPtr clazz, IntPtr fieldID, byte val)
	{
		SetStaticSByteField(clazz, fieldID, (sbyte)val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticSByteField(IntPtr clazz, IntPtr fieldID, sbyte val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticCharField(IntPtr clazz, IntPtr fieldID, char val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticShortField(IntPtr clazz, IntPtr fieldID, short val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticIntField(IntPtr clazz, IntPtr fieldID, int val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticLongField(IntPtr clazz, IntPtr fieldID, long val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticFloatField(IntPtr clazz, IntPtr fieldID, float val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetStaticDoubleField(IntPtr clazz, IntPtr fieldID, double val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private static extern IntPtr ConvertToBooleanArray(bool[] array);

	public static IntPtr ToBooleanArray(bool[] array)
	{
		return (array == null) ? IntPtr.Zero : ConvertToBooleanArray(array);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[Obsolete("AndroidJNI.ToByteArray is obsolete. Use AndroidJNI.ToSByteArray method instead")]
	public static extern IntPtr ToByteArray(byte[] array);

	public unsafe static IntPtr ToSByteArray(sbyte[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (sbyte* array2 = array)
		{
			return ToSByteArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToSByteArray(sbyte* array, int length);

	public unsafe static IntPtr ToCharArray(char[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (char* array2 = array)
		{
			return ToCharArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToCharArray(char* array, int length);

	public unsafe static IntPtr ToShortArray(short[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (short* array2 = array)
		{
			return ToShortArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToShortArray(short* array, int length);

	public unsafe static IntPtr ToIntArray(int[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (int* array2 = array)
		{
			return ToIntArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToIntArray(int* array, int length);

	public unsafe static IntPtr ToLongArray(long[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (long* array2 = array)
		{
			return ToLongArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToLongArray(long* array, int length);

	public unsafe static IntPtr ToFloatArray(float[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (float* array2 = array)
		{
			return ToFloatArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToFloatArray(float* array, int length);

	public unsafe static IntPtr ToDoubleArray(double[] array)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (double* array2 = array)
		{
			return ToDoubleArray(array2, array.Length);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToDoubleArray(double* array, int length);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr ToObjectArray(IntPtr* array, int length, IntPtr arrayClass);

	public unsafe static IntPtr ToObjectArray(IntPtr[] array, IntPtr arrayClass)
	{
		if (array == null)
		{
			return IntPtr.Zero;
		}
		fixed (IntPtr* array2 = array)
		{
			return ToObjectArray(array2, array.Length, arrayClass);
		}
	}

	public static IntPtr ToObjectArray(IntPtr[] array)
	{
		return ToObjectArray(array, IntPtr.Zero);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool[] FromBooleanArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[Obsolete("AndroidJNI.FromByteArray is obsolete. Use AndroidJNI.FromSByteArray method instead")]
	public static extern byte[] FromByteArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern sbyte[] FromSByteArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern char[] FromCharArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern short[] FromShortArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int[] FromIntArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern long[] FromLongArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern float[] FromFloatArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern double[] FromDoubleArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr[] FromObjectArray(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetArrayLength(IntPtr array);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewBooleanArray(int size);

	[Obsolete("AndroidJNI.NewByteArray is obsolete. Use AndroidJNI.NewSByteArray method instead")]
	public static IntPtr NewByteArray(int size)
	{
		return NewSByteArray(size);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewSByteArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewCharArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewShortArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewIntArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewLongArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewFloatArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewDoubleArray(int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr NewObjectArray(int size, IntPtr clazz, IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern bool GetBooleanArrayElement(IntPtr array, int index);

	[Obsolete("AndroidJNI.GetByteArrayElement is obsolete. Use AndroidJNI.GetSByteArrayElement method instead")]
	public static byte GetByteArrayElement(IntPtr array, int index)
	{
		return (byte)GetSByteArrayElement(array, index);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern sbyte GetSByteArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern char GetCharArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern short GetShortArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int GetIntArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern long GetLongArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern float GetFloatArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern double GetDoubleArrayElement(IntPtr array, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern IntPtr GetObjectArrayElement(IntPtr array, int index);

	[Obsolete("AndroidJNI.SetBooleanArrayElement(IntPtr, int, byte) is obsolete. Use AndroidJNI.SetBooleanArrayElement(IntPtr, int, bool) method instead")]
	public static void SetBooleanArrayElement(IntPtr array, int index, byte val)
	{
		SetBooleanArrayElement(array, index, val != 0);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetBooleanArrayElement(IntPtr array, int index, bool val);

	[Obsolete("AndroidJNI.SetByteArrayElement is obsolete. Use AndroidJNI.SetSByteArrayElement method instead")]
	public static void SetByteArrayElement(IntPtr array, int index, sbyte val)
	{
		SetSByteArrayElement(array, index, val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetSByteArrayElement(IntPtr array, int index, sbyte val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetCharArrayElement(IntPtr array, int index, char val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetShortArrayElement(IntPtr array, int index, short val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetIntArrayElement(IntPtr array, int index, int val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetLongArrayElement(IntPtr array, int index, long val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetFloatArrayElement(IntPtr array, int index, float val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetDoubleArrayElement(IntPtr array, int index, double val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetObjectArrayElement(IntPtr array, int index, IntPtr obj);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern IntPtr NewDirectByteBuffer(byte* buffer, long capacity);

	public static IntPtr NewDirectByteBuffer(NativeArray<byte> buffer)
	{
		return NewDirectByteBufferFromNativeArray(buffer);
	}

	public static IntPtr NewDirectByteBuffer(NativeArray<sbyte> buffer)
	{
		return NewDirectByteBufferFromNativeArray(buffer);
	}

	private unsafe static IntPtr NewDirectByteBufferFromNativeArray<T>(NativeArray<T> buffer) where T : struct
	{
		if (!buffer.IsCreated || buffer.Length <= 0)
		{
			return IntPtr.Zero;
		}
		return NewDirectByteBuffer((byte*)buffer.GetUnsafePtr(), buffer.Length);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern sbyte* GetDirectBufferAddress(IntPtr buffer);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern long GetDirectBufferCapacity(IntPtr buffer);

	private unsafe static NativeArray<T> GetDirectBuffer<T>(IntPtr buffer) where T : struct
	{
		if (buffer == IntPtr.Zero)
		{
			return default;
		}
		sbyte* directBufferAddress = GetDirectBufferAddress(buffer);
		if (directBufferAddress == null)
		{
			return default;
		}
		long directBufferCapacity = GetDirectBufferCapacity(buffer);
		if (directBufferCapacity > int.MaxValue)
		{
			throw new Exception($"Direct buffer is too large ({directBufferCapacity}) for NativeArray (max {int.MaxValue})");
		}
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>(directBufferAddress, (int)directBufferCapacity, Allocator.None);
	}

	public static NativeArray<byte> GetDirectByteBuffer(IntPtr buffer)
	{
		return GetDirectBuffer<byte>(buffer);
	}

	public static NativeArray<sbyte> GetDirectSByteBuffer(IntPtr buffer)
	{
		return GetDirectBuffer<sbyte>(buffer);
	}

	public static int RegisterNatives(IntPtr clazz, JNINativeMethod[] methods)
	{
		if (methods == null || methods.Length == 0)
		{
			return -1;
		}
		for (int i = 0; i < methods.Length; i++)
		{
			JNINativeMethod jNINativeMethod = methods[i];
			if (string.IsNullOrEmpty(jNINativeMethod.name) || (string.IsNullOrEmpty(jNINativeMethod.signature) ? true : false))
			{
				return -1;
			}
		}
		IntPtr natives = RegisterNativesAllocate(methods.Length);
		for (int j = 0; j < methods.Length; j++)
		{
			RegisterNativesSet(natives, j, methods[j].name, methods[j].signature, methods[j].fnPtr);
		}
		return RegisterNativesAndFree(clazz, natives, methods.Length);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private static extern IntPtr RegisterNativesAllocate(int length);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private static extern void RegisterNativesSet(IntPtr natives, int idx, string name, string signature, IntPtr fnPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private static extern int RegisterNativesAndFree(IntPtr clazz, IntPtr natives, int n);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern int UnregisterNatives(IntPtr clazz);
}
