using System;
using System.Collections.Generic;
using UnityEngine.Localization.PropertyVariants.TrackedProperties;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.PropertyVariants.TrackedObjects;

[Serializable]
public abstract class TrackedObject : ISerializationCallbackReceiver
{
	[Serializable]
	internal class TrackedPropertiesCollection
	{
		[SerializeReference]
		public List<ITrackedProperty> items = new List<ITrackedProperty>();
	}

	[SerializeField]
	[HideInInspector]
	private Object m_Target;

	[SerializeField]
	private TrackedPropertiesCollection m_TrackedProperties = new TrackedPropertiesCollection();

	private readonly Dictionary<string, ITrackedProperty> m_PropertiesLookup = new Dictionary<string, ITrackedProperty>();

	public Object Target
	{
		get
		{
			return m_Target;
		}
		set
		{
			m_Target = value;
		}
	}

	public IList<ITrackedProperty> TrackedProperties => m_TrackedProperties.items;

	public virtual bool CanTrackProperty(string propertyPath)
	{
		return true;
	}

	public T AddTrackedProperty<T>(string propertyPath) where T : ITrackedProperty, new()
	{
		T val = new T
		{
			PropertyPath = propertyPath
		};
		AddTrackedProperty(val);
		return val;
	}

	public virtual void AddTrackedProperty(ITrackedProperty trackedProperty)
	{
		if (trackedProperty == null)
		{
			throw new ArgumentNullException("trackedProperty");
		}
		if (string.IsNullOrEmpty(trackedProperty.PropertyPath))
		{
			throw new ArgumentException("Property path must not be null or empty.");
		}
		if (m_PropertiesLookup.ContainsKey(trackedProperty.PropertyPath))
		{
			throw new ArgumentException(trackedProperty.PropertyPath + " is already tracked.");
		}
		m_PropertiesLookup[trackedProperty.PropertyPath] = trackedProperty;
		TrackedProperties.Add(trackedProperty);
	}

	public virtual bool RemoveTrackedProperty(ITrackedProperty trackedProperty)
	{
		m_PropertiesLookup.Remove(trackedProperty.PropertyPath);
		return TrackedProperties.Remove(trackedProperty);
	}

	public T GetTrackedProperty<T>(string propertyPath, bool create = true) where T : ITrackedProperty, new()
	{
		ITrackedProperty trackedProperty = GetTrackedProperty(propertyPath);
		if (trackedProperty is T)
		{
			return (T)trackedProperty;
		}
		if (!create)
		{
			return default;
		}
		return AddTrackedProperty<T>(propertyPath);
	}

	public virtual ITrackedProperty GetTrackedProperty(string propertyPath)
	{
		if (!m_PropertiesLookup.TryGetValue(propertyPath, out var value))
		{
			return null;
		}
		return value;
	}

	public virtual ITrackedProperty CreateCustomTrackedProperty(string propertyPath)
	{
		return null;
	}

	public abstract AsyncOperationHandle ApplyLocale(Locale variantLocale, Locale defaultLocale);

	protected virtual void PostApplyTrackedProperties()
	{
	}

	public void OnAfterDeserialize()
	{
		m_PropertiesLookup.Clear();
		foreach (ITrackedProperty item in m_TrackedProperties.items)
		{
			m_PropertiesLookup[item.PropertyPath] = item;
		}
	}

	public void OnBeforeSerialize()
	{
		m_TrackedProperties.items.Clear();
		foreach (ITrackedProperty value in m_PropertiesLookup.Values)
		{
			m_TrackedProperties.items.Add(value);
		}
	}
}
