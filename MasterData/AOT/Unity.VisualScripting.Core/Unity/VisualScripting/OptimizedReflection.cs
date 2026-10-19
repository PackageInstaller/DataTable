using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting;

public static class OptimizedReflection
{
	private static readonly Dictionary<FieldInfo, IOptimizedAccessor> fieldAccessors;

	private static readonly Dictionary<PropertyInfo, IOptimizedAccessor> propertyAccessors;

	private static readonly Dictionary<MethodInfo, IOptimizedInvoker> methodInvokers;

	public static readonly bool jitAvailable;

	private static bool _useJitIfAvailable;

	internal static bool useJit
	{
		get
		{
			if (useJitIfAvailable)
			{
				return jitAvailable;
			}
			return false;
		}
	}

	public static bool useJitIfAvailable
	{
		get
		{
			return _useJitIfAvailable;
		}
		set
		{
			_useJitIfAvailable = value;
			ClearCache();
		}
	}

	public static bool safeMode { get; set; }

	static OptimizedReflection()
	{
		_useJitIfAvailable = true;
		fieldAccessors = new Dictionary<FieldInfo, IOptimizedAccessor>();
		propertyAccessors = new Dictionary<PropertyInfo, IOptimizedAccessor>();
		methodInvokers = new Dictionary<MethodInfo, IOptimizedInvoker>();
		jitAvailable = PlatformUtility.supportsJit;
	}

	internal static void OnRuntimeMethodLoad()
	{
		safeMode = Application.isEditor || Debug.isDebugBuild;
	}

	public static void ClearCache()
	{
		fieldAccessors.Clear();
		propertyAccessors.Clear();
		methodInvokers.Clear();
	}

	internal static void VerifyStaticTarget(Type targetType, object target)
	{
		VerifyTarget(targetType, target, @static: true);
	}

	internal static void VerifyInstanceTarget<TTArget>(object target)
	{
		VerifyTarget(typeof(TTArget), target, @static: false);
	}

	private static void VerifyTarget(Type targetType, object target, bool @static)
	{
		Ensure.That("targetType").IsNotNull(targetType);
		if (@static)
		{
			if (target != null)
			{
				throw new TargetException($"Superfluous target object for '{targetType}'.");
			}
			return;
		}
		if (target == null)
		{
			throw new TargetException($"Missing target object for '{targetType}'.");
		}
		if (!targetType.IsAssignableFrom(targetType))
		{
			throw new TargetException($"The target object does not match the target type.\nProvided: {target.GetType()}\nExpected: {targetType}");
		}
	}

	private static bool SupportsOptimization(MemberInfo memberInfo)
	{
		if (memberInfo.DeclaringType.IsValueType && !memberInfo.IsStatic())
		{
			return false;
		}
		return true;
	}

	public static IOptimizedAccessor Prewarm(this FieldInfo fieldInfo)
	{
		return GetFieldAccessor(fieldInfo);
	}

	public static object GetValueOptimized(this FieldInfo fieldInfo, object target)
	{
		return GetFieldAccessor(fieldInfo).GetValue(target);
	}

	public static void SetValueOptimized(this FieldInfo fieldInfo, object target, object value)
	{
		GetFieldAccessor(fieldInfo).SetValue(target, value);
	}

	public static bool SupportsOptimization(this FieldInfo fieldInfo)
	{
		if (!SupportsOptimization((MemberInfo)fieldInfo))
		{
			return false;
		}
		return true;
	}

	private static IOptimizedAccessor GetFieldAccessor(FieldInfo fieldInfo)
	{
		Ensure.That("fieldInfo").IsNotNull(fieldInfo);
		lock (fieldAccessors)
		{
			if (!fieldAccessors.TryGetValue(fieldInfo, out var value))
			{
				if (fieldInfo.SupportsOptimization())
				{
					Type type = ((!fieldInfo.IsStatic) ? typeof(InstanceFieldAccessor<, >).MakeGenericType(fieldInfo.DeclaringType, fieldInfo.FieldType) : typeof(StaticFieldAccessor<>).MakeGenericType(fieldInfo.FieldType));
					value = (IOptimizedAccessor)Activator.CreateInstance(type, fieldInfo);
				}
				else
				{
					value = new ReflectionFieldAccessor(fieldInfo);
				}
				value.Compile();
				fieldAccessors.Add(fieldInfo, value);
			}
			return value;
		}
	}

	public static IOptimizedAccessor Prewarm(this PropertyInfo propertyInfo)
	{
		return GetPropertyAccessor(propertyInfo);
	}

	public static object GetValueOptimized(this PropertyInfo propertyInfo, object target)
	{
		return GetPropertyAccessor(propertyInfo).GetValue(target);
	}

	public static void SetValueOptimized(this PropertyInfo propertyInfo, object target, object value)
	{
		GetPropertyAccessor(propertyInfo).SetValue(target, value);
	}

	public static bool SupportsOptimization(this PropertyInfo propertyInfo)
	{
		if (!SupportsOptimization((MemberInfo)propertyInfo))
		{
			return false;
		}
		return true;
	}

	private static IOptimizedAccessor GetPropertyAccessor(PropertyInfo propertyInfo)
	{
		Ensure.That("propertyInfo").IsNotNull(propertyInfo);
		lock (propertyAccessors)
		{
			if (!propertyAccessors.TryGetValue(propertyInfo, out var value))
			{
				if (propertyInfo.SupportsOptimization())
				{
					Type type = ((!propertyInfo.IsStatic()) ? typeof(InstancePropertyAccessor<, >).MakeGenericType(propertyInfo.DeclaringType, propertyInfo.PropertyType) : typeof(StaticPropertyAccessor<>).MakeGenericType(propertyInfo.PropertyType));
					value = (IOptimizedAccessor)Activator.CreateInstance(type, propertyInfo);
				}
				else
				{
					value = new ReflectionPropertyAccessor(propertyInfo);
				}
				value.Compile();
				propertyAccessors.Add(propertyInfo, value);
			}
			return value;
		}
	}

	public static IOptimizedInvoker Prewarm(this MethodInfo methodInfo)
	{
		return GetMethodInvoker(methodInfo);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target, params object[] args)
	{
		return GetMethodInvoker(methodInfo).Invoke(target, args);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target)
	{
		return GetMethodInvoker(methodInfo).Invoke(target);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target, object arg0)
	{
		return GetMethodInvoker(methodInfo).Invoke(target, arg0);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target, object arg0, object arg1)
	{
		return GetMethodInvoker(methodInfo).Invoke(target, arg0, arg1);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target, object arg0, object arg1, object arg2)
	{
		return GetMethodInvoker(methodInfo).Invoke(target, arg0, arg1, arg2);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target, object arg0, object arg1, object arg2, object arg3)
	{
		return GetMethodInvoker(methodInfo).Invoke(target, arg0, arg1, arg2, arg3);
	}

	public static object InvokeOptimized(this MethodInfo methodInfo, object target, object arg0, object arg1, object arg2, object arg3, object arg4)
	{
		return GetMethodInvoker(methodInfo).Invoke(target, arg0, arg1, arg2, arg3, arg4);
	}

	public static bool SupportsOptimization(this MethodInfo methodInfo)
	{
		if (!SupportsOptimization((MemberInfo)methodInfo))
		{
			return false;
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length > 5)
		{
			return false;
		}
		if (parameters.Any((ParameterInfo parameter) => parameter.ParameterType.IsByRef))
		{
			return false;
		}
		if (!jitAvailable && methodInfo.IsVirtual && !methodInfo.IsFinal)
		{
			return false;
		}
		if (methodInfo.CallingConvention == CallingConventions.VarArgs)
		{
			return false;
		}
		return true;
	}

	private static IOptimizedInvoker GetMethodInvoker(MethodInfo methodInfo)
	{
		Ensure.That("methodInfo").IsNotNull(methodInfo);
		lock (methodInvokers)
		{
			if (!methodInvokers.TryGetValue(methodInfo, out var value))
			{
				if (methodInfo.SupportsOptimization())
				{
					ParameterInfo[] parameters = methodInfo.GetParameters();
					Type type;
					if (methodInfo.ReturnType == typeof(void))
					{
						if (methodInfo.IsStatic)
						{
							if (parameters.Length == 0)
							{
								type = typeof(StaticActionInvoker);
							}
							else if (parameters.Length == 1)
							{
								type = typeof(StaticActionInvoker<>).MakeGenericType(parameters[0].ParameterType);
							}
							else if (parameters.Length == 2)
							{
								type = typeof(StaticActionInvoker<, >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType);
							}
							else if (parameters.Length == 3)
							{
								type = typeof(StaticActionInvoker<, , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType);
							}
							else if (parameters.Length == 4)
							{
								type = typeof(StaticActionInvoker<, , , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType);
							}
							else
							{
								if (parameters.Length != 5)
								{
									throw new NotSupportedException();
								}
								type = typeof(StaticActionInvoker<, , , , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType, parameters[4].ParameterType);
							}
						}
						else if (parameters.Length == 0)
						{
							type = typeof(InstanceActionInvoker<>).MakeGenericType(methodInfo.DeclaringType);
						}
						else if (parameters.Length == 1)
						{
							type = typeof(InstanceActionInvoker<, >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType);
						}
						else if (parameters.Length == 2)
						{
							type = typeof(InstanceActionInvoker<, , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType);
						}
						else if (parameters.Length == 3)
						{
							type = typeof(InstanceActionInvoker<, , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType);
						}
						else if (parameters.Length == 4)
						{
							type = typeof(InstanceActionInvoker<, , , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType);
						}
						else
						{
							if (parameters.Length != 5)
							{
								throw new NotSupportedException();
							}
							type = typeof(InstanceActionInvoker<, , , , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType, parameters[4].ParameterType);
						}
					}
					else if (methodInfo.IsStatic)
					{
						if (parameters.Length == 0)
						{
							type = typeof(StaticFunctionInvoker<>).MakeGenericType(methodInfo.ReturnType);
						}
						else if (parameters.Length == 1)
						{
							type = typeof(StaticFunctionInvoker<, >).MakeGenericType(parameters[0].ParameterType, methodInfo.ReturnType);
						}
						else if (parameters.Length == 2)
						{
							type = typeof(StaticFunctionInvoker<, , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, methodInfo.ReturnType);
						}
						else if (parameters.Length == 3)
						{
							type = typeof(StaticFunctionInvoker<, , , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, methodInfo.ReturnType);
						}
						else if (parameters.Length == 4)
						{
							type = typeof(StaticFunctionInvoker<, , , , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType, methodInfo.ReturnType);
						}
						else
						{
							if (parameters.Length != 5)
							{
								throw new NotSupportedException();
							}
							type = typeof(StaticFunctionInvoker<, , , , , >).MakeGenericType(parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType, parameters[4].ParameterType, methodInfo.ReturnType);
						}
					}
					else if (parameters.Length == 0)
					{
						type = typeof(InstanceFunctionInvoker<, >).MakeGenericType(methodInfo.DeclaringType, methodInfo.ReturnType);
					}
					else if (parameters.Length == 1)
					{
						type = typeof(InstanceFunctionInvoker<, , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, methodInfo.ReturnType);
					}
					else if (parameters.Length == 2)
					{
						type = typeof(InstanceFunctionInvoker<, , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, methodInfo.ReturnType);
					}
					else if (parameters.Length == 3)
					{
						type = typeof(InstanceFunctionInvoker<, , , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, methodInfo.ReturnType);
					}
					else if (parameters.Length == 4)
					{
						type = typeof(InstanceFunctionInvoker<, , , , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType, methodInfo.ReturnType);
					}
					else
					{
						if (parameters.Length != 5)
						{
							throw new NotSupportedException();
						}
						type = typeof(InstanceFunctionInvoker<, , , , , , >).MakeGenericType(methodInfo.DeclaringType, parameters[0].ParameterType, parameters[1].ParameterType, parameters[2].ParameterType, parameters[3].ParameterType, parameters[4].ParameterType, methodInfo.ReturnType);
					}
					value = (IOptimizedInvoker)Activator.CreateInstance(type, methodInfo);
				}
				else
				{
					value = new ReflectionInvoker(methodInfo);
				}
				value.Compile();
				methodInvokers.Add(methodInfo, value);
			}
			return value;
		}
	}
}
