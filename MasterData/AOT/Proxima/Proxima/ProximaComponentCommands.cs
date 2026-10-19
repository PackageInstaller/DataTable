using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace Proxima;

internal class ProximaComponentCommands
{
	[Serializable]
	internal class ButtonInfo
	{
		public string Id;

		public string Text;

		[NonSerialized]
		public MethodInfo Method;
	}

	[Serializable]
	internal class PropertyInfo
	{
		public string Name;

		public string Type;

		[SerializeIf("ShouldSerializeValue")]
		public object Value;

		public object Children;

		[NonSerialized]
		public PropertySetter Setter;

		[NonSerialized]
		public PropertyGetter Getter;

		[NonSerialized]
		public PropertyUpdater Updater;

		[NonSerialized]
		public Type PropertyType;

		public List<PropertyInfo> ChildProps => (List<PropertyInfo>)Children;

		[Preserve]
		public bool ShouldSerializeValue()
		{
			if (Children != null)
			{
				return Type.StartsWith("Object ");
			}
			return true;
		}
	}

	[Serializable]
	internal class ComponentInfo
	{
		public int Id;

		public int Order;

		public string Name;

		public object Properties;

		public object Buttons;

		[NonSerialized]
		public Component Component;

		[NonSerialized]
		public bool Temp;

		public List<PropertyInfo> Props => (List<PropertyInfo>)Properties;

		public List<ButtonInfo> Btns => (List<ButtonInfo>)Buttons;
	}

	[Serializable]
	internal class ComponentList
	{
		public object Components = new List<ComponentInfo>();

		public List<int> Destroyed = new List<int>();

		public List<ComponentInfo> Comps => (List<ComponentInfo>)Components;
	}

	private class ComponentStream
	{
		public HashSet<string> ActiveStreamIds = new HashSet<string>();

		public HashSet<string> PendingStreamIds = new HashSet<string>();

		public int GameObjectId;

		private List<Component> _components = new List<Component>();

		private ComponentList _componentList = new ComponentList();

		private ComponentList _changeList = new ComponentList();

		private int _lastUpdateFrame;

		private int _lastUpdatedIndex;

		private static List<Type> _nativeSerializedTypes = new List<Type>
		{
			typeof(Gradient),
			typeof(AnimationCurve),
			typeof(Keyframe),
			typeof(SoftJointLimit),
			typeof(SoftJointLimitSpring),
			typeof(JointDrive),
			typeof(JointMotor),
			typeof(JointSpring),
			typeof(JointLimits),
			typeof(WheelFrictionCurve),
			typeof(JointAngleLimits2D),
			typeof(JointTranslationLimits2D),
			typeof(JointMotor2D),
			typeof(JointSuspension2D),
			typeof(RectOffset)
		};

		private static HashSet<string> _typesWithEditor = new HashSet<string>
		{
			typeof(string).Name,
			typeof(bool).Name,
			typeof(byte).Name,
			typeof(sbyte).Name,
			typeof(short).Name,
			typeof(ushort).Name,
			typeof(int).Name,
			typeof(uint).Name,
			typeof(long).Name,
			typeof(ulong).Name,
			typeof(float).Name,
			typeof(double).Name,
			typeof(Vector2).Name,
			typeof(Vector3).Name,
			typeof(Vector4).Name,
			typeof(Vector2Int).Name,
			typeof(Vector3Int).Name,
			typeof(Quaternion).Name,
			typeof(Rect).Name,
			typeof(RectInt).Name,
			typeof(Bounds).Name,
			typeof(BoundsInt).Name,
			typeof(Color).Name,
			typeof(LayerMask).Name
		};

		private static HashSet<string> _disallowedAttrs = new HashSet<string> { "HideInInspector", "ObsoleteAttribute", "NativeConditionalAttribute", "EditorBrowsableAttribute" };

		public ComponentList Update(string id)
		{
			UpdateChangeList();
			if (PendingStreamIds.Contains(id))
			{
				PendingStreamIds.Remove(id);
				ActiveStreamIds.Add(id);
				return _componentList;
			}
			if (_changeList.Comps.Count <= 0 && _changeList.Destroyed.Count <= 0)
			{
				return null;
			}
			return _changeList;
		}

		public void Cleanup()
		{
			foreach (ComponentInfo comp in _componentList.Comps)
			{
				_idToComponentInfo.Remove(comp.Id);
				ReturnToPool(comp);
			}
		}

		private void UpdateChangeList()
		{
			if (_lastUpdateFrame == Time.frameCount)
			{
				return;
			}
			_lastUpdateFrame = Time.frameCount;
			List<ComponentInfo> comps = _changeList.Comps;
			for (int i = 0; i < comps.Count; i++)
			{
				if (comps[i].Temp)
				{
					ReturnToPool(comps[i]);
				}
			}
			_changeList.Comps.Clear();
			_changeList.Destroyed.Clear();
			if (!ProximaGameObjectCommands.IdToGameObject.TryGetValue(GameObjectId, out var value) || !value)
			{
				return;
			}
			value.GetComponents(_components);
			UpdateDeletedComponents();
			if (_lastUpdatedIndex >= _components.Count)
			{
				if (_lastUpdatedIndex < ProximaInspector.MaxComponentUpdateFrequency)
				{
					_lastUpdatedIndex++;
					return;
				}
				_lastUpdatedIndex = 0;
			}
			UpdateComponentInfo(_components[_lastUpdatedIndex], _lastUpdatedIndex);
			_lastUpdatedIndex++;
		}

		private bool ShouldHide(Component component)
		{
			if (!ProximaGameObjectCommands.ShowHidden)
			{
				return component.hideFlags.HasFlag(HideFlags.HideInInspector);
			}
			return false;
		}

		private void UpdateDeletedComponents()
		{
			for (int num = _componentList.Comps.Count - 1; num >= 0; num--)
			{
				ComponentInfo componentInfo = _componentList.Comps[num];
				if (!componentInfo.Component || ShouldHide(componentInfo.Component))
				{
					_idToComponentInfo.Remove(componentInfo.Id);
					_componentList.Comps.RemoveAt(num);
					_changeList.Destroyed.Add(componentInfo.Id);
					ReturnToPool(componentInfo);
				}
			}
		}

		private void UpdateComponentInfo(Component component, int order)
		{
			if (!ShouldHide(component))
			{
				int instanceID = component.GetInstanceID();
				if (!_idToComponentInfo.TryGetValue(instanceID, out var value))
				{
					value = GetFromPool(instanceID, component.GetType().Name, component, temp: false);
					value.Order = order;
					_componentList.Comps.Add(value);
					_idToComponentInfo.Add(component.GetInstanceID(), value);
					CreateComponentProperties(component, value);
					ProHook_CreateComponentButtons?.Invoke(component, value);
					_changeList.Comps.Add(value);
				}
				else
				{
					UpdateProperties(value, order);
				}
			}
		}

		private bool CallUpdater(object parent, PropertyInfo property)
		{
			return property.Updater(parent, ref property.Value);
		}

		private bool UpdatePropertyValue(object parent, PropertyInfo property, bool force)
		{
			if (force && property.Getter != null)
			{
				property.Value = property.Getter(parent);
				return true;
			}
			if (property.Updater != null)
			{
				return CallUpdater(parent, property);
			}
			if (property.Getter != null)
			{
				object obj = property.Getter(parent);
				if (!AreEqual(obj, property.Value))
				{
					property.Value = obj;
					return true;
				}
			}
			return false;
		}

		private bool UpdateProperty(object parent, PropertyInfo property)
		{
			bool flag = UpdatePropertyValue(parent, property, force: false);
			if (property.Value != null && property.Children != null)
			{
				if (ArrayOrList.IsArrayOrList(property.PropertyType))
				{
					flag = UpdateArrayItemProperties(property) | flag;
				}
				if (property.ChildProps != null)
				{
					foreach (PropertyInfo childProp in property.ChildProps)
					{
						flag = UpdateProperty(property.Value, childProp) | flag;
					}
				}
			}
			return flag;
		}

		private void UpdateProperties(ComponentInfo ci, int order)
		{
			ComponentInfo componentInfo = null;
			for (int i = 0; i < ci.Props.Count; i++)
			{
				PropertyInfo propertyInfo = ci.Props[i];
				if (UpdateProperty(ci.Component, propertyInfo))
				{
					if (componentInfo == null)
					{
						componentInfo = GetFromPool(ci.Id, ci.Name, ci.Component, temp: true);
						_changeList.Comps.Add(componentInfo);
					}
					componentInfo.Props.Add(propertyInfo);
				}
			}
			if (ci.Order != order)
			{
				ci.Order = order;
				if (componentInfo == null)
				{
					componentInfo = GetFromPool(ci.Id, ci.Name, ci.Component, temp: true);
					_changeList.Comps.Add(componentInfo);
				}
				componentInfo.Order = order;
			}
		}

		private void UpdateChildProperties(PropertyGetter parentGetter, List<PropertyInfo> list)
		{
			object obj = parentGetter(null);
			if (obj == null)
			{
				return;
			}
			foreach (PropertyInfo item in list)
			{
				UpdatePropertyValue(obj, item, force: false);
			}
		}

		private void CreateComponentProperties(Component component, ComponentInfo ci)
		{
			ci.Properties = new List<PropertyInfo>();
			component.GetType();
			if (ProximaReflection_Generated.Properties.TryGetValue(component.GetType().FullName, out var value))
			{
				CreatePropertiesFromOverride(ci, value);
			}
			else if (component is MonoBehaviour)
			{
				CreatePropertiesForMonoBehaviour(component, ci);
			}
			else
			{
				CreatePropertiesForNativeObject(component, ci);
			}
		}

		private void CreatePropertiesFromOverride(ComponentInfo ci, PropertyInfo[] props)
		{
			foreach (PropertyInfo propertyInfo in props)
			{
				AddPropertyRecursively(ci.Component, ci.Props, propertyInfo.Name, propertyInfo.PropertyType, propertyInfo.Setter, propertyInfo.Getter, propertyInfo.Updater);
			}
		}

		private PropertyInfo AddPropertyToList(object parent, List<PropertyInfo> list, string name, Type type, PropertySetter setter, PropertyGetter getter, PropertyUpdater updater)
		{
			PropertyInfo propertyInfo = new PropertyInfo
			{
				Name = name,
				Type = ProximaSerialization.GetSerializedTypeName(type),
				PropertyType = type,
				Setter = setter,
				Getter = getter,
				Updater = updater
			};
			UpdatePropertyValue(parent, propertyInfo, force: true);
			list.Add(propertyInfo);
			return propertyInfo;
		}

		private PropertyGetter GetPropertyGetter(System.Reflection.PropertyInfo property, FieldInfo field)
		{
			if (property != null && property.CanRead)
			{
				return property.GetValue;
			}
			if (field != null)
			{
				return field.GetValue;
			}
			return null;
		}

		private PropertySetter GetPropertySetter(System.Reflection.PropertyInfo property, FieldInfo field)
		{
			if (property != null && property.CanWrite)
			{
				return property.SetValue;
			}
			if (field != null)
			{
				return field.SetValue;
			}
			return null;
		}

		private bool UpdateArrayItemProperties(PropertyInfo property)
		{
			if (property.Value == null)
			{
				if (property.Children != null)
				{
					property.Children = null;
					return true;
				}
				return false;
			}
			if (property.Children == null)
			{
				property.Children = new List<PropertyInfo>();
			}
			int num = ArrayOrList.Count(property.Value);
			int i = property.ChildProps.Count;
			if (num < i)
			{
				property.ChildProps.RemoveRange(num, i - num);
				return true;
			}
			if (num > i)
			{
				Type elementType = ArrayOrList.GetElementType(property.PropertyType);
				for (; num > i; i++)
				{
					int index = i;
					PropertySetter setter = (object o, object v) =>
					{
						ArrayOrList.Set(o, index, v);
					};
					PropertyGetter getter = (object o) => ArrayOrList.Get(o, index);
					AddPropertyRecursively(property.Value, property.ChildProps, index.ToString(), elementType, setter, getter);
				}
				return true;
			}
			return false;
		}

		private void AddPropertyRecursively(object parent, List<PropertyInfo> list, string name, Type type, PropertySetter setter, PropertyGetter getter, PropertyUpdater updater = null)
		{
			if (HasEditor(type))
			{
				PropertyInfo propertyInfo = AddPropertyToList(parent, list, name, type, setter, getter, updater);
				if (type.IsSubclassOf(typeof(UnityEngine.Object)) && propertyInfo.Value as UnityEngine.Object != null)
				{
					Type type2 = propertyInfo.Value.GetType();
					if (type == typeof(Material))
					{
						propertyInfo.Children = new List<PropertyInfo>();
						AddMaterialProperties(propertyInfo.Value as Material, propertyInfo.ChildProps);
					}
					else if (type2.IsSubclassOf(typeof(ScriptableObject)))
					{
						propertyInfo.Children = new List<PropertyInfo>();
						AddChildProperties(propertyInfo.Value, type2, propertyInfo.ChildProps);
					}
				}
			}
			else if (ArrayOrList.IsArrayOrList(type))
			{
				PropertyInfo property = AddPropertyToList(parent, list, name, type, setter, getter, updater);
				UpdateArrayItemProperties(property);
			}
			else
			{
				PropertyInfo propertyInfo2 = AddPropertyToList(parent, list, name, type, setter, getter, updater);
				propertyInfo2.Children = new List<PropertyInfo>();
				if (propertyInfo2.Value != null)
				{
					AddChildProperties(propertyInfo2.Value, type, propertyInfo2.ChildProps);
				}
			}
		}

		private void AddMaterialProperties(Material material, List<PropertyInfo> children)
		{
			Shader shader = material.shader;
			int propertyCount = shader.GetPropertyCount();
			for (int i = 0; i < propertyCount; i++)
			{
				string propertyName = shader.GetPropertyName(i);
				switch (shader.GetPropertyType(i))
				{
				case ShaderPropertyType.Color:
					AddPropertyToList(material, children, propertyName, typeof(Color), (object o, object v) =>
					{
						material.SetColor(propertyName, (Color)v);
					}, (object o) => material.GetColor(propertyName), null);
					break;
				case ShaderPropertyType.Vector:
					AddPropertyToList(material, children, propertyName, typeof(Vector4), (object o, object v) =>
					{
						material.SetVector(propertyName, (Vector4)v);
					}, (object o) => material.GetVector(propertyName), null);
					break;
				case ShaderPropertyType.Float:
				case ShaderPropertyType.Range:
					AddPropertyToList(material, children, propertyName, typeof(float), (object o, object v) =>
					{
						material.SetFloat(propertyName, (float)v);
					}, (object o) => material.GetFloat(propertyName), null);
					break;
				case ShaderPropertyType.Texture:
					AddPropertyToList(material, children, propertyName, typeof(Texture), (object o, object v) =>
					{
						material.SetTexture(propertyName, (Texture)v);
					}, (object o) => material.GetTexture(propertyName), null);
					break;
				case ShaderPropertyType.Int:
					AddPropertyToList(material, children, propertyName, typeof(int), (object o, object v) =>
					{
						material.SetInt(propertyName, (int)v);
					}, (object o) => material.GetInt(propertyName), null);
					break;
				}
			}
		}

		private void AddPropertyRecursively(object parent, List<PropertyInfo> list, string name, System.Reflection.PropertyInfo property, FieldInfo field)
		{
			Type type = ((property != null) ? property.PropertyType : field.FieldType);
			PropertySetter propertySetter = GetPropertySetter(property, field);
			PropertyGetter propertyGetter = GetPropertyGetter(property, field);
			AddPropertyRecursively(parent, list, name, type, propertySetter, propertyGetter);
		}

		private void AddEnabledProperty(ComponentInfo ci)
		{
			PropertySetter setter = (object c, object v) =>
			{
				((MonoBehaviour)c).enabled = (bool)v;
			};
			PropertyGetter getter = (object c) => ((MonoBehaviour)c).enabled;
			PropertyUpdater updater = delegate(object o, ref object v)
			{
				bool enabled = ((MonoBehaviour)o).enabled;
				if (!enabled.Equals((bool)v))
				{
					v = enabled;
					return true;
				}
				return false;
			};
			AddPropertyToList(ci.Component, ci.Props, "enabled", typeof(bool), setter, getter, updater);
		}

		private void AddChildProperties(object parent, Type type, List<PropertyInfo> list)
		{
			FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			foreach (FieldInfo fieldInfo in fields)
			{
				if ((fieldInfo.IsPublic || fieldInfo.GetCustomAttribute<SerializeField>() != null) && fieldInfo.GetCustomAttribute<HideInInspector>() == null)
				{
					string fieldWithoutPrefix;
					if (fieldInfo.Name.StartsWith("m_"))
					{
						fieldWithoutPrefix = fieldInfo.Name.Substring(2);
					}
					else
					{
						fieldWithoutPrefix = (fieldInfo.Name.StartsWith("_") ? fieldInfo.Name.Substring(1) : fieldInfo.Name);
					}
					string fieldWithoutPrefixUpperCase = fieldWithoutPrefix[0].ToString().ToUpper() + fieldWithoutPrefix.Substring(1);
					System.Reflection.PropertyInfo propertyInfo = type.GetProperties().FirstOrDefault((System.Reflection.PropertyInfo p) => p.Name == fieldWithoutPrefix || p.Name == fieldWithoutPrefixUpperCase);
					if (propertyInfo != null && propertyInfo.PropertyType == fieldInfo.FieldType && ShouldUseProperty(propertyInfo))
					{
						AddPropertyRecursively(parent, list, propertyInfo.Name, propertyInfo, fieldInfo);
					}
					else if (ShouldUseField(fieldInfo))
					{
						AddPropertyRecursively(parent, list, fieldInfo.Name, null, fieldInfo);
					}
				}
			}
			if (!_nativeSerializedTypes.Contains(type))
			{
				return;
			}
			System.Reflection.PropertyInfo[] properties = type.GetProperties(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			foreach (System.Reflection.PropertyInfo propertyInfo2 in properties)
			{
				if (propertyInfo2.CanWrite && ShouldUseProperty(propertyInfo2))
				{
					AddPropertyRecursively(parent, list, propertyInfo2.Name, propertyInfo2, null);
				}
			}
		}

		private void CreatePropertiesForMonoBehaviour(Component component, ComponentInfo ci)
		{
			AddEnabledProperty(ci);
			AddChildProperties(component, component.GetType(), ci.Props);
		}

		private bool HasEditor(Type type)
		{
			if (!_typesWithEditor.Contains(type.Name) && !type.IsEnum)
			{
				return type.IsSubclassOf(typeof(UnityEngine.Object));
			}
			return true;
		}

		private bool ShouldUseType(Type type)
		{
			if (!type.IsArray && type.IsSerializable)
			{
				return true;
			}
			if (HasEditor(type))
			{
				return true;
			}
			if (type.IsArray && ShouldUseType(type.GetElementType()))
			{
				return true;
			}
			if (typeof(IList).IsAssignableFrom(type) && type.IsGenericType && ShouldUseType(type.GetGenericArguments()[0]))
			{
				return true;
			}
			if (_nativeSerializedTypes.Contains(type))
			{
				return true;
			}
			return false;
		}

		private bool ShouldUse(IEnumerable<Attribute> attributes, string name, Type type)
		{
			IEnumerable<string> first = attributes.Select((Attribute a) => a.GetType().Name);
			if (ShouldUseType(type))
			{
				return !first.Intersect(_disallowedAttrs).Any();
			}
			return false;
		}

		private bool ShouldUseProperty(System.Reflection.PropertyInfo property)
		{
			return ShouldUse(property.GetCustomAttributes(), property.Name, property.PropertyType);
		}

		private bool ShouldUseField(FieldInfo field)
		{
			return ShouldUse(field.GetCustomAttributes(), field.Name, field.FieldType);
		}

		private void CreatePropertiesForNativeObject(Component component, ComponentInfo ci)
		{
			System.Reflection.PropertyInfo[] properties = component.GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public);
			foreach (System.Reflection.PropertyInfo propertyInfo in properties)
			{
				if (ShouldUseProperty(propertyInfo))
				{
					AddPropertyRecursively(ci.Component, ci.Props, propertyInfo.Name, propertyInfo, null);
				}
			}
		}
	}

	private static Dictionary<int, ComponentStream> _goToStream;

	private static Dictionary<string, ComponentStream> _streams;

	private static Dictionary<int, ComponentInfo> _idToComponentInfo;

	private static List<ComponentInfo> _pool = new List<ComponentInfo>();

	private static readonly int _poolSize = 25;

	internal static Action<Component, ComponentInfo> ProHook_CreateComponentButtons;

	public static Dictionary<int, ComponentInfo> IdToComponentInfo => _idToComponentInfo;

	private static ComponentInfo GetFromPool(int id, string name, Component component, bool temp)
	{
		ComponentInfo componentInfo;
		if (_pool.Count > 0)
		{
			componentInfo = _pool[_pool.Count - 1];
			_pool.RemoveAt(_pool.Count - 1);
		}
		else
		{
			componentInfo = new ComponentInfo
			{
				Properties = new List<PropertyInfo>(),
				Buttons = new List<ButtonInfo>()
			};
		}
		componentInfo.Id = id;
		componentInfo.Name = name;
		componentInfo.Component = component;
		componentInfo.Temp = temp;
		return componentInfo;
	}

	private static void ReturnToPool(ComponentInfo info)
	{
		if (_pool.Count < _poolSize)
		{
			info.Id = 0;
			info.Name = null;
			info.Component = null;
			info.Props.Clear();
			info.Btns.Clear();
			_pool.Add(info);
		}
	}

	private static bool AreEqual(object lhs, object rhs)
	{
		if (lhs == null && rhs == null)
		{
			return true;
		}
		if (lhs == null || rhs == null)
		{
			return false;
		}
		return lhs.Equals(rhs);
	}

	[ProximaInitialize]
	public static void Init()
	{
		_goToStream = new Dictionary<int, ComponentStream>();
		_streams = new Dictionary<string, ComponentStream>();
		_idToComponentInfo = new Dictionary<int, ComponentInfo>();
	}

	[ProximaTeardown]
	public static void Teardown()
	{
		foreach (ComponentStream value in _streams.Values)
		{
			value.Cleanup();
		}
		_goToStream.Clear();
		_streams.Clear();
		_idToComponentInfo.Clear();
	}

	[ProximaStreamStart("Components", false)]
	public static void StartStream(string id, int gameObjectId)
	{
		if (!_goToStream.TryGetValue(gameObjectId, out var value))
		{
			value = new ComponentStream();
			value.GameObjectId = gameObjectId;
			_goToStream.Add(gameObjectId, value);
		}
		value.PendingStreamIds.Add(id);
		_streams.Add(id, value);
	}

	[ProximaStreamUpdate("Components", false)]
	public static ComponentList UpdateStream(string id)
	{
		if (_streams.TryGetValue(id, out var value))
		{
			return value.Update(id);
		}
		return null;
	}

	[ProximaStreamStop("Components", false)]
	public static void StopStream(string id)
	{
		if (_streams.TryGetValue(id, out var value))
		{
			value.PendingStreamIds.Remove(id);
			value.ActiveStreamIds.Remove(id);
			if (value.PendingStreamIds.Count == 0 && value.ActiveStreamIds.Count == 0)
			{
				value.Cleanup();
				_goToStream.Remove(value.GameObjectId);
			}
		}
		_streams.Remove(id);
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void DestroyComponent(int id)
	{
		if (!_idToComponentInfo.TryGetValue(id, out var value))
		{
			Log.Warning($"DestroyComponent: Component with id {id} not found");
		}
		else if ((bool)value.Component)
		{
			UnityEngine.Object.DestroyImmediate(value.Component);
		}
	}

	public static object GetPropertyValueForTest(int componentId, string name)
	{
		if (_idToComponentInfo.TryGetValue(componentId, out var value))
		{
			PropertyInfo propertyInfo = value.Props.Find((PropertyInfo p) => p.Name == name);
			if (propertyInfo != null)
			{
				return propertyInfo.Getter(value.Component);
			}
		}
		return null;
	}

	public static Type GetPropertyTypeForTest(int componentId, string name)
	{
		if (_idToComponentInfo.TryGetValue(componentId, out var value))
		{
			PropertyInfo propertyInfo = value.Props.Find((PropertyInfo p) => p.Name == name);
			if (propertyInfo != null)
			{
				return propertyInfo.PropertyType;
			}
		}
		return null;
	}
}
