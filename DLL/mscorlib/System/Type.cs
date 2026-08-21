using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using Unity;

namespace System;

[Serializable]
public abstract class Type : MemberInfo, IReflect, _Type
{
	private static volatile Binder s_defaultBinder;

	public static readonly char Delimiter = '.';

	public static readonly Type[] EmptyTypes = Array.Empty<Type>();

	public static readonly object Missing = System.Reflection.Missing.Value;

	public static readonly MemberFilter FilterAttribute = FilterAttributeImpl;

	public static readonly MemberFilter FilterName = FilterNameImpl;

	public static readonly MemberFilter FilterNameIgnoreCase = FilterNameIgnoreCaseImpl;

	private const BindingFlags DefaultLookup = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public;

	internal RuntimeTypeHandle _impl;

	internal const string DefaultTypeNameWhenMissingMetadata = "UnknownType";

	public virtual bool IsSerializable
	{
		get
		{
			if ((GetAttributeFlagsImpl() & TypeAttributes.Serializable) != TypeAttributes.NotPublic)
			{
				return true;
			}
			Type type = UnderlyingSystemType;
			if (type.IsRuntimeImplemented())
			{
				do
				{
					if (type == typeof(Delegate) || type == typeof(Enum))
					{
						return true;
					}
					type = type.BaseType;
				}
				while (type != null);
			}
			return false;
		}
	}

	public virtual bool ContainsGenericParameters
	{
		get
		{
			if (HasElementType)
			{
				return GetRootElementType().ContainsGenericParameters;
			}
			if (IsGenericParameter)
			{
				return true;
			}
			if (!IsGenericType)
			{
				return false;
			}
			Type[] genericArguments = GetGenericArguments();
			for (int i = 0; i < genericArguments.Length; i++)
			{
				if (genericArguments[i].ContainsGenericParameters)
				{
					return true;
				}
			}
			return false;
		}
	}

	public bool IsVisible
	{
		get
		{
			if (IsGenericParameter)
			{
				return true;
			}
			if (HasElementType)
			{
				return GetElementType().IsVisible;
			}
			Type type = this;
			while (type.IsNested)
			{
				if (!type.IsNestedPublic)
				{
					return false;
				}
				type = type.DeclaringType;
			}
			if (!type.IsPublic)
			{
				return false;
			}
			if (IsGenericType && !IsGenericTypeDefinition)
			{
				Type[] genericArguments = GetGenericArguments();
				for (int i = 0; i < genericArguments.Length; i++)
				{
					if (!genericArguments[i].IsVisible)
					{
						return false;
					}
				}
			}
			return true;
		}
	}

	public override MemberTypes MemberType => MemberTypes.TypeInfo;

	public abstract string Namespace { get; }

	public abstract string AssemblyQualifiedName { get; }

	public abstract string FullName { get; }

	public abstract Assembly Assembly { get; }

	public new abstract Module Module { get; }

	public bool IsNested => DeclaringType != null;

	public override Type DeclaringType => null;

	public virtual MethodBase DeclaringMethod => null;

	public override Type ReflectedType => null;

	public abstract Type UnderlyingSystemType { get; }

	public virtual bool IsTypeDefinition
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public bool IsArray => IsArrayImpl();

	public bool IsByRef => IsByRefImpl();

	public bool IsPointer => IsPointerImpl();

	public virtual bool IsConstructedGenericType
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool IsGenericParameter => false;

	public virtual bool IsGenericTypeParameter
	{
		get
		{
			if (IsGenericParameter)
			{
				return DeclaringMethod == null;
			}
			return false;
		}
	}

	public virtual bool IsGenericMethodParameter
	{
		get
		{
			if (IsGenericParameter)
			{
				return DeclaringMethod != null;
			}
			return false;
		}
	}

	public virtual bool IsGenericType => false;

	public virtual bool IsGenericTypeDefinition => false;

	public virtual bool IsSZArray
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool IsVariableBoundArray
	{
		get
		{
			if (IsArray)
			{
				return !IsSZArray;
			}
			return false;
		}
	}

	public virtual bool IsByRefLike
	{
		get
		{
			throw new NotSupportedException("Derived classes must provide an implementation.");
		}
	}

	public bool HasElementType => HasElementTypeImpl();

	public virtual Type[] GenericTypeArguments
	{
		get
		{
			if (!IsGenericType || IsGenericTypeDefinition)
			{
				return Array.Empty<Type>();
			}
			return GetGenericArguments();
		}
	}

	public virtual int GenericParameterPosition
	{
		get
		{
			throw new InvalidOperationException("Method may only be called on a Type for which Type.IsGenericParameter is true.");
		}
	}

	public virtual GenericParameterAttributes GenericParameterAttributes
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public TypeAttributes Attributes => GetAttributeFlagsImpl();

	public bool IsAbstract => (GetAttributeFlagsImpl() & TypeAttributes.Abstract) != 0;

	public bool IsImport => (GetAttributeFlagsImpl() & TypeAttributes.Import) != 0;

	public bool IsSealed => (GetAttributeFlagsImpl() & TypeAttributes.Sealed) != 0;

	public bool IsSpecialName => (GetAttributeFlagsImpl() & TypeAttributes.SpecialName) != 0;

	public bool IsClass
	{
		get
		{
			if ((GetAttributeFlagsImpl() & TypeAttributes.ClassSemanticsMask) == 0)
			{
				return !IsValueType;
			}
			return false;
		}
	}

	public bool IsNestedAssembly => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.NestedAssembly;

	public bool IsNestedFamANDAssem => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.NestedFamANDAssem;

	public bool IsNestedFamily => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.NestedFamily;

	public bool IsNestedFamORAssem => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.VisibilityMask;

	public bool IsNestedPrivate => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.NestedPrivate;

	public bool IsNestedPublic => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.NestedPublic;

	public bool IsNotPublic => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == 0;

	public bool IsPublic => (GetAttributeFlagsImpl() & TypeAttributes.VisibilityMask) == TypeAttributes.Public;

	public bool IsAutoLayout => (GetAttributeFlagsImpl() & TypeAttributes.LayoutMask) == 0;

	public bool IsExplicitLayout => (GetAttributeFlagsImpl() & TypeAttributes.LayoutMask) == TypeAttributes.ExplicitLayout;

	public bool IsLayoutSequential => (GetAttributeFlagsImpl() & TypeAttributes.LayoutMask) == TypeAttributes.SequentialLayout;

	public bool IsAnsiClass => (GetAttributeFlagsImpl() & TypeAttributes.StringFormatMask) == 0;

	public bool IsAutoClass => (GetAttributeFlagsImpl() & TypeAttributes.StringFormatMask) == TypeAttributes.AutoClass;

	public bool IsUnicodeClass => (GetAttributeFlagsImpl() & TypeAttributes.StringFormatMask) == TypeAttributes.UnicodeClass;

	public bool IsCOMObject => IsCOMObjectImpl();

	public bool IsContextful => IsContextfulImpl();

	public virtual bool IsCollectible => true;

	public virtual bool IsEnum => IsSubclassOf(typeof(Enum));

	public bool IsMarshalByRef => IsMarshalByRefImpl();

	public bool IsPrimitive => IsPrimitiveImpl();

	public bool IsValueType => IsValueTypeImpl();

	public virtual bool IsSignatureType => false;

	public virtual bool IsSecurityCritical
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool IsSecuritySafeCritical
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool IsSecurityTransparent
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual StructLayoutAttribute StructLayoutAttribute
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public ConstructorInfo TypeInitializer => GetConstructorImpl(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, CallingConventions.Any, EmptyTypes, null);

	public virtual RuntimeTypeHandle TypeHandle
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public abstract Guid GUID { get; }

	public abstract Type BaseType { get; }

	public static Binder DefaultBinder
	{
		get
		{
			if (s_defaultBinder == null)
			{
				DefaultBinder value = new DefaultBinder();
				Interlocked.CompareExchange(ref s_defaultBinder, value, null);
			}
			return s_defaultBinder;
		}
	}

	internal virtual bool IsUserType => true;

	internal virtual bool IsSzArray => false;

	public bool IsInterface
	{
		get
		{
			RuntimeType runtimeType = this as RuntimeType;
			if (runtimeType != null)
			{
				return RuntimeTypeHandle.IsInterface(runtimeType);
			}
			return (GetAttributeFlagsImpl() & TypeAttributes.ClassSemanticsMask) == TypeAttributes.ClassSemanticsMask;
		}
	}

	internal string FullNameOrDefault
	{
		get
		{
			if (InternalNameIfAvailable == null)
			{
				return "UnknownType";
			}
			try
			{
				return FullName;
			}
			catch (MissingMetadataException)
			{
				return "UnknownType";
			}
		}
	}

	internal string InternalNameIfAvailable
	{
		get
		{
			Type rootCauseForFailure = null;
			return InternalGetNameIfAvailable(ref rootCauseForFailure);
		}
	}

	internal string NameOrDefault => InternalNameIfAvailable ?? "UnknownType";

	public virtual bool IsEnumDefined(object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (!IsEnum)
		{
			throw new ArgumentException("Type provided must be an Enum.", "enumType");
		}
		Type type = value.GetType();
		if (type.IsEnum)
		{
			if (!type.IsEquivalentTo(this))
			{
				throw new ArgumentException(SR.Format("Object must be the same type as the enum. The type passed in was '{0}'; the enum type was '{1}'.", type.ToString(), ToString()));
			}
			type = type.GetEnumUnderlyingType();
		}
		if (type == typeof(string))
		{
			object[] enumNames = GetEnumNames();
			if (Array.IndexOf(enumNames, value) >= 0)
			{
				return true;
			}
			return false;
		}
		if (IsIntegerType(type))
		{
			Type enumUnderlyingType = GetEnumUnderlyingType();
			if (enumUnderlyingType.GetTypeCodeImpl() != type.GetTypeCodeImpl())
			{
				throw new ArgumentException(SR.Format("Enum underlying type and the object must be same type or object must be a String. Type passed in was '{0}'; the enum underlying type was '{1}'.", type.ToString(), enumUnderlyingType.ToString()));
			}
			return BinarySearch(GetEnumRawConstantValues(), value) >= 0;
		}
		throw new InvalidOperationException("Unknown enum type.");
	}

	public virtual string GetEnumName(object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (!IsEnum)
		{
			throw new ArgumentException("Type provided must be an Enum.", "enumType");
		}
		Type type = value.GetType();
		if (!type.IsEnum && !IsIntegerType(type))
		{
			throw new ArgumentException("The value passed in must be an enum base or an underlying type for an enum, such as an Int32.", "value");
		}
		int num = BinarySearch(GetEnumRawConstantValues(), value);
		if (num >= 0)
		{
			return GetEnumNames()[num];
		}
		return null;
	}

	public virtual string[] GetEnumNames()
	{
		if (!IsEnum)
		{
			throw new ArgumentException("Type provided must be an Enum.", "enumType");
		}
		GetEnumData(out var enumNames, out var _);
		return enumNames;
	}

	private Array GetEnumRawConstantValues()
	{
		GetEnumData(out var _, out var enumValues);
		return enumValues;
	}

	private void GetEnumData(out string[] enumNames, out Array enumValues)
	{
		FieldInfo[] fields = GetFields(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		object[] array = new object[fields.Length];
		string[] array2 = new string[fields.Length];
		for (int i = 0; i < fields.Length; i++)
		{
			array2[i] = fields[i].Name;
			array[i] = fields[i].GetRawConstantValue();
		}
		IComparer comparer = Comparer<object>.Default;
		for (int j = 1; j < array.Length; j++)
		{
			int num = j;
			string text = array2[j];
			object obj = array[j];
			bool flag = false;
			while (comparer.Compare(array[num - 1], obj) > 0)
			{
				array2[num] = array2[num - 1];
				array[num] = array[num - 1];
				num--;
				flag = true;
				if (num == 0)
				{
					break;
				}
			}
			if (flag)
			{
				array2[num] = text;
				array[num] = obj;
			}
		}
		enumNames = array2;
		enumValues = array;
	}

	private static int BinarySearch(Array array, object value)
	{
		ulong[] array2 = new ulong[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array2[i] = Enum.ToUInt64(array.GetValue(i));
		}
		ulong value2 = Enum.ToUInt64(value);
		return Array.BinarySearch(array2, value2);
	}

	internal static bool IsIntegerType(Type t)
	{
		if (!(t == typeof(int)) && !(t == typeof(short)) && !(t == typeof(ushort)) && !(t == typeof(byte)) && !(t == typeof(sbyte)) && !(t == typeof(uint)) && !(t == typeof(long)) && !(t == typeof(ulong)) && !(t == typeof(char)))
		{
			return t == typeof(bool);
		}
		return true;
	}

	internal Type GetRootElementType()
	{
		Type type = this;
		while (type.HasElementType)
		{
			type = type.GetElementType();
		}
		return type;
	}

	public virtual Type[] FindInterfaces(TypeFilter filter, object filterCriteria)
	{
		if (filter == null)
		{
			throw new ArgumentNullException("filter");
		}
		Type[] interfaces = GetInterfaces();
		int num = 0;
		for (int i = 0; i < interfaces.Length; i++)
		{
			if (!filter(interfaces[i], filterCriteria))
			{
				interfaces[i] = null;
			}
			else
			{
				num++;
			}
		}
		if (num == interfaces.Length)
		{
			return interfaces;
		}
		Type[] array = new Type[num];
		num = 0;
		for (int j = 0; j < interfaces.Length; j++)
		{
			if (interfaces[j] != null)
			{
				array[num++] = interfaces[j];
			}
		}
		return array;
	}

	public virtual MemberInfo[] FindMembers(MemberTypes memberType, BindingFlags bindingAttr, MemberFilter filter, object filterCriteria)
	{
		MethodInfo[] array = null;
		ConstructorInfo[] array2 = null;
		FieldInfo[] array3 = null;
		PropertyInfo[] array4 = null;
		EventInfo[] array5 = null;
		Type[] array6 = null;
		int num = 0;
		int num2 = 0;
		if ((memberType & MemberTypes.Method) != 0)
		{
			array = GetMethods(bindingAttr);
			if (filter != null)
			{
				for (num = 0; num < array.Length; num++)
				{
					if (!filter(array[num], filterCriteria))
					{
						array[num] = null;
					}
					else
					{
						num2++;
					}
				}
			}
			else
			{
				num2 += array.Length;
			}
		}
		if ((memberType & MemberTypes.Constructor) != 0)
		{
			array2 = GetConstructors(bindingAttr);
			if (filter != null)
			{
				for (num = 0; num < array2.Length; num++)
				{
					if (!filter(array2[num], filterCriteria))
					{
						array2[num] = null;
					}
					else
					{
						num2++;
					}
				}
			}
			else
			{
				num2 += array2.Length;
			}
		}
		if ((memberType & MemberTypes.Field) != 0)
		{
			array3 = GetFields(bindingAttr);
			if (filter != null)
			{
				for (num = 0; num < array3.Length; num++)
				{
					if (!filter(array3[num], filterCriteria))
					{
						array3[num] = null;
					}
					else
					{
						num2++;
					}
				}
			}
			else
			{
				num2 += array3.Length;
			}
		}
		if ((memberType & MemberTypes.Property) != 0)
		{
			array4 = GetProperties(bindingAttr);
			if (filter != null)
			{
				for (num = 0; num < array4.Length; num++)
				{
					if (!filter(array4[num], filterCriteria))
					{
						array4[num] = null;
					}
					else
					{
						num2++;
					}
				}
			}
			else
			{
				num2 += array4.Length;
			}
		}
		if ((memberType & MemberTypes.Event) != 0)
		{
			array5 = GetEvents(bindingAttr);
			if (filter != null)
			{
				for (num = 0; num < array5.Length; num++)
				{
					if (!filter(array5[num], filterCriteria))
					{
						array5[num] = null;
					}
					else
					{
						num2++;
					}
				}
			}
			else
			{
				num2 += array5.Length;
			}
		}
		if ((memberType & MemberTypes.NestedType) != 0)
		{
			array6 = GetNestedTypes(bindingAttr);
			if (filter != null)
			{
				for (num = 0; num < array6.Length; num++)
				{
					if (!filter(array6[num], filterCriteria))
					{
						array6[num] = null;
					}
					else
					{
						num2++;
					}
				}
			}
			else
			{
				num2 += array6.Length;
			}
		}
		MemberInfo[] array7 = new MemberInfo[num2];
		num2 = 0;
		if (array != null)
		{
			for (num = 0; num < array.Length; num++)
			{
				if (array[num] != null)
				{
					array7[num2++] = array[num];
				}
			}
		}
		if (array2 != null)
		{
			for (num = 0; num < array2.Length; num++)
			{
				if (array2[num] != null)
				{
					array7[num2++] = array2[num];
				}
			}
		}
		if (array3 != null)
		{
			for (num = 0; num < array3.Length; num++)
			{
				if (array3[num] != null)
				{
					array7[num2++] = array3[num];
				}
			}
		}
		if (array4 != null)
		{
			for (num = 0; num < array4.Length; num++)
			{
				if (array4[num] != null)
				{
					array7[num2++] = array4[num];
				}
			}
		}
		if (array5 != null)
		{
			for (num = 0; num < array5.Length; num++)
			{
				if (array5[num] != null)
				{
					array7[num2++] = array5[num];
				}
			}
		}
		if (array6 != null)
		{
			for (num = 0; num < array6.Length; num++)
			{
				if (array6[num] != null)
				{
					array7[num2++] = array6[num];
				}
			}
		}
		return array7;
	}

	[ComVisible(true)]
	public virtual bool IsSubclassOf(Type c)
	{
		Type type = this;
		if (type == c)
		{
			return false;
		}
		while (type != null)
		{
			if (type == c)
			{
				return true;
			}
			type = type.BaseType;
		}
		return false;
	}

	public virtual bool IsAssignableFrom(Type c)
	{
		if (c == null)
		{
			return false;
		}
		if (this == c)
		{
			return true;
		}
		Type underlyingSystemType = UnderlyingSystemType;
		if (underlyingSystemType.IsRuntimeImplemented())
		{
			return underlyingSystemType.IsAssignableFrom(c);
		}
		if (c.IsSubclassOf(this))
		{
			return true;
		}
		if (IsInterface)
		{
			return c.ImplementInterface(this);
		}
		if (IsGenericParameter)
		{
			Type[] genericParameterConstraints = GetGenericParameterConstraints();
			for (int i = 0; i < genericParameterConstraints.Length; i++)
			{
				if (!genericParameterConstraints[i].IsAssignableFrom(c))
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}

	internal bool ImplementInterface(Type ifaceType)
	{
		Type type = this;
		while (type != null)
		{
			Type[] interfaces = type.GetInterfaces();
			if (interfaces != null)
			{
				for (int i = 0; i < interfaces.Length; i++)
				{
					if (interfaces[i] == ifaceType || (interfaces[i] != null && interfaces[i].ImplementInterface(ifaceType)))
					{
						return true;
					}
				}
			}
			type = type.BaseType;
		}
		return false;
	}

	private static bool FilterAttributeImpl(MemberInfo m, object filterCriteria)
	{
		if (filterCriteria == null)
		{
			throw new InvalidFilterCriteriaException("An Int32 must be provided for the filter criteria.");
		}
		switch (m.MemberType)
		{
		case MemberTypes.Constructor:
		case MemberTypes.Method:
		{
			MethodAttributes methodAttributes = MethodAttributes.PrivateScope;
			try
			{
				methodAttributes = (MethodAttributes)(int)filterCriteria;
			}
			catch
			{
				throw new InvalidFilterCriteriaException("An Int32 must be provided for the filter criteria.");
			}
			MethodAttributes methodAttributes2 = ((m.MemberType != MemberTypes.Method) ? ((ConstructorInfo)m).Attributes : ((MethodInfo)m).Attributes);
			if ((methodAttributes & MethodAttributes.MemberAccessMask) != MethodAttributes.PrivateScope && (methodAttributes2 & MethodAttributes.MemberAccessMask) != (methodAttributes & MethodAttributes.MemberAccessMask))
			{
				return false;
			}
			if ((methodAttributes & MethodAttributes.Static) != MethodAttributes.PrivateScope && (methodAttributes2 & MethodAttributes.Static) == 0)
			{
				return false;
			}
			if ((methodAttributes & MethodAttributes.Final) != MethodAttributes.PrivateScope && (methodAttributes2 & MethodAttributes.Final) == 0)
			{
				return false;
			}
			if ((methodAttributes & MethodAttributes.Virtual) != MethodAttributes.PrivateScope && (methodAttributes2 & MethodAttributes.Virtual) == 0)
			{
				return false;
			}
			if ((methodAttributes & MethodAttributes.Abstract) != MethodAttributes.PrivateScope && (methodAttributes2 & MethodAttributes.Abstract) == 0)
			{
				return false;
			}
			if ((methodAttributes & MethodAttributes.SpecialName) != MethodAttributes.PrivateScope && (methodAttributes2 & MethodAttributes.SpecialName) == 0)
			{
				return false;
			}
			return true;
		}
		case MemberTypes.Field:
		{
			FieldAttributes fieldAttributes = FieldAttributes.PrivateScope;
			try
			{
				fieldAttributes = (FieldAttributes)(int)filterCriteria;
			}
			catch
			{
				throw new InvalidFilterCriteriaException("An Int32 must be provided for the filter criteria.");
			}
			FieldAttributes attributes = ((FieldInfo)m).Attributes;
			if ((fieldAttributes & FieldAttributes.FieldAccessMask) != FieldAttributes.PrivateScope && (attributes & FieldAttributes.FieldAccessMask) != (fieldAttributes & FieldAttributes.FieldAccessMask))
			{
				return false;
			}
			if ((fieldAttributes & FieldAttributes.Static) != FieldAttributes.PrivateScope && (attributes & FieldAttributes.Static) == 0)
			{
				return false;
			}
			if ((fieldAttributes & FieldAttributes.InitOnly) != FieldAttributes.PrivateScope && (attributes & FieldAttributes.InitOnly) == 0)
			{
				return false;
			}
			if ((fieldAttributes & FieldAttributes.Literal) != FieldAttributes.PrivateScope && (attributes & FieldAttributes.Literal) == 0)
			{
				return false;
			}
			if ((fieldAttributes & FieldAttributes.NotSerialized) != FieldAttributes.PrivateScope && (attributes & FieldAttributes.NotSerialized) == 0)
			{
				return false;
			}
			if ((fieldAttributes & FieldAttributes.PinvokeImpl) != FieldAttributes.PrivateScope && (attributes & FieldAttributes.PinvokeImpl) == 0)
			{
				return false;
			}
			return true;
		}
		default:
			return false;
		}
	}

	private static bool FilterNameImpl(MemberInfo m, object filterCriteria)
	{
		if (filterCriteria == null || !(filterCriteria is string))
		{
			throw new InvalidFilterCriteriaException("A String must be provided for the filter criteria.");
		}
		string text = (string)filterCriteria;
		text = text.Trim();
		string text2 = m.Name;
		if (m.MemberType == MemberTypes.NestedType)
		{
			text2 = text2.Substring(text2.LastIndexOf('+') + 1);
		}
		if (text.Length > 0 && text[text.Length - 1] == '*')
		{
			text = text.Substring(0, text.Length - 1);
			return text2.StartsWith(text, StringComparison.Ordinal);
		}
		return text2.Equals(text);
	}

	private static bool FilterNameIgnoreCaseImpl(MemberInfo m, object filterCriteria)
	{
		if (filterCriteria == null || !(filterCriteria is string))
		{
			throw new InvalidFilterCriteriaException("A String must be provided for the filter criteria.");
		}
		string text = (string)filterCriteria;
		text = text.Trim();
		string text2 = m.Name;
		if (m.MemberType == MemberTypes.NestedType)
		{
			text2 = text2.Substring(text2.LastIndexOf('+') + 1);
		}
		if (text.Length > 0 && text[text.Length - 1] == '*')
		{
			text = text.Substring(0, text.Length - 1);
			return string.Compare(text2, 0, text, 0, text.Length, StringComparison.OrdinalIgnoreCase) == 0;
		}
		return string.Compare(text, text2, StringComparison.OrdinalIgnoreCase) == 0;
	}

	public new Type GetType()
	{
		return base.GetType();
	}

	protected abstract bool IsArrayImpl();

	protected abstract bool IsByRefImpl();

	protected abstract bool IsPointerImpl();

	protected abstract bool HasElementTypeImpl();

	public abstract Type GetElementType();

	public virtual int GetArrayRank()
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual Type GetGenericTypeDefinition()
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual Type[] GetGenericArguments()
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual Type[] GetGenericParameterConstraints()
	{
		if (!IsGenericParameter)
		{
			throw new InvalidOperationException("Method may only be called on a Type for which Type.IsGenericParameter is true.");
		}
		throw new InvalidOperationException();
	}

	protected abstract TypeAttributes GetAttributeFlagsImpl();

	protected abstract bool IsCOMObjectImpl();

	protected virtual bool IsContextfulImpl()
	{
		return typeof(ContextBoundObject).IsAssignableFrom(this);
	}

	protected virtual bool IsMarshalByRefImpl()
	{
		return typeof(MarshalByRefObject).IsAssignableFrom(this);
	}

	protected abstract bool IsPrimitiveImpl();

	protected virtual bool IsValueTypeImpl()
	{
		return IsSubclassOf(typeof(ValueType));
	}

	[ComVisible(true)]
	public ConstructorInfo GetConstructor(Type[] types)
	{
		return GetConstructor(BindingFlags.Instance | BindingFlags.Public, null, types, null);
	}

	[ComVisible(true)]
	public ConstructorInfo GetConstructor(BindingFlags bindingAttr, Binder binder, Type[] types, ParameterModifier[] modifiers)
	{
		return GetConstructor(bindingAttr, binder, CallingConventions.Any, types, modifiers);
	}

	[ComVisible(true)]
	public ConstructorInfo GetConstructor(BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		if (types == null)
		{
			throw new ArgumentNullException("types");
		}
		for (int i = 0; i < types.Length; i++)
		{
			if (types[i] == null)
			{
				throw new ArgumentNullException("types");
			}
		}
		return GetConstructorImpl(bindingAttr, binder, callConvention, types, modifiers);
	}

	protected abstract ConstructorInfo GetConstructorImpl(BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers);

	[ComVisible(true)]
	public ConstructorInfo[] GetConstructors()
	{
		return GetConstructors(BindingFlags.Instance | BindingFlags.Public);
	}

	[ComVisible(true)]
	public abstract ConstructorInfo[] GetConstructors(BindingFlags bindingAttr);

	public EventInfo GetEvent(string name)
	{
		return GetEvent(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract EventInfo GetEvent(string name, BindingFlags bindingAttr);

	public virtual EventInfo[] GetEvents()
	{
		return GetEvents(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract EventInfo[] GetEvents(BindingFlags bindingAttr);

	public FieldInfo GetField(string name)
	{
		return GetField(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract FieldInfo GetField(string name, BindingFlags bindingAttr);

	public FieldInfo[] GetFields()
	{
		return GetFields(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract FieldInfo[] GetFields(BindingFlags bindingAttr);

	public MemberInfo[] GetMember(string name)
	{
		return GetMember(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public virtual MemberInfo[] GetMember(string name, BindingFlags bindingAttr)
	{
		return GetMember(name, MemberTypes.All, bindingAttr);
	}

	public virtual MemberInfo[] GetMember(string name, MemberTypes type, BindingFlags bindingAttr)
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public MemberInfo[] GetMembers()
	{
		return GetMembers(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract MemberInfo[] GetMembers(BindingFlags bindingAttr);

	public MethodInfo GetMethod(string name)
	{
		return GetMethod(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public MethodInfo GetMethod(string name, BindingFlags bindingAttr)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		return GetMethodImpl(name, bindingAttr, null, CallingConventions.Any, null, null);
	}

	public MethodInfo GetMethod(string name, Type[] types)
	{
		return GetMethod(name, types, null);
	}

	public MethodInfo GetMethod(string name, Type[] types, ParameterModifier[] modifiers)
	{
		return GetMethod(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public, null, types, modifiers);
	}

	public MethodInfo GetMethod(string name, BindingFlags bindingAttr, Binder binder, Type[] types, ParameterModifier[] modifiers)
	{
		return GetMethod(name, bindingAttr, binder, CallingConventions.Any, types, modifiers);
	}

	public MethodInfo GetMethod(string name, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (types == null)
		{
			throw new ArgumentNullException("types");
		}
		for (int i = 0; i < types.Length; i++)
		{
			if (types[i] == null)
			{
				throw new ArgumentNullException("types");
			}
		}
		return GetMethodImpl(name, bindingAttr, binder, callConvention, types, modifiers);
	}

	protected abstract MethodInfo GetMethodImpl(string name, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers);

	public MethodInfo GetMethod(string name, int genericParameterCount, Type[] types)
	{
		return GetMethod(name, genericParameterCount, types, null);
	}

	public MethodInfo GetMethod(string name, int genericParameterCount, Type[] types, ParameterModifier[] modifiers)
	{
		return GetMethod(name, genericParameterCount, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public, null, types, modifiers);
	}

	public MethodInfo GetMethod(string name, int genericParameterCount, BindingFlags bindingAttr, Binder binder, Type[] types, ParameterModifier[] modifiers)
	{
		return GetMethod(name, genericParameterCount, bindingAttr, binder, CallingConventions.Any, types, modifiers);
	}

	public MethodInfo GetMethod(string name, int genericParameterCount, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (genericParameterCount < 0)
		{
			throw new ArgumentException("Non-negative number required.", "genericParameterCount");
		}
		if (types == null)
		{
			throw new ArgumentNullException("types");
		}
		for (int i = 0; i < types.Length; i++)
		{
			if (types[i] == null)
			{
				throw new ArgumentNullException("types");
			}
		}
		return GetMethodImpl(name, genericParameterCount, bindingAttr, binder, callConvention, types, modifiers);
	}

	protected virtual MethodInfo GetMethodImpl(string name, int genericParameterCount, BindingFlags bindingAttr, Binder binder, CallingConventions callConvention, Type[] types, ParameterModifier[] modifiers)
	{
		throw new NotSupportedException();
	}

	public MethodInfo[] GetMethods()
	{
		return GetMethods(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract MethodInfo[] GetMethods(BindingFlags bindingAttr);

	public Type GetNestedType(string name)
	{
		return GetNestedType(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract Type GetNestedType(string name, BindingFlags bindingAttr);

	public Type[] GetNestedTypes()
	{
		return GetNestedTypes(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract Type[] GetNestedTypes(BindingFlags bindingAttr);

	public PropertyInfo GetProperty(string name)
	{
		return GetProperty(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public PropertyInfo GetProperty(string name, BindingFlags bindingAttr)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		return GetPropertyImpl(name, bindingAttr, null, null, null, null);
	}

	public PropertyInfo GetProperty(string name, Type returnType)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (returnType == null)
		{
			throw new ArgumentNullException("returnType");
		}
		return GetPropertyImpl(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public, null, returnType, null, null);
	}

	public PropertyInfo GetProperty(string name, Type[] types)
	{
		return GetProperty(name, null, types);
	}

	public PropertyInfo GetProperty(string name, Type returnType, Type[] types)
	{
		return GetProperty(name, returnType, types, null);
	}

	public PropertyInfo GetProperty(string name, Type returnType, Type[] types, ParameterModifier[] modifiers)
	{
		return GetProperty(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public, null, returnType, types, modifiers);
	}

	public PropertyInfo GetProperty(string name, BindingFlags bindingAttr, Binder binder, Type returnType, Type[] types, ParameterModifier[] modifiers)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (types == null)
		{
			throw new ArgumentNullException("types");
		}
		return GetPropertyImpl(name, bindingAttr, binder, returnType, types, modifiers);
	}

	protected abstract PropertyInfo GetPropertyImpl(string name, BindingFlags bindingAttr, Binder binder, Type returnType, Type[] types, ParameterModifier[] modifiers);

	public PropertyInfo[] GetProperties()
	{
		return GetProperties(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public);
	}

	public abstract PropertyInfo[] GetProperties(BindingFlags bindingAttr);

	public virtual MemberInfo[] GetDefaultMembers()
	{
		throw NotImplemented.ByDesign;
	}

	public static RuntimeTypeHandle GetTypeHandle(object o)
	{
		if (o == null)
		{
			throw new ArgumentNullException(null, "Invalid handle.");
		}
		return o.GetType().TypeHandle;
	}

	public static Type[] GetTypeArray(object[] args)
	{
		if (args == null)
		{
			throw new ArgumentNullException("args");
		}
		Type[] array = new Type[args.Length];
		for (int i = 0; i < array.Length; i++)
		{
			if (args[i] == null)
			{
				throw new ArgumentNullException();
			}
			array[i] = args[i].GetType();
		}
		return array;
	}

	public static TypeCode GetTypeCode(Type type)
	{
		if (type == null)
		{
			return TypeCode.Empty;
		}
		return type.GetTypeCodeImpl();
	}

	protected virtual TypeCode GetTypeCodeImpl()
	{
		if (this != UnderlyingSystemType && UnderlyingSystemType != null)
		{
			return GetTypeCode(UnderlyingSystemType);
		}
		return TypeCode.Object;
	}

	public static Type GetTypeFromCLSID(Guid clsid)
	{
		return GetTypeFromCLSID(clsid, null, throwOnError: false);
	}

	public static Type GetTypeFromCLSID(Guid clsid, bool throwOnError)
	{
		return GetTypeFromCLSID(clsid, null, throwOnError);
	}

	public static Type GetTypeFromCLSID(Guid clsid, string server)
	{
		return GetTypeFromCLSID(clsid, server, throwOnError: false);
	}

	public static Type GetTypeFromProgID(string progID)
	{
		return GetTypeFromProgID(progID, null, throwOnError: false);
	}

	public static Type GetTypeFromProgID(string progID, bool throwOnError)
	{
		return GetTypeFromProgID(progID, null, throwOnError);
	}

	public static Type GetTypeFromProgID(string progID, string server)
	{
		return GetTypeFromProgID(progID, server, throwOnError: false);
	}

	[DebuggerStepThrough]
	[DebuggerHidden]
	public object InvokeMember(string name, BindingFlags invokeAttr, Binder binder, object target, object[] args)
	{
		return InvokeMember(name, invokeAttr, binder, target, args, null, null, null);
	}

	[DebuggerStepThrough]
	[DebuggerHidden]
	public object InvokeMember(string name, BindingFlags invokeAttr, Binder binder, object target, object[] args, CultureInfo culture)
	{
		return InvokeMember(name, invokeAttr, binder, target, args, null, culture, null);
	}

	public abstract object InvokeMember(string name, BindingFlags invokeAttr, Binder binder, object target, object[] args, ParameterModifier[] modifiers, CultureInfo culture, string[] namedParameters);

	public Type GetInterface(string name)
	{
		return GetInterface(name, ignoreCase: false);
	}

	public abstract Type GetInterface(string name, bool ignoreCase);

	public abstract Type[] GetInterfaces();

	[ComVisible(true)]
	public virtual InterfaceMapping GetInterfaceMap(Type interfaceType)
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual bool IsInstanceOfType(object o)
	{
		if (o != null)
		{
			return IsAssignableFrom(o.GetType());
		}
		return false;
	}

	public virtual bool IsEquivalentTo(Type other)
	{
		return this == other;
	}

	public virtual Type GetEnumUnderlyingType()
	{
		if (!IsEnum)
		{
			throw new ArgumentException("Type provided must be an Enum.", "enumType");
		}
		FieldInfo[] fields = GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (fields == null || fields.Length != 1)
		{
			throw new ArgumentException("The Enum type should contain one and only one instance field.", "enumType");
		}
		return fields[0].FieldType;
	}

	public virtual Array GetEnumValues()
	{
		if (!IsEnum)
		{
			throw new ArgumentException("Type provided must be an Enum.", "enumType");
		}
		throw NotImplemented.ByDesign;
	}

	public virtual Type MakeArrayType()
	{
		throw new NotSupportedException();
	}

	public virtual Type MakeArrayType(int rank)
	{
		throw new NotSupportedException();
	}

	public virtual Type MakeByRefType()
	{
		throw new NotSupportedException();
	}

	public virtual Type MakeGenericType(params Type[] typeArguments)
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual Type MakePointerType()
	{
		throw new NotSupportedException();
	}

	public static Type MakeGenericSignatureType(Type genericTypeDefinition, params Type[] typeArguments)
	{
		return new SignatureConstructedGenericType(genericTypeDefinition, typeArguments);
	}

	public static Type MakeGenericMethodParameter(int position)
	{
		if (position < 0)
		{
			throw new ArgumentException("Non-negative number required.", "position");
		}
		return new SignatureGenericMethodParameterType(position);
	}

	public override string ToString()
	{
		return "Type: " + Name;
	}

	public override bool Equals(object o)
	{
		if (o != null)
		{
			return Equals(o as Type);
		}
		return false;
	}

	public override int GetHashCode()
	{
		Type underlyingSystemType = UnderlyingSystemType;
		if ((object)underlyingSystemType != this)
		{
			return underlyingSystemType.GetHashCode();
		}
		return base.GetHashCode();
	}

	public virtual bool Equals(Type o)
	{
		if (!(o == null))
		{
			return (object)UnderlyingSystemType == o.UnderlyingSystemType;
		}
		return false;
	}

	internal virtual Type InternalResolve()
	{
		return UnderlyingSystemType;
	}

	internal virtual Type RuntimeResolve()
	{
		throw new NotImplementedException();
	}

	internal virtual MethodInfo GetMethod(MethodInfo fromNoninstanciated)
	{
		throw new InvalidOperationException("can only be called in generic type");
	}

	internal virtual ConstructorInfo GetConstructor(ConstructorInfo fromNoninstanciated)
	{
		throw new InvalidOperationException("can only be called in generic type");
	}

	internal virtual FieldInfo GetField(FieldInfo fromNoninstanciated)
	{
		throw new InvalidOperationException("can only be called in generic type");
	}

	public static Type GetTypeFromHandle(RuntimeTypeHandle handle)
	{
		if (handle.Value == IntPtr.Zero)
		{
			return null;
		}
		return internal_from_handle(handle.Value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type internal_from_handle(IntPtr handle);

	internal virtual RuntimeTypeHandle GetTypeHandleInternal()
	{
		return TypeHandle;
	}

	internal virtual bool HasProxyAttributeImpl()
	{
		return false;
	}

	internal string FormatTypeName()
	{
		return FormatTypeName(serialization: false);
	}

	internal virtual string FormatTypeName(bool serialization)
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type GetType(string typeName, bool throwOnError, bool ignoreCase)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RuntimeType.GetType(typeName, throwOnError, ignoreCase, reflectionOnly: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type GetType(string typeName, bool throwOnError)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RuntimeType.GetType(typeName, throwOnError, ignoreCase: false, reflectionOnly: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type GetType(string typeName)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RuntimeType.GetType(typeName, throwOnError: false, ignoreCase: false, reflectionOnly: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type GetType(string typeName, Func<AssemblyName, Assembly> assemblyResolver, Func<Assembly, string, bool, Type> typeResolver)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return TypeNameParser.GetType(typeName, assemblyResolver, typeResolver, throwOnError: false, ignoreCase: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type GetType(string typeName, Func<AssemblyName, Assembly> assemblyResolver, Func<Assembly, string, bool, Type> typeResolver, bool throwOnError)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return TypeNameParser.GetType(typeName, assemblyResolver, typeResolver, throwOnError, ignoreCase: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type GetType(string typeName, Func<AssemblyName, Assembly> assemblyResolver, Func<Assembly, string, bool, Type> typeResolver, bool throwOnError, bool ignoreCase)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return TypeNameParser.GetType(typeName, assemblyResolver, typeResolver, throwOnError, ignoreCase, ref stackMark);
	}

	public static bool operator ==(Type left, Type right)
	{
		return (object)left == right;
	}

	public static bool operator !=(Type left, Type right)
	{
		return (object)left != right;
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Type ReflectionOnlyGetType(string typeName, bool throwIfNotFound, bool ignoreCase)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RuntimeType.GetType(typeName, throwIfNotFound, ignoreCase, reflectionOnly: true, ref stackMark);
	}

	public static Type GetTypeFromCLSID(Guid clsid, string server, bool throwOnError)
	{
		return RuntimeType.GetTypeFromCLSIDImpl(clsid, server, throwOnError);
	}

	public static Type GetTypeFromProgID(string progID, string server, bool throwOnError)
	{
		return RuntimeType.GetTypeFromProgIDImpl(progID, server, throwOnError);
	}

	internal bool IsRuntimeImplemented()
	{
		return UnderlyingSystemType is RuntimeType;
	}

	internal virtual string InternalGetNameIfAvailable(ref Type rootCauseForFailure)
	{
		return Name;
	}

	void _Type.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Type.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Type.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _Type.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
