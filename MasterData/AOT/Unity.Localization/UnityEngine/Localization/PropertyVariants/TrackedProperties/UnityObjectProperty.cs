using System;
using System.Collections.Generic;

namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

[Serializable]
public class UnityObjectProperty : ITrackedPropertyValue<Object>, ITrackedProperty, ISerializationCallbackReceiver
{
	[Serializable]
	internal class LocaleIdentifierValuePair
	{
		public LocaleIdentifier localeIdentifier;

		public LazyLoadReference<Object> value;
	}

	[SerializeField]
	private string m_PropertyPath;

	[SerializeField]
	private string m_TypeString;

	[SerializeField]
	private List<LocaleIdentifierValuePair> m_VariantData = new List<LocaleIdentifierValuePair>();

	internal Dictionary<LocaleIdentifier, LocaleIdentifierValuePair> m_VariantLookup = new Dictionary<LocaleIdentifier, LocaleIdentifierValuePair>();

	public string PropertyPath
	{
		get
		{
			return m_PropertyPath;
		}
		set
		{
			m_PropertyPath = value;
		}
	}

	public Type PropertyType { get; set; }

	public bool HasVariant(LocaleIdentifier localeIdentifier)
	{
		return m_VariantLookup.ContainsKey(localeIdentifier);
	}

	public void RemoveVariant(LocaleIdentifier localeIdentifier)
	{
		m_VariantLookup.Remove(localeIdentifier);
	}

	public bool GetValue(LocaleIdentifier localeIdentifier, out Object foundValue)
	{
		if (m_VariantLookup.TryGetValue(localeIdentifier, out var value))
		{
			foundValue = value.value.asset;
			return true;
		}
		foundValue = null;
		return false;
	}

	public bool GetValue(LocaleIdentifier localeIdentifier, LocaleIdentifier fallback, out Object foundValue)
	{
		if (m_VariantLookup.TryGetValue(localeIdentifier, out var value) || m_VariantLookup.TryGetValue(fallback, out value))
		{
			foundValue = value.value.asset;
			return true;
		}
		foundValue = null;
		return false;
	}

	public void SetValue(LocaleIdentifier localeIdentifier, Object newValue)
	{
		if (!m_VariantLookup.TryGetValue(localeIdentifier, out var value))
		{
			value = new LocaleIdentifierValuePair
			{
				localeIdentifier = localeIdentifier
			};
			m_VariantLookup[localeIdentifier] = value;
		}
		value.value.asset = newValue;
	}

	public void OnBeforeSerialize()
	{
		m_TypeString = PropertyType?.AssemblyQualifiedName;
		m_VariantData.Clear();
		foreach (LocaleIdentifierValuePair value in m_VariantLookup.Values)
		{
			m_VariantData.Add(value);
		}
	}

	public void OnAfterDeserialize()
	{
		m_VariantLookup.Clear();
		foreach (LocaleIdentifierValuePair variantDatum in m_VariantData)
		{
			m_VariantLookup[variantDatum.localeIdentifier] = variantDatum;
		}
		if (!string.IsNullOrEmpty(m_TypeString))
		{
			PropertyType = Type.GetType(m_TypeString);
		}
	}
}
