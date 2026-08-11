using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;
using ES3Types;
using UnityEngine;

namespace ES3Internal;

public static class ES3Reflection
{
	public struct ES3ReflectedMember
	{
		private FieldInfo fieldInfo;

		private PropertyInfo propertyInfo;

		public bool isProperty;

		public bool IsNull
		{
			get
			{
				if (fieldInfo == null)
				{
					return propertyInfo == null;
				}
				return false;
			}
		}

		public string Name
		{
			get
			{
				if (!isProperty)
				{
					return fieldInfo.Name;
				}
				return propertyInfo.Name;
			}
		}

		public Type MemberType
		{
			get
			{
				if (!isProperty)
				{
					return fieldInfo.FieldType;
				}
				return propertyInfo.PropertyType;
			}
		}

		public bool IsPublic
		{
			get
			{
				if (!isProperty)
				{
					return fieldInfo.IsPublic;
				}
				if (propertyInfo.GetGetMethod(nonPublic: true).IsPublic)
				{
					return propertyInfo.GetSetMethod(nonPublic: true).IsPublic;
				}
				return false;
			}
		}

		public bool IsProtected
		{
			get
			{
				if (!isProperty)
				{
					return fieldInfo.IsFamily;
				}
				return propertyInfo.GetGetMethod(nonPublic: true).IsFamily;
			}
		}

		public bool IsStatic
		{
			get
			{
				if (!isProperty)
				{
					return fieldInfo.IsStatic;
				}
				return propertyInfo.GetGetMethod(nonPublic: true).IsStatic;
			}
		}

		public ES3ReflectedMember(object fieldPropertyInfo)
		{
			if (fieldPropertyInfo == null)
			{
				propertyInfo = null;
				fieldInfo = null;
				isProperty = false;
				return;
			}
			isProperty = IsAssignableFrom(typeof(PropertyInfo), fieldPropertyInfo.GetType());
			if (isProperty)
			{
				propertyInfo = (PropertyInfo)fieldPropertyInfo;
				fieldInfo = null;
			}
			else
			{
				fieldInfo = (FieldInfo)fieldPropertyInfo;
				propertyInfo = null;
			}
		}

		public void SetValue(object obj, object value)
		{
			if (isProperty)
			{
				propertyInfo.SetValue(obj, value, null);
			}
			else
			{
				fieldInfo.SetValue(obj, value);
			}
		}

		public object GetValue(object obj)
		{
			if (isProperty)
			{
				return propertyInfo.GetValue(obj, null);
			}
			return fieldInfo.GetValue(obj);
		}
	}

	public class ES3ReflectedMethod
	{
		private MethodInfo method;

		public ES3ReflectedMethod(Type type, string methodName, Type[] genericParameters, Type[] parameterTypes)
		{
			MethodInfo methodInfo = type.GetMethod(methodName, parameterTypes);
			method = methodInfo.MakeGenericMethod(genericParameters);
		}

		public ES3ReflectedMethod(Type type, string methodName, Type[] genericParameters, Type[] parameterTypes, BindingFlags bindingAttr)
		{
			MethodInfo methodInfo = type.GetMethod(methodName, bindingAttr, null, parameterTypes, null);
			method = methodInfo.MakeGenericMethod(genericParameters);
		}

		public object Invoke(object obj, object[] parameters = null)
		{
			return method.Invoke(obj, parameters);
		}
	}

	public const string memberFieldPrefix = "m_";

	public const string componentTagFieldName = "tag";

	public const string componentNameFieldName = "name";

	public static readonly string[] excludedPropertyNames = new string[3] { "runInEditMode", "useGUILayout", "hideFlags" };

	public static readonly Type serializableAttributeType = typeof(SerializableAttribute);

	public static readonly Type serializeFieldAttributeType = typeof(SerializeField);

	public static readonly Type obsoleteAttributeType = typeof(ObsoleteAttribute);

	public static readonly Type nonSerializedAttributeType = typeof(NonSerializedAttribute);

	public static readonly Type es3SerializableAttributeType = typeof(ES3Serializable);

	public static readonly Type es3NonSerializableAttributeType = typeof(ES3NonSerializable);

	public static Type[] EmptyTypes = new Type[0];

	private static Assembly[] _assemblies = null;

	private static Assembly[] Assemblies
	{
		get
		{
			if (_assemblies == null)
			{
				string[] assemblyNames = new ES3Settings().assemblyNames;
				List<Assembly> list = new List<Assembly>();
				Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
				foreach (Assembly assembly in assemblies)
				{
					try
					{
						if (Enumerable.Contains(assemblyNames, assembly.GetName().Name))
						{
							list.Add(assembly);
						}
					}
					catch
					{
					}
				}
				_assemblies = list.ToArray();
			}
			return _assemblies;
		}
	}

	public static Type[] GetElementTypes(Type type)
	{
		if (IsGenericType(type))
		{
			return GetGenericArguments(type);
		}
		if (type.IsArray)
		{
			return new Type[1] { GetElementType(type) };
		}
		return null;
	}

	public static List<FieldInfo> GetSerializableFields(Type type, List<FieldInfo> serializableFields = null, bool safe = true, string[] memberNames = null, BindingFlags bindings = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic)
	{
		if (type == null)
		{
			return new List<FieldInfo>();
		}
		FieldInfo[] fields = type.GetFields(bindings);
		if (serializableFields == null)
		{
			serializableFields = new List<FieldInfo>();
		}
		FieldInfo[] array = fields;
		foreach (FieldInfo fieldInfo in array)
		{
			string name = fieldInfo.Name;
			if (memberNames == null || Enumerable.Contains(memberNames, name))
			{
				Type fieldType = fieldInfo.FieldType;
				if (AttributeIsDefined(fieldInfo, es3SerializableAttributeType))
				{
					serializableFields.Add(fieldInfo);
				}
				else if (!AttributeIsDefined(fieldInfo, es3NonSerializableAttributeType) && (!safe || fieldInfo.IsPublic || AttributeIsDefined(fieldInfo, serializeFieldAttributeType)) && !fieldInfo.IsLiteral && !fieldInfo.IsInitOnly && (!(fieldType == type) || IsAssignableFrom(typeof(UnityEngine.Object), fieldType)) && !AttributeIsDefined(fieldInfo, nonSerializedAttributeType) && !AttributeIsDefined(fieldInfo, obsoleteAttributeType) && TypeIsSerializable(fieldInfo.FieldType) && (!safe || !name.StartsWith("m_") || fieldInfo.DeclaringType.Namespace == null || !fieldInfo.DeclaringType.Namespace.Contains("UnityEngine")))
				{
					serializableFields.Add(fieldInfo);
				}
			}
		}
		Type type2 = BaseType(type);
		if (type2 != null && type2 != typeof(object) && type2 != typeof(UnityEngine.Object))
		{
			GetSerializableFields(BaseType(type), serializableFields, safe, memberNames);
		}
		return serializableFields;
	}

	public static List<PropertyInfo> GetSerializableProperties(Type type, List<PropertyInfo> serializableProperties = null, bool safe = true, string[] memberNames = null, BindingFlags bindings = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic)
	{
		bool flag = IsAssignableFrom(typeof(Component), type);
		if (!safe)
		{
			bindings |= BindingFlags.NonPublic;
		}
		PropertyInfo[] properties = type.GetProperties(bindings);
		if (serializableProperties == null)
		{
			serializableProperties = new List<PropertyInfo>();
		}
		PropertyInfo[] array = properties;
		foreach (PropertyInfo propertyInfo in array)
		{
			if (AttributeIsDefined(propertyInfo, es3SerializableAttributeType))
			{
				serializableProperties.Add(propertyInfo);
			}
			else
			{
				if (AttributeIsDefined(propertyInfo, es3NonSerializableAttributeType))
				{
					continue;
				}
				string name = propertyInfo.Name;
				if (!Enumerable.Contains(excludedPropertyNames, name) && (memberNames == null || Enumerable.Contains(memberNames, name)) && (!safe || AttributeIsDefined(propertyInfo, serializeFieldAttributeType) || AttributeIsDefined(propertyInfo, es3SerializableAttributeType)))
				{
					Type propertyType = propertyInfo.PropertyType;
					if ((!(propertyType == type) || IsAssignableFrom(typeof(UnityEngine.Object), propertyType)) && propertyInfo.CanRead && propertyInfo.CanWrite && (propertyInfo.GetIndexParameters().Length == 0 || propertyType.IsArray) && TypeIsSerializable(propertyType) && (!flag || (!(name == "tag") && !(name == "name"))) && !AttributeIsDefined(propertyInfo, obsoleteAttributeType) && !AttributeIsDefined(propertyInfo, nonSerializedAttributeType))
					{
						serializableProperties.Add(propertyInfo);
					}
				}
			}
		}
		Type type2 = BaseType(type);
		if (type2 != null && type2 != typeof(object))
		{
			GetSerializableProperties(type2, serializableProperties, safe, memberNames);
		}
		return serializableProperties;
	}

	public static bool TypeIsSerializable(Type type)
	{
		if (type == null)
		{
			return false;
		}
		if (AttributeIsDefined(type, es3NonSerializableAttributeType))
		{
			return false;
		}
		if (IsPrimitive(type) || IsValueType(type) || IsAssignableFrom(typeof(Component), type) || IsAssignableFrom(typeof(ScriptableObject), type))
		{
			return true;
		}
		ES3Type orCreateES3Type = ES3TypeMgr.GetOrCreateES3Type(type, throwException: false);
		if (orCreateES3Type != null && !orCreateES3Type.isUnsupported)
		{
			return true;
		}
		if (TypeIsArray(type))
		{
			if (TypeIsSerializable(type.GetElementType()))
			{
				return true;
			}
			return false;
		}
		Type[] genericArguments = type.GetGenericArguments();
		for (int i = 0; i < genericArguments.Length; i++)
		{
			if (!TypeIsSerializable(genericArguments[i]))
			{
				return false;
			}
		}
		return false;
	}

	public static object CreateInstance(Type type)
	{
		if (IsAssignableFrom(typeof(Component), type))
		{
			return ES3ComponentType.CreateComponent(type);
		}
		if (IsAssignableFrom(typeof(ScriptableObject), type))
		{
			return ScriptableObject.CreateInstance(type);
		}
		if (HasParameterlessConstructor(type))
		{
			return Activator.CreateInstance(type);
		}
		return FormatterServices.GetUninitializedObject(type);
	}

	public static object CreateInstance(Type type, params object[] args)
	{
		if (IsAssignableFrom(typeof(Component), type))
		{
			return ES3ComponentType.CreateComponent(type);
		}
		if (IsAssignableFrom(typeof(ScriptableObject), type))
		{
			return ScriptableObject.CreateInstance(type);
		}
		return Activator.CreateInstance(type, args);
	}

	public static Array ArrayCreateInstance(Type type, int length)
	{
		return Array.CreateInstance(type, new int[1] { length });
	}

	public static Array ArrayCreateInstance(Type type, int[] dimensions)
	{
		return Array.CreateInstance(type, dimensions);
	}

	public static Type MakeGenericType(Type type, Type genericParam)
	{
		return type.MakeGenericType(genericParam);
	}

	public static ES3ReflectedMember[] GetSerializableMembers(Type type, bool safe = true, string[] memberNames = null)
	{
		if (type == null)
		{
			return new ES3ReflectedMember[0];
		}
		List<FieldInfo> serializableFields = GetSerializableFields(type, new List<FieldInfo>(), safe, memberNames);
		List<PropertyInfo> serializableProperties = GetSerializableProperties(type, new List<PropertyInfo>(), safe, memberNames);
		ES3ReflectedMember[] array = new ES3ReflectedMember[serializableFields.Count + serializableProperties.Count];
		for (int i = 0; i < serializableFields.Count; i++)
		{
			array[i] = new ES3ReflectedMember(serializableFields[i]);
		}
		for (int j = 0; j < serializableProperties.Count; j++)
		{
			array[j + serializableFields.Count] = new ES3ReflectedMember(serializableProperties[j]);
		}
		return array;
	}

	public static ES3ReflectedMember GetES3ReflectedProperty(Type type, string propertyName)
	{
		return new ES3ReflectedMember(GetProperty(type, propertyName));
	}

	public static ES3ReflectedMember GetES3ReflectedMember(Type type, string fieldName)
	{
		return new ES3ReflectedMember(GetField(type, fieldName));
	}

	public static IList<T> GetInstances<T>()
	{
		List<T> list = new List<T>();
		Assembly[] assemblies = Assemblies;
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type[] types = assemblies[i].GetTypes();
			foreach (Type type in types)
			{
				if (IsAssignableFrom(typeof(T), type) && HasParameterlessConstructor(type) && !IsAbstract(type))
				{
					list.Add((T)Activator.CreateInstance(type));
				}
			}
		}
		return list;
	}

	public static IList<Type> GetDerivedTypes(Type derivedType)
	{
		return (from assembly in Assemblies
			from type in assembly.GetTypes()
			where IsAssignableFrom(derivedType, type)
			select type).ToList();
	}

	public static bool IsAssignableFrom(Type a, Type b)
	{
		return a.IsAssignableFrom(b);
	}

	public static Type GetGenericTypeDefinition(Type type)
	{
		return type.GetGenericTypeDefinition();
	}

	public static Type[] GetGenericArguments(Type type)
	{
		return type.GetGenericArguments();
	}

	public static int GetArrayRank(Type type)
	{
		return type.GetArrayRank();
	}

	public static string GetAssemblyQualifiedName(Type type)
	{
		return type.AssemblyQualifiedName;
	}

	public static ES3ReflectedMethod GetMethod(Type type, string methodName, Type[] genericParameters, Type[] parameterTypes)
	{
		return new ES3ReflectedMethod(type, methodName, genericParameters, parameterTypes);
	}

	public static bool TypeIsArray(Type type)
	{
		return type.IsArray;
	}

	public static Type GetElementType(Type type)
	{
		return type.GetElementType();
	}

	public static bool IsAbstract(Type type)
	{
		return type.IsAbstract;
	}

	public static bool IsInterface(Type type)
	{
		return type.IsInterface;
	}

	public static bool IsGenericType(Type type)
	{
		return type.IsGenericType;
	}

	public static bool IsValueType(Type type)
	{
		return type.IsValueType;
	}

	public static bool IsEnum(Type type)
	{
		return type.IsEnum;
	}

	public static bool HasParameterlessConstructor(Type type)
	{
		if (IsValueType(type) || GetParameterlessConstructor(type) != null)
		{
			return true;
		}
		return false;
	}

	public static ConstructorInfo GetParameterlessConstructor(Type type)
	{
		ConstructorInfo[] constructors = type.GetConstructors(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		foreach (ConstructorInfo constructorInfo in constructors)
		{
			if (constructorInfo.GetParameters().Length == 0)
			{
				return constructorInfo;
			}
		}
		return null;
	}

	public static string GetShortAssemblyQualifiedName(Type type)
	{
		if (IsPrimitive(type))
		{
			return type.ToString();
		}
		return type.FullName + "," + type.Assembly.GetName().Name;
	}

	public static PropertyInfo GetProperty(Type type, string propertyName)
	{
		PropertyInfo property = type.GetProperty(propertyName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (property == null && BaseType(type) != typeof(object))
		{
			return GetProperty(BaseType(type), propertyName);
		}
		return property;
	}

	public static FieldInfo GetField(Type type, string fieldName)
	{
		FieldInfo field = type.GetField(fieldName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (field == null && BaseType(type) != typeof(object))
		{
			return GetField(BaseType(type), fieldName);
		}
		return field;
	}

	public static MethodInfo[] GetMethods(Type type, string methodName)
	{
		return (from t in type.GetMethods()
			where t.Name == methodName
			select t).ToArray();
	}

	public static bool IsPrimitive(Type type)
	{
		if (!type.IsPrimitive && !(type == typeof(string)))
		{
			return type == typeof(decimal);
		}
		return true;
	}

	public static bool AttributeIsDefined(MemberInfo info, Type attributeType)
	{
		return Attribute.IsDefined(info, attributeType, inherit: true);
	}

	public static bool AttributeIsDefined(Type type, Type attributeType)
	{
		return type.IsDefined(attributeType, inherit: true);
	}

	public static bool ImplementsInterface(Type type, Type interfaceType)
	{
		return type.GetInterface(interfaceType.Name) != null;
	}

	public static Type BaseType(Type type)
	{
		return type.BaseType;
	}

	public static Type GetType(string typeString)
	{
		return typeString switch
		{
			"bool" => typeof(bool), 
			"byte" => typeof(byte), 
			"sbyte" => typeof(sbyte), 
			"char" => typeof(char), 
			"decimal" => typeof(decimal), 
			"double" => typeof(double), 
			"float" => typeof(float), 
			"int" => typeof(int), 
			"uint" => typeof(uint), 
			"long" => typeof(long), 
			"ulong" => typeof(ulong), 
			"short" => typeof(short), 
			"ushort" => typeof(ushort), 
			"string" => typeof(string), 
			"Vector2" => typeof(Vector2), 
			"Vector3" => typeof(Vector3), 
			"Vector4" => typeof(Vector4), 
			"Color" => typeof(Color), 
			"Transform" => typeof(Transform), 
			"Component" => typeof(Component), 
			"GameObject" => typeof(GameObject), 
			"MeshFilter" => typeof(MeshFilter), 
			"Material" => typeof(Material), 
			"Texture2D" => typeof(Texture2D), 
			"UnityEngine.Object" => typeof(UnityEngine.Object), 
			"System.Object" => typeof(object), 
			_ => Type.GetType(typeString), 
		};
	}

	public static string GetTypeString(Type type)
	{
		if (type == typeof(bool))
		{
			return "bool";
		}
		if (type == typeof(byte))
		{
			return "byte";
		}
		if (type == typeof(sbyte))
		{
			return "sbyte";
		}
		if (type == typeof(char))
		{
			return "char";
		}
		if (type == typeof(decimal))
		{
			return "decimal";
		}
		if (type == typeof(double))
		{
			return "double";
		}
		if (type == typeof(float))
		{
			return "float";
		}
		if (type == typeof(int))
		{
			return "int";
		}
		if (type == typeof(uint))
		{
			return "uint";
		}
		if (type == typeof(long))
		{
			return "long";
		}
		if (type == typeof(ulong))
		{
			return "ulong";
		}
		if (type == typeof(short))
		{
			return "short";
		}
		if (type == typeof(ushort))
		{
			return "ushort";
		}
		if (type == typeof(string))
		{
			return "string";
		}
		if (type == typeof(Vector2))
		{
			return "Vector2";
		}
		if (type == typeof(Vector3))
		{
			return "Vector3";
		}
		if (type == typeof(Vector4))
		{
			return "Vector4";
		}
		if (type == typeof(Color))
		{
			return "Color";
		}
		if (type == typeof(Transform))
		{
			return "Transform";
		}
		if (type == typeof(Component))
		{
			return "Component";
		}
		if (type == typeof(GameObject))
		{
			return "GameObject";
		}
		if (type == typeof(MeshFilter))
		{
			return "MeshFilter";
		}
		if (type == typeof(Material))
		{
			return "Material";
		}
		if (type == typeof(Texture2D))
		{
			return "Texture2D";
		}
		if (type == typeof(UnityEngine.Object))
		{
			return "UnityEngine.Object";
		}
		if (type == typeof(object))
		{
			return "System.Object";
		}
		return GetShortAssemblyQualifiedName(type);
	}
}
