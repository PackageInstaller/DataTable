using System;
using System.Reflection;

namespace UnityEngine;

public class AndroidJavaProxy
{
	public readonly AndroidJavaClass javaInterface;

	internal IntPtr proxyObject = IntPtr.Zero;

	private static readonly GlobalJavaObjectRef s_JavaLangSystemClass = new GlobalJavaObjectRef(AndroidJNISafe.FindClass("java/lang/System"));

	private static readonly IntPtr s_HashCodeMethodID = AndroidJNIHelper.GetMethodID(s_JavaLangSystemClass, "identityHashCode", "(Ljava/lang/Object;)I", isStatic: true);

	public AndroidJavaProxy(string javaInterface)
		: this(new AndroidJavaClass(javaInterface))
	{
	}

	public AndroidJavaProxy(AndroidJavaClass javaInterface)
	{
		this.javaInterface = javaInterface;
	}

	~AndroidJavaProxy()
	{
		AndroidJNISafe.DeleteWeakGlobalRef(proxyObject);
	}

	public virtual AndroidJavaObject Invoke(string methodName, object[] args)
	{
		Exception ex = null;
		BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;
		int num = 0;
		Type[] array = new Type[args.Length];
		for (int i = 0; i < args.Length; i++)
		{
			if (args[i] == null)
			{
				array[i] = null;
				num++;
			}
			else
			{
				array[i] = args[i].GetType();
			}
		}
		try
		{
			MethodInfo methodInfo = null;
			if (num > 0)
			{
				MethodInfo[] methods = GetType().GetMethods(bindingAttr);
				int num2 = 0;
				MethodInfo[] array2 = methods;
				foreach (MethodInfo methodInfo2 in array2)
				{
					if (methodName != methodInfo2.Name)
					{
						continue;
					}
					ParameterInfo[] parameters = methodInfo2.GetParameters();
					if (parameters.Length != args.Length)
					{
						continue;
					}
					bool flag = true;
					for (int k = 0; k < parameters.Length; k++)
					{
						if (array[k] == null)
						{
							if (parameters[k].ParameterType.IsValueType)
							{
								flag = false;
								break;
							}
						}
						else if (!parameters[k].ParameterType.IsAssignableFrom(array[k]))
						{
							flag = false;
							break;
						}
					}
					if (flag)
					{
						num2++;
						methodInfo = methodInfo2;
					}
				}
				if (num2 > 1)
				{
					throw new Exception("Ambiguous overloads found for " + methodName + " with given parameters");
				}
			}
			else
			{
				methodInfo = GetType().GetMethod(methodName, bindingAttr, null, array, null);
			}
			if (methodInfo != null)
			{
				return _AndroidJNIHelper.Box(methodInfo.Invoke(this, args));
			}
		}
		catch (TargetInvocationException ex2)
		{
			ex = ex2.InnerException;
		}
		catch (Exception ex3)
		{
			ex = ex3;
		}
		string[] array3 = new string[args.Length];
		for (int l = 0; l < array3.Length; l++)
		{
			if (array[l] == null)
			{
				array3[l] = "null";
			}
			else
			{
				array3[l] = array[l].ToString();
			}
		}
		if (ex != null)
		{
			throw new TargetInvocationException(GetType()?.ToString() + "." + methodName + "(" + string.Join(",", array3) + ")", ex);
		}
		Exception ex4 = new Exception("No such proxy method: " + GetType()?.ToString() + "." + methodName + "(" + string.Join(",", array3) + ")");
		IntPtr intPtr = AndroidReflection.CreateInvocationError(ex4, methodNotFound: true);
		return (intPtr == IntPtr.Zero) ? null : new AndroidJavaObject(intPtr);
	}

	public virtual AndroidJavaObject Invoke(string methodName, AndroidJavaObject[] javaArgs)
	{
		object[] array = new object[javaArgs.Length];
		for (int i = 0; i < javaArgs.Length; i++)
		{
			array[i] = _AndroidJNIHelper.Unbox(javaArgs[i]);
			if (!(array[i] is AndroidJavaObject) && javaArgs[i] != null)
			{
				javaArgs[i].Dispose();
			}
		}
		return Invoke(methodName, array);
	}

	public virtual IntPtr Invoke(string methodName, IntPtr javaArgs)
	{
		int num = 0;
		if (javaArgs != IntPtr.Zero)
		{
			num = AndroidJNISafe.GetArrayLength(javaArgs);
		}
		if (num == 1 && methodName == "equals")
		{
			IntPtr objectArrayElement = AndroidJNISafe.GetObjectArrayElement(javaArgs, 0);
			AndroidJavaObject obj = ((objectArrayElement == IntPtr.Zero) ? null : new AndroidJavaObject(objectArrayElement));
			return AndroidJNIHelper.Box(equals(obj));
		}
		if (num == 0 && methodName == "hashCode")
		{
			return AndroidJNIHelper.Box(hashCode());
		}
		AndroidJavaObject[] array = new AndroidJavaObject[num];
		for (int i = 0; i < num; i++)
		{
			IntPtr objectArrayElement2 = AndroidJNISafe.GetObjectArrayElement(javaArgs, i);
			array[i] = ((objectArrayElement2 != IntPtr.Zero) ? AndroidJavaObject.AndroidJavaObjectDeleteLocalRef(objectArrayElement2) : null);
		}
		using AndroidJavaObject androidJavaObject = Invoke(methodName, array);
		if (androidJavaObject == null)
		{
			return IntPtr.Zero;
		}
		return AndroidJNI.NewLocalRef(androidJavaObject.GetRawObject());
	}

	public virtual bool equals(AndroidJavaObject obj)
	{
		IntPtr obj2 = obj?.GetRawObject() ?? IntPtr.Zero;
		return AndroidJNI.IsSameObject(proxyObject, obj2);
	}

	public virtual int hashCode()
	{
		Span<jvalue> args = stackalloc jvalue[1];
		args[0].l = GetRawProxy();
		return AndroidJNISafe.CallStaticIntMethod(s_JavaLangSystemClass, s_HashCodeMethodID, args);
	}

	public virtual string toString()
	{
		return this?.ToString() + " <c# proxy java object>";
	}

	internal AndroidJavaObject GetProxyObject()
	{
		return AndroidJavaObject.AndroidJavaObjectDeleteLocalRef(GetRawProxy());
	}

	internal IntPtr GetRawProxy()
	{
		IntPtr intPtr = IntPtr.Zero;
		if (proxyObject != IntPtr.Zero)
		{
			intPtr = AndroidJNI.NewLocalRef(proxyObject);
			if (intPtr == IntPtr.Zero)
			{
				AndroidJNI.DeleteWeakGlobalRef(proxyObject);
				proxyObject = IntPtr.Zero;
			}
		}
		if (intPtr == IntPtr.Zero)
		{
			intPtr = AndroidJNIHelper.CreateJavaProxy(this);
			proxyObject = AndroidJNI.NewWeakGlobalRef(intPtr);
		}
		return intPtr;
	}
}
