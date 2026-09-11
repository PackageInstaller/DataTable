using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace MessagePack.Internal;

internal class ObjectSerializationInfo
{
	public class EmittableMemberAndConstructorParameter
	{
		public EmittableMember MemberInfo { get; set; }

		public ParameterInfo ConstructorParameter { get; set; }
	}

	public class EmittableMember
	{
		private readonly bool dynamicMethod;

		public bool IsProperty => PropertyInfo != null;

		public bool IsField => FieldInfo != null;

		public bool IsWritable { get; set; }

		public bool IsInitOnly => PropertyInfo?.GetSetMethod(nonPublic: true)?.ReturnParameter.GetRequiredCustomModifiers().Any((Type modifierType) => modifierType.FullName == "System.Runtime.CompilerServices.IsExternalInit") == true;

		public bool IsReadable { get; set; }

		public int IntKey { get; set; }

		public string StringKey { get; set; }

		public Type Type
		{
			get
			{
				if (!IsField)
				{
					return PropertyInfo.PropertyType;
				}
				return FieldInfo.FieldType;
			}
		}

		public FieldInfo FieldInfo { get; set; }

		public PropertyInfo PropertyInfo { get; set; }

		public string Name
		{
			get
			{
				if (!IsProperty)
				{
					return FieldInfo.Name;
				}
				return PropertyInfo.Name;
			}
		}

		public bool IsValueType => (IsProperty ? PropertyInfo.PropertyType : FieldInfo.FieldType).IsValueType;

		public bool IsExplicitContract { get; set; }

		internal bool IsActuallyWritable
		{
			get
			{
				if (IsWritable)
				{
					if (!dynamicMethod)
					{
						return !IsProblematicInitProperty;
					}
					return true;
				}
				return false;
			}
		}

		internal bool IsProblematicInitProperty
		{
			get
			{
				PropertyInfo propertyInfo = PropertyInfo;
				if ((object)propertyInfo != null && propertyInfo.DeclaringType.IsGenericType)
				{
					return IsInitOnly;
				}
				return false;
			}
		}

		internal EmittableMember(bool dynamicMethod)
		{
			this.dynamicMethod = dynamicMethod;
		}

		public MessagePackFormatterAttribute GetMessagePackFormatterAttribute()
		{
			if (IsProperty)
			{
				return PropertyInfo.GetCustomAttribute<MessagePackFormatterAttribute>(inherit: true);
			}
			return FieldInfo.GetCustomAttribute<MessagePackFormatterAttribute>(inherit: true);
		}

		public DataMemberAttribute GetDataMemberAttribute()
		{
			if (IsProperty)
			{
				return PropertyInfo.GetCustomAttribute<DataMemberAttribute>(inherit: true);
			}
			return FieldInfo.GetCustomAttribute<DataMemberAttribute>(inherit: true);
		}

		public void EmitLoadValue(ILGenerator il)
		{
			if (IsProperty)
			{
				il.EmitCall(PropertyInfo.GetGetMethod(nonPublic: true));
			}
			else
			{
				il.Emit(OpCodes.Ldfld, FieldInfo);
			}
		}

		public void EmitStoreValue(ILGenerator il)
		{
			if (IsProperty)
			{
				il.EmitCall(PropertyInfo.GetSetMethod(nonPublic: true));
			}
			else
			{
				il.Emit(OpCodes.Stfld, FieldInfo);
			}
		}

		internal void ThrowIfNotWritable()
		{
			if (IsProblematicInitProperty && !dynamicMethod)
			{
				throw new InitAccessorInGenericClassNotSupportedException("`init` property accessor " + PropertyInfo.SetMethod.DeclaringType.FullName + "." + PropertyInfo.Name + " found in generic type, which is not supported with the DynamicObjectResolver. Use the AllowPrivate variety of the resolver instead. See https://github.com/neuecc/MessagePack-CSharp/issues/1134 for details.");
			}
		}
	}

	private class OrderBaseTypesBeforeDerivedTypes : IComparer<Type>
	{
		internal static readonly OrderBaseTypesBeforeDerivedTypes Instance = new OrderBaseTypesBeforeDerivedTypes();

		private OrderBaseTypesBeforeDerivedTypes()
		{
		}

		public int Compare(Type x, Type y)
		{
			if (!x.IsEquivalentTo(y))
			{
				if (!x.IsAssignableFrom(y))
				{
					if (!y.IsAssignableFrom(x))
					{
						return 0;
					}
					return 1;
				}
				return -1;
			}
			return 0;
		}
	}

	public Type Type { get; set; }

	public bool IsIntKey { get; set; }

	public bool IsStringKey => !IsIntKey;

	public bool IsClass { get; set; }

	public bool IsStruct => !IsClass;

	public bool ShouldUseFormatterResolver { get; private set; }

	public ConstructorInfo BestmatchConstructor { get; set; }

	public EmittableMemberAndConstructorParameter[] ConstructorParameters { get; set; }

	public EmittableMember[] Members { get; set; }

	private ObjectSerializationInfo()
	{
	}

	public static ObjectSerializationInfo CreateOrNull(Type type, bool forceStringKey, bool contractless, bool allowPrivate, bool dynamicMethod)
	{
		TypeInfo typeInfo = type.GetTypeInfo();
		bool isClass = typeInfo.IsClass || typeInfo.IsInterface || typeInfo.IsAbstract;
		bool isValueType = typeInfo.IsValueType;
		MessagePackObjectAttribute messagePackObjectAttribute = typeInfo.GetCustomAttributes<MessagePackObjectAttribute>().FirstOrDefault();
		DataContractAttribute customAttribute = typeInfo.GetCustomAttribute<DataContractAttribute>();
		if (messagePackObjectAttribute == null && customAttribute == null && !forceStringKey && !contractless)
		{
			return null;
		}
		bool flag = true;
		Dictionary<int, EmittableMember> dictionary = new Dictionary<int, EmittableMember>();
		Dictionary<string, EmittableMember> dictionary2 = new Dictionary<string, EmittableMember>();
		if ((forceStringKey | contractless) || (messagePackObjectAttribute != null && messagePackObjectAttribute.KeyAsPropertyName))
		{
			flag = !forceStringKey && (messagePackObjectAttribute == null || !messagePackObjectAttribute.KeyAsPropertyName);
			int num = 0;
			foreach (IGrouping<string, MemberInfo> item in from m in type.GetRuntimeProperties().Concat(type.GetRuntimeFields().Cast<MemberInfo>()).OrderBy((MemberInfo m) => m.DeclaringType, OrderBaseTypesBeforeDerivedTypes.Instance)
				group m by m.Name)
			{
				bool flag2 = true;
				foreach (MemberInfo item2 in item)
				{
					if (item2.GetCustomAttribute<IgnoreMemberAttribute>(inherit: true) != null || item2.GetCustomAttribute<IgnoreDataMemberAttribute>(inherit: true) != null)
					{
						continue;
					}
					EmittableMember emittableMember;
					if (item2 is PropertyInfo propertyInfo)
					{
						if (propertyInfo.IsIndexer())
						{
							continue;
						}
						MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
						MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
						emittableMember = new EmittableMember(dynamicMethod)
						{
							PropertyInfo = propertyInfo,
							IsReadable = (getMethod != null && (allowPrivate || getMethod.IsPublic) && !getMethod.IsStatic),
							IsWritable = (setMethod != null && (allowPrivate || setMethod.IsPublic) && !setMethod.IsStatic),
							StringKey = (flag2 ? item2.Name : (item2.DeclaringType.FullName + "." + item2.Name))
						};
					}
					else
					{
						if (!(item2 is FieldInfo fieldInfo))
						{
							throw new MessagePackSerializationException("unexpected member type");
						}
						if (item2.GetCustomAttribute<CompilerGeneratedAttribute>(inherit: true) != null || fieldInfo.IsStatic)
						{
							continue;
						}
						emittableMember = new EmittableMember(dynamicMethod)
						{
							FieldInfo = fieldInfo,
							IsReadable = (allowPrivate || fieldInfo.IsPublic),
							IsWritable = (allowPrivate || (fieldInfo.IsPublic && !fieldInfo.IsInitOnly)),
							StringKey = (flag2 ? item2.Name : (item2.DeclaringType.FullName + "." + item2.Name))
						};
					}
					if (emittableMember.IsReadable || emittableMember.IsWritable)
					{
						emittableMember.IntKey = num++;
						if (flag)
						{
							dictionary.Add(emittableMember.IntKey, emittableMember);
						}
						else
						{
							dictionary2.Add(emittableMember.StringKey, emittableMember);
						}
						flag2 = false;
					}
				}
			}
		}
		else
		{
			bool flag3 = true;
			int num2 = 0;
			foreach (PropertyInfo allProperty in GetAllProperties(type))
			{
				if (allProperty.GetCustomAttribute<IgnoreMemberAttribute>(inherit: true) != null || allProperty.GetCustomAttribute<IgnoreDataMemberAttribute>(inherit: true) != null || allProperty.IsIndexer())
				{
					continue;
				}
				MethodInfo getMethod2 = allProperty.GetGetMethod(nonPublic: true);
				MethodInfo setMethod2 = allProperty.GetSetMethod(nonPublic: true);
				EmittableMember emittableMember2 = new EmittableMember(dynamicMethod)
				{
					PropertyInfo = allProperty,
					IsReadable = (getMethod2 != null && (allowPrivate || getMethod2.IsPublic) && !getMethod2.IsStatic),
					IsWritable = (setMethod2 != null && (allowPrivate || setMethod2.IsPublic) && !setMethod2.IsStatic)
				};
				if (!emittableMember2.IsReadable && !emittableMember2.IsWritable)
				{
					continue;
				}
				KeyAttribute keyAttribute;
				if (messagePackObjectAttribute != null)
				{
					keyAttribute = allProperty.GetCustomAttribute<KeyAttribute>(inherit: true);
					if (keyAttribute == null)
					{
						throw new MessagePackDynamicObjectResolverException("all public members must mark KeyAttribute or IgnoreMemberAttribute. type: " + type.FullName + " member:" + allProperty.Name);
					}
					emittableMember2.IsExplicitContract = true;
					if (!keyAttribute.IntKey.HasValue && keyAttribute.StringKey == null)
					{
						throw new MessagePackDynamicObjectResolverException("both IntKey and StringKey are null. type: " + type.FullName + " member:" + allProperty.Name);
					}
				}
				else
				{
					DataMemberAttribute customAttribute2 = allProperty.GetCustomAttribute<DataMemberAttribute>(inherit: true);
					if (customAttribute2 == null)
					{
						continue;
					}
					emittableMember2.IsExplicitContract = true;
					keyAttribute = ((customAttribute2.Order != -1) ? new KeyAttribute(customAttribute2.Order) : ((customAttribute2.Name == null) ? new KeyAttribute(allProperty.Name) : new KeyAttribute(customAttribute2.Name)));
				}
				if (flag3)
				{
					flag3 = false;
					flag = keyAttribute.IntKey.HasValue;
				}
				else if ((flag && !keyAttribute.IntKey.HasValue) || (!flag && keyAttribute.StringKey == null))
				{
					throw new MessagePackDynamicObjectResolverException("all members key type must be same. type: " + type.FullName + " member:" + allProperty.Name);
				}
				if (flag)
				{
					emittableMember2.IntKey = keyAttribute.IntKey.Value;
					if (dictionary.TryGetValue(emittableMember2.IntKey, out var value))
					{
						MethodInfo setMethod3 = value.PropertyInfo.SetMethod;
						if ((object)setMethod3 == null || !setMethod3.IsVirtual)
						{
							MethodInfo getMethod3 = value.PropertyInfo.GetMethod;
							if ((object)getMethod3 == null || !getMethod3.IsVirtual)
							{
								throw new MessagePackDynamicObjectResolverException("key is duplicated, all members key must be unique. type: " + type.FullName + " member:" + allProperty.Name);
							}
						}
					}
					else
					{
						dictionary.Add(emittableMember2.IntKey, emittableMember2);
					}
					continue;
				}
				emittableMember2.StringKey = keyAttribute.StringKey;
				if (dictionary2.TryGetValue(emittableMember2.StringKey, out var value2))
				{
					MethodInfo setMethod4 = value2.PropertyInfo.SetMethod;
					if ((object)setMethod4 == null || !setMethod4.IsVirtual)
					{
						MethodInfo getMethod4 = value2.PropertyInfo.GetMethod;
						if ((object)getMethod4 == null || !getMethod4.IsVirtual)
						{
							throw new MessagePackDynamicObjectResolverException("key is duplicated, all members key must be unique. type: " + type.FullName + " member:" + allProperty.Name);
						}
					}
				}
				else
				{
					emittableMember2.IntKey = num2++;
					dictionary2.Add(emittableMember2.StringKey, emittableMember2);
				}
			}
			foreach (FieldInfo allField in GetAllFields(type))
			{
				if (allField.GetCustomAttribute<IgnoreMemberAttribute>(inherit: true) != null || allField.GetCustomAttribute<IgnoreDataMemberAttribute>(inherit: true) != null || allField.GetCustomAttribute<CompilerGeneratedAttribute>(inherit: true) != null || allField.IsStatic)
				{
					continue;
				}
				EmittableMember emittableMember3 = new EmittableMember(dynamicMethod)
				{
					FieldInfo = allField,
					IsReadable = (allowPrivate || allField.IsPublic),
					IsWritable = (allowPrivate || (allField.IsPublic && !allField.IsInitOnly))
				};
				if (!emittableMember3.IsReadable && !emittableMember3.IsWritable)
				{
					continue;
				}
				KeyAttribute keyAttribute2;
				if (messagePackObjectAttribute != null)
				{
					keyAttribute2 = allField.GetCustomAttribute<KeyAttribute>(inherit: true);
					if (keyAttribute2 == null)
					{
						throw new MessagePackDynamicObjectResolverException("all public members must mark KeyAttribute or IgnoreMemberAttribute. type: " + type.FullName + " member:" + allField.Name);
					}
					emittableMember3.IsExplicitContract = true;
					if (!keyAttribute2.IntKey.HasValue && keyAttribute2.StringKey == null)
					{
						throw new MessagePackDynamicObjectResolverException("both IntKey and StringKey are null. type: " + type.FullName + " member:" + allField.Name);
					}
				}
				else
				{
					DataMemberAttribute customAttribute3 = allField.GetCustomAttribute<DataMemberAttribute>(inherit: true);
					if (customAttribute3 == null)
					{
						continue;
					}
					emittableMember3.IsExplicitContract = true;
					keyAttribute2 = ((customAttribute3.Order != -1) ? new KeyAttribute(customAttribute3.Order) : ((customAttribute3.Name == null) ? new KeyAttribute(allField.Name) : new KeyAttribute(customAttribute3.Name)));
				}
				if (flag3)
				{
					flag3 = false;
					flag = keyAttribute2.IntKey.HasValue;
				}
				else if ((flag && !keyAttribute2.IntKey.HasValue) || (!flag && keyAttribute2.StringKey == null))
				{
					throw new MessagePackDynamicObjectResolverException("all members key type must be same. type: " + type.FullName + " member:" + allField.Name);
				}
				if (flag)
				{
					emittableMember3.IntKey = keyAttribute2.IntKey.Value;
					if (dictionary.ContainsKey(emittableMember3.IntKey))
					{
						throw new MessagePackDynamicObjectResolverException("key is duplicated, all members key must be unique. type: " + type.FullName + " member:" + allField.Name);
					}
					dictionary.Add(emittableMember3.IntKey, emittableMember3);
					continue;
				}
				emittableMember3.StringKey = keyAttribute2.StringKey;
				if (dictionary2.ContainsKey(emittableMember3.StringKey))
				{
					throw new MessagePackDynamicObjectResolverException("key is duplicated, all members key must be unique. type: " + type.FullName + " member:" + allField.Name);
				}
				emittableMember3.IntKey = num2++;
				dictionary2.Add(emittableMember3.StringKey, emittableMember3);
			}
		}
		IEnumerator<ConstructorInfo> enumerator5 = null;
		ConstructorInfo ctor = typeInfo.DeclaredConstructors.SingleOrDefault((ConstructorInfo x) => x.GetCustomAttribute<SerializationConstructorAttribute>(inherit: false) != null);
		if (ctor == null)
		{
			enumerator5 = (from x in typeInfo.DeclaredConstructors
				where !x.IsStatic && (allowPrivate || x.IsPublic)
				orderby x.GetParameters().Length descending
				select x).GetEnumerator();
			if (enumerator5.MoveNext())
			{
				ctor = enumerator5.Current;
			}
		}
		if (ctor == null && !isValueType)
		{
			throw new MessagePackDynamicObjectResolverException("can't find public constructor. type:" + type.FullName);
		}
		List<EmittableMemberAndConstructorParameter> constructorParameters = new List<EmittableMemberAndConstructorParameter>();
		if (ctor != null)
		{
			ILookup<string, KeyValuePair<string, EmittableMember>> lookup = dictionary2.ToLookup((KeyValuePair<string, EmittableMember> x) => x.Key, (KeyValuePair<string, EmittableMember> x) => x, StringComparer.OrdinalIgnoreCase);
			ILookup<string, KeyValuePair<string, EmittableMember>> lookup2 = dictionary2.ToLookup((KeyValuePair<string, EmittableMember> x) => x.Value.Name, (KeyValuePair<string, EmittableMember> x) => x, StringComparer.OrdinalIgnoreCase);
			do
			{
				constructorParameters.Clear();
				int num3 = 0;
				ParameterInfo[] parameters = ctor.GetParameters();
				foreach (ParameterInfo parameterInfo in parameters)
				{
					EmittableMember value3;
					if (flag)
					{
						if (!dictionary.TryGetValue(num3, out value3))
						{
							if (enumerator5 != null)
							{
								ctor = null;
								continue;
							}
							throw new MessagePackDynamicObjectResolverException("can't find matched constructor parameter, index not found. type:" + type.FullName + " parameterIndex:" + num3);
						}
						if ((!(parameterInfo.ParameterType == value3.Type) && !parameterInfo.ParameterType.GetTypeInfo().IsAssignableFrom(value3.Type)) || !value3.IsReadable)
						{
							if (enumerator5 != null)
							{
								ctor = null;
								continue;
							}
							throw new MessagePackDynamicObjectResolverException("can't find matched constructor parameter, parameterType mismatch. type:" + type.FullName + " parameterIndex:" + num3 + " paramterType:" + parameterInfo.ParameterType.Name);
						}
						constructorParameters.Add(new EmittableMemberAndConstructorParameter
						{
							ConstructorParameter = parameterInfo,
							MemberInfo = value3
						});
					}
					else
					{
						IEnumerable<KeyValuePair<string, EmittableMember>> source = lookup[parameterInfo.Name];
						IEnumerable<KeyValuePair<string, EmittableMember>> enumerable = lookup2[parameterInfo.Name];
						int num5 = source.Count();
						int num6 = enumerable.Count();
						int num7 = num5;
						if (num5 == 0 && num6 != 0)
						{
							num7 = num6;
							source = enumerable;
						}
						switch (num7)
						{
						default:
							if (enumerator5 != null)
							{
								ctor = null;
								continue;
							}
							throw new MessagePackDynamicObjectResolverException("duplicate matched constructor parameter name:" + type.FullName + " parameterName:" + parameterInfo.Name + " paramterType:" + parameterInfo.ParameterType.Name);
						case 1:
							break;
						case 0:
							if (enumerator5 != null)
							{
								ctor = null;
								continue;
							}
							throw new MessagePackDynamicObjectResolverException("can't find matched constructor parameter, index not found. type:" + type.FullName + " parameterName:" + parameterInfo.Name);
						}
						value3 = source.First().Value;
						if (!parameterInfo.ParameterType.IsAssignableFrom(value3.Type) || !value3.IsReadable)
						{
							if (enumerator5 != null)
							{
								ctor = null;
								continue;
							}
							throw new MessagePackDynamicObjectResolverException("can't find matched constructor parameter, parameterType mismatch. type:" + type.FullName + " parameterName:" + parameterInfo.Name + " paramterType:" + parameterInfo.ParameterType.Name);
						}
						constructorParameters.Add(new EmittableMemberAndConstructorParameter
						{
							ConstructorParameter = parameterInfo,
							MemberInfo = value3
						});
					}
					num3++;
				}
			}
			while (TryGetNextConstructor(enumerator5, ref ctor));
			if (ctor == null)
			{
				throw new MessagePackDynamicObjectResolverException("can't find matched constructor. type:" + type.FullName);
			}
		}
		EmittableMember[] source2 = ((!flag) ? dictionary2.Values.OrderBy((EmittableMember x) => x.GetDataMemberAttribute()?.Order ?? int.MaxValue).ToArray() : dictionary.Values.OrderBy((EmittableMember x) => x.IntKey).ToArray());
		bool shouldUseFormatterResolver = false;
		EmittableMember[] array = source2.Where((EmittableMember m) => m.IsExplicitContract || constructorParameters.Any((EmittableMemberAndConstructorParameter p) => p.MemberInfo.Equals(m)) || m.IsWritable).ToArray();
		EmittableMember[] array2 = array;
		foreach (EmittableMember emittableMember4 in array2)
		{
			if (!IsOptimizeTargetType(emittableMember4.Type) && emittableMember4.GetMessagePackFormatterAttribute() == null)
			{
				shouldUseFormatterResolver = true;
				break;
			}
		}
		if (!allowPrivate)
		{
			array.Where((EmittableMember m) => m.IsProblematicInitProperty && !constructorParameters.Any((EmittableMemberAndConstructorParameter cp) => cp.MemberInfo == m)).FirstOrDefault()?.ThrowIfNotWritable();
		}
		return new ObjectSerializationInfo
		{
			Type = type,
			IsClass = isClass,
			ShouldUseFormatterResolver = shouldUseFormatterResolver,
			BestmatchConstructor = ctor,
			ConstructorParameters = constructorParameters.ToArray(),
			IsIntKey = flag,
			Members = array
		};
	}

	internal static bool IsOptimizeTargetType(Type type)
	{
		if (!(type == typeof(short)) && !(type == typeof(int)) && !(type == typeof(long)) && !(type == typeof(ushort)) && !(type == typeof(uint)) && !(type == typeof(ulong)) && !(type == typeof(float)) && !(type == typeof(double)) && !(type == typeof(bool)) && !(type == typeof(byte)) && !(type == typeof(sbyte)) && !(type == typeof(char)))
		{
			return type == typeof(byte[]);
		}
		return true;
	}

	private static IEnumerable<FieldInfo> GetAllFields(Type type)
	{
		if ((object)type.BaseType != null)
		{
			foreach (FieldInfo allField in GetAllFields(type.BaseType))
			{
				yield return allField;
			}
		}
		FieldInfo[] fields = type.GetFields(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		for (int i = 0; i < fields.Length; i++)
		{
			yield return fields[i];
		}
	}

	private static IEnumerable<PropertyInfo> GetAllProperties(Type type)
	{
		if ((object)type.BaseType != null)
		{
			foreach (PropertyInfo allProperty in GetAllProperties(type.BaseType))
			{
				yield return allProperty;
			}
		}
		PropertyInfo[] properties = type.GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		for (int i = 0; i < properties.Length; i++)
		{
			yield return properties[i];
		}
	}

	private static bool TryGetNextConstructor(IEnumerator<ConstructorInfo> ctorEnumerator, ref ConstructorInfo ctor)
	{
		if (ctorEnumerator == null || ctor != null)
		{
			return false;
		}
		if (ctorEnumerator.MoveNext())
		{
			ctor = ctorEnumerator.Current;
			return true;
		}
		ctor = null;
		return false;
	}
}
