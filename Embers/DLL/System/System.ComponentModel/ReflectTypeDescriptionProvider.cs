using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel.Design;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.ComponentModel;

internal sealed class ReflectTypeDescriptionProvider : TypeDescriptionProvider
{
	private class ReflectedTypeData
	{
		private Type _type;

		private AttributeCollection _attributes;

		private EventDescriptorCollection _events;

		private PropertyDescriptorCollection _properties;

		private TypeConverter _converter;

		private object[] _editors;

		private Type[] _editorTypes;

		private int _editorCount;

		internal bool IsPopulated => (_attributes != null) | (_events != null) | (_properties != null);

		internal ReflectedTypeData(Type type)
		{
			_type = type;
		}

		internal AttributeCollection GetAttributes()
		{
			if (_attributes == null)
			{
				Attribute[] array = ReflectGetAttributes(_type);
				Type baseType = _type.BaseType;
				while (baseType != null && baseType != typeof(object))
				{
					Attribute[] array2 = ReflectGetAttributes(baseType);
					Attribute[] array3 = new Attribute[array.Length + array2.Length];
					Array.Copy(array, 0, array3, 0, array.Length);
					Array.Copy(array2, 0, array3, array.Length, array2.Length);
					array = array3;
					baseType = baseType.BaseType;
				}
				int num = array.Length;
				Type[] interfaces = _type.GetInterfaces();
				foreach (Type type in interfaces)
				{
					if ((type.Attributes & TypeAttributes.NestedPrivate) != TypeAttributes.NotPublic)
					{
						AttributeCollection attributes = TypeDescriptor.GetAttributes(type);
						if (attributes.Count > 0)
						{
							Attribute[] array4 = new Attribute[array.Length + attributes.Count];
							Array.Copy(array, 0, array4, 0, array.Length);
							attributes.CopyTo(array4, array.Length);
							array = array4;
						}
					}
				}
				OrderedDictionary orderedDictionary = new OrderedDictionary(array.Length);
				for (int j = 0; j < array.Length; j++)
				{
					bool flag = true;
					if (j >= num)
					{
						for (int k = 0; k < _skipInterfaceAttributeList.Length; k++)
						{
							if (_skipInterfaceAttributeList[k].IsInstanceOfType(array[j]))
							{
								flag = false;
								break;
							}
						}
					}
					if (flag && !orderedDictionary.Contains(array[j].TypeId))
					{
						orderedDictionary[array[j].TypeId] = array[j];
					}
				}
				array = new Attribute[orderedDictionary.Count];
				orderedDictionary.Values.CopyTo(array, 0);
				_attributes = new AttributeCollection(array);
			}
			return _attributes;
		}

		internal string GetClassName(object instance)
		{
			return _type.FullName;
		}

		internal string GetComponentName(object instance)
		{
			if (instance is IComponent { Site: { } site })
			{
				if (site is INestedSite nestedSite)
				{
					return nestedSite.FullName;
				}
				return site.Name;
			}
			return null;
		}

		internal TypeConverter GetConverter(object instance)
		{
			TypeConverterAttribute typeConverterAttribute = null;
			if (instance != null)
			{
				typeConverterAttribute = (TypeConverterAttribute)TypeDescriptor.GetAttributes(_type)[typeof(TypeConverterAttribute)];
				TypeConverterAttribute typeConverterAttribute2 = (TypeConverterAttribute)TypeDescriptor.GetAttributes(instance)[typeof(TypeConverterAttribute)];
				if (typeConverterAttribute != typeConverterAttribute2)
				{
					Type typeFromName = GetTypeFromName(typeConverterAttribute2.ConverterTypeName);
					if (typeFromName != null && typeof(TypeConverter).IsAssignableFrom(typeFromName))
					{
						return (TypeConverter)CreateInstance(typeFromName, _type);
					}
				}
			}
			if (_converter == null)
			{
				if (typeConverterAttribute == null)
				{
					typeConverterAttribute = (TypeConverterAttribute)TypeDescriptor.GetAttributes(_type)[typeof(TypeConverterAttribute)];
				}
				if (typeConverterAttribute != null)
				{
					Type typeFromName2 = GetTypeFromName(typeConverterAttribute.ConverterTypeName);
					if (typeFromName2 != null && typeof(TypeConverter).IsAssignableFrom(typeFromName2))
					{
						_converter = (TypeConverter)CreateInstance(typeFromName2, _type);
					}
				}
				if (_converter == null)
				{
					_converter = (TypeConverter)SearchIntrinsicTable(IntrinsicTypeConverters, _type);
				}
			}
			return _converter;
		}

		internal EventDescriptor GetDefaultEvent(object instance)
		{
			AttributeCollection attributeCollection = ((instance == null) ? TypeDescriptor.GetAttributes(_type) : TypeDescriptor.GetAttributes(instance));
			DefaultEventAttribute defaultEventAttribute = (DefaultEventAttribute)attributeCollection[typeof(DefaultEventAttribute)];
			if (defaultEventAttribute != null && defaultEventAttribute.Name != null)
			{
				if (instance != null)
				{
					return TypeDescriptor.GetEvents(instance)[defaultEventAttribute.Name];
				}
				return TypeDescriptor.GetEvents(_type)[defaultEventAttribute.Name];
			}
			return null;
		}

		internal PropertyDescriptor GetDefaultProperty(object instance)
		{
			AttributeCollection attributeCollection = ((instance == null) ? TypeDescriptor.GetAttributes(_type) : TypeDescriptor.GetAttributes(instance));
			DefaultPropertyAttribute defaultPropertyAttribute = (DefaultPropertyAttribute)attributeCollection[typeof(DefaultPropertyAttribute)];
			if (defaultPropertyAttribute != null && defaultPropertyAttribute.Name != null)
			{
				if (instance != null)
				{
					return TypeDescriptor.GetProperties(instance)[defaultPropertyAttribute.Name];
				}
				return TypeDescriptor.GetProperties(_type)[defaultPropertyAttribute.Name];
			}
			return null;
		}

		internal object GetEditor(object instance, Type editorBaseType)
		{
			EditorAttribute editorAttribute;
			if (instance != null)
			{
				editorAttribute = GetEditorAttribute(TypeDescriptor.GetAttributes(_type), editorBaseType);
				EditorAttribute editorAttribute2 = GetEditorAttribute(TypeDescriptor.GetAttributes(instance), editorBaseType);
				if (editorAttribute != editorAttribute2)
				{
					Type typeFromName = GetTypeFromName(editorAttribute2.EditorTypeName);
					if (typeFromName != null && editorBaseType.IsAssignableFrom(typeFromName))
					{
						return CreateInstance(typeFromName, _type);
					}
				}
			}
			lock (this)
			{
				for (int i = 0; i < _editorCount; i++)
				{
					if (_editorTypes[i] == editorBaseType)
					{
						return _editors[i];
					}
				}
			}
			object obj = null;
			editorAttribute = GetEditorAttribute(TypeDescriptor.GetAttributes(_type), editorBaseType);
			if (editorAttribute != null)
			{
				Type typeFromName2 = GetTypeFromName(editorAttribute.EditorTypeName);
				if (typeFromName2 != null && editorBaseType.IsAssignableFrom(typeFromName2))
				{
					obj = CreateInstance(typeFromName2, _type);
				}
			}
			if (obj == null)
			{
				Hashtable editorTable = GetEditorTable(editorBaseType);
				if (editorTable != null)
				{
					obj = SearchIntrinsicTable(editorTable, _type);
				}
				if (obj != null && !editorBaseType.IsInstanceOfType(obj))
				{
					obj = null;
				}
			}
			if (obj != null)
			{
				lock (this)
				{
					if (_editorTypes == null || _editorTypes.Length == _editorCount)
					{
						int num = ((_editorTypes == null) ? 4 : (_editorTypes.Length * 2));
						Type[] array = new Type[num];
						object[] array2 = new object[num];
						if (_editorTypes != null)
						{
							_editorTypes.CopyTo(array, 0);
							_editors.CopyTo(array2, 0);
						}
						_editorTypes = array;
						_editors = array2;
						_editorTypes[_editorCount] = editorBaseType;
						_editors[_editorCount++] = obj;
					}
				}
			}
			return obj;
		}

		private static EditorAttribute GetEditorAttribute(AttributeCollection attributes, Type editorBaseType)
		{
			foreach (Attribute attribute in attributes)
			{
				if (attribute is EditorAttribute editorAttribute)
				{
					Type type = Type.GetType(editorAttribute.EditorBaseTypeName);
					if (type != null && type == editorBaseType)
					{
						return editorAttribute;
					}
				}
			}
			return null;
		}

		internal EventDescriptorCollection GetEvents()
		{
			if (_events == null)
			{
				Dictionary<string, EventDescriptor> dictionary = new Dictionary<string, EventDescriptor>(16);
				Type type = _type;
				Type typeFromHandle = typeof(object);
				EventDescriptor[] array;
				do
				{
					array = ReflectGetEvents(type);
					EventDescriptor[] array2 = array;
					foreach (EventDescriptor eventDescriptor in array2)
					{
						if (!dictionary.ContainsKey(eventDescriptor.Name))
						{
							dictionary.Add(eventDescriptor.Name, eventDescriptor);
						}
					}
					type = type.BaseType;
				}
				while (type != null && type != typeFromHandle);
				array = new EventDescriptor[dictionary.Count];
				dictionary.Values.CopyTo(array, 0);
				_events = new EventDescriptorCollection(array, readOnly: true);
			}
			return _events;
		}

		internal PropertyDescriptorCollection GetProperties()
		{
			if (_properties == null)
			{
				Dictionary<string, PropertyDescriptor> dictionary = new Dictionary<string, PropertyDescriptor>(10);
				Type type = _type;
				Type typeFromHandle = typeof(object);
				PropertyDescriptor[] array;
				do
				{
					array = ReflectGetProperties(type);
					PropertyDescriptor[] array2 = array;
					foreach (PropertyDescriptor propertyDescriptor in array2)
					{
						if (!dictionary.ContainsKey(propertyDescriptor.Name))
						{
							dictionary.Add(propertyDescriptor.Name, propertyDescriptor);
						}
					}
					type = type.BaseType;
				}
				while (type != null && type != typeFromHandle);
				array = new PropertyDescriptor[dictionary.Count];
				dictionary.Values.CopyTo(array, 0);
				_properties = new PropertyDescriptorCollection(array, readOnly: true);
			}
			return _properties;
		}

		private Type GetTypeFromName(string typeName)
		{
			if (typeName == null || typeName.Length == 0)
			{
				return null;
			}
			int num = typeName.IndexOf(',');
			Type type = null;
			if (num == -1)
			{
				type = _type.Assembly.GetType(typeName);
			}
			if (type == null)
			{
				type = Type.GetType(typeName);
			}
			if (type == null && num != -1)
			{
				type = Type.GetType(typeName.Substring(0, num));
			}
			return type;
		}

		internal void Refresh()
		{
			_attributes = null;
			_events = null;
			_properties = null;
			_converter = null;
			_editors = null;
			_editorTypes = null;
			_editorCount = 0;
		}
	}

	private Hashtable _typeData;

	private static Type[] _typeConstructor = new Type[1] { typeof(Type) };

	private static volatile Hashtable _editorTables;

	private static volatile Hashtable _intrinsicTypeConverters;

	private static object _intrinsicReferenceKey = new object();

	private static object _intrinsicNullableKey = new object();

	private static object _dictionaryKey = new object();

	private static volatile Hashtable _propertyCache;

	private static volatile Hashtable _eventCache;

	private static volatile Hashtable _attributeCache;

	private static volatile Hashtable _extendedPropertyCache;

	private static readonly Guid _extenderProviderKey = Guid.NewGuid();

	private static readonly Guid _extenderPropertiesKey = Guid.NewGuid();

	private static readonly Guid _extenderProviderPropertiesKey = Guid.NewGuid();

	private static readonly Type[] _skipInterfaceAttributeList = new Type[3]
	{
		typeof(GuidAttribute),
		typeof(ComVisibleAttribute),
		typeof(InterfaceTypeAttribute)
	};

	private static object _internalSyncObject = new object();

	private static Hashtable IntrinsicTypeConverters
	{
		get
		{
			if (_intrinsicTypeConverters == null)
			{
				_intrinsicTypeConverters = new Hashtable
				{
					[typeof(bool)] = typeof(BooleanConverter),
					[typeof(byte)] = typeof(ByteConverter),
					[typeof(sbyte)] = typeof(SByteConverter),
					[typeof(char)] = typeof(CharConverter),
					[typeof(double)] = typeof(DoubleConverter),
					[typeof(string)] = typeof(StringConverter),
					[typeof(int)] = typeof(Int32Converter),
					[typeof(short)] = typeof(Int16Converter),
					[typeof(long)] = typeof(Int64Converter),
					[typeof(float)] = typeof(SingleConverter),
					[typeof(ushort)] = typeof(UInt16Converter),
					[typeof(uint)] = typeof(UInt32Converter),
					[typeof(ulong)] = typeof(UInt64Converter),
					[typeof(object)] = typeof(TypeConverter),
					[typeof(void)] = typeof(TypeConverter),
					[typeof(CultureInfo)] = typeof(CultureInfoConverter),
					[typeof(DateTime)] = typeof(DateTimeConverter),
					[typeof(DateTimeOffset)] = typeof(DateTimeOffsetConverter),
					[typeof(decimal)] = typeof(DecimalConverter),
					[typeof(TimeSpan)] = typeof(TimeSpanConverter),
					[typeof(Guid)] = typeof(GuidConverter),
					[typeof(Array)] = typeof(ArrayConverter),
					[typeof(ICollection)] = typeof(CollectionConverter),
					[typeof(Enum)] = typeof(EnumConverter),
					[_intrinsicReferenceKey] = typeof(ReferenceConverter),
					[_intrinsicNullableKey] = typeof(NullableConverter)
				};
			}
			return _intrinsicTypeConverters;
		}
	}

	internal ReflectTypeDescriptionProvider()
	{
	}

	public override object CreateInstance(IServiceProvider provider, Type objectType, Type[] argTypes, object[] args)
	{
		object obj = null;
		if (argTypes != null)
		{
			obj = SecurityUtils.SecureConstructorInvoke(objectType, argTypes, args, allowNonPublic: true, BindingFlags.ExactBinding);
		}
		else
		{
			if (args != null)
			{
				argTypes = new Type[args.Length];
				for (int i = 0; i < args.Length; i++)
				{
					if (args[i] != null)
					{
						argTypes[i] = args[i].GetType();
					}
					else
					{
						argTypes[i] = typeof(object);
					}
				}
			}
			else
			{
				argTypes = new Type[0];
			}
			obj = SecurityUtils.SecureConstructorInvoke(objectType, argTypes, args, allowNonPublic: true);
		}
		if (obj == null)
		{
			obj = SecurityUtils.SecureCreateInstance(objectType, args);
		}
		return obj;
	}

	private static object CreateInstance(Type objectType, Type callingType)
	{
		object obj = SecurityUtils.SecureConstructorInvoke(objectType, _typeConstructor, new object[1] { callingType }, allowNonPublic: false);
		if (obj == null)
		{
			obj = SecurityUtils.SecureCreateInstance(objectType);
		}
		return obj;
	}

	internal AttributeCollection GetAttributes(Type type)
	{
		return GetTypeData(type, createIfNeeded: true).GetAttributes();
	}

	public override IDictionary GetCache(object instance)
	{
		if (instance is IComponent { Site: not null } component && component.Site.GetService(typeof(IDictionaryService)) is IDictionaryService dictionaryService)
		{
			IDictionary dictionary = dictionaryService.GetValue(_dictionaryKey) as IDictionary;
			if (dictionary == null)
			{
				dictionary = new Hashtable();
				dictionaryService.SetValue(_dictionaryKey, dictionary);
			}
			return dictionary;
		}
		return null;
	}

	internal string GetClassName(Type type)
	{
		return GetTypeData(type, createIfNeeded: true).GetClassName(null);
	}

	internal string GetComponentName(Type type, object instance)
	{
		return GetTypeData(type, createIfNeeded: true).GetComponentName(instance);
	}

	internal TypeConverter GetConverter(Type type, object instance)
	{
		return GetTypeData(type, createIfNeeded: true).GetConverter(instance);
	}

	internal EventDescriptor GetDefaultEvent(Type type, object instance)
	{
		return GetTypeData(type, createIfNeeded: true).GetDefaultEvent(instance);
	}

	internal PropertyDescriptor GetDefaultProperty(Type type, object instance)
	{
		return GetTypeData(type, createIfNeeded: true).GetDefaultProperty(instance);
	}

	internal object GetEditor(Type type, object instance, Type editorBaseType)
	{
		return GetTypeData(type, createIfNeeded: true).GetEditor(instance, editorBaseType);
	}

	private static Hashtable GetEditorTable(Type editorBaseType)
	{
		if (_editorTables == null)
		{
			lock (_internalSyncObject)
			{
				if (_editorTables == null)
				{
					_editorTables = new Hashtable(4);
				}
			}
		}
		object obj = _editorTables[editorBaseType];
		if (obj == null)
		{
			RuntimeHelpers.RunClassConstructor(editorBaseType.TypeHandle);
			obj = _editorTables[editorBaseType];
			if (obj == null)
			{
				lock (_internalSyncObject)
				{
					obj = _editorTables[editorBaseType];
					if (obj == null)
					{
						_editorTables[editorBaseType] = _editorTables;
					}
				}
			}
		}
		if (obj == _editorTables)
		{
			obj = null;
		}
		return (Hashtable)obj;
	}

	internal EventDescriptorCollection GetEvents(Type type)
	{
		return GetTypeData(type, createIfNeeded: true).GetEvents();
	}

	internal AttributeCollection GetExtendedAttributes(object instance)
	{
		return AttributeCollection.Empty;
	}

	internal string GetExtendedClassName(object instance)
	{
		return GetClassName(instance.GetType());
	}

	internal string GetExtendedComponentName(object instance)
	{
		return GetComponentName(instance.GetType(), instance);
	}

	internal TypeConverter GetExtendedConverter(object instance)
	{
		return GetConverter(instance.GetType(), instance);
	}

	internal EventDescriptor GetExtendedDefaultEvent(object instance)
	{
		return null;
	}

	internal PropertyDescriptor GetExtendedDefaultProperty(object instance)
	{
		return null;
	}

	internal object GetExtendedEditor(object instance, Type editorBaseType)
	{
		return GetEditor(instance.GetType(), instance, editorBaseType);
	}

	internal EventDescriptorCollection GetExtendedEvents(object instance)
	{
		return EventDescriptorCollection.Empty;
	}

	internal PropertyDescriptorCollection GetExtendedProperties(object instance)
	{
		Type type = instance.GetType();
		IExtenderProvider[] extenderProviders = GetExtenderProviders(instance);
		IDictionary cache = TypeDescriptor.GetCache(instance);
		if (extenderProviders.Length == 0)
		{
			return PropertyDescriptorCollection.Empty;
		}
		PropertyDescriptorCollection propertyDescriptorCollection = null;
		if (cache != null)
		{
			propertyDescriptorCollection = cache[_extenderPropertiesKey] as PropertyDescriptorCollection;
		}
		if (propertyDescriptorCollection != null)
		{
			return propertyDescriptorCollection;
		}
		ArrayList arrayList = null;
		for (int i = 0; i < extenderProviders.Length; i++)
		{
			PropertyDescriptor[] array = ReflectGetExtendedProperties(extenderProviders[i]);
			if (arrayList == null)
			{
				arrayList = new ArrayList(array.Length * extenderProviders.Length);
			}
			foreach (PropertyDescriptor propertyDescriptor in array)
			{
				if (propertyDescriptor.Attributes[typeof(ExtenderProvidedPropertyAttribute)] is ExtenderProvidedPropertyAttribute { ReceiverType: var receiverType } && receiverType != null && receiverType.IsAssignableFrom(type))
				{
					arrayList.Add(propertyDescriptor);
				}
			}
		}
		if (arrayList != null)
		{
			PropertyDescriptor[] array2 = new PropertyDescriptor[arrayList.Count];
			arrayList.CopyTo(array2, 0);
			propertyDescriptorCollection = new PropertyDescriptorCollection(array2, readOnly: true);
		}
		else
		{
			propertyDescriptorCollection = PropertyDescriptorCollection.Empty;
		}
		if (cache != null)
		{
			cache[_extenderPropertiesKey] = propertyDescriptorCollection;
		}
		return propertyDescriptorCollection;
	}

	protected internal override IExtenderProvider[] GetExtenderProviders(object instance)
	{
		if (instance == null)
		{
			throw new ArgumentNullException("instance");
		}
		if (instance is IComponent { Site: not null } component)
		{
			IExtenderListService extenderListService = component.Site.GetService(typeof(IExtenderListService)) as IExtenderListService;
			IDictionary cache = TypeDescriptor.GetCache(instance);
			if (extenderListService != null)
			{
				return GetExtenders(extenderListService.GetExtenderProviders(), instance, cache);
			}
			IContainer container = component.Site.Container;
			if (container != null)
			{
				return GetExtenders(container.Components, instance, cache);
			}
		}
		return new IExtenderProvider[0];
	}

	private static IExtenderProvider[] GetExtenders(ICollection components, object instance, IDictionary cache)
	{
		bool flag = false;
		int num = 0;
		IExtenderProvider[] array = null;
		ulong num2 = 0uL;
		int num3 = 64;
		IExtenderProvider[] array2 = components as IExtenderProvider[];
		if (cache != null)
		{
			array = cache[_extenderProviderKey] as IExtenderProvider[];
		}
		if (array == null)
		{
			flag = true;
		}
		int num4 = 0;
		int num5 = 0;
		if (array2 != null)
		{
			for (num4 = 0; num4 < array2.Length; num4++)
			{
				if (array2[num4].CanExtend(instance))
				{
					num++;
					if (num4 < num3)
					{
						num2 |= (ulong)(1L << num4);
					}
					if (!flag && (num5 >= array.Length || array2[num4] != array[num5++]))
					{
						flag = true;
					}
				}
			}
		}
		else if (components != null)
		{
			foreach (object component in components)
			{
				if (component is IExtenderProvider extenderProvider && extenderProvider.CanExtend(instance))
				{
					num++;
					if (num4 < num3)
					{
						num2 |= (ulong)(1L << num4);
					}
					if (!flag && (num5 >= array.Length || extenderProvider != array[num5++]))
					{
						flag = true;
					}
				}
				num4++;
			}
		}
		if (array != null && num != array.Length)
		{
			flag = true;
		}
		if (flag)
		{
			if (array2 == null || num != array2.Length)
			{
				IExtenderProvider[] array3 = new IExtenderProvider[num];
				num4 = 0;
				num5 = 0;
				if (array2 != null && num > 0)
				{
					for (; num4 < array2.Length; num4++)
					{
						if ((num4 < num3 && (num2 & (ulong)(1L << num4)) != 0L) || (num4 >= num3 && array2[num4].CanExtend(instance)))
						{
							array3[num5++] = array2[num4];
						}
					}
				}
				else if (num > 0)
				{
					IEnumerator enumerator2 = components.GetEnumerator();
					while (enumerator2.MoveNext())
					{
						if (enumerator2.Current is IExtenderProvider extenderProvider2 && ((num4 < num3 && (num2 & (ulong)(1L << num4)) != 0L) || (num4 >= num3 && extenderProvider2.CanExtend(instance))))
						{
							array3[num5++] = extenderProvider2;
						}
						num4++;
					}
				}
				array2 = array3;
			}
			if (cache != null)
			{
				cache[_extenderProviderKey] = array2;
				cache.Remove(_extenderPropertiesKey);
			}
		}
		else
		{
			array2 = array;
		}
		return array2;
	}

	internal object GetExtendedPropertyOwner(object instance, PropertyDescriptor pd)
	{
		return GetPropertyOwner(instance.GetType(), instance, pd);
	}

	public override ICustomTypeDescriptor GetExtendedTypeDescriptor(object instance)
	{
		return null;
	}

	internal PropertyDescriptorCollection GetProperties(Type type)
	{
		return GetTypeData(type, createIfNeeded: true).GetProperties();
	}

	internal object GetPropertyOwner(Type type, object instance, PropertyDescriptor pd)
	{
		return TypeDescriptor.GetAssociation(type, instance);
	}

	public override Type GetReflectionType(Type objectType, object instance)
	{
		return objectType;
	}

	private ReflectedTypeData GetTypeData(Type type, bool createIfNeeded)
	{
		ReflectedTypeData reflectedTypeData = null;
		if (_typeData != null)
		{
			reflectedTypeData = (ReflectedTypeData)_typeData[type];
			if (reflectedTypeData != null)
			{
				return reflectedTypeData;
			}
		}
		lock (_internalSyncObject)
		{
			if (_typeData != null)
			{
				reflectedTypeData = (ReflectedTypeData)_typeData[type];
			}
			if ((reflectedTypeData == null) & createIfNeeded)
			{
				reflectedTypeData = new ReflectedTypeData(type);
				if (_typeData == null)
				{
					_typeData = new Hashtable();
				}
				_typeData[type] = reflectedTypeData;
			}
		}
		return reflectedTypeData;
	}

	public override ICustomTypeDescriptor GetTypeDescriptor(Type objectType, object instance)
	{
		return null;
	}

	private static Type GetTypeFromName(string typeName)
	{
		Type type = Type.GetType(typeName);
		if (type == null)
		{
			int num = typeName.IndexOf(',');
			if (num != -1)
			{
				type = Type.GetType(typeName.Substring(0, num));
			}
		}
		return type;
	}

	internal bool IsPopulated(Type type)
	{
		return GetTypeData(type, createIfNeeded: false)?.IsPopulated ?? false;
	}

	private static Attribute[] ReflectGetAttributes(Type type)
	{
		if (_attributeCache == null)
		{
			lock (_internalSyncObject)
			{
				if (_attributeCache == null)
				{
					_attributeCache = new Hashtable();
				}
			}
		}
		Attribute[] array = (Attribute[])_attributeCache[type];
		if (array != null)
		{
			return array;
		}
		lock (_internalSyncObject)
		{
			array = (Attribute[])_attributeCache[type];
			if (array == null)
			{
				object[] customAttributes = type.GetCustomAttributes(typeof(Attribute), inherit: false);
				array = new Attribute[customAttributes.Length];
				customAttributes.CopyTo(array, 0);
				_attributeCache[type] = array;
			}
		}
		return array;
	}

	internal static Attribute[] ReflectGetAttributes(MemberInfo member)
	{
		if (_attributeCache == null)
		{
			lock (_internalSyncObject)
			{
				if (_attributeCache == null)
				{
					_attributeCache = new Hashtable();
				}
			}
		}
		Attribute[] array = (Attribute[])_attributeCache[member];
		if (array != null)
		{
			return array;
		}
		lock (_internalSyncObject)
		{
			array = (Attribute[])_attributeCache[member];
			if (array == null)
			{
				object[] customAttributes = member.GetCustomAttributes(typeof(Attribute), inherit: false);
				array = new Attribute[customAttributes.Length];
				customAttributes.CopyTo(array, 0);
				_attributeCache[member] = array;
			}
		}
		return array;
	}

	private static EventDescriptor[] ReflectGetEvents(Type type)
	{
		if (_eventCache == null)
		{
			lock (_internalSyncObject)
			{
				if (_eventCache == null)
				{
					_eventCache = new Hashtable();
				}
			}
		}
		EventDescriptor[] array = (EventDescriptor[])_eventCache[type];
		if (array != null)
		{
			return array;
		}
		lock (_internalSyncObject)
		{
			array = (EventDescriptor[])_eventCache[type];
			if (array == null)
			{
				BindingFlags bindingAttr = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;
				EventInfo[] events = type.GetEvents(bindingAttr);
				array = new EventDescriptor[events.Length];
				int num = 0;
				foreach (EventInfo eventInfo in events)
				{
					if (eventInfo.DeclaringType.IsPublic || eventInfo.DeclaringType.IsNestedPublic || !(eventInfo.DeclaringType.Assembly == typeof(ReflectTypeDescriptionProvider).Assembly))
					{
						MethodInfo addMethod = eventInfo.GetAddMethod();
						MethodInfo removeMethod = eventInfo.GetRemoveMethod();
						if (addMethod != null && removeMethod != null)
						{
							array[num++] = new ReflectEventDescriptor(type, eventInfo);
						}
					}
				}
				if (num != array.Length)
				{
					EventDescriptor[] array2 = new EventDescriptor[num];
					Array.Copy(array, 0, array2, 0, num);
					array = array2;
				}
				_eventCache[type] = array;
			}
		}
		return array;
	}

	private static PropertyDescriptor[] ReflectGetExtendedProperties(IExtenderProvider provider)
	{
		IDictionary cache = TypeDescriptor.GetCache(provider);
		if (cache != null && cache[_extenderProviderPropertiesKey] is PropertyDescriptor[] result)
		{
			return result;
		}
		if (_extendedPropertyCache == null)
		{
			lock (_internalSyncObject)
			{
				if (_extendedPropertyCache == null)
				{
					_extendedPropertyCache = new Hashtable();
				}
			}
		}
		Type type = provider.GetType();
		ReflectPropertyDescriptor[] array = (ReflectPropertyDescriptor[])_extendedPropertyCache[type];
		if (array == null)
		{
			lock (_internalSyncObject)
			{
				array = (ReflectPropertyDescriptor[])_extendedPropertyCache[type];
				if (array == null)
				{
					AttributeCollection attributes = TypeDescriptor.GetAttributes(type);
					ArrayList arrayList = new ArrayList(attributes.Count);
					foreach (Attribute item in attributes)
					{
						if (!(item is ProvidePropertyAttribute providePropertyAttribute))
						{
							continue;
						}
						Type typeFromName = GetTypeFromName(providePropertyAttribute.ReceiverTypeName);
						if (!(typeFromName != null))
						{
							continue;
						}
						MethodInfo method = type.GetMethod("Get" + providePropertyAttribute.PropertyName, new Type[1] { typeFromName });
						if (method != null && !method.IsStatic && method.IsPublic)
						{
							MethodInfo methodInfo = type.GetMethod("Set" + providePropertyAttribute.PropertyName, new Type[2] { typeFromName, method.ReturnType });
							if (methodInfo != null && (methodInfo.IsStatic || !methodInfo.IsPublic))
							{
								methodInfo = null;
							}
							arrayList.Add(new ReflectPropertyDescriptor(type, providePropertyAttribute.PropertyName, method.ReturnType, typeFromName, method, methodInfo, null));
						}
					}
					array = new ReflectPropertyDescriptor[arrayList.Count];
					arrayList.CopyTo(array, 0);
					_extendedPropertyCache[type] = array;
				}
			}
		}
		PropertyDescriptor[] array2 = new PropertyDescriptor[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			Attribute[] attributes2 = null;
			if (!(provider is IComponent { Site: not null }))
			{
				attributes2 = new Attribute[1] { DesignOnlyAttribute.Yes };
			}
			ReflectPropertyDescriptor obj = array[i];
			ExtendedPropertyDescriptor extendedPropertyDescriptor = new ExtendedPropertyDescriptor(obj, obj.ExtenderGetReceiverType(), provider, attributes2);
			array2[i] = extendedPropertyDescriptor;
		}
		if (cache != null)
		{
			cache[_extenderProviderPropertiesKey] = array2;
		}
		return array2;
	}

	private static PropertyDescriptor[] ReflectGetProperties(Type type)
	{
		if (_propertyCache == null)
		{
			lock (_internalSyncObject)
			{
				if (_propertyCache == null)
				{
					_propertyCache = new Hashtable();
				}
			}
		}
		PropertyDescriptor[] array = (PropertyDescriptor[])_propertyCache[type];
		if (array != null)
		{
			return array;
		}
		lock (_internalSyncObject)
		{
			array = (PropertyDescriptor[])_propertyCache[type];
			if (array == null)
			{
				BindingFlags bindingAttr = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public;
				PropertyInfo[] properties = type.GetProperties(bindingAttr);
				array = new PropertyDescriptor[properties.Length];
				int num = 0;
				foreach (PropertyInfo propertyInfo in properties)
				{
					if (propertyInfo.GetIndexParameters().Length == 0)
					{
						MethodInfo getMethod = propertyInfo.GetGetMethod();
						MethodInfo setMethod = propertyInfo.GetSetMethod();
						string name = propertyInfo.Name;
						if (getMethod != null)
						{
							array[num++] = new ReflectPropertyDescriptor(type, name, propertyInfo.PropertyType, propertyInfo, getMethod, setMethod, null);
						}
					}
				}
				if (num != array.Length)
				{
					PropertyDescriptor[] array2 = new PropertyDescriptor[num];
					Array.Copy(array, 0, array2, 0, num);
					array = array2;
				}
				_propertyCache[type] = array;
			}
		}
		return array;
	}

	internal void Refresh(Type type)
	{
		GetTypeData(type, createIfNeeded: false)?.Refresh();
	}

	private static object SearchIntrinsicTable(Hashtable table, Type callingType)
	{
		object obj = null;
		lock (table)
		{
			Type type = callingType;
			while (type != null && type != typeof(object))
			{
				obj = table[type];
				if (obj is string typeName)
				{
					obj = Type.GetType(typeName);
					if (obj != null)
					{
						table[type] = obj;
					}
				}
				if (obj != null)
				{
					break;
				}
				type = type.BaseType;
			}
			if (obj == null)
			{
				foreach (DictionaryEntry item in table)
				{
					Type type2 = item.Key as Type;
					if (!(type2 != null) || !type2.IsInterface || !type2.IsAssignableFrom(callingType))
					{
						continue;
					}
					obj = item.Value;
					if (obj is string typeName2)
					{
						obj = Type.GetType(typeName2);
						if (obj != null)
						{
							table[callingType] = obj;
						}
					}
					if (obj != null)
					{
						break;
					}
				}
			}
			if (obj == null)
			{
				if (callingType.IsGenericType && callingType.GetGenericTypeDefinition() == typeof(Nullable<>))
				{
					obj = table[_intrinsicNullableKey];
				}
				else if (callingType.IsInterface)
				{
					obj = table[_intrinsicReferenceKey];
				}
			}
			if (obj == null)
			{
				obj = table[typeof(object)];
			}
			Type type3 = obj as Type;
			if (type3 != null)
			{
				obj = CreateInstance(type3, callingType);
				if (type3.GetConstructor(_typeConstructor) == null)
				{
					table[callingType] = obj;
				}
			}
		}
		return obj;
	}
}
