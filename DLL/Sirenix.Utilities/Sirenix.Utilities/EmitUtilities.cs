using System;
using System.Reflection;
using UnityEngine;

namespace Sirenix.Utilities;

public static class EmitUtilities
{
	private static Assembly EngineAssembly = typeof(UnityEngine.Object).Assembly;

	public static bool CanEmit => false;

	private static bool EmitIsIllegalForMember(MemberInfo member)
	{
		if (member.DeclaringType != null)
		{
			return member.DeclaringType.Assembly == EngineAssembly;
		}
		return false;
	}

	public static Func<FieldType> CreateStaticFieldGetter<FieldType>(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (!fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field must be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		if (fieldInfo.IsLiteral)
		{
			FieldType value = (FieldType)fieldInfo.GetValue(null);
			return () => value;
		}
		return () => (FieldType)fieldInfo.GetValue(null);
	}

	public static Func<object> CreateWeakStaticFieldGetter(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (!fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field must be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return () => fieldInfo.GetValue(null);
	}

	public static Action<FieldType> CreateStaticFieldSetter<FieldType>(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (!fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field must be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		if (fieldInfo.IsLiteral)
		{
			throw new ArgumentException("Field cannot be constant.");
		}
		return delegate(FieldType value)
		{
			fieldInfo.SetValue(null, value);
		};
	}

	public static Action<object> CreateWeakStaticFieldSetter(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (!fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field must be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(object value)
		{
			fieldInfo.SetValue(null, value);
		};
	}

	public static ValueGetter<InstanceType, FieldType> CreateInstanceFieldGetter<InstanceType, FieldType>(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field cannot be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(ref InstanceType classInstance)
		{
			return (FieldType)fieldInfo.GetValue(classInstance);
		};
	}

	public static WeakValueGetter<FieldType> CreateWeakInstanceFieldGetter<FieldType>(Type instanceType, FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (instanceType == null)
		{
			throw new ArgumentNullException("instanceType");
		}
		if (fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field cannot be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(ref object classInstance)
		{
			return (FieldType)fieldInfo.GetValue(classInstance);
		};
	}

	public static WeakValueGetter CreateWeakInstanceFieldGetter(Type instanceType, FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (instanceType == null)
		{
			throw new ArgumentNullException("instanceType");
		}
		if (fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field cannot be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(ref object classInstance)
		{
			return fieldInfo.GetValue(classInstance);
		};
	}

	public static ValueSetter<InstanceType, FieldType> CreateInstanceFieldSetter<InstanceType, FieldType>(FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field cannot be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(ref InstanceType classInstance, FieldType value)
		{
			if (typeof(InstanceType).IsValueType)
			{
				object obj = classInstance;
				fieldInfo.SetValue(obj, value);
				classInstance = (InstanceType)obj;
			}
			else
			{
				fieldInfo.SetValue(classInstance, value);
			}
		};
	}

	public static WeakValueSetter<FieldType> CreateWeakInstanceFieldSetter<FieldType>(Type instanceType, FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (instanceType == null)
		{
			throw new ArgumentNullException("instanceType");
		}
		if (fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field cannot be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(ref object classInstance, FieldType value)
		{
			fieldInfo.SetValue(classInstance, value);
		};
	}

	public static WeakValueSetter CreateWeakInstanceFieldSetter(Type instanceType, FieldInfo fieldInfo)
	{
		if (fieldInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		if (instanceType == null)
		{
			throw new ArgumentNullException("instanceType");
		}
		if (fieldInfo.IsStatic)
		{
			throw new ArgumentException("Field cannot be static.");
		}
		fieldInfo = fieldInfo.DeAliasField();
		return delegate(ref object classInstance, object value)
		{
			fieldInfo.SetValue(classInstance, value);
		};
	}

	public static WeakValueGetter CreateWeakInstancePropertyGetter(Type instanceType, PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("propertyInfo");
		}
		if (instanceType == null)
		{
			throw new ArgumentNullException("instanceType");
		}
		propertyInfo = propertyInfo.DeAliasProperty();
		if (propertyInfo.GetIndexParameters().Length != 0)
		{
			throw new ArgumentException("Property must not have any index parameters");
		}
		MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
		if (getMethod == null)
		{
			throw new ArgumentException("Property must have a getter.");
		}
		if (getMethod.IsStatic)
		{
			throw new ArgumentException("Property cannot be static.");
		}
		return delegate(ref object classInstance)
		{
			return propertyInfo.GetValue(classInstance, null);
		};
	}

	public static WeakValueSetter CreateWeakInstancePropertySetter(Type instanceType, PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("propertyInfo");
		}
		if (instanceType == null)
		{
			throw new ArgumentNullException("instanceType");
		}
		propertyInfo = propertyInfo.DeAliasProperty();
		if (propertyInfo.GetIndexParameters().Length != 0)
		{
			throw new ArgumentException("Property must not have any index parameters");
		}
		MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
		if (setMethod.IsStatic)
		{
			throw new ArgumentException("Property cannot be static.");
		}
		return delegate(ref object classInstance, object value)
		{
			propertyInfo.SetValue(classInstance, value, null);
		};
	}

	public static Action<PropType> CreateStaticPropertySetter<PropType>(PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		propertyInfo = propertyInfo.DeAliasProperty();
		if (propertyInfo.GetIndexParameters().Length != 0)
		{
			throw new ArgumentException("Property must not have any index parameters");
		}
		MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
		if (setMethod == null)
		{
			throw new ArgumentException("Property must have a set method.");
		}
		if (!setMethod.IsStatic)
		{
			throw new ArgumentException("Property must be static.");
		}
		return delegate(PropType value)
		{
			propertyInfo.SetValue(null, value, null);
		};
	}

	public static Func<PropType> CreateStaticPropertyGetter<PropType>(PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("propertyInfo");
		}
		propertyInfo = propertyInfo.DeAliasProperty();
		if (propertyInfo.GetIndexParameters().Length != 0)
		{
			throw new ArgumentException("Property must not have any index parameters");
		}
		MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
		if (getMethod == null)
		{
			throw new ArgumentException("Property must have a get method.");
		}
		if (!getMethod.IsStatic)
		{
			throw new ArgumentException("Property must be static.");
		}
		return () => (PropType)propertyInfo.GetValue(null, null);
	}

	public static ValueSetter<InstanceType, PropType> CreateInstancePropertySetter<InstanceType, PropType>(PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("fieldInfo");
		}
		propertyInfo = propertyInfo.DeAliasProperty();
		if (propertyInfo.GetIndexParameters().Length != 0)
		{
			throw new ArgumentException("Property must not have any index parameters");
		}
		MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
		if (setMethod == null)
		{
			throw new ArgumentException("Property must have a set method.");
		}
		if (setMethod.IsStatic)
		{
			throw new ArgumentException("Property cannot be static.");
		}
		return delegate(ref InstanceType classInstance, PropType value)
		{
			if (typeof(InstanceType).IsValueType)
			{
				object obj = classInstance;
				propertyInfo.SetValue(obj, value, null);
				classInstance = (InstanceType)obj;
			}
			else
			{
				propertyInfo.SetValue(classInstance, value, null);
			}
		};
	}

	public static ValueGetter<InstanceType, PropType> CreateInstancePropertyGetter<InstanceType, PropType>(PropertyInfo propertyInfo)
	{
		if (propertyInfo == null)
		{
			throw new ArgumentNullException("propertyInfo");
		}
		propertyInfo = propertyInfo.DeAliasProperty();
		if (propertyInfo.GetIndexParameters().Length != 0)
		{
			throw new ArgumentException("Property must not have any index parameters");
		}
		MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
		if (getMethod == null)
		{
			throw new ArgumentException("Property must have a get method.");
		}
		if (getMethod.IsStatic)
		{
			throw new ArgumentException("Property cannot be static.");
		}
		return delegate(ref InstanceType classInstance)
		{
			return (PropType)propertyInfo.GetValue(classInstance, null);
		};
	}

	public static Func<InstanceType, ReturnType> CreateMethodReturner<InstanceType, ReturnType>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (Func<InstanceType, ReturnType>)Delegate.CreateDelegate(typeof(Func<InstanceType, ReturnType>), methodInfo);
	}

	public static Action CreateStaticMethodCaller(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (!methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is an instance method when it has to be static.");
		}
		if (methodInfo.GetParameters().Length != 0)
		{
			throw new ArgumentException("Given method cannot have any parameters.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (Action)Delegate.CreateDelegate(typeof(Action), methodInfo);
	}

	public static Action<object, TArg1> CreateWeakInstanceMethodCaller<TArg1>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 1)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must have exactly one parameter.");
		}
		if (parameters[0].ParameterType != typeof(TArg1))
		{
			throw new ArgumentException("The first parameter of the method '" + methodInfo.Name + "' must be of type " + typeof(TArg1)?.ToString() + ".");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return delegate(object classInstance, TArg1 arg)
		{
			methodInfo.Invoke(classInstance, new object[1] { arg });
		};
	}

	public static Action<object> CreateWeakInstanceMethodCaller(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		if (methodInfo.GetParameters().Length != 0)
		{
			throw new ArgumentException("Given method cannot have any parameters.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return delegate(object classInstance)
		{
			methodInfo.Invoke(classInstance, null);
		};
	}

	public static Func<object, TArg1, TResult> CreateWeakInstanceMethodCaller<TResult, TArg1>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		if (methodInfo.ReturnType != typeof(TResult))
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must return type " + typeof(TResult)?.ToString() + ".");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 1)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must have exactly one parameter.");
		}
		if (!typeof(TArg1).InheritsFrom(parameters[0].ParameterType))
		{
			throw new ArgumentException("The first parameter of the method '" + methodInfo.Name + "' must be of type " + typeof(TArg1)?.ToString() + ".");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (object classInstance, TArg1 arg1) => (TResult)methodInfo.Invoke(classInstance, new object[1] { arg1 });
	}

	public static Func<object, TResult> CreateWeakInstanceMethodCallerFunc<TResult>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		if (methodInfo.ReturnType != typeof(TResult))
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must return type " + typeof(TResult)?.ToString() + ".");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 0)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must have no parameter.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (object classInstance) => (TResult)methodInfo.Invoke(classInstance, null);
	}

	public static Func<object, TArg, TResult> CreateWeakInstanceMethodCallerFunc<TArg, TResult>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		if (methodInfo.ReturnType != typeof(TResult))
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must return type " + typeof(TResult)?.ToString() + ".");
		}
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length != 1)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' must have one parameter.");
		}
		if (!parameters[0].ParameterType.IsAssignableFrom(typeof(TArg)))
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' has an invalid parameter type.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (object classInstance, TArg arg) => (TResult)methodInfo.Invoke(classInstance, new object[1] { arg });
	}

	public static Action<InstanceType> CreateInstanceMethodCaller<InstanceType>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		if (methodInfo.GetParameters().Length != 0)
		{
			throw new ArgumentException("Given method cannot have any parameters.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (Action<InstanceType>)Delegate.CreateDelegate(typeof(Action<InstanceType>), methodInfo);
	}

	public static Action<InstanceType, Arg1> CreateInstanceMethodCaller<InstanceType, Arg1>(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		if (methodInfo.IsStatic)
		{
			throw new ArgumentException("Given method '" + methodInfo.Name + "' is static when it has to be an instance method.");
		}
		if (methodInfo.GetParameters().Length != 1)
		{
			throw new ArgumentException("Given method must have only one parameter.");
		}
		methodInfo = methodInfo.DeAliasMethod();
		return (Action<InstanceType, Arg1>)Delegate.CreateDelegate(typeof(Action<InstanceType, Arg1>), methodInfo);
	}
}
