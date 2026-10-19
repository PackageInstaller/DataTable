using System;
using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat;

namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

[Serializable]
public class TrackedProperty<TPrimitive> : ITrackedPropertyValue<TPrimitive>, ITrackedProperty, IStringProperty, ISerializationCallbackReceiver, ITrackedPropertyRemoveVariant
{
	[Serializable]
	internal class LocaleIdentifierValuePair
	{
		public LocaleIdentifier localeIdentifier;

		public TPrimitive value;
	}

	[SerializeField]
	private string m_PropertyPath;

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

	public bool HasVariant(LocaleIdentifier localeIdentifier)
	{
		return m_VariantLookup.ContainsKey(localeIdentifier);
	}

	public void RemoveVariant(LocaleIdentifier localeIdentifier)
	{
		m_VariantLookup.Remove(localeIdentifier);
	}

	public bool GetValue(LocaleIdentifier localeIdentifier, out TPrimitive foundValue)
	{
		if (m_VariantLookup.TryGetValue(localeIdentifier, out var value))
		{
			foundValue = value.value;
			return true;
		}
		foundValue = default;
		return false;
	}

	public bool GetValue(LocaleIdentifier localeIdentifier, LocaleIdentifier fallback, out TPrimitive foundValue)
	{
		if (m_VariantLookup.TryGetValue(localeIdentifier, out var value) || m_VariantLookup.TryGetValue(fallback, out value))
		{
			foundValue = value.value;
			return true;
		}
		foundValue = default;
		return false;
	}

	public void SetValue(LocaleIdentifier localeIdentifier, TPrimitive value)
	{
		if (!m_VariantLookup.TryGetValue(localeIdentifier, out var value2))
		{
			value2 = new LocaleIdentifierValuePair
			{
				localeIdentifier = localeIdentifier
			};
			m_VariantLookup[localeIdentifier] = value2;
		}
		value2.value = value;
	}

	public string GetValueAsString(LocaleIdentifier localeIdentifier)
	{
		if (!GetValue(localeIdentifier, out var foundValue))
		{
			return null;
		}
		return ConvertToString(foundValue);
	}

	public string GetValueAsString(LocaleIdentifier localeIdentifier, LocaleIdentifier fallback)
	{
		if (!GetValue(localeIdentifier, fallback, out var foundValue))
		{
			return null;
		}
		return ConvertToString(foundValue);
	}

	public void SetValueFromString(LocaleIdentifier localeIdentifier, string stringValue)
	{
		TPrimitive value = ConvertFromString(stringValue);
		SetValue(localeIdentifier, value);
	}

	protected virtual string ConvertToString(TPrimitive value)
	{
		return Convert.ToString(value);
	}

	protected virtual TPrimitive ConvertFromString(string value)
	{
		return (TPrimitive)Convert.ChangeType(value, typeof(TPrimitive));
	}

	public void OnBeforeSerialize()
	{
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
	}

	public override string ToString()
	{
		return Smart.Format("{GetType().Name}({PropertyPath}) - {1:list:{Key}({Value.value})|, |, }", this, m_VariantLookup);
	}
}
