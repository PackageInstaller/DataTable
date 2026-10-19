using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Layouts;

public struct InputDeviceMatcher : IEquatable<InputDeviceMatcher>
{
	[Serializable]
	internal struct MatcherJson
	{
		public struct Capability
		{
			public string path;

			public string value;
		}

		public string @interface;

		public string[] interfaces;

		public string deviceClass;

		public string[] deviceClasses;

		public string manufacturer;

		public string manufacturerContains;

		public string[] manufacturers;

		public string product;

		public string[] products;

		public string version;

		public string[] versions;

		public Capability[] capabilities;

		public static MatcherJson FromMatcher(InputDeviceMatcher matcher)
		{
			if (matcher.empty)
			{
				return default;
			}
			MatcherJson result = default;
			KeyValuePair<InternedString, object>[] patterns = matcher.m_Patterns;
			for (int i = 0; i < patterns.Length; i++)
			{
				KeyValuePair<InternedString, object> keyValuePair = patterns[i];
				InternedString key = keyValuePair.Key;
				string text = keyValuePair.Value.ToString();
				if (key == kInterfaceKey)
				{
					if (result.@interface == null)
					{
						result.@interface = text;
					}
					else
					{
						ArrayHelpers.Append(ref result.interfaces, text);
					}
				}
				else if (key == kDeviceClassKey)
				{
					if (result.deviceClass == null)
					{
						result.deviceClass = text;
					}
					else
					{
						ArrayHelpers.Append(ref result.deviceClasses, text);
					}
				}
				else if (key == kManufacturerKey)
				{
					if (result.manufacturer == null)
					{
						result.manufacturer = text;
					}
					else
					{
						ArrayHelpers.Append(ref result.manufacturers, text);
					}
				}
				else if (key == kProductKey)
				{
					if (result.product == null)
					{
						result.product = text;
					}
					else
					{
						ArrayHelpers.Append(ref result.products, text);
					}
				}
				else if (key == kVersionKey)
				{
					if (result.version == null)
					{
						result.version = text;
					}
					else
					{
						ArrayHelpers.Append(ref result.versions, text);
					}
				}
				else
				{
					ArrayHelpers.Append(ref result.capabilities, new Capability
					{
						path = key,
						value = text
					});
				}
			}
			return result;
		}

		public InputDeviceMatcher ToMatcher()
		{
			InputDeviceMatcher result = default;
			if (!string.IsNullOrEmpty(@interface))
			{
				result = result.WithInterface(@interface);
			}
			if (interfaces != null)
			{
				string[] array = interfaces;
				foreach (string pattern in array)
				{
					result = result.WithInterface(pattern);
				}
			}
			if (!string.IsNullOrEmpty(deviceClass))
			{
				result = result.WithDeviceClass(deviceClass);
			}
			if (deviceClasses != null)
			{
				string[] array = deviceClasses;
				foreach (string pattern2 in array)
				{
					result = result.WithDeviceClass(pattern2);
				}
			}
			if (!string.IsNullOrEmpty(manufacturer))
			{
				result = result.WithManufacturer(manufacturer);
			}
			if (manufacturers != null)
			{
				string[] array = manufacturers;
				foreach (string pattern3 in array)
				{
					result = result.WithManufacturer(pattern3);
				}
			}
			if (!string.IsNullOrEmpty(manufacturerContains))
			{
				result = result.WithManufacturerContains(manufacturerContains);
			}
			if (!string.IsNullOrEmpty(product))
			{
				result = result.WithProduct(product);
			}
			if (products != null)
			{
				string[] array = products;
				foreach (string pattern4 in array)
				{
					result = result.WithProduct(pattern4);
				}
			}
			if (!string.IsNullOrEmpty(version))
			{
				result = result.WithVersion(version);
			}
			if (versions != null)
			{
				string[] array = versions;
				foreach (string pattern5 in array)
				{
					result = result.WithVersion(pattern5);
				}
			}
			if (capabilities != null)
			{
				Capability[] array2 = capabilities;
				for (int i = 0; i < array2.Length; i++)
				{
					Capability capability = array2[i];
					result = result.WithCapability(capability.path, capability.value);
				}
			}
			return result;
		}
	}

	private KeyValuePair<InternedString, object>[] m_Patterns;

	private static readonly InternedString kInterfaceKey = new InternedString("interface");

	private static readonly InternedString kDeviceClassKey = new InternedString("deviceClass");

	private static readonly InternedString kManufacturerKey = new InternedString("manufacturer");

	private static readonly InternedString kManufacturerContainsKey = new InternedString("manufacturerContains");

	private static readonly InternedString kProductKey = new InternedString("product");

	private static readonly InternedString kVersionKey = new InternedString("version");

	public bool empty => m_Patterns == null;

	public IEnumerable<KeyValuePair<string, object>> patterns
	{
		get
		{
			if (m_Patterns != null)
			{
				int count = m_Patterns.Length;
				int i = 0;
				while (i < count)
				{
					yield return new KeyValuePair<string, object>(m_Patterns[i].Key.ToString(), m_Patterns[i].Value);
					int num = i + 1;
					i = num;
				}
			}
		}
	}

	public InputDeviceMatcher WithInterface(string pattern, bool supportRegex = true)
	{
		return With(kInterfaceKey, pattern, supportRegex);
	}

	public InputDeviceMatcher WithDeviceClass(string pattern, bool supportRegex = true)
	{
		return With(kDeviceClassKey, pattern, supportRegex);
	}

	public InputDeviceMatcher WithManufacturer(string pattern, bool supportRegex = true)
	{
		return With(kManufacturerKey, pattern, supportRegex);
	}

	public InputDeviceMatcher WithManufacturerContains(string noRegExPattern)
	{
		return With(kManufacturerContainsKey, noRegExPattern, supportRegex: false);
	}

	public InputDeviceMatcher WithProduct(string pattern, bool supportRegex = true)
	{
		return With(kProductKey, pattern, supportRegex);
	}

	public InputDeviceMatcher WithVersion(string pattern, bool supportRegex = true)
	{
		return With(kVersionKey, pattern, supportRegex);
	}

	public InputDeviceMatcher WithCapability<TValue>(string path, TValue value)
	{
		return With(new InternedString(path), value);
	}

	private InputDeviceMatcher With(InternedString key, object value, bool supportRegex = true)
	{
		if (supportRegex && value is string text && !text.All((char ch) => char.IsLetterOrDigit(ch) || char.IsWhiteSpace(ch)) && !double.TryParse(text, out var _))
		{
			value = new Regex(text, RegexOptions.IgnoreCase);
		}
		InputDeviceMatcher result2 = this;
		ArrayHelpers.Append(ref result2.m_Patterns, new KeyValuePair<InternedString, object>(key, value));
		return result2;
	}

	public float MatchPercentage(InputDeviceDescription deviceDescription)
	{
		if (empty)
		{
			return 0f;
		}
		int num = m_Patterns.Length;
		for (int i = 0; i < num; i++)
		{
			InternedString key = m_Patterns[i].Key;
			object value = m_Patterns[i].Value;
			if (key == kInterfaceKey)
			{
				if (string.IsNullOrEmpty(deviceDescription.interfaceName) || !MatchSingleProperty(value, deviceDescription.interfaceName))
				{
					return 0f;
				}
				continue;
			}
			if (key == kDeviceClassKey)
			{
				if (string.IsNullOrEmpty(deviceDescription.deviceClass) || !MatchSingleProperty(value, deviceDescription.deviceClass))
				{
					return 0f;
				}
				continue;
			}
			if (key == kManufacturerKey)
			{
				if (string.IsNullOrEmpty(deviceDescription.manufacturer) || !MatchSingleProperty(value, deviceDescription.manufacturer))
				{
					return 0f;
				}
				continue;
			}
			if (key == kManufacturerContainsKey)
			{
				if (string.IsNullOrEmpty(deviceDescription.manufacturer) || !MatchSinglePropertyContains(value, deviceDescription.manufacturer))
				{
					return 0f;
				}
				continue;
			}
			if (key == kProductKey)
			{
				if (string.IsNullOrEmpty(deviceDescription.product) || !MatchSingleProperty(value, deviceDescription.product))
				{
					return 0f;
				}
				continue;
			}
			if (key == kVersionKey)
			{
				if (string.IsNullOrEmpty(deviceDescription.version) || !MatchSingleProperty(value, deviceDescription.version))
				{
					return 0f;
				}
				continue;
			}
			if (string.IsNullOrEmpty(deviceDescription.capabilities))
			{
				return 0f;
			}
			JsonParser jsonParser = new JsonParser(deviceDescription.capabilities);
			if (!jsonParser.NavigateToProperty(key.ToString()) || !jsonParser.CurrentPropertyHasValueEqualTo(new JsonParser.JsonValue
			{
				type = JsonParser.JsonValueType.Any,
				anyValue = value
			}))
			{
				return 0f;
			}
		}
		int numPropertiesIn = GetNumPropertiesIn(deviceDescription);
		float num2 = 1f / (float)numPropertiesIn;
		return (float)num * num2;
	}

	private static bool MatchSingleProperty(object pattern, string value)
	{
		if (pattern is string strA)
		{
			return string.Compare(strA, value, StringComparison.OrdinalIgnoreCase) == 0;
		}
		if (pattern is Regex regex)
		{
			return regex.IsMatch(value);
		}
		return false;
	}

	private static bool MatchSinglePropertyContains(object pattern, string value)
	{
		if (pattern is string value2)
		{
			return value.Contains(value2, StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private static int GetNumPropertiesIn(InputDeviceDescription description)
	{
		int num = 0;
		if (!string.IsNullOrEmpty(description.interfaceName))
		{
			num++;
		}
		if (!string.IsNullOrEmpty(description.deviceClass))
		{
			num++;
		}
		if (!string.IsNullOrEmpty(description.manufacturer))
		{
			num++;
		}
		if (!string.IsNullOrEmpty(description.product))
		{
			num++;
		}
		if (!string.IsNullOrEmpty(description.version))
		{
			num++;
		}
		if (!string.IsNullOrEmpty(description.capabilities))
		{
			num++;
		}
		return num;
	}

	public static InputDeviceMatcher FromDeviceDescription(InputDeviceDescription deviceDescription)
	{
		InputDeviceMatcher result = default;
		if (!string.IsNullOrEmpty(deviceDescription.interfaceName))
		{
			result = result.WithInterface(deviceDescription.interfaceName, supportRegex: false);
		}
		if (!string.IsNullOrEmpty(deviceDescription.deviceClass))
		{
			result = result.WithDeviceClass(deviceDescription.deviceClass, supportRegex: false);
		}
		if (!string.IsNullOrEmpty(deviceDescription.manufacturer))
		{
			result = result.WithManufacturer(deviceDescription.manufacturer, supportRegex: false);
		}
		if (!string.IsNullOrEmpty(deviceDescription.product))
		{
			result = result.WithProduct(deviceDescription.product, supportRegex: false);
		}
		if (!string.IsNullOrEmpty(deviceDescription.version))
		{
			result = result.WithVersion(deviceDescription.version, supportRegex: false);
		}
		return result;
	}

	public override string ToString()
	{
		if (empty)
		{
			return "<empty>";
		}
		string text = string.Empty;
		KeyValuePair<InternedString, object>[] array = m_Patterns;
		for (int i = 0; i < array.Length; i++)
		{
			KeyValuePair<InternedString, object> keyValuePair = array[i];
			text = ((text.Length <= 0) ? (text + $"{keyValuePair.Key}={keyValuePair.Value}") : (text + $",{keyValuePair.Key}={keyValuePair.Value}"));
		}
		return text;
	}

	public bool Equals(InputDeviceMatcher other)
	{
		if (m_Patterns == other.m_Patterns)
		{
			return true;
		}
		if (m_Patterns == null || other.m_Patterns == null)
		{
			return false;
		}
		if (m_Patterns.Length != other.m_Patterns.Length)
		{
			return false;
		}
		for (int i = 0; i < m_Patterns.Length; i++)
		{
			KeyValuePair<InternedString, object> keyValuePair = m_Patterns[i];
			bool flag = false;
			for (int j = 0; j < m_Patterns.Length; j++)
			{
				KeyValuePair<InternedString, object> keyValuePair2 = other.m_Patterns[j];
				if (!(keyValuePair.Key != keyValuePair2.Key))
				{
					if (!keyValuePair.Value.Equals(keyValuePair2.Value))
					{
						return false;
					}
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is InputDeviceMatcher other)
		{
			return Equals(other);
		}
		return false;
	}

	public static bool operator ==(InputDeviceMatcher left, InputDeviceMatcher right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(InputDeviceMatcher left, InputDeviceMatcher right)
	{
		return !(left == right);
	}

	public override int GetHashCode()
	{
		if (m_Patterns == null)
		{
			return 0;
		}
		return m_Patterns.GetHashCode();
	}
}
