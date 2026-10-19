using System;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Layouts;

[Serializable]
public struct InputDeviceDescription : IEquatable<InputDeviceDescription>
{
	private struct DeviceDescriptionJson
	{
		public string @interface;

		public string type;

		public string product;

		public string serial;

		public string version;

		public string manufacturer;

		public string capabilities;
	}

	[SerializeField]
	private string m_InterfaceName;

	[SerializeField]
	private string m_DeviceClass;

	[SerializeField]
	private string m_Manufacturer;

	[SerializeField]
	private string m_Product;

	[SerializeField]
	private string m_Serial;

	[SerializeField]
	private string m_Version;

	[SerializeField]
	private string m_Capabilities;

	public string interfaceName
	{
		get
		{
			return m_InterfaceName;
		}
		set
		{
			m_InterfaceName = value;
		}
	}

	public string deviceClass
	{
		get
		{
			return m_DeviceClass;
		}
		set
		{
			m_DeviceClass = value;
		}
	}

	public string manufacturer
	{
		get
		{
			return m_Manufacturer;
		}
		set
		{
			m_Manufacturer = value;
		}
	}

	public string product
	{
		get
		{
			return m_Product;
		}
		set
		{
			m_Product = value;
		}
	}

	public string serial
	{
		get
		{
			return m_Serial;
		}
		set
		{
			m_Serial = value;
		}
	}

	public string version
	{
		get
		{
			return m_Version;
		}
		set
		{
			m_Version = value;
		}
	}

	public string capabilities
	{
		get
		{
			return m_Capabilities;
		}
		set
		{
			m_Capabilities = value;
		}
	}

	public bool empty
	{
		get
		{
			if (string.IsNullOrEmpty(m_InterfaceName) && string.IsNullOrEmpty(m_DeviceClass) && string.IsNullOrEmpty(m_Manufacturer) && string.IsNullOrEmpty(m_Product) && string.IsNullOrEmpty(m_Serial) && string.IsNullOrEmpty(m_Version))
			{
				return string.IsNullOrEmpty(m_Capabilities);
			}
			return false;
		}
	}

	public override string ToString()
	{
		bool flag = !string.IsNullOrEmpty(product);
		bool flag2 = !string.IsNullOrEmpty(manufacturer);
		bool flag3 = !string.IsNullOrEmpty(interfaceName);
		if (flag & flag2)
		{
			if (flag3)
			{
				return manufacturer + " " + product + " (" + interfaceName + ")";
			}
			return manufacturer + " " + product;
		}
		if (flag)
		{
			if (flag3)
			{
				return product + " (" + interfaceName + ")";
			}
			return product;
		}
		if (!string.IsNullOrEmpty(deviceClass))
		{
			if (flag3)
			{
				return deviceClass + " (" + interfaceName + ")";
			}
			return deviceClass;
		}
		if (!string.IsNullOrEmpty(capabilities))
		{
			string text = capabilities;
			if (capabilities.Length > 40)
			{
				text = text.Substring(0, 40) + "...";
			}
			if (flag3)
			{
				return text + " (" + interfaceName + ")";
			}
			return text;
		}
		if (flag3)
		{
			return interfaceName;
		}
		return "<Empty Device Description>";
	}

	public bool Equals(InputDeviceDescription other)
	{
		if (m_InterfaceName.InvariantEqualsIgnoreCase(other.m_InterfaceName) && m_DeviceClass.InvariantEqualsIgnoreCase(other.m_DeviceClass) && m_Manufacturer.InvariantEqualsIgnoreCase(other.m_Manufacturer) && m_Product.InvariantEqualsIgnoreCase(other.m_Product) && m_Serial.InvariantEqualsIgnoreCase(other.m_Serial) && m_Version.InvariantEqualsIgnoreCase(other.m_Version))
		{
			return m_Capabilities.InvariantEqualsIgnoreCase(other.m_Capabilities);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is InputDeviceDescription other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((((((((((((m_InterfaceName != null) ? m_InterfaceName.GetHashCode() : 0) * 397) ^ ((m_DeviceClass != null) ? m_DeviceClass.GetHashCode() : 0)) * 397) ^ ((m_Manufacturer != null) ? m_Manufacturer.GetHashCode() : 0)) * 397) ^ ((m_Product != null) ? m_Product.GetHashCode() : 0)) * 397) ^ ((m_Serial != null) ? m_Serial.GetHashCode() : 0)) * 397) ^ ((m_Version != null) ? m_Version.GetHashCode() : 0)) * 397) ^ ((m_Capabilities != null) ? m_Capabilities.GetHashCode() : 0);
	}

	public static bool operator ==(InputDeviceDescription left, InputDeviceDescription right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(InputDeviceDescription left, InputDeviceDescription right)
	{
		return !left.Equals(right);
	}

	public string ToJson()
	{
		return JsonUtility.ToJson(new DeviceDescriptionJson
		{
			@interface = interfaceName,
			type = deviceClass,
			product = product,
			manufacturer = manufacturer,
			serial = serial,
			version = version,
			capabilities = capabilities
		}, prettyPrint: true);
	}

	public static InputDeviceDescription FromJson(string json)
	{
		if (json == null)
		{
			throw new ArgumentNullException("json");
		}
		DeviceDescriptionJson deviceDescriptionJson = JsonUtility.FromJson<DeviceDescriptionJson>(json);
		return new InputDeviceDescription
		{
			interfaceName = deviceDescriptionJson.@interface,
			deviceClass = deviceDescriptionJson.type,
			product = deviceDescriptionJson.product,
			manufacturer = deviceDescriptionJson.manufacturer,
			serial = deviceDescriptionJson.serial,
			version = deviceDescriptionJson.version,
			capabilities = deviceDescriptionJson.capabilities
		};
	}

	internal static bool ComparePropertyToDeviceDescriptor(string propertyName, JsonParser.JsonString propertyValue, string deviceDescriptor)
	{
		JsonParser jsonParser = new JsonParser(deviceDescriptor);
		if (!jsonParser.NavigateToProperty(propertyName))
		{
			if (propertyValue.text.isEmpty)
			{
				return true;
			}
			return false;
		}
		return jsonParser.CurrentPropertyHasValueEqualTo(propertyValue);
	}
}
