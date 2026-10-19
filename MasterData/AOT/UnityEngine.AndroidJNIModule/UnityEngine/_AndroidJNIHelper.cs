using System;
using System.Text;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
internal sealed class _AndroidJNIHelper
{
	public static IntPtr CreateJavaProxy(IntPtr player, IntPtr delegateHandle, AndroidJavaProxy proxy)
	{
		return AndroidReflection.NewProxyInstance(player, delegateHandle, proxy.javaInterface.GetRawClass());
	}

	public static IntPtr CreateJavaRunnable(AndroidJavaRunnable jrunnable)
	{
		return AndroidJNIHelper.CreateJavaProxy(new AndroidJavaRunnableProxy(jrunnable));
	}

	[RequiredByNativeCode]
	public static IntPtr InvokeJavaProxyMethod(AndroidJavaProxy proxy, IntPtr jmethodName, IntPtr jargs)
	{
		try
		{
			return proxy.Invoke(AndroidJNI.GetStringChars(jmethodName), jargs);
		}
		catch (Exception ex)
		{
			return AndroidReflection.CreateInvocationError(ex, methodNotFound: false);
		}
	}

	public static void CreateJNIArgArray(object[] args, Span<jvalue> ret)
	{
		int num = 0;
		foreach (object obj in args)
		{
			if (obj == null)
			{
				ret[num].l = IntPtr.Zero;
			}
			else if (AndroidReflection.IsPrimitive(obj.GetType()))
			{
				if (obj is int)
				{
					ret[num].i = (int)obj;
				}
				else if (obj is bool)
				{
					ret[num].z = (bool)obj;
				}
				else if (obj is byte)
				{
					Debug.LogWarning("Passing Byte arguments to Java methods is obsolete, pass SByte parameters instead");
					ret[num].b = (sbyte)(byte)obj;
				}
				else if (obj is sbyte)
				{
					ret[num].b = (sbyte)obj;
				}
				else if (obj is short)
				{
					ret[num].s = (short)obj;
				}
				else if (obj is long)
				{
					ret[num].j = (long)obj;
				}
				else if (obj is float)
				{
					ret[num].f = (float)obj;
				}
				else if (obj is double)
				{
					ret[num].d = (double)obj;
				}
				else if (obj is char)
				{
					ret[num].c = (char)obj;
				}
			}
			else if (obj is string)
			{
				ret[num].l = AndroidJNISafe.NewString((string)obj);
			}
			else if (obj is AndroidJavaClass)
			{
				ret[num].l = ((AndroidJavaClass)obj).GetRawClass();
			}
			else if (obj is AndroidJavaObject)
			{
				ret[num].l = ((AndroidJavaObject)obj).GetRawObject();
			}
			else if (obj is Array)
			{
				ret[num].l = ConvertToJNIArray((Array)obj);
			}
			else if (obj is AndroidJavaProxy)
			{
				ret[num].l = ((AndroidJavaProxy)obj).GetRawProxy();
			}
			else
			{
				if (!(obj is AndroidJavaRunnable))
				{
					throw new Exception("JNI; Unknown argument type '" + obj.GetType()?.ToString() + "'");
				}
				ret[num].l = AndroidJNIHelper.CreateJavaRunnable((AndroidJavaRunnable)obj);
			}
			num++;
		}
	}

	public static object UnboxArray(AndroidJavaObject obj)
	{
		if (obj == null)
		{
			return null;
		}
		AndroidJavaClass androidJavaClass = new AndroidJavaClass("java/lang/reflect/Array");
		AndroidJavaObject androidJavaObject = obj.Call<AndroidJavaObject>("getClass", Array.Empty<object>());
		AndroidJavaObject androidJavaObject2 = androidJavaObject.Call<AndroidJavaObject>("getComponentType", Array.Empty<object>());
		string text = androidJavaObject2.Call<string>("getName", Array.Empty<object>());
		int num = androidJavaClass.CallStatic<int>("getLength", new object[1] { obj });
		Array array;
		if (!androidJavaObject2.Call<bool>("isPrimitive", Array.Empty<object>()))
		{
			if ("java.lang.String" == text)
			{
				array = new string[num];
			}
			else
			{
				array = ((!("java.lang.Class" == text)) ? new AndroidJavaObject[num] : new AndroidJavaClass[num]);
			}
		}
		else if ("int" == text)
		{
			array = new int[num];
		}
		else if ("boolean" == text)
		{
			array = new bool[num];
		}
		else if ("byte" == text)
		{
			array = new sbyte[num];
		}
		else if ("short" == text)
		{
			array = new short[num];
		}
		else if ("long" == text)
		{
			array = new long[num];
		}
		else if ("float" == text)
		{
			array = new float[num];
		}
		else if ("double" == text)
		{
			array = new double[num];
		}
		else
		{
			if (!("char" == text))
			{
				throw new Exception("JNI; Unknown argument type '" + text + "'");
			}
			array = new char[num];
		}
		for (int i = 0; i < num; i++)
		{
			array.SetValue(Unbox(androidJavaClass.CallStatic<AndroidJavaObject>("get", new object[2] { obj, i })), i);
		}
		androidJavaClass.Dispose();
		return array;
	}

	public static object Unbox(AndroidJavaObject obj)
	{
		if (obj == null)
		{
			return null;
		}
		using AndroidJavaObject androidJavaObject = obj.Call<AndroidJavaObject>("getClass", Array.Empty<object>());
		string text = androidJavaObject.Call<string>("getName", Array.Empty<object>());
		if ("java.lang.Integer" == text)
		{
			return obj.Call<int>("intValue", Array.Empty<object>());
		}
		if ("java.lang.Boolean" == text)
		{
			return obj.Call<bool>("booleanValue", Array.Empty<object>());
		}
		if ("java.lang.Byte" == text)
		{
			return obj.Call<sbyte>("byteValue", Array.Empty<object>());
		}
		if ("java.lang.Short" == text)
		{
			return obj.Call<short>("shortValue", Array.Empty<object>());
		}
		if ("java.lang.Long" == text)
		{
			return obj.Call<long>("longValue", Array.Empty<object>());
		}
		if ("java.lang.Float" == text)
		{
			return obj.Call<float>("floatValue", Array.Empty<object>());
		}
		if ("java.lang.Double" == text)
		{
			return obj.Call<double>("doubleValue", Array.Empty<object>());
		}
		if ("java.lang.Character" == text)
		{
			return obj.Call<char>("charValue", Array.Empty<object>());
		}
		if ("java.lang.String" == text)
		{
			return obj.Call<string>("toString", Array.Empty<object>());
		}
		if ("java.lang.Class" == text)
		{
			return new AndroidJavaClass(obj.GetRawObject());
		}
		if (androidJavaObject.Call<bool>("isArray", Array.Empty<object>()))
		{
			return UnboxArray(obj);
		}
		return obj;
	}

	public static AndroidJavaObject Box(object obj)
	{
		if (obj == null)
		{
			return null;
		}
		if (AndroidReflection.IsPrimitive(obj.GetType()))
		{
			if (obj is int)
			{
				return new AndroidJavaObject("java.lang.Integer", (int)obj);
			}
			if (obj is bool)
			{
				return new AndroidJavaObject("java.lang.Boolean", (bool)obj);
			}
			if (obj is byte)
			{
				return new AndroidJavaObject("java.lang.Byte", (sbyte)obj);
			}
			if (obj is sbyte)
			{
				return new AndroidJavaObject("java.lang.Byte", (sbyte)obj);
			}
			if (obj is short)
			{
				return new AndroidJavaObject("java.lang.Short", (short)obj);
			}
			if (obj is long)
			{
				return new AndroidJavaObject("java.lang.Long", (long)obj);
			}
			if (obj is float)
			{
				return new AndroidJavaObject("java.lang.Float", (float)obj);
			}
			if (obj is double)
			{
				return new AndroidJavaObject("java.lang.Double", (double)obj);
			}
			if (obj is char)
			{
				return new AndroidJavaObject("java.lang.Character", (char)obj);
			}
			throw new Exception("JNI; Unknown argument type '" + obj.GetType()?.ToString() + "'");
		}
		if (obj is string)
		{
			return new AndroidJavaObject("java.lang.String", (string)obj);
		}
		if (obj is AndroidJavaClass)
		{
			return new AndroidJavaObject(((AndroidJavaClass)obj).GetRawClass());
		}
		if (obj is AndroidJavaObject)
		{
			return (AndroidJavaObject)obj;
		}
		if (obj is Array)
		{
			return AndroidJavaObject.AndroidJavaObjectDeleteLocalRef(ConvertToJNIArray((Array)obj));
		}
		if (obj is AndroidJavaProxy)
		{
			return ((AndroidJavaProxy)obj).GetProxyObject();
		}
		if (obj is AndroidJavaRunnable)
		{
			return AndroidJavaObject.AndroidJavaObjectDeleteLocalRef(AndroidJNIHelper.CreateJavaRunnable((AndroidJavaRunnable)obj));
		}
		throw new Exception("JNI; Unknown argument type '" + obj.GetType()?.ToString() + "'");
	}

	public static void DeleteJNIArgArray(object[] args, Span<jvalue> jniArgs)
	{
		if (args == null)
		{
			return;
		}
		int num = 0;
		foreach (object obj in args)
		{
			if (obj is string || obj is AndroidJavaRunnable || obj is AndroidJavaProxy || obj is Array)
			{
				AndroidJNISafe.DeleteLocalRef(jniArgs[num].l);
			}
			num++;
		}
	}

	public static IntPtr ConvertToJNIArray(Array array)
	{
		Type elementType = array.GetType().GetElementType();
		if (AndroidReflection.IsPrimitive(elementType))
		{
			if (elementType == typeof(int))
			{
				return AndroidJNISafe.ToIntArray((int[])array);
			}
			if (elementType == typeof(bool))
			{
				return AndroidJNISafe.ToBooleanArray((bool[])array);
			}
			if (elementType == typeof(byte))
			{
				Debug.LogWarning("AndroidJNIHelper: converting Byte array is obsolete, use SByte array instead");
				return AndroidJNISafe.ToByteArray((byte[])array);
			}
			if (elementType == typeof(sbyte))
			{
				return AndroidJNISafe.ToSByteArray((sbyte[])array);
			}
			if (elementType == typeof(short))
			{
				return AndroidJNISafe.ToShortArray((short[])array);
			}
			if (elementType == typeof(long))
			{
				return AndroidJNISafe.ToLongArray((long[])array);
			}
			if (elementType == typeof(float))
			{
				return AndroidJNISafe.ToFloatArray((float[])array);
			}
			if (elementType == typeof(double))
			{
				return AndroidJNISafe.ToDoubleArray((double[])array);
			}
			if (elementType == typeof(char))
			{
				return AndroidJNISafe.ToCharArray((char[])array);
			}
			return IntPtr.Zero;
		}
		if (elementType == typeof(string))
		{
			string[] array2 = (string[])array;
			int length = array.GetLength(0);
			IntPtr intPtr = AndroidJNISafe.FindClass("java/lang/String");
			IntPtr intPtr2 = AndroidJNI.NewObjectArray(length, intPtr, IntPtr.Zero);
			for (int i = 0; i < length; i++)
			{
				IntPtr intPtr3 = AndroidJNISafe.NewString(array2[i]);
				AndroidJNI.SetObjectArrayElement(intPtr2, i, intPtr3);
				AndroidJNISafe.DeleteLocalRef(intPtr3);
			}
			AndroidJNISafe.DeleteLocalRef(intPtr);
			return intPtr2;
		}
		if (elementType == typeof(AndroidJavaObject))
		{
			AndroidJavaObject[] array3 = (AndroidJavaObject[])array;
			int length2 = array.GetLength(0);
			IntPtr[] array4 = new IntPtr[length2];
			IntPtr intPtr4 = AndroidJNISafe.FindClass("java/lang/Object");
			IntPtr intPtr5 = IntPtr.Zero;
			for (int j = 0; j < length2; j++)
			{
				if (array3[j] != null)
				{
					array4[j] = array3[j].GetRawObject();
					IntPtr rawClass = array3[j].GetRawClass();
					if (intPtr5 == IntPtr.Zero)
					{
						intPtr5 = rawClass;
					}
					else if (intPtr5 != intPtr4 && !AndroidJNI.IsSameObject(intPtr5, rawClass))
					{
						intPtr5 = intPtr4;
					}
				}
				else
				{
					array4[j] = IntPtr.Zero;
				}
			}
			IntPtr result = AndroidJNISafe.ToObjectArray(array4, intPtr5);
			AndroidJNISafe.DeleteLocalRef(intPtr4);
			return result;
		}
		if (AndroidReflection.IsAssignableFrom(typeof(AndroidJavaProxy), elementType))
		{
			AndroidJavaProxy[] array5 = (AndroidJavaProxy[])array;
			int length3 = array.GetLength(0);
			IntPtr[] array6 = new IntPtr[length3];
			IntPtr intPtr6 = AndroidJNISafe.FindClass("java/lang/Object");
			IntPtr intPtr7 = IntPtr.Zero;
			for (int k = 0; k < length3; k++)
			{
				if (array5[k] != null)
				{
					array6[k] = array5[k].GetRawProxy();
					IntPtr rawClass2 = array5[k].javaInterface.GetRawClass();
					if (intPtr7 == IntPtr.Zero)
					{
						intPtr7 = rawClass2;
					}
					else if (intPtr7 != intPtr6 && !AndroidJNI.IsSameObject(intPtr7, rawClass2))
					{
						intPtr7 = intPtr6;
					}
				}
				else
				{
					array6[k] = IntPtr.Zero;
				}
			}
			IntPtr result2 = AndroidJNISafe.ToObjectArray(array6, intPtr7);
			AndroidJNISafe.DeleteLocalRef(intPtr6);
			return result2;
		}
		throw new Exception("JNI; Unknown array type '" + elementType?.ToString() + "'");
	}

	public static ArrayType ConvertFromJNIArray<ArrayType>(IntPtr array)
	{
		Type elementType = typeof(ArrayType).GetElementType();
		if (AndroidReflection.IsPrimitive(elementType))
		{
			if (elementType == typeof(int))
			{
				return (ArrayType)(object)AndroidJNISafe.FromIntArray(array);
			}
			if (elementType == typeof(bool))
			{
				return (ArrayType)(object)AndroidJNISafe.FromBooleanArray(array);
			}
			if (elementType == typeof(byte))
			{
				Debug.LogWarning("AndroidJNIHelper: converting from Byte array is obsolete, use SByte array instead");
				return (ArrayType)(object)AndroidJNISafe.FromByteArray(array);
			}
			if (elementType == typeof(sbyte))
			{
				return (ArrayType)(object)AndroidJNISafe.FromSByteArray(array);
			}
			if (elementType == typeof(short))
			{
				return (ArrayType)(object)AndroidJNISafe.FromShortArray(array);
			}
			if (elementType == typeof(long))
			{
				return (ArrayType)(object)AndroidJNISafe.FromLongArray(array);
			}
			if (elementType == typeof(float))
			{
				return (ArrayType)(object)AndroidJNISafe.FromFloatArray(array);
			}
			if (elementType == typeof(double))
			{
				return (ArrayType)(object)AndroidJNISafe.FromDoubleArray(array);
			}
			if (elementType == typeof(char))
			{
				return (ArrayType)(object)AndroidJNISafe.FromCharArray(array);
			}
			return default;
		}
		if (elementType == typeof(string))
		{
			int arrayLength = AndroidJNISafe.GetArrayLength(array);
			string[] array2 = new string[arrayLength];
			for (int i = 0; i < arrayLength; i++)
			{
				IntPtr objectArrayElement = AndroidJNI.GetObjectArrayElement(array, i);
				array2[i] = AndroidJNISafe.GetStringChars(objectArrayElement);
				AndroidJNISafe.DeleteLocalRef(objectArrayElement);
			}
			return (ArrayType)(object)array2;
		}
		if (elementType == typeof(AndroidJavaObject))
		{
			int arrayLength2 = AndroidJNISafe.GetArrayLength(array);
			AndroidJavaObject[] array3 = new AndroidJavaObject[arrayLength2];
			for (int j = 0; j < arrayLength2; j++)
			{
				IntPtr objectArrayElement2 = AndroidJNI.GetObjectArrayElement(array, j);
				array3[j] = new AndroidJavaObject(objectArrayElement2);
				AndroidJNISafe.DeleteLocalRef(objectArrayElement2);
			}
			return (ArrayType)(object)array3;
		}
		throw new Exception("JNI: Unknown generic array type '" + elementType?.ToString() + "'");
	}

	public static IntPtr GetConstructorID(IntPtr jclass, object[] args)
	{
		return AndroidJNIHelper.GetConstructorID(jclass, GetSignature(args));
	}

	public static IntPtr GetMethodID(IntPtr jclass, string methodName, object[] args, bool isStatic)
	{
		return AndroidJNIHelper.GetMethodID(jclass, methodName, GetSignature(args), isStatic);
	}

	public static IntPtr GetMethodID<ReturnType>(IntPtr jclass, string methodName, object[] args, bool isStatic)
	{
		return AndroidJNIHelper.GetMethodID(jclass, methodName, GetSignature<ReturnType>(args), isStatic);
	}

	public static IntPtr GetFieldID<ReturnType>(IntPtr jclass, string fieldName, bool isStatic)
	{
		return AndroidJNIHelper.GetFieldID(jclass, fieldName, GetSignature(typeof(ReturnType)), isStatic);
	}

	public static IntPtr GetConstructorID(IntPtr jclass, string signature)
	{
		IntPtr intPtr = IntPtr.Zero;
		try
		{
			intPtr = AndroidReflection.GetConstructorMember(jclass, signature);
			return AndroidJNISafe.FromReflectedMethod(intPtr);
		}
		catch (Exception ex)
		{
			IntPtr methodID = AndroidJNISafe.GetMethodID(jclass, "<init>", signature);
			if (methodID != IntPtr.Zero)
			{
				return methodID;
			}
			throw ex;
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(intPtr);
		}
	}

	public static IntPtr GetMethodID(IntPtr jclass, string methodName, string signature, bool isStatic)
	{
		IntPtr intPtr = IntPtr.Zero;
		try
		{
			intPtr = AndroidReflection.GetMethodMember(jclass, methodName, signature, isStatic);
			return AndroidJNISafe.FromReflectedMethod(intPtr);
		}
		catch (Exception ex)
		{
			IntPtr methodIDFallback = GetMethodIDFallback(jclass, methodName, signature, isStatic);
			if (methodIDFallback != IntPtr.Zero)
			{
				return methodIDFallback;
			}
			throw ex;
		}
		finally
		{
			AndroidJNISafe.DeleteLocalRef(intPtr);
		}
	}

	private static IntPtr GetMethodIDFallback(IntPtr jclass, string methodName, string signature, bool isStatic)
	{
		try
		{
			return isStatic ? AndroidJNISafe.GetStaticMethodID(jclass, methodName, signature) : AndroidJNISafe.GetMethodID(jclass, methodName, signature);
		}
		catch (Exception)
		{
		}
		return IntPtr.Zero;
	}

	public static IntPtr GetFieldID(IntPtr jclass, string fieldName, string signature, bool isStatic)
	{
		IntPtr zero = IntPtr.Zero;
		Exception ex = null;
		AndroidJNI.PushLocalFrame(10);
		try
		{
			IntPtr fieldMember = AndroidReflection.GetFieldMember(jclass, fieldName, signature, isStatic);
			if (!isStatic)
			{
				jclass = AndroidReflection.GetFieldClass(fieldMember);
			}
			signature = AndroidReflection.GetFieldSignature(fieldMember);
		}
		catch (Exception ex2)
		{
			ex = ex2;
		}
		try
		{
			zero = (isStatic ? AndroidJNISafe.GetStaticFieldID(jclass, fieldName, signature) : AndroidJNISafe.GetFieldID(jclass, fieldName, signature));
			if (zero == IntPtr.Zero)
			{
				if (ex != null)
				{
					throw ex;
				}
				throw new Exception($"Field {fieldName} or type signature {signature} not found");
			}
			return zero;
		}
		finally
		{
			AndroidJNI.PopLocalFrame(IntPtr.Zero);
		}
	}

	public static string GetSignature(object obj)
	{
		if (obj == null)
		{
			return "Ljava/lang/Object;";
		}
		Type type = ((obj is Type) ? ((Type)obj) : obj.GetType());
		if (AndroidReflection.IsPrimitive(type))
		{
			if (type.Equals(typeof(int)))
			{
				return "I";
			}
			if (type.Equals(typeof(bool)))
			{
				return "Z";
			}
			if (type.Equals(typeof(byte)))
			{
				Debug.LogWarning("AndroidJNIHelper.GetSignature: using Byte parameters is obsolete, use SByte parameters instead");
				return "B";
			}
			if (type.Equals(typeof(sbyte)))
			{
				return "B";
			}
			if (type.Equals(typeof(short)))
			{
				return "S";
			}
			if (type.Equals(typeof(long)))
			{
				return "J";
			}
			if (type.Equals(typeof(float)))
			{
				return "F";
			}
			if (type.Equals(typeof(double)))
			{
				return "D";
			}
			if (type.Equals(typeof(char)))
			{
				return "C";
			}
			return "";
		}
		if (type.Equals(typeof(string)))
		{
			return "Ljava/lang/String;";
		}
		if (obj is AndroidJavaProxy)
		{
			using (AndroidJavaObject androidJavaObject = new AndroidJavaObject(((AndroidJavaProxy)obj).javaInterface.GetRawClass()))
			{
				return "L" + androidJavaObject.Call<string>("getName", Array.Empty<object>()) + ";";
			}
		}
		if (obj == type && AndroidReflection.IsAssignableFrom(typeof(AndroidJavaProxy), type))
		{
			return "";
		}
		if (type.Equals(typeof(AndroidJavaRunnable)))
		{
			return "Ljava/lang/Runnable;";
		}
		if (type.Equals(typeof(AndroidJavaClass)))
		{
			return "Ljava/lang/Class;";
		}
		if (type.Equals(typeof(AndroidJavaObject)))
		{
			if (obj == type)
			{
				return "Ljava/lang/Object;";
			}
			AndroidJavaObject androidJavaObject2 = (AndroidJavaObject)obj;
			using AndroidJavaObject androidJavaObject3 = androidJavaObject2.Call<AndroidJavaObject>("getClass", Array.Empty<object>());
			return "L" + androidJavaObject3.Call<string>("getName", Array.Empty<object>()) + ";";
		}
		if (AndroidReflection.IsAssignableFrom(typeof(Array), type))
		{
			if (type.GetArrayRank() != 1)
			{
				throw new Exception("JNI: System.Array in n dimensions is not allowed");
			}
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append('[');
			stringBuilder.Append(GetSignature(type.GetElementType()));
			return (stringBuilder.Length > 1) ? stringBuilder.ToString() : "";
		}
		throw new Exception("JNI: Unknown signature for type '" + type?.ToString() + "' (obj = " + obj?.ToString() + ") " + ((type == obj) ? "equal" : "instance"));
	}

	public static string GetSignature(object[] args)
	{
		if (args == null || args.Length == 0)
		{
			return "()V";
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append('(');
		foreach (object obj in args)
		{
			stringBuilder.Append(GetSignature(obj));
		}
		stringBuilder.Append(")V");
		return stringBuilder.ToString();
	}

	public static string GetSignature<ReturnType>(object[] args)
	{
		if (args == null || args.Length == 0)
		{
			return "()" + GetSignature(typeof(ReturnType));
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append('(');
		foreach (object obj in args)
		{
			stringBuilder.Append(GetSignature(obj));
		}
		stringBuilder.Append(')');
		stringBuilder.Append(GetSignature(typeof(ReturnType)));
		return stringBuilder.ToString();
	}
}
