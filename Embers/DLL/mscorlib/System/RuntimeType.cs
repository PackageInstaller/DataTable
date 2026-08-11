using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Threading;
using Mono;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
internal class RuntimeType : TypeInfo, ISerializable, ICloneable
{
	internal enum MemberListType
	{
		All,
		CaseSensitive,
		CaseInsensitive,
		HandleToInfo
	}

	private struct ListBuilder<T>(int capacity) where T : class
	{
		private T[] _items = null;

		private T _item = null;

		private int _count = 0;

		private int _capacity = capacity;

		public T this[int index]
		{
			get
			{
				if (_items == null)
				{
					return _item;
				}
				return _items[index];
			}
		}

		public int Count => _count;

		public T[] ToArray()
		{
			if (_count == 0)
			{
				return Array.Empty<T>();
			}
			if (_count == 1)
			{
				return new T[1] { _item };
			}
			Array.Resize(ref _items, _count);
			_capacity = _count;
			return _items;
		}

		public void CopyTo(object[] array, int index)
		{
			if (_count != 0)
			{
				if (_count == 1)
				{
					array[index] = _item;
				}
				else
				{
					Array.Copy(_items, 0, array, index, _count);
				}
			}
		}

		public void Add(T item)
		{
			if (_count == 0)
			{
				_item = item;
			}
			else
			{
				if (_count == 1)
				{
					if (_capacity < 2)
					{
						_capacity = 4;
					}
					_items = new T[_capacity];
					_items[0] = _item;
				}
				else if (_capacity == _count)
				{
					int num = 2 * _capacity;
					Array.Resize(ref _items, num);
					_capacity = num;
				}
				_items[_count] = item;
			}
			_count++;
		}
	}

	internal static readonly RuntimeType ValueType = (RuntimeType)typeof(ValueType);

	internal static readonly RuntimeType EnumType = (RuntimeType)typeof(Enum);

	private static readonly RuntimeType ObjectType = (RuntimeType)typeof(object);

	private static readonly RuntimeType StringType = (RuntimeType)typeof(string);

	private static readonly RuntimeType DelegateType = (RuntimeType)typeof(Delegate);

	private static Type[] s_SICtorParamTypes;

	internal static Func<Type, Type[], Type> MakeTypeBuilderInstantiation;

	private const BindingFlags MemberBindingMask = (BindingFlags)255;

	private const BindingFlags InvocationMask = BindingFlags.InvokeMethod | BindingFlags.CreateInstance | BindingFlags.GetField | BindingFlags.SetField | BindingFlags.GetProperty | BindingFlags.SetProperty | BindingFlags.PutDispProperty | BindingFlags.PutRefDispProperty;

	private const BindingFlags BinderNonCreateInstance = BindingFlags.InvokeMethod | BindingFlags.GetField | BindingFlags.SetField | BindingFlags.GetProperty | BindingFlags.SetProperty;

	private const BindingFlags BinderGetSetProperty = BindingFlags.GetProperty | BindingFlags.SetProperty;

	private const BindingFlags BinderSetInvokeProperty = BindingFlags.InvokeMethod | BindingFlags.SetProperty;

	private const BindingFlags BinderGetSetField = BindingFlags.GetField | BindingFlags.SetField;

	private const BindingFlags BinderSetInvokeField = BindingFlags.InvokeMethod | BindingFlags.SetField;

	private const BindingFlags BinderNonFieldGetSet = (BindingFlags)16773888;

	private const BindingFlags ClassicBindingMask = BindingFlags.InvokeMethod | BindingFlags.GetProperty | BindingFlags.SetProperty | BindingFlags.PutDispProperty | BindingFlags.PutRefDispProperty;

	private static RuntimeType s_typedRef = (RuntimeType)typeof(TypedReference);

	[NonSerialized]
	private MonoTypeInfo type_info;

	internal object GenericCache;

	private RuntimeConstructorInfo m_serializationCtor;

	private const int GenericParameterCountAny = -1;

	public override Module Module => GetRuntimeModule();

	public override Assembly Assembly => GetRuntimeAssembly();

	public override RuntimeTypeHandle TypeHandle => new RuntimeTypeHandle(this);

	public override Type BaseType => GetBaseType();

	public override Type UnderlyingSystemType => this;

	public override bool IsEnum => GetBaseType() == EnumType;

	public override GenericParameterAttributes GenericParameterAttributes
	{
		get
		{
			if (!IsGenericParameter)
			{
				throw new InvalidOperationException(Environment.GetResourceString("Method may only be called on a Type for which Type.IsGenericParameter is true."));
			}
			return GetGenericParameterAttributes();
		}
	}

	internal override bool IsSzArray => RuntimeTypeHandle.IsSzArray(this);

	public override bool IsGenericTypeDefinition => RuntimeTypeHandle.IsGenericTypeDefinition(this);

	public override bool IsGenericParameter => RuntimeTypeHandle.IsGenericVariable(this);

	public override int GenericParameterPosition
	{
		get
		{
			if (!IsGenericParameter)
			{
				throw new InvalidOperationException(Environment.GetResourceString("Method may only be called on a Type for which Type.IsGenericParameter is true."));
			}
			return GetGenericParameterPosition();
		}
	}

	public override bool IsGenericType => RuntimeTypeHandle.HasInstantiation(this);

	public override bool IsConstructedGenericType
	{
		get
		{
			if (IsGenericType)
			{
				return !IsGenericTypeDefinition;
			}
			return false;
		}
	}

	public override MemberTypes MemberType
	{
		get
		{
			if (base.IsPublic || base.IsNotPublic)
			{
				return MemberTypes.TypeInfo;
			}
			return MemberTypes.NestedType;
		}
	}

	public override Type ReflectedType => DeclaringType;

	public override int MetadataToken => RuntimeTypeHandle.GetToken(this);

	public override StructLayoutAttribute StructLayoutAttribute => StructLayoutAttribute.GetCustomAttribute(this);

	public override bool ContainsGenericParameters
	{
		get
		{
			if (IsGenericParameter)
			{
				return true;
			}
			if (IsGenericType)
			{
				Type[] genericArguments = GetGenericArguments();
				for (int i = 0; i < genericArguments.Length; i++)
				{
					if (genericArguments[i].ContainsGenericParameters)
					{
						return true;
					}
				}
			}
			if (base.HasElementType)
			{
				return GetElementType().ContainsGenericParameters;
			}
			return false;
		}
	}

	public override Guid GUID
	{
		get
		{
			byte[] array = new byte[16];
			GetGUID(this, array);
			return new Guid(array);
		}
	}

	public override extern MethodBase DeclaringMethod
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override string AssemblyQualifiedName => getFullName(full_name: true, assembly_qualified: true);

	public override extern Type DeclaringType
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override extern string Name
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override extern string Namespace
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override string FullName
	{
		get
		{
			if (ContainsGenericParameters && !GetRootElementType().IsGenericTypeDefinition)
			{
				return null;
			}
			if (type_info == null)
			{
				type_info = new MonoTypeInfo();
			}
			string result;
			if ((result = type_info.full_name) == null)
			{
				result = (type_info.full_name = getFullName(full_name: true, assembly_qualified: false));
			}
			return result;
		}
	}

	public override bool IsSZArray
	{
		get
		{
			if (base.IsArray)
			{
				return (object)this == GetElementType().MakeArrayType();
			}
			return false;
		}
	}

	internal override bool IsUserType => false;

	public override bool IsByRefLike => RuntimeTypeHandle.IsByRefLike(this);

	public override bool IsTypeDefinition => RuntimeTypeHandle.IsTypeDefinition(this);

	internal static RuntimeType GetType(string typeName, bool throwOnError, bool ignoreCase, bool reflectionOnly, ref StackCrawlMark stackMark)
	{
		if (typeName == null)
		{
			throw new ArgumentNullException("typeName");
		}
		return RuntimeTypeHandle.GetTypeByName(typeName, throwOnError, ignoreCase, reflectionOnly, ref stackMark, loadTypeFromPartialName: false);
	}

	private static void ThrowIfTypeNeverValidGenericArgument(RuntimeType type)
	{
		if (type.IsPointer || type.IsByRef || type == typeof(void))
		{
			throw new ArgumentException(Environment.GetResourceString("The type '{0}' may not be used as a type argument.", type.ToString()));
		}
	}

	internal static void SanityCheckGenericArguments(RuntimeType[] genericArguments, RuntimeType[] genericParamters)
	{
		if (genericArguments == null)
		{
			throw new ArgumentNullException();
		}
		for (int i = 0; i < genericArguments.Length; i++)
		{
			if (genericArguments[i] == null)
			{
				throw new ArgumentNullException();
			}
			ThrowIfTypeNeverValidGenericArgument(genericArguments[i]);
		}
		if (genericArguments.Length != genericParamters.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("The type or method has {1} generic parameter(s), but {0} generic argument(s) were provided. A generic argument must be provided for each generic parameter.", genericArguments.Length, genericParamters.Length));
		}
	}

	private static void SplitName(string fullname, out string name, out string ns)
	{
		name = null;
		ns = null;
		if (fullname == null)
		{
			return;
		}
		int num = fullname.LastIndexOf(".", StringComparison.Ordinal);
		if (num != -1)
		{
			ns = fullname.Substring(0, num);
			int num2 = fullname.Length - ns.Length - 1;
			if (num2 != 0)
			{
				name = fullname.Substring(num + 1, num2);
			}
			else
			{
				name = "";
			}
		}
		else
		{
			name = fullname;
		}
	}

	internal static BindingFlags FilterPreCalculate(bool isPublic, bool isInherited, bool isStatic)
	{
		BindingFlags bindingFlags = (isPublic ? BindingFlags.Public : BindingFlags.NonPublic);
		if (isInherited)
		{
			bindingFlags |= BindingFlags.DeclaredOnly;
			if (isStatic)
			{
				return bindingFlags | (BindingFlags.Static | BindingFlags.FlattenHierarchy);
			}
			return bindingFlags | BindingFlags.Instance;
		}
		if (isStatic)
		{
			return bindingFlags | BindingFlags.Static;
		}
		return bindingFlags | BindingFlags.Instance;
	}

	private static void FilterHelper(BindingFlags bindingFlags, ref string name, bool allowPrefixLookup, out bool prefixLookup, out bool ignoreCase, out MemberListType listType)
	{
		prefixLookup = false;
		ignoreCase = false;
		if (name != null)
		{
			if ((bindingFlags & BindingFlags.IgnoreCase) != BindingFlags.Default)
			{
				name = name.ToLower(CultureInfo.InvariantCulture);
				ignoreCase = true;
				listType = MemberListType.CaseInsensitive;
			}
			else
			{
				listType = MemberListType.CaseSensitive;
			}
			if (allowPrefixLookup && name.EndsWith("*", StringComparison.Ordinal))
			{
				name = name.Substring(0, name.Length - 1);
				prefixLookup = true;
				listType = MemberListType.All;
			}
		}
		else
		{
			listType = MemberListType.All;
		}
	}

	private static void FilterHelper(BindingFlags bindingFlags, ref string name, out bool ignoreCase, out MemberListType listType)
	{
		FilterHelper(bindingFlags, ref name, allowPrefixLookup: false, out var _, out ignoreCase, out listType);
	}

	private static bool FilterApplyPrefixLookup(MemberInfo memberInfo, string name, bool ignoreCase)
	{
		if (ignoreCase)
		{
			if (!memberInfo.Name.StartsWith(name, StringComparison.OrdinalIgnoreCase))
			{
				return false;
			}
		}
		else if (!memberInfo.Name.StartsWith(name, StringComparison.Ordinal))
		{
			return false;
		}
		return true;
	}

	private static bool FilterApplyBase(MemberInfo memberInfo, BindingFlags bindingFlags, bool isPublic, bool isNonProtectedInternal, bool isStatic, string name, bool prefixLookup)
	{
		if (isPublic)
		{
			if ((bindingFlags & BindingFlags.Public) == 0)
			{
				return false;
			}
		}
		else if ((bindingFlags & BindingFlags.NonPublic) == 0)
		{
			return false;
		}
		bool flag = (object)memberInfo.DeclaringType != memberInfo.ReflectedType;
		if (((bindingFlags & BindingFlags.DeclaredOnly) != 0) & flag)
		{
			return false;
		}
		if (memberInfo.MemberType != MemberTypes.TypeInfo && memberInfo.MemberType != MemberTypes.NestedType)
		{
			if (isStatic)
			{
				if (((bindingFlags & BindingFlags.FlattenHierarchy) == 0) & flag)
				{
					return false;
				}
				if ((bindingFlags & BindingFlags.Static) == 0)
				{
					return false;
				}
			}
			else if ((bindingFlags & BindingFlags.Instance) == 0)
			{
				return false;
			}
		}
		if (prefixLookup && !FilterApplyPrefixLookup(memberInfo, name, (bindingFlags & BindingFlags.IgnoreCase) != 0))
		{
			return false;
		}
		if ((((bindingFlags & BindingFlags.DeclaredOnly) == 0) & flag & isNonProtectedInternal) && (bindingFlags & BindingFlags.NonPublic) != BindingFlags.Default && !isStatic && (bindingFlags & BindingFlags.Instance) != BindingFlags.Default)
		{
			MethodInfo methodInfo = memberInfo as MethodInfo;
			if (methodInfo == null)
			{
				return false;
			}
			if (!methodInfo.IsVirtual && !methodInfo.IsAbstract)
			{
				return false;
			}
		}
		return true;
	}

	private static bool FilterApplyType(Type type, BindingFlags bindingFlags, string name, bool prefixLookup, string ns)
	{
		bool isPublic = type.IsNestedPublic || type.IsPublic;
		bool isStatic = false;
		if (!FilterApplyBase(type, bindingFlags, isPublic, type.IsNestedAssembly, isStatic, name, prefixLookup))
		{
			return false;
		}
		if (ns != null && ns != type.Namespace)
		{
			return false;
		}
		return true;
	}

	private static bool FilterApplyMethodInfo(RuntimeMethodInfo method, BindingFlags bindingFlags, CallingConventions callConv, Type[] argumentTypes)
	{
		return FilterApplyMethodBase(method, method.BindingFlags, bindingFlags, callConv, argumentTypes);
	}

	private static bool FilterApplyConstructorInfo(RuntimeConstructorInfo constructor, BindingFlags bindingFlags, CallingConventions callConv, Type[] argumentTypes)
	{
		return FilterApplyMethodBase(constructor, constructor.BindingFlags, bindingFlags, callConv, argumentTypes);
	}

	private static bool FilterApplyMethodBase(MethodBase methodBase, BindingFlags methodFlags, BindingFlags bindingFlags, CallingConventions callConv, Type[] argumentTypes)
	{
		bindingFlags ^= BindingFlags.DeclaredOnly;
		if ((callConv & CallingConventions.Any) == 0)
		{
			if ((callConv & CallingConventions.VarArgs) != 0 && (methodBase.CallingConvention & CallingConventions.VarArgs) == 0)
			{
				return false;
			}
			if ((callConv & CallingConventions.Standard) != 0 && (methodBase.CallingConvention & CallingConventions.Standard) == 0)
			{
				return false;
			}
		}
		if (argumentTypes != null)
		{
			ParameterInfo[] parametersNoCopy = methodBase.GetParametersNoCopy();
			if (argumentTypes.Length != parametersNoCopy.Length)
			{
				if ((bindingFlags & (BindingFlags.InvokeMethod | BindingFlags.CreateInstance | BindingFlags.GetProperty | BindingFlags.SetProperty)) == 0)
				{
					return false;
				}
				bool flag = false;
				if (argumentTypes.Length > parametersNoCopy.Length)
				{
					if ((methodBase.CallingConvention & CallingConventions.VarArgs) == 0)
					{
						flag = true;
					}
				}
				else if ((bindingFlags & BindingFlags.OptionalParamBinding) == 0)
				{
					flag = true;
				}
				else if (!parametersNoCopy[argumentTypes.Length].IsOptional)
				{
					flag = true;
				}
				if (flag)
				{
					if (parametersNoCopy.Length == 0)
					{
						return false;
					}
					if (argumentTypes.Length < parametersNoCopy.Length - 1)
					{
						return false;
					}
					ParameterInfo parameterInfo = parametersNoCopy[parametersNoCopy.Length - 1];
					if (!parameterInfo.ParameterType.IsArray)
					{
						return false;
					}
					if (!parameterInfo.IsDefined(typeof(ParamArrayAttribute), inherit: false))
					{
						return false;
					}
				}
			}
			else if ((bindingFlags & BindingFlags.ExactBinding) != BindingFlags.Default && (bindingFlags & BindingFlags.InvokeMethod) == 0)
			{
				for (int i = 0; i < parametersNoCopy.Length; i++)
				{
					if ((object)argumentTypes[i] != null && !argumentTypes[i].MatchesParameterTypeExactly(parametersNoCopy[i]))
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	internal RuntimeType()
	{
		throw new NotSupportedException();
	}

	private ListBuilder<MethodInfo> GetMethodCandidates(string name, BindingFlags bindingAttr, CallingConventions callConv, Type[] types, int genericParamCount, bool allowPrefixLookup)
	{
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var ignoreCase, out var listType);
		RuntimeMethodInfo[] methodsByName = GetMethodsByName(name, bindingAttr, listType, this);
		ListBuilder<MethodInfo> result = new ListBuilder<MethodInfo>(methodsByName.Length);
		foreach (RuntimeMethodInfo runtimeMethodInfo in methodsByName)
		{
			if (genericParamCount != -1)
			{
				bool isGenericMethod = runtimeMethodInfo.IsGenericMethod;
				if (((genericParamCount == 0) & isGenericMethod) || (genericParamCount > 0 && !isGenericMethod) || runtimeMethodInfo.GetGenericArguments().Length != genericParamCount)
				{
					continue;
				}
			}
			if (FilterApplyMethodInfo(runtimeMethodInfo, bindingAttr, callConv, types) && (!prefixLookup || FilterApplyPrefixLookup(runtimeMethodInfo, name, ignoreCase)))
			{
				result.Add(runtimeMethodInfo);
			}
		}
		return result;
	}

	private ListBuilder<ConstructorInfo> GetConstructorCandidates(string name, BindingFlags bindingAttr, CallingConventions callConv, Type[] types, bool allowPrefixLookup)
	{
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var ignoreCase, out var _);
		if ((!prefixLookup && name != null && name.Length == 0) || (!string.IsNullOrEmpty(name) && name != ConstructorInfo.ConstructorName && name != ConstructorInfo.TypeConstructorName))
		{
			return new ListBuilder<ConstructorInfo>(0);
		}
		RuntimeConstructorInfo[] constructors_internal = GetConstructors_internal(bindingAttr, this);
		ListBuilder<ConstructorInfo> result = new ListBuilder<ConstructorInfo>(constructors_internal.Length);
		foreach (RuntimeConstructorInfo runtimeConstructorInfo in constructors_internal)
		{
			if (FilterApplyConstructorInfo(runtimeConstructorInfo, bindingAttr, callConv, types) && (!prefixLookup || FilterApplyPrefixLookup(runtimeConstructorInfo, name, ignoreCase)))
			{
				result.Add(runtimeConstructorInfo);
			}
		}
		return result;
	}

	private ListBuilder<PropertyInfo> GetPropertyCandidates(string name, BindingFlags bindingAttr, Type[] types, bool allowPrefixLookup)
	{
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var ignoreCase, out var listType);
		RuntimePropertyInfo[] propertiesByName = GetPropertiesByName(name, bindingAttr, listType, this);
		bindingAttr ^= BindingFlags.DeclaredOnly;
		ListBuilder<PropertyInfo> result = new ListBuilder<PropertyInfo>(propertiesByName.Length);
		foreach (RuntimePropertyInfo runtimePropertyInfo in propertiesByName)
		{
			if ((bindingAttr & runtimePropertyInfo.BindingFlags) == runtimePropertyInfo.BindingFlags && (!prefixLookup || FilterApplyPrefixLookup(runtimePropertyInfo, name, ignoreCase)) && (types == null || runtimePropertyInfo.GetIndexParameters().Length == types.Length))
			{
				result.Add(runtimePropertyInfo);
			}
		}
		return result;
	}

	private ListBuilder<EventInfo> GetEventCandidates(string name, BindingFlags bindingAttr, bool allowPrefixLookup)
	{
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var ignoreCase, out var listType);
		RuntimeEventInfo[] events_internal = GetEvents_internal(name, bindingAttr, listType, this);
		bindingAttr ^= BindingFlags.DeclaredOnly;
		ListBuilder<EventInfo> result = new ListBuilder<EventInfo>(events_internal.Length);
		foreach (RuntimeEventInfo runtimeEventInfo in events_internal)
		{
			if ((bindingAttr & runtimeEventInfo.BindingFlags) == runtimeEventInfo.BindingFlags && (!prefixLookup || FilterApplyPrefixLookup(runtimeEventInfo, name, ignoreCase)))
			{
				result.Add(runtimeEventInfo);
			}
		}
		return result;
	}

	private ListBuilder<FieldInfo> GetFieldCandidates(string name, BindingFlags bindingAttr, bool allowPrefixLookup)
	{
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var ignoreCase, out var listType);
		RuntimeFieldInfo[] fields_internal = GetFields_internal(name, bindingAttr, listType, this);
		bindingAttr ^= BindingFlags.DeclaredOnly;
		ListBuilder<FieldInfo> result = new ListBuilder<FieldInfo>(fields_internal.Length);
		foreach (RuntimeFieldInfo runtimeFieldInfo in fields_internal)
		{
			if ((bindingAttr & runtimeFieldInfo.BindingFlags) == runtimeFieldInfo.BindingFlags && (!prefixLookup || FilterApplyPrefixLookup(runtimeFieldInfo, name, ignoreCase)))
			{
				result.Add(runtimeFieldInfo);
			}
		}
		return result;
	}

	private ListBuilder<Type> GetNestedTypeCandidates(string fullname, BindingFlags bindingAttr, bool allowPrefixLookup)
	{
		bindingAttr &= ~BindingFlags.Static;
		SplitName(fullname, out var name, out var ns);
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var _, out var listType);
		RuntimeType[] nestedTypes_internal = GetNestedTypes_internal(name, bindingAttr, listType);
		ListBuilder<Type> result = new ListBuilder<Type>(nestedTypes_internal.Length);
		foreach (RuntimeType runtimeType in nestedTypes_internal)
		{
			if (FilterApplyType(runtimeType, bindingAttr, name, prefixLookup, ns))
			{
				result.Add(runtimeType);
			}
		}
		return result;
	}

	public override MethodInfo[] GetMethods(BindingFlags bindingAttr)
	{
		return GetMethodCandidates(null, bindingAttr, CallingConventions.Any, null, -1, allowPrefixLookup: false).ToArray();
	}

	[ComVisible(true)]
	public override ConstructorInfo[] GetConstructors(BindingFlags bindingAttr)
	{
		return GetConstructorCandidates(null, bindingAttr, CallingConventions.Any, null, allowPrefixLookup: false).ToArray();
	}

	public override PropertyInfo[] GetProperties(BindingFlags bindingAttr)
	{
		return GetPropertyCandidates(null, bindingAttr, null, allowPrefixLookup: false).ToArray();
	}

	public override EventInfo[] GetEvents(BindingFlags bindingAttr)
	{
		return GetEventCandidates(null, bindingAttr, allowPrefixLookup: false).ToArray();
	}

	public override FieldInfo[] GetFields(BindingFlags bindingAttr)
	{
		return GetFieldCandidates(null, bindingAttr, allowPrefixLookup: false).ToArray();
	}

	public override Type[] GetNestedTypes(BindingFlags bindingAttr)
	{
		return GetNestedTypeCandidates(null, bindingAttr, allowPrefixLookup: false).ToArray();
	}

	public override MemberInfo[] GetMembers(BindingFlags bindingAttr)
	{
		ListBuilder<MethodInfo> methodCandidates = GetMethodCandidates(null, bindingAttr, CallingConventions.Any, null, -1, allowPrefixLookup: false);
		ListBuilder<ConstructorInfo> constructorCandidates = GetConstructorCandidates(null, bindingAttr, CallingConventions.Any, null, allowPrefixLookup: false);
		ListBuilder<PropertyInfo> propertyCandidates = GetPropertyCandidates(null, bindingAttr, null, allowPrefixLookup: false);
		ListBuilder<EventInfo> eventCandidates = GetEventCandidates(null, bindingAttr, allowPrefixLookup: false);
		ListBuilder<FieldInfo> fieldCandidates = GetFieldCandidates(null, bindingAttr, allowPrefixLookup: false);
		ListBuilder<Type> nestedTypeCandidates = GetNestedTypeCandidates(null, bindingAttr, allowPrefixLookup: false);
		MemberInfo[] array = new MemberInfo[methodCandidates.Count + constructorCandidates.Count + propertyCandidates.Count + eventCandidates.Count + fieldCandidates.Count + nestedTypeCandidates.Count];
		int num = 0;
		object[] array2 = array;
		methodCandidates.CopyTo(array2, num);
		num += methodCandidates.Count;
		array2 = array;
		constructorCandidates.CopyTo(array2, num);
		num += constructorCandidates.Count;
		array2 = array;
		propertyCandidates.CopyTo(array2, num);
		num += propertyCandidates.Count;
		array2 = array;
		eventCandidates.CopyTo(array2, num);
		num += eventCandidates.Count;
		array2 = array;
		fieldCandidates.CopyTo(array2, num);
		num += fieldCandidates.Count;
		array2 = array;
		nestedTypeCandidates.CopyTo(array2, num);
		num += nestedTypeCandidates.Count;
		return array;
	}

	protected override ConstructorInfo GetConstructorImpl(BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		ListBuilder<ConstructorInfo> constructorCandidates = GetConstructorCandidates(null, bindingAttr, CallingConventions.Any, types, allowPrefixLookup: false);
		if (constructorCandidates.Count == 0)
		{
			return null;
		}
		if (types.Length == 0 && constructorCandidates.Count == 1)
		{
			ConstructorInfo constructorInfo = constructorCandidates[0];
			ParameterInfo[] parametersNoCopy = constructorInfo.GetParametersNoCopy();
			if (parametersNoCopy == null || parametersNoCopy.Length == 0)
			{
				return constructorInfo;
			}
		}
		MethodBase[] match;
		if ((bindingAttr & BindingFlags.ExactBinding) != BindingFlags.Default)
		{
			match = constructorCandidates.ToArray();
			return System.DefaultBinder.ExactBinding(match, types, modifiers) as ConstructorInfo;
		}
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		Binder binder2 = binder;
		match = constructorCandidates.ToArray();
		return binder2.SelectMethod(bindingAttr, match, types, modifiers) as ConstructorInfo;
	}

	protected override PropertyInfo GetPropertyImpl(string name, BindingFlags bindingAttr, Binder binder, Type returnType, Type[] types, ParameterModifier[] modifiers)
	{
		if (name == null)
		{
			throw new ArgumentNullException();
		}
		ListBuilder<PropertyInfo> propertyCandidates = GetPropertyCandidates(name, bindingAttr, types, allowPrefixLookup: false);
		if (propertyCandidates.Count == 0)
		{
			return null;
		}
		if (types == null || types.Length == 0)
		{
			if (propertyCandidates.Count == 1)
			{
				PropertyInfo propertyInfo = propertyCandidates[0];
				if ((object)returnType != null && !returnType.IsEquivalentTo(propertyInfo.PropertyType))
				{
					return null;
				}
				return propertyInfo;
			}
			if ((object)returnType == null)
			{
				throw new AmbiguousMatchException(Environment.GetResourceString("Ambiguous match found."));
			}
		}
		if ((bindingAttr & BindingFlags.ExactBinding) != BindingFlags.Default)
		{
			return System.DefaultBinder.ExactPropertyBinding(propertyCandidates.ToArray(), returnType, types, modifiers);
		}
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		return binder.SelectProperty(bindingAttr, propertyCandidates.ToArray(), returnType, types, modifiers);
	}

	public override EventInfo GetEvent(string name, BindingFlags bindingAttr)
	{
		if (name == null)
		{
			throw new ArgumentNullException();
		}
		FilterHelper(bindingAttr, ref name, out var _, out var listType);
		RuntimeEventInfo[] events_internal = GetEvents_internal(name, bindingAttr, listType, this);
		EventInfo eventInfo = null;
		bindingAttr ^= BindingFlags.DeclaredOnly;
		foreach (RuntimeEventInfo runtimeEventInfo in events_internal)
		{
			if ((bindingAttr & runtimeEventInfo.BindingFlags) == runtimeEventInfo.BindingFlags)
			{
				if (eventInfo != null)
				{
					throw new AmbiguousMatchException(Environment.GetResourceString("Ambiguous match found."));
				}
				eventInfo = runtimeEventInfo;
			}
		}
		return eventInfo;
	}

	public override FieldInfo GetField(string name, BindingFlags bindingAttr)
	{
		if (name == null)
		{
			throw new ArgumentNullException();
		}
		FilterHelper(bindingAttr, ref name, out var _, out var listType);
		RuntimeFieldInfo[] fields_internal = GetFields_internal(name, bindingAttr, listType, this);
		FieldInfo fieldInfo = null;
		bindingAttr ^= BindingFlags.DeclaredOnly;
		bool flag = false;
		foreach (RuntimeFieldInfo runtimeFieldInfo in fields_internal)
		{
			if ((bindingAttr & runtimeFieldInfo.BindingFlags) != runtimeFieldInfo.BindingFlags)
			{
				continue;
			}
			if (fieldInfo != null)
			{
				if ((object)runtimeFieldInfo.DeclaringType == fieldInfo.DeclaringType)
				{
					throw new AmbiguousMatchException(Environment.GetResourceString("Ambiguous match found."));
				}
				if (fieldInfo.DeclaringType.IsInterface && runtimeFieldInfo.DeclaringType.IsInterface)
				{
					flag = true;
				}
			}
			if (fieldInfo == null || runtimeFieldInfo.DeclaringType.IsSubclassOf(fieldInfo.DeclaringType) || fieldInfo.DeclaringType.IsInterface)
			{
				fieldInfo = runtimeFieldInfo;
			}
		}
		if (flag && fieldInfo.DeclaringType.IsInterface)
		{
			throw new AmbiguousMatchException(Environment.GetResourceString("Ambiguous match found."));
		}
		return fieldInfo;
	}

	public override Type GetInterface(string fullname, bool ignoreCase)
	{
		if (fullname == null)
		{
			throw new ArgumentNullException();
		}
		BindingFlags bindingFlags = BindingFlags.Public | BindingFlags.NonPublic;
		bindingFlags &= ~BindingFlags.Static;
		if (ignoreCase)
		{
			bindingFlags |= BindingFlags.IgnoreCase;
		}
		SplitName(fullname, out var name, out var ns);
		FilterHelper(bindingFlags, ref name, out ignoreCase, out var _);
		List<RuntimeType> list = null;
		StringComparison comparisonType = (ignoreCase ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal);
		Type[] interfaces = GetInterfaces();
		for (int i = 0; i < interfaces.Length; i++)
		{
			RuntimeType runtimeType = (RuntimeType)interfaces[i];
			if (string.Equals(runtimeType.Name, name, comparisonType))
			{
				if (list == null)
				{
					list = new List<RuntimeType>(2);
				}
				list.Add(runtimeType);
			}
		}
		if (list == null)
		{
			return null;
		}
		RuntimeType[] array = list.ToArray();
		RuntimeType runtimeType2 = null;
		foreach (RuntimeType runtimeType3 in array)
		{
			if (FilterApplyType(runtimeType3, bindingFlags, name, prefixLookup: false, ns))
			{
				if (runtimeType2 != null)
				{
					throw new AmbiguousMatchException(Environment.GetResourceString("Ambiguous match found."));
				}
				runtimeType2 = runtimeType3;
			}
		}
		return runtimeType2;
	}

	public override Type GetNestedType(string fullname, BindingFlags bindingAttr)
	{
		if (fullname == null)
		{
			throw new ArgumentNullException();
		}
		bindingAttr &= ~BindingFlags.Static;
		SplitName(fullname, out var name, out var ns);
		FilterHelper(bindingAttr, ref name, out var _, out var listType);
		RuntimeType[] nestedTypes_internal = GetNestedTypes_internal(name, bindingAttr, listType);
		RuntimeType runtimeType = null;
		foreach (RuntimeType runtimeType2 in nestedTypes_internal)
		{
			if (FilterApplyType(runtimeType2, bindingAttr, name, prefixLookup: false, ns))
			{
				if (runtimeType != null)
				{
					throw new AmbiguousMatchException(Environment.GetResourceString("Ambiguous match found."));
				}
				runtimeType = runtimeType2;
			}
		}
		return runtimeType;
	}

	public override MemberInfo[] GetMember(string name, MemberTypes type, BindingFlags bindingAttr)
	{
		if (name == null)
		{
			throw new ArgumentNullException();
		}
		ListBuilder<MethodInfo> listBuilder = default(ListBuilder<MethodInfo>);
		ListBuilder<ConstructorInfo> listBuilder2 = default(ListBuilder<ConstructorInfo>);
		ListBuilder<PropertyInfo> listBuilder3 = default(ListBuilder<PropertyInfo>);
		ListBuilder<EventInfo> listBuilder4 = default(ListBuilder<EventInfo>);
		ListBuilder<FieldInfo> listBuilder5 = default(ListBuilder<FieldInfo>);
		ListBuilder<Type> listBuilder6 = default(ListBuilder<Type>);
		int num = 0;
		if ((type & MemberTypes.Method) != 0)
		{
			listBuilder = GetMethodCandidates(name, bindingAttr, CallingConventions.Any, null, -1, allowPrefixLookup: true);
			if (type == MemberTypes.Method)
			{
				return listBuilder.ToArray();
			}
			num += listBuilder.Count;
		}
		if ((type & MemberTypes.Constructor) != 0)
		{
			listBuilder2 = GetConstructorCandidates(name, bindingAttr, CallingConventions.Any, null, allowPrefixLookup: true);
			if (type == MemberTypes.Constructor)
			{
				return listBuilder2.ToArray();
			}
			num += listBuilder2.Count;
		}
		if ((type & MemberTypes.Property) != 0)
		{
			listBuilder3 = GetPropertyCandidates(name, bindingAttr, null, allowPrefixLookup: true);
			if (type == MemberTypes.Property)
			{
				return listBuilder3.ToArray();
			}
			num += listBuilder3.Count;
		}
		if ((type & MemberTypes.Event) != 0)
		{
			listBuilder4 = GetEventCandidates(name, bindingAttr, allowPrefixLookup: true);
			if (type == MemberTypes.Event)
			{
				return listBuilder4.ToArray();
			}
			num += listBuilder4.Count;
		}
		if ((type & MemberTypes.Field) != 0)
		{
			listBuilder5 = GetFieldCandidates(name, bindingAttr, allowPrefixLookup: true);
			if (type == MemberTypes.Field)
			{
				return listBuilder5.ToArray();
			}
			num += listBuilder5.Count;
		}
		if ((type & (MemberTypes.TypeInfo | MemberTypes.NestedType)) != 0)
		{
			listBuilder6 = GetNestedTypeCandidates(name, bindingAttr, allowPrefixLookup: true);
			if (type == MemberTypes.NestedType || type == MemberTypes.TypeInfo)
			{
				return listBuilder6.ToArray();
			}
			num += listBuilder6.Count;
		}
		MemberInfo[] array;
		if (type != (MemberTypes.Constructor | MemberTypes.Method))
		{
			array = new MemberInfo[num];
		}
		else
		{
			MemberInfo[] array2 = new MethodBase[num];
			array = array2;
		}
		MemberInfo[] array3 = array;
		int num2 = 0;
		object[] array4 = array3;
		listBuilder.CopyTo(array4, num2);
		num2 += listBuilder.Count;
		array4 = array3;
		listBuilder2.CopyTo(array4, num2);
		num2 += listBuilder2.Count;
		array4 = array3;
		listBuilder3.CopyTo(array4, num2);
		num2 += listBuilder3.Count;
		array4 = array3;
		listBuilder4.CopyTo(array4, num2);
		num2 += listBuilder4.Count;
		array4 = array3;
		listBuilder5.CopyTo(array4, num2);
		num2 += listBuilder5.Count;
		array4 = array3;
		listBuilder6.CopyTo(array4, num2);
		num2 += listBuilder6.Count;
		return array3;
	}

	internal RuntimeModule GetRuntimeModule()
	{
		return RuntimeTypeHandle.GetModule(this);
	}

	internal RuntimeAssembly GetRuntimeAssembly()
	{
		return RuntimeTypeHandle.GetAssembly(this);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal sealed override RuntimeTypeHandle GetTypeHandleInternal()
	{
		return new RuntimeTypeHandle(this);
	}

	public override bool IsInstanceOfType(object o)
	{
		return RuntimeTypeHandle.IsInstanceOfType(this, o);
	}

	public override bool IsAssignableFrom(TypeInfo typeInfo)
	{
		if (typeInfo == null)
		{
			return false;
		}
		return IsAssignableFrom(typeInfo.AsType());
	}

	public override bool IsAssignableFrom(Type c)
	{
		if ((object)c == null)
		{
			return false;
		}
		if ((object)c == this)
		{
			return true;
		}
		RuntimeType runtimeType = c.UnderlyingSystemType as RuntimeType;
		if (runtimeType != null)
		{
			return RuntimeTypeHandle.CanCastTo(runtimeType, this);
		}
		return false;
	}

	public override bool IsEquivalentTo(Type other)
	{
		if (!(other is RuntimeType runtimeType))
		{
			return false;
		}
		if (runtimeType == this)
		{
			return true;
		}
		return RuntimeTypeHandle.IsEquivalentTo(this, runtimeType);
	}

	private RuntimeType GetBaseType()
	{
		if (base.IsInterface)
		{
			return null;
		}
		if (RuntimeTypeHandle.IsGenericVariable(this))
		{
			Type[] genericParameterConstraints = GetGenericParameterConstraints();
			RuntimeType runtimeType = ObjectType;
			for (int i = 0; i < genericParameterConstraints.Length; i++)
			{
				RuntimeType runtimeType2 = (RuntimeType)genericParameterConstraints[i];
				if (runtimeType2.IsInterface)
				{
					continue;
				}
				if (runtimeType2.IsGenericParameter)
				{
					GenericParameterAttributes genericParameterAttributes = runtimeType2.GenericParameterAttributes & GenericParameterAttributes.SpecialConstraintMask;
					if ((genericParameterAttributes & GenericParameterAttributes.ReferenceTypeConstraint) == 0 && (genericParameterAttributes & GenericParameterAttributes.NotNullableValueTypeConstraint) == 0)
					{
						continue;
					}
				}
				runtimeType = runtimeType2;
			}
			if (runtimeType == ObjectType && (GenericParameterAttributes & GenericParameterAttributes.SpecialConstraintMask & GenericParameterAttributes.NotNullableValueTypeConstraint) != GenericParameterAttributes.None)
			{
				runtimeType = ValueType;
			}
			return runtimeType;
		}
		return RuntimeTypeHandle.GetBaseType(this);
	}

	protected override TypeAttributes GetAttributeFlagsImpl()
	{
		return RuntimeTypeHandle.GetAttributes(this);
	}

	protected override bool IsContextfulImpl()
	{
		return RuntimeTypeHandle.IsContextful(this);
	}

	protected override bool IsByRefImpl()
	{
		return RuntimeTypeHandle.IsByRef(this);
	}

	protected override bool IsPrimitiveImpl()
	{
		return RuntimeTypeHandle.IsPrimitive(this);
	}

	protected override bool IsPointerImpl()
	{
		return RuntimeTypeHandle.IsPointer(this);
	}

	protected override bool IsCOMObjectImpl()
	{
		return RuntimeTypeHandle.IsComObject(this, isGenericCOM: false);
	}

	internal override bool HasProxyAttributeImpl()
	{
		return RuntimeTypeHandle.HasProxyAttribute(this);
	}

	protected override bool IsValueTypeImpl()
	{
		if (this == typeof(ValueType) || this == typeof(Enum))
		{
			return false;
		}
		return IsSubclassOf(typeof(ValueType));
	}

	protected override bool HasElementTypeImpl()
	{
		return RuntimeTypeHandle.HasElementType(this);
	}

	protected override bool IsArrayImpl()
	{
		return RuntimeTypeHandle.IsArray(this);
	}

	public override int GetArrayRank()
	{
		if (!IsArrayImpl())
		{
			throw new ArgumentException(Environment.GetResourceString("Must be an array type."));
		}
		return RuntimeTypeHandle.GetArrayRank(this);
	}

	public override Type GetElementType()
	{
		return RuntimeTypeHandle.GetElementType(this);
	}

	public override string[] GetEnumNames()
	{
		if (!IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		string[] array = Enum.InternalGetNames(this);
		string[] array2 = new string[array.Length];
		Array.Copy(array, array2, array.Length);
		return array2;
	}

	public override Array GetEnumValues()
	{
		if (!IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		ulong[] array = Enum.InternalGetValues(this);
		Array array2 = Array.CreateInstance(this, array.Length);
		for (int i = 0; i < array.Length; i++)
		{
			object value = Enum.ToObject(this, array[i]);
			array2.SetValue(value, i);
		}
		return array2;
	}

	public override Type GetEnumUnderlyingType()
	{
		if (!IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		return Enum.InternalGetUnderlyingType(this);
	}

	public override bool IsEnumDefined(object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		RuntimeType runtimeType = (RuntimeType)value.GetType();
		if (runtimeType.IsEnum)
		{
			if (!runtimeType.IsEquivalentTo(this))
			{
				throw new ArgumentException(Environment.GetResourceString("Object must be the same type as the enum. The type passed in was '{0}'; the enum type was '{1}'.", runtimeType.ToString(), ToString()));
			}
			runtimeType = (RuntimeType)runtimeType.GetEnumUnderlyingType();
		}
		if (runtimeType == StringType)
		{
			object[] array = Enum.InternalGetNames(this);
			if (Array.IndexOf(array, value) >= 0)
			{
				return true;
			}
			return false;
		}
		if (Type.IsIntegerType(runtimeType))
		{
			RuntimeType runtimeType2 = Enum.InternalGetUnderlyingType(this);
			if (runtimeType2 != runtimeType)
			{
				throw new ArgumentException(Environment.GetResourceString("Enum underlying type and the object must be same type or object must be a String. Type passed in was '{0}'; the enum underlying type was '{1}'.", runtimeType.ToString(), runtimeType2.ToString()));
			}
			ulong[] array2 = Enum.InternalGetValues(this);
			ulong value2 = Enum.ToUInt64(value);
			return Array.BinarySearch(array2, value2) >= 0;
		}
		if (CompatibilitySwitches.IsAppEarlierThanWindowsPhone8)
		{
			throw new ArgumentException(Environment.GetResourceString("Enum underlying type and the object must be same type or object must be a String. Type passed in was '{0}'; the enum underlying type was '{1}'.", runtimeType.ToString(), GetEnumUnderlyingType()));
		}
		throw new InvalidOperationException(Environment.GetResourceString("Unknown enum type."));
	}

	public override string GetEnumName(object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		Type type = value.GetType();
		if (!type.IsEnum && !Type.IsIntegerType(type))
		{
			throw new ArgumentException(Environment.GetResourceString("The value passed in must be an enum base or an underlying type for an enum, such as an Int32."), "value");
		}
		ulong[] array = Enum.InternalGetValues(this);
		ulong value2 = Enum.ToUInt64(value);
		int num = Array.BinarySearch(array, value2);
		if (num >= 0)
		{
			return Enum.InternalGetNames(this)[num];
		}
		return null;
	}

	internal RuntimeType[] GetGenericArgumentsInternal()
	{
		return (RuntimeType[])GetGenericArgumentsInternal(runtimeArray: true);
	}

	public override Type[] GetGenericArguments()
	{
		Type[] array = GetGenericArgumentsInternal(runtimeArray: false);
		if (array == null)
		{
			array = Array.Empty<Type>();
		}
		return array;
	}

	public override Type MakeGenericType(params Type[] instantiation)
	{
		if (instantiation == null)
		{
			throw new ArgumentNullException("instantiation");
		}
		RuntimeType[] array = new RuntimeType[instantiation.Length];
		if (!IsGenericTypeDefinition)
		{
			throw new InvalidOperationException(Environment.GetResourceString("{0} is not a GenericTypeDefinition. MakeGenericType may only be called on a type for which Type.IsGenericTypeDefinition is true.", this));
		}
		if (GetGenericArguments().Length != instantiation.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("The number of generic arguments provided doesn't equal the arity of the generic type definition."), "instantiation");
		}
		for (int i = 0; i < instantiation.Length; i++)
		{
			Type type = instantiation[i];
			if (type == null)
			{
				throw new ArgumentNullException();
			}
			RuntimeType runtimeType = type as RuntimeType;
			if (runtimeType == null)
			{
				if (type.IsSignatureType)
				{
					return Type.MakeGenericSignatureType(this, instantiation);
				}
				Type[] array2 = new Type[instantiation.Length];
				for (int j = 0; j < instantiation.Length; j++)
				{
					array2[j] = instantiation[j];
				}
				instantiation = array2;
				if (!RuntimeFeature.IsDynamicCodeSupported)
				{
					throw new PlatformNotSupportedException();
				}
				return MakeTypeBuilderInstantiation(this, instantiation);
			}
			array[i] = runtimeType;
		}
		RuntimeType[] genericArgumentsInternal = GetGenericArgumentsInternal();
		SanityCheckGenericArguments(array, genericArgumentsInternal);
		Type[] types = array;
		Type type2 = MakeGenericType(this, types);
		if (type2 == null)
		{
			throw new TypeLoadException();
		}
		return type2;
	}

	public override Type GetGenericTypeDefinition()
	{
		if (!IsGenericType)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This operation is only valid on generic types."));
		}
		return RuntimeTypeHandle.GetGenericTypeDefinition(this);
	}

	public override MemberInfo[] GetDefaultMembers()
	{
		MemberInfo[] array = null;
		string defaultMemberName = GetDefaultMemberName();
		if (defaultMemberName != null)
		{
			array = GetMember(defaultMemberName);
		}
		if (array == null)
		{
			array = Array.Empty<MemberInfo>();
		}
		return array;
	}

	[DebuggerStepThrough]
	[DebuggerHidden]
	public override object InvokeMember(string name, BindingFlags bindingFlags, Binder binder, object target, object[] providedArgs, ParameterModifier[] modifiers, CultureInfo culture, string[] namedParams)
	{
		if (IsGenericParameter)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Method must be called on a Type for which Type.IsGenericParameter is false."));
		}
		if ((bindingFlags & (BindingFlags.InvokeMethod | BindingFlags.CreateInstance | BindingFlags.GetField | BindingFlags.SetField | BindingFlags.GetProperty | BindingFlags.SetProperty | BindingFlags.PutDispProperty | BindingFlags.PutRefDispProperty)) == 0)
		{
			throw new ArgumentException(Environment.GetResourceString("Must specify binding flags describing the invoke operation required (BindingFlags.InvokeMethod CreateInstance GetField SetField GetProperty SetProperty)."), "bindingFlags");
		}
		if ((bindingFlags & (BindingFlags)0xFF) == 0)
		{
			bindingFlags |= BindingFlags.Instance | BindingFlags.Public;
			if ((bindingFlags & BindingFlags.CreateInstance) == 0)
			{
				bindingFlags |= BindingFlags.Static;
			}
		}
		if (namedParams != null)
		{
			if (providedArgs != null)
			{
				if (namedParams.Length > providedArgs.Length)
				{
					throw new ArgumentException(Environment.GetResourceString("Named parameter array cannot be bigger than argument array."), "namedParams");
				}
			}
			else if (namedParams.Length != 0)
			{
				throw new ArgumentException(Environment.GetResourceString("Named parameter array cannot be bigger than argument array."), "namedParams");
			}
		}
		if (namedParams != null && Array.IndexOf(namedParams, null) != -1)
		{
			throw new ArgumentException(Environment.GetResourceString("Named parameter value must not be null."), "namedParams");
		}
		int num = ((providedArgs != null) ? providedArgs.Length : 0);
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		if ((bindingFlags & BindingFlags.CreateInstance) != BindingFlags.Default)
		{
			if ((bindingFlags & BindingFlags.CreateInstance) != BindingFlags.Default && (bindingFlags & (BindingFlags.InvokeMethod | BindingFlags.GetField | BindingFlags.SetField | BindingFlags.GetProperty | BindingFlags.SetProperty)) != BindingFlags.Default)
			{
				throw new ArgumentException(Environment.GetResourceString("Cannot specify both CreateInstance and another access type."), "bindingFlags");
			}
			return Activator.CreateInstance(this, bindingFlags, binder, providedArgs, culture);
		}
		if ((bindingFlags & (BindingFlags.PutDispProperty | BindingFlags.PutRefDispProperty)) != BindingFlags.Default)
		{
			bindingFlags |= BindingFlags.SetProperty;
		}
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (name.Length == 0 || name.Equals("[DISPID=0]"))
		{
			name = GetDefaultMemberName();
			if (name == null)
			{
				name = "ToString";
			}
		}
		bool flag = (bindingFlags & BindingFlags.GetField) != 0;
		bool flag2 = (bindingFlags & BindingFlags.SetField) != 0;
		if (flag | flag2)
		{
			if (flag)
			{
				if (flag2)
				{
					throw new ArgumentException(Environment.GetResourceString("Cannot specify both Get and Set on a field."), "bindingFlags");
				}
				if ((bindingFlags & BindingFlags.SetProperty) != BindingFlags.Default)
				{
					throw new ArgumentException(Environment.GetResourceString("Cannot specify both GetField and SetProperty."), "bindingFlags");
				}
			}
			else
			{
				if (providedArgs == null)
				{
					throw new ArgumentNullException("providedArgs");
				}
				if ((bindingFlags & BindingFlags.GetProperty) != BindingFlags.Default)
				{
					throw new ArgumentException(Environment.GetResourceString("Cannot specify both SetField and GetProperty."), "bindingFlags");
				}
				if ((bindingFlags & BindingFlags.InvokeMethod) != BindingFlags.Default)
				{
					throw new ArgumentException(Environment.GetResourceString("Cannot specify Set on a Field and Invoke on a method."), "bindingFlags");
				}
			}
			FieldInfo fieldInfo = null;
			FieldInfo[] array = GetMember(name, MemberTypes.Field, bindingFlags) as FieldInfo[];
			if (array.Length == 1)
			{
				fieldInfo = array[0];
			}
			else if (array.Length != 0)
			{
				fieldInfo = binder.BindToField(bindingFlags, array, flag ? Empty.Value : providedArgs[0], culture);
			}
			if (fieldInfo != null)
			{
				if (fieldInfo.FieldType.IsArray || (object)fieldInfo.FieldType == typeof(Array))
				{
					int num2 = (((bindingFlags & BindingFlags.GetField) == 0) ? (num - 1) : num);
					if (num2 > 0)
					{
						int[] array2 = new int[num2];
						for (int i = 0; i < num2; i++)
						{
							try
							{
								array2[i] = ((IConvertible)providedArgs[i]).ToInt32(null);
							}
							catch (InvalidCastException)
							{
								throw new ArgumentException(Environment.GetResourceString("All indexes must be of type Int32."));
							}
						}
						Array array3 = (Array)fieldInfo.GetValue(target);
						if ((bindingFlags & BindingFlags.GetField) != BindingFlags.Default)
						{
							return array3.GetValue(array2);
						}
						array3.SetValue(providedArgs[num2], array2);
						return null;
					}
				}
				if (flag)
				{
					if (num != 0)
					{
						throw new ArgumentException(Environment.GetResourceString("No arguments can be provided to Get a field value."), "bindingFlags");
					}
					return fieldInfo.GetValue(target);
				}
				if (num != 1)
				{
					throw new ArgumentException(Environment.GetResourceString("Only the field value can be specified to set a field value."), "bindingFlags");
				}
				fieldInfo.SetValue(target, providedArgs[0], bindingFlags, binder, culture);
				return null;
			}
			if ((bindingFlags & (BindingFlags)0xFFF300) == 0)
			{
				throw new MissingFieldException(FullName, name);
			}
		}
		bool flag3 = (bindingFlags & BindingFlags.GetProperty) != 0;
		bool flag4 = (bindingFlags & BindingFlags.SetProperty) != 0;
		if (flag3 | flag4)
		{
			if (flag3)
			{
				if (flag4)
				{
					throw new ArgumentException(Environment.GetResourceString("Cannot specify both Get and Set on a property."), "bindingFlags");
				}
			}
			else if ((bindingFlags & BindingFlags.InvokeMethod) != BindingFlags.Default)
			{
				throw new ArgumentException(Environment.GetResourceString("Cannot specify Set on a property and Invoke on a method."), "bindingFlags");
			}
		}
		MethodInfo[] array4 = null;
		MethodInfo methodInfo = null;
		if ((bindingFlags & BindingFlags.InvokeMethod) != BindingFlags.Default)
		{
			MethodInfo[] array5 = GetMember(name, MemberTypes.Method, bindingFlags) as MethodInfo[];
			List<MethodInfo> list = null;
			foreach (MethodInfo methodInfo2 in array5)
			{
				if (!FilterApplyMethodInfo((RuntimeMethodInfo)methodInfo2, bindingFlags, CallingConventions.Any, new Type[num]))
				{
					continue;
				}
				if (methodInfo == null)
				{
					methodInfo = methodInfo2;
					continue;
				}
				if (list == null)
				{
					list = new List<MethodInfo>(array5.Length);
					list.Add(methodInfo);
				}
				list.Add(methodInfo2);
			}
			if (list != null)
			{
				array4 = new MethodInfo[list.Count];
				list.CopyTo(array4);
			}
		}
		if (((methodInfo == null) & flag3) | flag4)
		{
			PropertyInfo[] array6 = GetMember(name, MemberTypes.Property, bindingFlags) as PropertyInfo[];
			List<MethodInfo> list2 = null;
			for (int k = 0; k < array6.Length; k++)
			{
				MethodInfo methodInfo3 = null;
				methodInfo3 = ((!flag4) ? array6[k].GetGetMethod(nonPublic: true) : array6[k].GetSetMethod(nonPublic: true));
				if (methodInfo3 == null || !FilterApplyMethodInfo((RuntimeMethodInfo)methodInfo3, bindingFlags, CallingConventions.Any, new Type[num]))
				{
					continue;
				}
				if (methodInfo == null)
				{
					methodInfo = methodInfo3;
					continue;
				}
				if (list2 == null)
				{
					list2 = new List<MethodInfo>(array6.Length);
					list2.Add(methodInfo);
				}
				list2.Add(methodInfo3);
			}
			if (list2 != null)
			{
				array4 = new MethodInfo[list2.Count];
				list2.CopyTo(array4);
			}
		}
		if (methodInfo != null)
		{
			if (array4 == null && num == 0 && methodInfo.GetParametersNoCopy().Length == 0 && (bindingFlags & BindingFlags.OptionalParamBinding) == 0)
			{
				return methodInfo.Invoke(target, bindingFlags, binder, providedArgs, culture);
			}
			if (array4 == null)
			{
				array4 = new MethodInfo[1] { methodInfo };
			}
			if (providedArgs == null)
			{
				providedArgs = Array.Empty<object>();
			}
			object state = null;
			MethodBase methodBase = null;
			try
			{
				Binder binder2 = binder;
				BindingFlags bindingAttr = bindingFlags;
				MethodBase[] match = array4;
				methodBase = binder2.BindToMethod(bindingAttr, match, ref providedArgs, modifiers, culture, namedParams, out state);
			}
			catch (MissingMethodException)
			{
			}
			if (methodBase == null)
			{
				throw new MissingMethodException(FullName, name);
			}
			object result = ((MethodInfo)methodBase).Invoke(target, bindingFlags, binder, providedArgs, culture);
			if (state != null)
			{
				binder.ReorderArgumentArray(ref providedArgs, state);
			}
			return result;
		}
		throw new MissingMethodException(FullName, name);
	}

	public override bool Equals(object obj)
	{
		return obj == this;
	}

	public static bool operator ==(RuntimeType left, RuntimeType right)
	{
		return (object)left == right;
	}

	public static bool operator !=(RuntimeType left, RuntimeType right)
	{
		return (object)left != right;
	}

	public object Clone()
	{
		return this;
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		UnitySerializationHolder.GetUnitySerializationInfo(info, this);
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, ObjectType, inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		if ((object)attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		RuntimeType runtimeType = attributeType.UnderlyingSystemType as RuntimeType;
		if (runtimeType == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "attributeType");
		}
		return MonoCustomAttrs.GetCustomAttributes(this, runtimeType, inherit);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		if ((object)attributeType == null)
		{
			throw new ArgumentNullException("attributeType");
		}
		RuntimeType runtimeType = attributeType.UnderlyingSystemType as RuntimeType;
		if (runtimeType == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "attributeType");
		}
		return MonoCustomAttrs.IsDefined(this, runtimeType, inherit);
	}

	public override IList<CustomAttributeData> GetCustomAttributesData()
	{
		return CustomAttributeData.GetCustomAttributesInternal(this);
	}

	internal override string FormatTypeName(bool serialization)
	{
		if (serialization)
		{
			return GetCachedName(TypeNameKind.SerializationName);
		}
		Type rootElementType = GetRootElementType();
		if (rootElementType.IsNested)
		{
			return Name;
		}
		string text = ToString();
		if (rootElementType.IsPrimitive || rootElementType == typeof(void) || rootElementType == typeof(TypedReference))
		{
			text = text.Substring("System.".Length);
		}
		return text;
	}

	private void CreateInstanceCheckThis()
	{
		if (this is ReflectionOnlyType)
		{
			throw new ArgumentException(Environment.GetResourceString("It is illegal to invoke a method on a Type loaded via ReflectionOnlyGetType."));
		}
		if (ContainsGenericParameters)
		{
			throw new ArgumentException(Environment.GetResourceString("Cannot create an instance of {0} because Type.ContainsGenericParameters is true.", this));
		}
		Type rootElementType = GetRootElementType();
		if ((object)rootElementType == typeof(ArgIterator))
		{
			throw new NotSupportedException(Environment.GetResourceString("Cannot dynamically create an instance of ArgIterator."));
		}
		if ((object)rootElementType == typeof(void))
		{
			throw new NotSupportedException(Environment.GetResourceString("Cannot dynamically create an instance of System.Void."));
		}
	}

	internal object CreateInstanceImpl(BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, ref StackCrawlMark stackMark)
	{
		CreateInstanceCheckThis();
		object obj = null;
		try
		{
			if (args == null)
			{
				args = Array.Empty<object>();
			}
			int num = args.Length;
			if (binder == null)
			{
				binder = Type.DefaultBinder;
			}
			bool publicOnly = (bindingAttr & BindingFlags.NonPublic) == 0;
			bool wrapExceptions = (bindingAttr & BindingFlags.DoNotWrapExceptions) == 0;
			if (num == 0 && (bindingAttr & BindingFlags.Public) != BindingFlags.Default && (bindingAttr & BindingFlags.Instance) != BindingFlags.Default && (IsGenericCOMObjectImpl() || base.IsValueType))
			{
				obj = CreateInstanceDefaultCtor(publicOnly, skipCheckThis: false, fillCache: true, wrapExceptions, ref stackMark);
			}
			else
			{
				ConstructorInfo[] constructors = GetConstructors(bindingAttr);
				List<MethodBase> list = new List<MethodBase>(constructors.Length);
				Type[] array = new Type[num];
				for (int i = 0; i < num; i++)
				{
					if (args[i] != null)
					{
						array[i] = args[i].GetType();
					}
				}
				for (int j = 0; j < constructors.Length; j++)
				{
					if (FilterApplyConstructorInfo((RuntimeConstructorInfo)constructors[j], bindingAttr, CallingConventions.Any, array))
					{
						list.Add(constructors[j]);
					}
				}
				MethodBase[] array2 = new MethodBase[list.Count];
				list.CopyTo(array2);
				if (array2 != null && array2.Length == 0)
				{
					array2 = null;
				}
				if (array2 == null)
				{
					throw new MissingMethodException(Environment.GetResourceString("Constructor on type '{0}' not found.", FullName));
				}
				object state = null;
				MethodBase methodBase;
				try
				{
					methodBase = binder.BindToMethod(bindingAttr, array2, ref args, null, culture, null, out state);
				}
				catch (MissingMethodException)
				{
					methodBase = null;
				}
				if (methodBase == null)
				{
					throw new MissingMethodException(Environment.GetResourceString("Constructor on type '{0}' not found.", FullName));
				}
				if (methodBase.GetParametersNoCopy().Length == 0)
				{
					if (args.Length != 0)
					{
						throw new NotSupportedException(string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Vararg calling convention not supported.")));
					}
					obj = Activator.CreateInstance(this, nonPublic: true, wrapExceptions);
				}
				else
				{
					obj = ((ConstructorInfo)methodBase).Invoke(bindingAttr, binder, args, culture);
					if (state != null)
					{
						binder.ReorderArgumentArray(ref args, state);
					}
				}
			}
		}
		catch (Exception)
		{
			throw;
		}
		return obj;
	}

	[DebuggerStepThrough]
	[DebuggerHidden]
	internal object CreateInstanceDefaultCtor(bool publicOnly, bool skipCheckThis, bool fillCache, bool wrapExceptions, ref StackCrawlMark stackMark)
	{
		if (GetType() == typeof(ReflectionOnlyType))
		{
			throw new InvalidOperationException(Environment.GetResourceString("The requested operation is invalid in the ReflectionOnly context."));
		}
		return CreateInstanceSlow(publicOnly, wrapExceptions, skipCheckThis, fillCache);
	}

	internal RuntimeConstructorInfo GetDefaultConstructor()
	{
		RuntimeConstructorInfo runtimeConstructorInfo = null;
		if (type_info == null)
		{
			type_info = new MonoTypeInfo();
		}
		else
		{
			runtimeConstructorInfo = type_info.default_ctor;
		}
		if (runtimeConstructorInfo == null)
		{
			ConstructorInfo[] constructors = GetConstructors(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			for (int i = 0; i < constructors.Length; i++)
			{
				if (constructors[i].GetParametersCount() == 0)
				{
					runtimeConstructorInfo = (type_info.default_ctor = (RuntimeConstructorInfo)constructors[i]);
					break;
				}
			}
		}
		return runtimeConstructorInfo;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern MethodInfo GetCorrespondingInflatedMethod(MethodInfo generic);

	[MethodImpl((MethodImplOptions)4096)]
	private extern ConstructorInfo GetCorrespondingInflatedConstructor(ConstructorInfo generic);

	internal override MethodInfo GetMethod(MethodInfo fromNoninstanciated)
	{
		if (fromNoninstanciated == null)
		{
			throw new ArgumentNullException("fromNoninstanciated");
		}
		return GetCorrespondingInflatedMethod(fromNoninstanciated);
	}

	internal override ConstructorInfo GetConstructor(ConstructorInfo fromNoninstanciated)
	{
		if (fromNoninstanciated == null)
		{
			throw new ArgumentNullException("fromNoninstanciated");
		}
		return GetCorrespondingInflatedConstructor(fromNoninstanciated);
	}

	internal override FieldInfo GetField(FieldInfo fromNoninstanciated)
	{
		BindingFlags bindingFlags = (fromNoninstanciated.IsStatic ? BindingFlags.Static : BindingFlags.Instance);
		bindingFlags = (BindingFlags)((int)bindingFlags | (fromNoninstanciated.IsPublic ? 16 : 32));
		return GetField(fromNoninstanciated.Name, bindingFlags);
	}

	private string GetDefaultMemberName()
	{
		object[] customAttributes = GetCustomAttributes(typeof(DefaultMemberAttribute), inherit: true);
		if (customAttributes.Length == 0)
		{
			return null;
		}
		return ((DefaultMemberAttribute)customAttributes[0]).MemberName;
	}

	internal RuntimeConstructorInfo GetSerializationCtor()
	{
		if (m_serializationCtor == null)
		{
			Type[] types = new Type[2]
			{
				typeof(SerializationInfo),
				typeof(StreamingContext)
			};
			m_serializationCtor = GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, CallingConventions.Any, types, null) as RuntimeConstructorInfo;
		}
		return m_serializationCtor;
	}

	internal object CreateInstanceSlow(bool publicOnly, bool wrapExceptions, bool skipCheckThis, bool fillCache)
	{
		if (!skipCheckThis)
		{
			CreateInstanceCheckThis();
		}
		return CreateInstanceMono(!publicOnly, wrapExceptions);
	}

	private object CreateInstanceMono(bool nonPublic, bool wrapExceptions)
	{
		RuntimeConstructorInfo runtimeConstructorInfo = GetDefaultConstructor();
		if (!nonPublic && runtimeConstructorInfo != null && !runtimeConstructorInfo.IsPublic)
		{
			runtimeConstructorInfo = null;
		}
		if (runtimeConstructorInfo == null)
		{
			Type rootElementType = GetRootElementType();
			if ((object)rootElementType == typeof(TypedReference) || (object)rootElementType == typeof(RuntimeArgumentHandle))
			{
				throw new NotSupportedException(Environment.GetResourceString("Cannot create boxed TypedReference, ArgIterator, or RuntimeArgumentHandle Objects."));
			}
			if (base.IsValueType)
			{
				return CreateInstanceInternal(this);
			}
			throw new MissingMethodException("Default constructor not found for type " + FullName);
		}
		if (base.IsAbstract)
		{
			throw new MissingMethodException("Cannot create an abstract class '{0}'.", FullName);
		}
		return runtimeConstructorInfo.InternalInvoke(null, null, wrapExceptions);
	}

	internal object CheckValue(object value, Binder binder, CultureInfo culture, BindingFlags invokeAttr)
	{
		bool failed = false;
		object result = TryConvertToType(value, ref failed);
		if (!failed)
		{
			return result;
		}
		if ((invokeAttr & BindingFlags.ExactBinding) == BindingFlags.ExactBinding)
		{
			throw new ArgumentException(string.Format(CultureInfo.CurrentUICulture, Environment.GetResourceString("Object of type '{0}' cannot be converted to type '{1}'."), value.GetType(), this));
		}
		if (binder != null && binder != Type.DefaultBinder)
		{
			return binder.ChangeType(value, this, culture);
		}
		throw new ArgumentException(string.Format(CultureInfo.CurrentUICulture, Environment.GetResourceString("Object of type '{0}' cannot be converted to type '{1}'."), value.GetType(), this));
	}

	private object TryConvertToType(object value, ref bool failed)
	{
		if (IsInstanceOfType(value))
		{
			return value;
		}
		if (base.IsByRef)
		{
			Type elementType = GetElementType();
			if (value == null || elementType.IsInstanceOfType(value))
			{
				return value;
			}
		}
		if (value == null)
		{
			return value;
		}
		if (IsEnum)
		{
			if (Enum.GetUnderlyingType(this) == value.GetType())
			{
				return value;
			}
			object obj = IsConvertibleToPrimitiveType(value, this);
			if (obj != null)
			{
				return obj;
			}
		}
		else if (base.IsPrimitive)
		{
			object obj2 = IsConvertibleToPrimitiveType(value, this);
			if (obj2 != null)
			{
				return obj2;
			}
		}
		else if (base.IsPointer)
		{
			Type type = value.GetType();
			if (type == typeof(IntPtr) || type == typeof(UIntPtr))
			{
				return value;
			}
		}
		failed = true;
		return null;
	}

	private static object IsConvertibleToPrimitiveType(object value, Type targetType)
	{
		Type type = value.GetType();
		if (type.IsEnum)
		{
			type = Enum.GetUnderlyingType(type);
			if (type == targetType)
			{
				return value;
			}
		}
		TypeCode typeCode = Type.GetTypeCode(type);
		switch (Type.GetTypeCode(targetType))
		{
		case TypeCode.Char:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (char)(byte)value;
			case TypeCode.UInt16:
				return value;
			}
			break;
		case TypeCode.Int16:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (short)(byte)value;
			case TypeCode.SByte:
				return (short)(sbyte)value;
			}
			break;
		case TypeCode.UInt16:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (ushort)(byte)value;
			case TypeCode.Char:
				return value;
			}
			break;
		case TypeCode.Int32:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (int)(byte)value;
			case TypeCode.SByte:
				return (int)(sbyte)value;
			case TypeCode.Char:
				return (int)(char)value;
			case TypeCode.Int16:
				return (int)(short)value;
			case TypeCode.UInt16:
				return (int)(ushort)value;
			}
			break;
		case TypeCode.UInt32:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (uint)(byte)value;
			case TypeCode.Char:
				return (uint)(char)value;
			case TypeCode.UInt16:
				return (uint)(ushort)value;
			}
			break;
		case TypeCode.Int64:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (long)(byte)value;
			case TypeCode.SByte:
				return (long)(sbyte)value;
			case TypeCode.Int16:
				return (long)(short)value;
			case TypeCode.Char:
				return (long)(char)value;
			case TypeCode.UInt16:
				return (long)(ushort)value;
			case TypeCode.Int32:
				return (long)(int)value;
			case TypeCode.UInt32:
				return (long)(uint)value;
			}
			break;
		case TypeCode.UInt64:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (ulong)(byte)value;
			case TypeCode.Char:
				return (ulong)(char)value;
			case TypeCode.UInt16:
				return (ulong)(ushort)value;
			case TypeCode.UInt32:
				return (ulong)(uint)value;
			}
			break;
		case TypeCode.Single:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (float)(int)(byte)value;
			case TypeCode.SByte:
				return (float)(sbyte)value;
			case TypeCode.Int16:
				return (float)(short)value;
			case TypeCode.Char:
				return (float)(int)(char)value;
			case TypeCode.UInt16:
				return (float)(int)(ushort)value;
			case TypeCode.Int32:
				return (float)(int)value;
			case TypeCode.UInt32:
				return (float)(uint)value;
			case TypeCode.Int64:
				return (float)(long)value;
			case TypeCode.UInt64:
				return (float)(ulong)value;
			}
			break;
		case TypeCode.Double:
			switch (typeCode)
			{
			case TypeCode.Byte:
				return (double)(int)(byte)value;
			case TypeCode.SByte:
				return (double)(sbyte)value;
			case TypeCode.Char:
				return (double)(int)(char)value;
			case TypeCode.Int16:
				return (double)(short)value;
			case TypeCode.UInt16:
				return (double)(int)(ushort)value;
			case TypeCode.Int32:
				return (double)(int)value;
			case TypeCode.UInt32:
				return (double)(uint)value;
			case TypeCode.Int64:
				return (double)(long)value;
			case TypeCode.UInt64:
				return (double)(ulong)value;
			case TypeCode.Single:
				return (double)(float)value;
			}
			break;
		}
		return null;
	}

	private string GetCachedName(TypeNameKind kind)
	{
		if (kind == TypeNameKind.SerializationName)
		{
			return ToString();
		}
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern Type make_array_type(int rank);

	public override Type MakeArrayType()
	{
		return make_array_type(0);
	}

	public override Type MakeArrayType(int rank)
	{
		if (rank < 1 || rank > 255)
		{
			throw new IndexOutOfRangeException();
		}
		return make_array_type(rank);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern Type make_byref_type();

	public override Type MakeByRefType()
	{
		if (base.IsByRef)
		{
			throw new TypeLoadException("Can not call MakeByRefType on a ByRef type");
		}
		return make_byref_type();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type MakePointerType(Type type);

	public override Type MakePointerType()
	{
		if (base.IsByRef)
		{
			throw new TypeLoadException($"Could not load type '{GetType()}' from assembly '{AssemblyQualifiedName}");
		}
		return MakePointerType(this);
	}

	public override Type[] GetGenericParameterConstraints()
	{
		if (!IsGenericParameter)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Method may only be called on a Type for which Type.IsGenericParameter is true."));
		}
		Type[] array = new RuntimeGenericParamInfoHandle(RuntimeTypeHandle.GetGenericParameterInfo(this)).Constraints;
		if (array == null)
		{
			array = EmptyArray<Type>.Value;
		}
		return array;
	}

	internal static object CreateInstanceForAnotherGenericParameter(Type genericType, RuntimeType genericArgument)
	{
		return ((RuntimeType)MakeGenericType(genericType, new Type[1] { genericArgument })).GetDefaultConstructor().InternalInvoke(null, null, wrapExceptions: true);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type MakeGenericType(Type gt, Type[] types);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern IntPtr GetMethodsByName_native(IntPtr namePtr, BindingFlags bindingAttr, MemberListType listType);

	internal RuntimeMethodInfo[] GetMethodsByName(string name, BindingFlags bindingAttr, MemberListType listType, RuntimeType reflectedType)
	{
		RuntimeTypeHandle reflectedType2 = new RuntimeTypeHandle(reflectedType);
		using SafeStringMarshal safeStringMarshal = new SafeStringMarshal(name);
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(GetMethodsByName_native(safeStringMarshal.Value, bindingAttr, listType));
		int length = safeGPtrArrayHandle.Length;
		RuntimeMethodInfo[] array = new RuntimeMethodInfo[length];
		for (int i = 0; i < length; i++)
		{
			RuntimeMethodHandle handle = new RuntimeMethodHandle(safeGPtrArrayHandle[i]);
			array[i] = (RuntimeMethodInfo)RuntimeMethodInfo.GetMethodFromHandleNoGenericCheck(handle, reflectedType2);
		}
		return array;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetPropertiesByName_native(IntPtr name, BindingFlags bindingAttr, MemberListType listType);

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetConstructors_native(BindingFlags bindingAttr);

	private RuntimeConstructorInfo[] GetConstructors_internal(BindingFlags bindingAttr, RuntimeType reflectedType)
	{
		RuntimeTypeHandle reflectedType2 = new RuntimeTypeHandle(reflectedType);
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(GetConstructors_native(bindingAttr));
		int length = safeGPtrArrayHandle.Length;
		RuntimeConstructorInfo[] array = new RuntimeConstructorInfo[length];
		for (int i = 0; i < length; i++)
		{
			RuntimeMethodHandle handle = new RuntimeMethodHandle(safeGPtrArrayHandle[i]);
			array[i] = (RuntimeConstructorInfo)RuntimeMethodInfo.GetMethodFromHandleNoGenericCheck(handle, reflectedType2);
		}
		return array;
	}

	private RuntimePropertyInfo[] GetPropertiesByName(string name, BindingFlags bindingAttr, MemberListType listType, RuntimeType reflectedType)
	{
		RuntimeTypeHandle reflectedType2 = new RuntimeTypeHandle(reflectedType);
		using SafeStringMarshal safeStringMarshal = new SafeStringMarshal(name);
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(GetPropertiesByName_native(safeStringMarshal.Value, bindingAttr, listType));
		int length = safeGPtrArrayHandle.Length;
		RuntimePropertyInfo[] array = new RuntimePropertyInfo[length];
		for (int i = 0; i < length; i++)
		{
			RuntimePropertyHandle handle = new RuntimePropertyHandle(safeGPtrArrayHandle[i]);
			array[i] = (RuntimePropertyInfo)RuntimePropertyInfo.GetPropertyFromHandle(handle, reflectedType2);
		}
		return array;
	}

	public override InterfaceMapping GetInterfaceMap(Type ifaceType)
	{
		if (IsGenericParameter)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Method must be called on a Type for which Type.IsGenericParameter is false."));
		}
		if ((object)ifaceType == null)
		{
			throw new ArgumentNullException("ifaceType");
		}
		if (ifaceType as RuntimeType == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a runtime Type object."), "ifaceType");
		}
		if (!ifaceType.IsInterface)
		{
			throw new ArgumentException("Argument must be an interface.", "ifaceType");
		}
		if (base.IsInterface)
		{
			throw new ArgumentException("'this' type cannot be an interface itself");
		}
		InterfaceMapping result = default(InterfaceMapping);
		result.TargetType = this;
		result.InterfaceType = ifaceType;
		GetInterfaceMapData(this, ifaceType, out result.TargetMethods, out result.InterfaceMethods);
		if (result.TargetMethods == null)
		{
			throw new ArgumentException("Interface not found", "ifaceType");
		}
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetInterfaceMapData(Type t, Type iface, out MethodInfo[] targets, out MethodInfo[] methods);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetGUID(Type type, byte[] guid);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern void GetPacking(out int packing, out int size);

	internal static Type GetTypeFromCLSIDImpl(Guid clsid, string server, bool throwOnError)
	{
		throw new NotImplementedException("Unmanaged activation removed");
	}

	protected override TypeCode GetTypeCodeImpl()
	{
		return GetTypeCodeImplInternal(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern TypeCode GetTypeCodeImplInternal(Type type);

	internal static Type GetTypeFromProgIDImpl(string progID, string server, bool throwOnError)
	{
		throw new NotImplementedException("Unmanaged activation is not supported");
	}

	public override string ToString()
	{
		return getFullName(full_name: false, assembly_qualified: false);
	}

	private bool IsGenericCOMObjectImpl()
	{
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern object CreateInstanceInternal(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern string getFullName(bool full_name, bool assembly_qualified);

	[MethodImpl((MethodImplOptions)4096)]
	private extern Type[] GetGenericArgumentsInternal(bool runtimeArray);

	private GenericParameterAttributes GetGenericParameterAttributes()
	{
		return new RuntimeGenericParamInfoHandle(RuntimeTypeHandle.GetGenericParameterInfo(this)).Attributes;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetGenericParameterPosition();

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetEvents_native(IntPtr name, MemberListType listType);

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetFields_native(IntPtr name, BindingFlags bindingAttr, MemberListType listType);

	private RuntimeFieldInfo[] GetFields_internal(string name, BindingFlags bindingAttr, MemberListType listType, RuntimeType reflectedType)
	{
		RuntimeTypeHandle declaringType = new RuntimeTypeHandle(reflectedType);
		using SafeStringMarshal safeStringMarshal = new SafeStringMarshal(name);
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(GetFields_native(safeStringMarshal.Value, bindingAttr, listType));
		int length = safeGPtrArrayHandle.Length;
		RuntimeFieldInfo[] array = new RuntimeFieldInfo[length];
		for (int i = 0; i < length; i++)
		{
			RuntimeFieldHandle handle = new RuntimeFieldHandle(safeGPtrArrayHandle[i]);
			array[i] = (RuntimeFieldInfo)FieldInfo.GetFieldFromHandle(handle, declaringType);
		}
		return array;
	}

	private RuntimeEventInfo[] GetEvents_internal(string name, BindingFlags bindingAttr, MemberListType listType, RuntimeType reflectedType)
	{
		RuntimeTypeHandle reflectedType2 = new RuntimeTypeHandle(reflectedType);
		using SafeStringMarshal safeStringMarshal = new SafeStringMarshal(name);
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(GetEvents_native(safeStringMarshal.Value, listType));
		int length = safeGPtrArrayHandle.Length;
		RuntimeEventInfo[] array = new RuntimeEventInfo[length];
		for (int i = 0; i < length; i++)
		{
			RuntimeEventHandle handle = new RuntimeEventHandle(safeGPtrArrayHandle[i]);
			array[i] = (RuntimeEventInfo)EventInfo.GetEventFromHandle(handle, reflectedType2);
		}
		return array;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public override extern Type[] GetInterfaces();

	[MethodImpl((MethodImplOptions)4096)]
	private extern IntPtr GetNestedTypes_native(IntPtr name, BindingFlags bindingAttr, MemberListType listType);

	private RuntimeType[] GetNestedTypes_internal(string displayName, BindingFlags bindingAttr, MemberListType listType)
	{
		string str = null;
		if (displayName != null)
		{
			str = TypeIdentifiers.FromDisplay(displayName).InternalName;
		}
		using SafeStringMarshal safeStringMarshal = new SafeStringMarshal(str);
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(GetNestedTypes_native(safeStringMarshal.Value, bindingAttr, listType));
		int length = safeGPtrArrayHandle.Length;
		RuntimeType[] array = new RuntimeType[length];
		for (int i = 0; i < length; i++)
		{
			RuntimeTypeHandle handle = new RuntimeTypeHandle(safeGPtrArrayHandle[i]);
			array[i] = (RuntimeType)Type.GetTypeFromHandle(handle);
		}
		return array;
	}

	public override int GetHashCode()
	{
		Type underlyingSystemType = UnderlyingSystemType;
		if (underlyingSystemType != null && underlyingSystemType != this)
		{
			return underlyingSystemType.GetHashCode();
		}
		return (int)_impl.Value;
	}

	public sealed override bool HasSameMetadataDefinitionAs(MemberInfo other)
	{
		return HasSameMetadataDefinitionAsCore<RuntimeType>(other);
	}

	[ComVisible(true)]
	public override bool IsSubclassOf(Type type)
	{
		if ((object)type == null)
		{
			throw new ArgumentNullException("type");
		}
		RuntimeType runtimeType = type as RuntimeType;
		if (runtimeType == null)
		{
			return false;
		}
		return RuntimeTypeHandle.IsSubclassOf(this, runtimeType);
	}

	protected override MethodInfo GetMethodImpl(string name, BindingFlags bindingAttr, Binder binder, CallingConventions callConv, Type[] types, ParameterModifier[] modifiers)
	{
		return GetMethodImplCommon(name, -1, bindingAttr, binder, callConv, types, modifiers);
	}

	protected override MethodInfo GetMethodImpl(string name, int genericParameterCount, BindingFlags bindingAttr, Binder binder, CallingConventions callConv, Type[] types, ParameterModifier[] modifiers)
	{
		return GetMethodImplCommon(name, genericParameterCount, bindingAttr, binder, callConv, types, modifiers);
	}

	private MethodInfo GetMethodImplCommon(string name, int genericParameterCount, BindingFlags bindingAttr, Binder binder, CallingConventions callConv, Type[] types, ParameterModifier[] modifiers)
	{
		ListBuilder<MethodInfo> methodCandidates = GetMethodCandidates(name, genericParameterCount, bindingAttr, callConv, types, allowPrefixLookup: false);
		if (methodCandidates.Count == 0)
		{
			return null;
		}
		MethodBase[] match;
		if (types == null || types.Length == 0)
		{
			MethodInfo methodInfo = methodCandidates[0];
			if (methodCandidates.Count == 1)
			{
				return methodInfo;
			}
			if (types == null)
			{
				for (int i = 1; i < methodCandidates.Count; i++)
				{
					if (!System.DefaultBinder.CompareMethodSig(methodCandidates[i], methodInfo))
					{
						throw new AmbiguousMatchException("Ambiguous match found.");
					}
				}
				match = methodCandidates.ToArray();
				return System.DefaultBinder.FindMostDerivedNewSlotMeth(match, methodCandidates.Count) as MethodInfo;
			}
		}
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		Binder binder2 = binder;
		match = methodCandidates.ToArray();
		return binder2.SelectMethod(bindingAttr, match, types, modifiers) as MethodInfo;
	}

	private ListBuilder<MethodInfo> GetMethodCandidates(string name, int genericParameterCount, BindingFlags bindingAttr, CallingConventions callConv, Type[] types, bool allowPrefixLookup)
	{
		FilterHelper(bindingAttr, ref name, allowPrefixLookup, out var prefixLookup, out var ignoreCase, out var listType);
		RuntimeMethodInfo[] methodsByName = GetMethodsByName(name, bindingAttr, listType, this);
		ListBuilder<MethodInfo> result = new ListBuilder<MethodInfo>(methodsByName.Length);
		foreach (RuntimeMethodInfo runtimeMethodInfo in methodsByName)
		{
			if ((genericParameterCount == -1 || genericParameterCount == runtimeMethodInfo.GenericParameterCount) && FilterApplyMethodInfo(runtimeMethodInfo, bindingAttr, callConv, types) && (!prefixLookup || FilterApplyPrefixLookup(runtimeMethodInfo, name, ignoreCase)))
			{
				result.Add(runtimeMethodInfo);
			}
		}
		return result;
	}
}
