using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
public sealed class Member : ISerializationCallbackReceiver
{
	public enum Source
	{
		Unknown,
		Field,
		Property,
		Method,
		Constructor
	}

	[SerializeAs("name")]
	private string _name;

	[SerializeAs("parameterTypes")]
	private Type[] _parameterTypes;

	[SerializeAs("targetType")]
	private Type _targetType;

	[SerializeAs("targetTypeName")]
	private string _targetTypeName;

	[DoNotSerialize]
	private Source _source;

	[DoNotSerialize]
	private FieldInfo _fieldInfo;

	[DoNotSerialize]
	private PropertyInfo _propertyInfo;

	[DoNotSerialize]
	private MethodInfo _methodInfo;

	[DoNotSerialize]
	private ConstructorInfo _constructorInfo;

	[DoNotSerialize]
	private bool _isExtension;

	[DoNotSerialize]
	private bool _isInvokedAsExtension;

	[DoNotSerialize]
	private IOptimizedAccessor fieldAccessor;

	[DoNotSerialize]
	private IOptimizedAccessor propertyAccessor;

	[DoNotSerialize]
	private IOptimizedInvoker methodInvoker;

	public const MemberTypes SupportedMemberTypes = MemberTypes.Constructor | MemberTypes.Field | MemberTypes.Method | MemberTypes.Property;

	public const BindingFlags SupportedBindingFlags = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy;

	private static readonly object[] EmptyObjects = new object[0];

	[DoNotSerialize]
	public Type targetType
	{
		get
		{
			return _targetType;
		}
		private set
		{
			if (!(value == targetType))
			{
				isReflected = false;
				_targetType = value;
				if (value == null)
				{
					_targetTypeName = null;
				}
				else
				{
					_targetTypeName = RuntimeCodebase.SerializeType(value);
				}
			}
		}
	}

	[DoNotSerialize]
	public string targetTypeName => _targetTypeName;

	[DoNotSerialize]
	public string name
	{
		get
		{
			return _name;
		}
		private set
		{
			if (value != name)
			{
				isReflected = false;
			}
			_name = value;
		}
	}

	[DoNotSerialize]
	public bool isReflected { get; private set; }

	[DoNotSerialize]
	public Source source
	{
		get
		{
			EnsureReflected();
			return _source;
		}
		private set
		{
			_source = value;
		}
	}

	[DoNotSerialize]
	public FieldInfo fieldInfo
	{
		get
		{
			EnsureReflected();
			return _fieldInfo;
		}
		private set
		{
			_fieldInfo = value;
		}
	}

	[DoNotSerialize]
	public PropertyInfo propertyInfo
	{
		get
		{
			EnsureReflected();
			return _propertyInfo;
		}
		private set
		{
			_propertyInfo = value;
		}
	}

	[DoNotSerialize]
	public MethodInfo methodInfo
	{
		get
		{
			EnsureReflected();
			return _methodInfo;
		}
		private set
		{
			_methodInfo = value;
		}
	}

	[DoNotSerialize]
	public ConstructorInfo constructorInfo
	{
		get
		{
			EnsureReflected();
			return _constructorInfo;
		}
		private set
		{
			_constructorInfo = value;
		}
	}

	[DoNotSerialize]
	public bool isExtension
	{
		get
		{
			EnsureReflected();
			return _isExtension;
		}
		private set
		{
			_isExtension = value;
		}
	}

	[DoNotSerialize]
	public bool isInvokedAsExtension
	{
		get
		{
			EnsureReflected();
			return _isInvokedAsExtension;
		}
		private set
		{
			_isInvokedAsExtension = value;
		}
	}

	[DoNotSerialize]
	public Type[] parameterTypes
	{
		get
		{
			return _parameterTypes;
		}
		private set
		{
			_parameterTypes = value;
			isReflected = false;
		}
	}

	public MethodBase methodBase => source switch
	{
		Source.Method => (MethodBase)methodInfo, 
		Source.Constructor => constructorInfo, 
		_ => null, 
	};

	private MemberInfo _info => source switch
	{
		Source.Field => (MemberInfo)_fieldInfo, 
		Source.Property => _propertyInfo, 
		Source.Method => _methodInfo, 
		Source.Constructor => _constructorInfo, 
		_ => throw new UnexpectedEnumValueException<Source>(source), 
	};

	public MemberInfo info => source switch
	{
		Source.Field => (MemberInfo)fieldInfo, 
		Source.Property => propertyInfo, 
		Source.Method => methodInfo, 
		Source.Constructor => constructorInfo, 
		_ => throw new UnexpectedEnumValueException<Source>(source), 
	};

	public Type type => source switch
	{
		Source.Field => fieldInfo.FieldType, 
		Source.Property => propertyInfo.PropertyType, 
		Source.Method => methodInfo.ReturnType, 
		Source.Constructor => constructorInfo.DeclaringType, 
		_ => throw new UnexpectedEnumValueException<Source>(source), 
	};

	public bool isCoroutine
	{
		get
		{
			if (!isGettable)
			{
				return false;
			}
			return type == typeof(IEnumerator);
		}
	}

	public bool isYieldInstruction
	{
		get
		{
			if (!isGettable)
			{
				return false;
			}
			return typeof(YieldInstruction).IsAssignableFrom(type);
		}
	}

	public bool isGettable => IsGettable(nonPublic: true);

	public bool isPubliclyGettable => IsGettable(nonPublic: false);

	public bool isSettable => IsSettable(nonPublic: true);

	public bool isPubliclySettable => IsSettable(nonPublic: false);

	public bool isInvocable => IsInvocable(nonPublic: true);

	public bool isPubliclyInvocable => IsInvocable(nonPublic: false);

	public bool isAccessor => source switch
	{
		Source.Field => true, 
		Source.Property => true, 
		Source.Method => false, 
		Source.Constructor => false, 
		_ => throw new UnexpectedEnumValueException<Source>(source), 
	};

	public bool isField => source == Source.Field;

	public bool isProperty => source == Source.Property;

	public bool isMethod => source == Source.Method;

	public bool isConstructor => source == Source.Constructor;

	public bool requiresTarget
	{
		get
		{
			switch (source)
			{
			case Source.Field:
				return !fieldInfo.IsStatic;
			case Source.Property:
				return !(propertyInfo.GetGetMethod(nonPublic: true) ?? propertyInfo.GetSetMethod(nonPublic: true)).IsStatic;
			case Source.Method:
				if (methodInfo.IsStatic)
				{
					return isInvokedAsExtension;
				}
				return true;
			case Source.Constructor:
				return false;
			default:
				throw new UnexpectedEnumValueException<Source>(source);
			}
		}
	}

	public bool isOperator
	{
		get
		{
			if (isMethod)
			{
				return methodInfo.IsOperator();
			}
			return false;
		}
	}

	public bool isConversion
	{
		get
		{
			if (isMethod)
			{
				return methodInfo.IsUserDefinedConversion();
			}
			return false;
		}
	}

	public int order => info.MetadataToken;

	public Type declaringType => info.ExtendedDeclaringType(isInvokedAsExtension);

	public bool isInherited => targetType != declaringType;

	public Type pseudoDeclaringType
	{
		get
		{
			Type type = declaringType;
			if (typeof(UnityEngine.Object).IsAssignableFrom(targetType))
			{
				if (targetType == typeof(GameObject) || targetType == typeof(Component) || targetType == typeof(ScriptableObject))
				{
					return targetType;
				}
				if (type != typeof(UnityEngine.Object) && type != typeof(GameObject) && type != typeof(Component) && type != typeof(MonoBehaviour) && type != typeof(ScriptableObject) && type != typeof(object))
				{
					return targetType;
				}
			}
			return type;
		}
	}

	public bool isPseudoInherited
	{
		get
		{
			if (!(targetType != pseudoDeclaringType))
			{
				if (isMethod)
				{
					return methodInfo.IsGenericExtension();
				}
				return false;
			}
			return true;
		}
	}

	public bool isIndexer
	{
		get
		{
			if (isProperty)
			{
				return propertyInfo.GetIndexParameters().Length != 0;
			}
			return false;
		}
	}

	public bool isPredictable
	{
		get
		{
			if (!isField)
			{
				return info.HasAttribute<PredictableAttribute>();
			}
			return true;
		}
	}

	public bool allowsNull
	{
		get
		{
			if (isSettable)
			{
				if (!type.IsReferenceType() || !info.HasAttribute<AllowsNullAttribute>())
				{
					return Nullable.GetUnderlyingType(type) != null;
				}
				return true;
			}
			return false;
		}
	}

	[Obsolete("This parameterless constructor is only made public for serialization. Use another constructor instead.")]
	public Member()
	{
	}

	public Member(Type targetType, string name, Type[] parameterTypes = null)
	{
		Ensure.That("targetType").IsNotNull(targetType);
		Ensure.That("name").IsNotNull(name);
		if (parameterTypes != null)
		{
			for (int i = 0; i < parameterTypes.Length; i++)
			{
				if (parameterTypes[i] == null)
				{
					throw new ArgumentNullException("parameterTypes" + $"[{i}]");
				}
			}
		}
		this.targetType = targetType;
		this.name = name;
		this.parameterTypes = parameterTypes;
	}

	public Member(Type targetType, FieldInfo fieldInfo)
	{
		Ensure.That("targetType").IsNotNull(targetType);
		Ensure.That("fieldInfo").IsNotNull(fieldInfo);
		source = Source.Field;
		this.fieldInfo = fieldInfo;
		this.targetType = targetType;
		name = fieldInfo.Name;
		parameterTypes = null;
		isReflected = true;
	}

	public Member(Type targetType, PropertyInfo propertyInfo)
	{
		Ensure.That("targetType").IsNotNull(targetType);
		Ensure.That("propertyInfo").IsNotNull(propertyInfo);
		source = Source.Property;
		this.propertyInfo = propertyInfo;
		this.targetType = targetType;
		name = propertyInfo.Name;
		parameterTypes = null;
		isReflected = true;
	}

	public Member(Type targetType, MethodInfo methodInfo)
	{
		Ensure.That("targetType").IsNotNull(targetType);
		Ensure.That("methodInfo").IsNotNull(methodInfo);
		source = Source.Method;
		this.methodInfo = methodInfo;
		this.targetType = targetType;
		name = methodInfo.Name;
		isExtension = methodInfo.IsExtension();
		isInvokedAsExtension = methodInfo.IsInvokedAsExtension(targetType);
		parameterTypes = (from pi in methodInfo.GetInvocationParameters(_isInvokedAsExtension)
			select pi.ParameterType).ToArray();
		isReflected = true;
	}

	public Member(Type targetType, ConstructorInfo constructorInfo)
	{
		Ensure.That("targetType").IsNotNull(targetType);
		Ensure.That("constructorInfo").IsNotNull(constructorInfo);
		source = Source.Constructor;
		this.constructorInfo = constructorInfo;
		this.targetType = targetType;
		name = constructorInfo.Name;
		parameterTypes = (from pi in constructorInfo.GetParameters()
			select pi.ParameterType).ToArray();
		isReflected = true;
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		if (targetType != null)
		{
			_targetTypeName = RuntimeCodebase.SerializeType(targetType);
		}
		else if (_targetTypeName != null)
		{
			try
			{
				targetType = RuntimeCodebase.DeserializeType(_targetTypeName);
			}
			catch
			{
			}
		}
	}

	public bool IsGettable(bool nonPublic)
	{
		switch (source)
		{
		case Source.Field:
			if (!nonPublic)
			{
				return fieldInfo.IsPublic;
			}
			return true;
		case Source.Property:
			if (propertyInfo.CanRead)
			{
				if (!nonPublic)
				{
					return propertyInfo.GetGetMethod(nonPublic: false) != null;
				}
				return true;
			}
			return false;
		case Source.Method:
			if (methodInfo.ReturnType != typeof(void))
			{
				if (!nonPublic)
				{
					return methodInfo.IsPublic;
				}
				return true;
			}
			return false;
		case Source.Constructor:
			if (!nonPublic)
			{
				return constructorInfo.IsPublic;
			}
			return true;
		default:
			throw new UnexpectedEnumValueException<Source>(source);
		}
	}

	public bool IsSettable(bool nonPublic)
	{
		switch (source)
		{
		case Source.Field:
			if (!fieldInfo.IsLiteral && !fieldInfo.IsInitOnly)
			{
				if (!nonPublic)
				{
					return fieldInfo.IsPublic;
				}
				return true;
			}
			return false;
		case Source.Property:
			if (propertyInfo.CanWrite)
			{
				if (!nonPublic)
				{
					return propertyInfo.GetSetMethod(nonPublic: false) != null;
				}
				return true;
			}
			return false;
		case Source.Method:
			return false;
		case Source.Constructor:
			return false;
		default:
			throw new UnexpectedEnumValueException<Source>(source);
		}
	}

	public bool IsInvocable(bool nonPublic)
	{
		switch (source)
		{
		case Source.Field:
			return false;
		case Source.Property:
			return false;
		case Source.Method:
			if (!nonPublic)
			{
				return methodInfo.IsPublic;
			}
			return true;
		case Source.Constructor:
			if (!nonPublic)
			{
				return constructorInfo.IsPublic;
			}
			return true;
		default:
			throw new UnexpectedEnumValueException<Source>(source);
		}
	}

	private void EnsureExplicitParameterTypes()
	{
		if (parameterTypes == null)
		{
			throw new InvalidOperationException("Missing parameter types.");
		}
	}

	public void Reflect()
	{
		if (targetType == null)
		{
			if (targetTypeName != null)
			{
				throw new MissingMemberException(targetTypeName, name);
			}
			throw new MissingMemberException("Target type not found.");
		}
		_source = Source.Unknown;
		_fieldInfo = null;
		_propertyInfo = null;
		_methodInfo = null;
		_constructorInfo = null;
		fieldAccessor = null;
		propertyAccessor = null;
		methodInvoker = null;
		MemberInfo[] extendedMember;
		try
		{
			extendedMember = targetType.GetExtendedMember(name, MemberTypes.Constructor | MemberTypes.Field | MemberTypes.Method | MemberTypes.Property, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
		}
		catch (NotSupportedException innerException)
		{
			throw new InvalidOperationException($"An error occured when trying to reflect the member '{name}' of the type '{targetType.FullName}' in a '{GetType().Name}' unit. Supported member types: {MemberTypes.Constructor | MemberTypes.Field | MemberTypes.Method | MemberTypes.Property}, supported binding flags: {BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy}", innerException);
		}
		if (extendedMember.Length == 0 && RuntimeCodebase.RenamedMembers(targetType).TryGetValue(name, out var value))
		{
			name = value;
			try
			{
				extendedMember = targetType.GetExtendedMember(name, MemberTypes.Constructor | MemberTypes.Field | MemberTypes.Method | MemberTypes.Property, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			}
			catch (NotSupportedException innerException2)
			{
				throw new InvalidOperationException($"An error occured when trying to reflect the renamed member '{name}' of the type '{targetType.FullName}' in a '{GetType().Name}' unit. Supported member types: {MemberTypes.Constructor | MemberTypes.Field | MemberTypes.Method | MemberTypes.Property}, supported binding flags: {BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy}", innerException2);
			}
		}
		if (extendedMember.Length == 0)
		{
			throw new MissingMemberException("No matching member found: '" + targetType.Name + "." + name + "'");
		}
		MemberTypes? memberTypes = null;
		MemberInfo[] array = extendedMember;
		foreach (MemberInfo memberInfo in array)
		{
			if (!memberTypes.HasValue)
			{
				memberTypes = memberInfo.MemberType;
			}
			else if (memberInfo.MemberType != memberTypes && !memberInfo.IsExtensionMethod())
			{
				Debug.LogWarning("Multiple members with the same name are of a different type: '" + targetType.Name + "." + name + "'");
				break;
			}
		}
		switch (memberTypes)
		{
		case MemberTypes.Field:
			ReflectField(extendedMember);
			break;
		case MemberTypes.Property:
			ReflectProperty(extendedMember);
			break;
		case MemberTypes.Method:
			ReflectMethod(extendedMember);
			break;
		case MemberTypes.Constructor:
			ReflectConstructor(extendedMember);
			break;
		default:
			throw new UnexpectedEnumValueException<MemberTypes>(memberTypes.Value);
		}
		isReflected = true;
	}

	private void ReflectField(IEnumerable<MemberInfo> candidates)
	{
		_source = Source.Field;
		_fieldInfo = candidates.OfType<FieldInfo>().Disambiguate(targetType);
		if (_fieldInfo == null)
		{
			throw new MissingMemberException("No matching field found: '" + targetType.Name + "." + name + "'");
		}
	}

	private void ReflectProperty(IEnumerable<MemberInfo> candidates)
	{
		_source = Source.Property;
		_propertyInfo = candidates.OfType<PropertyInfo>().Disambiguate(targetType);
		if (_propertyInfo == null)
		{
			throw new MissingMemberException("No matching property found: '" + targetType.Name + "." + name + "'");
		}
	}

	private void ReflectConstructor(IEnumerable<MemberInfo> candidates)
	{
		_source = Source.Constructor;
		EnsureExplicitParameterTypes();
		_constructorInfo = (from c in candidates.OfType<ConstructorInfo>()
			where !c.IsStatic
			select c).Disambiguate(targetType, parameterTypes);
		if (_constructorInfo == null)
		{
			throw new MissingMemberException("No matching constructor found: '" + targetType.Name + " (" + parameterTypes.Select((Type t) => t.Name).ToCommaSeparatedString() + ")'");
		}
	}

	private void ReflectMethod(IEnumerable<MemberInfo> candidates)
	{
		_source = Source.Method;
		EnsureExplicitParameterTypes();
		_methodInfo = candidates.OfType<MethodInfo>().Disambiguate(targetType, parameterTypes);
		if (_methodInfo == null)
		{
			throw new MissingMemberException("No matching method found: '" + targetType.Name + "." + name + " (" + parameterTypes.Select((Type t) => t.Name).ToCommaSeparatedString() + ")'\nCandidates:\n" + candidates.ToLineSeparatedString());
		}
		_isExtension = _methodInfo.IsExtension();
		_isInvokedAsExtension = _methodInfo.IsInvokedAsExtension(targetType);
	}

	public void Prewarm()
	{
		if (fieldAccessor == null)
		{
			fieldAccessor = fieldInfo?.Prewarm();
		}
		if (propertyAccessor == null)
		{
			propertyAccessor = propertyInfo?.Prewarm();
		}
		if (methodInvoker == null)
		{
			methodInvoker = methodInfo?.Prewarm();
		}
	}

	public void EnsureReflected()
	{
		if (!isReflected)
		{
			Reflect();
		}
	}

	public void EnsureReady(object target)
	{
		EnsureReflected();
		if (target == null && requiresTarget)
		{
			throw new InvalidOperationException($"Missing target object for '{targetType}.{name}'.");
		}
		if (target != null && !requiresTarget)
		{
			throw new InvalidOperationException($"Superfluous target object for '{targetType}.{name}'.");
		}
	}

	public object Get(object target)
	{
		EnsureReady(target);
		switch (source)
		{
		case Source.Field:
			if (fieldAccessor == null)
			{
				fieldAccessor = fieldInfo.Prewarm();
			}
			return fieldAccessor.GetValue(target);
		case Source.Property:
			if (propertyAccessor == null)
			{
				propertyAccessor = propertyInfo.Prewarm();
			}
			return propertyAccessor.GetValue(target);
		case Source.Method:
			throw new NotSupportedException("Member is a method. Consider using 'Invoke' instead.");
		case Source.Constructor:
			throw new NotSupportedException("Member is a constructor. Consider using 'Invoke' instead.");
		default:
			throw new UnexpectedEnumValueException<Source>(source);
		}
	}

	public T Get<T>(object target)
	{
		return (T)Get(target);
	}

	public object Set(object target, object value)
	{
		EnsureReady(target);
		switch (source)
		{
		case Source.Field:
			if (fieldAccessor == null)
			{
				fieldAccessor = fieldInfo.Prewarm();
			}
			fieldAccessor.SetValue(target, value);
			return value;
		case Source.Property:
			if (propertyAccessor == null)
			{
				propertyAccessor = propertyInfo.Prewarm();
			}
			propertyAccessor.SetValue(target, value);
			return value;
		case Source.Method:
			throw new NotSupportedException("Member is a method.");
		case Source.Constructor:
			throw new NotSupportedException("Member is a constructor.");
		default:
			throw new UnexpectedEnumValueException<Source>(source);
		}
	}

	private void EnsureInvocable(object target)
	{
		EnsureReady(target);
		if (source == Source.Field || source == Source.Property)
		{
			throw new NotSupportedException("Member is a field or property.");
		}
		if (source == Source.Method)
		{
			if (methodInfo.ContainsGenericParameters)
			{
				throw new NotSupportedException($"Trying to invoke an open-constructed generic method: '{methodInfo}'.");
			}
			if (methodInvoker == null)
			{
				methodInvoker = methodInfo.Prewarm();
			}
		}
		else
		{
			if (source != Source.Constructor)
			{
				throw new UnexpectedEnumValueException<Source>(source);
			}
			if (constructorInfo.ContainsGenericParameters)
			{
				throw new NotSupportedException($"Trying to invoke an open-constructed generic constructor: '{constructorInfo}'.");
			}
		}
	}

	public IEnumerable<ParameterInfo> GetParameterInfos()
	{
		EnsureReflected();
		return methodBase.GetInvocationParameters(isInvokedAsExtension);
	}

	public object Invoke(object target)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				return methodInvoker.Invoke(null, target);
			}
			return methodInvoker.Invoke(target);
		}
		return constructorInfo.Invoke(EmptyObjects);
	}

	public object Invoke(object target, object arg0)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				return methodInvoker.Invoke(null, target, arg0);
			}
			return methodInvoker.Invoke(target, arg0);
		}
		return constructorInfo.Invoke(new object[1] { arg0 });
	}

	public object Invoke(object target, object arg0, object arg1)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				return methodInvoker.Invoke(null, target, arg0, arg1);
			}
			return methodInvoker.Invoke(target, arg0, arg1);
		}
		return constructorInfo.Invoke(new object[2] { arg0, arg1 });
	}

	public object Invoke(object target, object arg0, object arg1, object arg2)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				return methodInvoker.Invoke(null, target, arg0, arg1, arg2);
			}
			return methodInvoker.Invoke(target, arg0, arg1, arg2);
		}
		return constructorInfo.Invoke(new object[3] { arg0, arg1, arg2 });
	}

	public object Invoke(object target, object arg0, object arg1, object arg2, object arg3)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				return methodInvoker.Invoke(null, target, arg0, arg1, arg2, arg3);
			}
			return methodInvoker.Invoke(target, arg0, arg1, arg2, arg3);
		}
		return constructorInfo.Invoke(new object[4] { arg0, arg1, arg2, arg3 });
	}

	public object Invoke(object target, object arg0, object arg1, object arg2, object arg3, object arg4)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				return methodInvoker.Invoke(null, target, arg0, arg1, arg2, arg3, arg4);
			}
			return methodInvoker.Invoke(target, arg0, arg1, arg2, arg3, arg4);
		}
		return constructorInfo.Invoke(new object[5] { arg0, arg1, arg2, arg3, arg4 });
	}

	public object Invoke(object target, params object[] arguments)
	{
		EnsureInvocable(target);
		if (source == Source.Method)
		{
			if (isInvokedAsExtension)
			{
				object[] array = new object[arguments.Length + 1];
				array[0] = target;
				Array.Copy(arguments, 0, array, 1, arguments.Length);
				return methodInvoker.Invoke(null, array);
			}
			return methodInvoker.Invoke(target, arguments);
		}
		return constructorInfo.Invoke(arguments);
	}

	public T Invoke<T>(object target)
	{
		return (T)Invoke(target);
	}

	public T Invoke<T>(object target, object arg0)
	{
		return (T)Invoke(target, arg0);
	}

	public T Invoke<T>(object target, object arg0, object arg1)
	{
		return (T)Invoke(target, arg0, arg1);
	}

	public T Invoke<T>(object target, object arg0, object arg1, object arg2)
	{
		return (T)Invoke(target, arg0, arg1, arg2);
	}

	public T Invoke<T>(object target, object arg0, object arg1, object arg2, object arg3)
	{
		return (T)Invoke(target, arg0, arg1, arg2, arg3);
	}

	public T Invoke<T>(object target, object arg0, object arg1, object arg2, object arg3, object arg4)
	{
		return (T)Invoke(target, arg0, arg1, arg2, arg3, arg4);
	}

	public T Invoke<T>(object target, params object[] arguments)
	{
		return (T)Invoke(target, arguments);
	}

	public override bool Equals(object obj)
	{
		Member member = obj as Member;
		if (!(member != null) || !(targetType == member.targetType) || !(name == member.name))
		{
			return false;
		}
		bool flag = parameterTypes != null;
		bool flag2 = member.parameterTypes != null;
		if (flag != flag2)
		{
			return false;
		}
		if (flag)
		{
			int num = parameterTypes.Length;
			int num2 = member.parameterTypes.Length;
			if (num != num2)
			{
				return false;
			}
			for (int i = 0; i < num; i++)
			{
				if (parameterTypes[i] != member.parameterTypes[i])
				{
					return false;
				}
			}
		}
		return true;
	}

	public override int GetHashCode()
	{
		int num = 17;
		num = num * 23 + (targetType?.GetHashCode() ?? 0);
		num = num * 23 + (name?.GetHashCode() ?? 0);
		if (parameterTypes != null)
		{
			Type[] array = parameterTypes;
			foreach (Type type in array)
			{
				num = num * 23 + type.GetHashCode();
			}
		}
		else
		{
			num *= 23;
		}
		return num;
	}

	public static bool operator ==(Member a, Member b)
	{
		if ((object)a == b)
		{
			return true;
		}
		if ((object)a == null || (object)b == null)
		{
			return false;
		}
		return a.Equals(b);
	}

	public static bool operator !=(Member a, Member b)
	{
		return !(a == b);
	}

	public string ToUniqueString()
	{
		string text = targetType.FullName + "." + name;
		if (parameterTypes != null)
		{
			text += "(";
			Type[] array = parameterTypes;
			foreach (Type type in array)
			{
				text += type.FullName;
			}
			text += ")";
		}
		return text;
	}

	public override string ToString()
	{
		return targetType.CSharpName() + "." + name;
	}

	public Member ToDeclarer()
	{
		return new Member(declaringType, name, parameterTypes);
	}

	public Member ToPseudoDeclarer()
	{
		return new Member(pseudoDeclaringType, name, parameterTypes);
	}
}
