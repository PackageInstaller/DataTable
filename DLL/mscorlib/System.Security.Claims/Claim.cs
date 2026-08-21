using System.Collections.Generic;
using System.Globalization;
using System.Runtime.Serialization;

namespace System.Security.Claims;

[Serializable]
public class Claim
{
	private string m_issuer;

	private string m_originalIssuer;

	private string m_type;

	private string m_value;

	private string m_valueType;

	[NonSerialized]
	private byte[] m_userSerializationData;

	private Dictionary<string, string> m_properties;

	[NonSerialized]
	private object m_propertyLock = new object();

	[NonSerialized]
	private ClaimsIdentity m_subject;

	public IDictionary<string, string> Properties
	{
		get
		{
			if (m_properties == null)
			{
				lock (m_propertyLock)
				{
					if (m_properties == null)
					{
						m_properties = new Dictionary<string, string>();
					}
				}
			}
			return m_properties;
		}
	}

	public ClaimsIdentity Subject
	{
		get
		{
			return m_subject;
		}
		internal set
		{
			m_subject = value;
		}
	}

	public string Type => m_type;

	public string Value => m_value;

	public Claim(string type, string value, string valueType, string issuer, string originalIssuer, ClaimsIdentity subject)
		: this(type, value, valueType, issuer, originalIssuer, subject, null, null)
	{
	}

	internal Claim(string type, string value, string valueType, string issuer, string originalIssuer, ClaimsIdentity subject, string propertyKey, string propertyValue)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		m_type = type;
		m_value = value;
		if (string.IsNullOrEmpty(valueType))
		{
			m_valueType = "http://www.w3.org/2001/XMLSchema#string";
		}
		else
		{
			m_valueType = valueType;
		}
		if (string.IsNullOrEmpty(issuer))
		{
			m_issuer = "LOCAL AUTHORITY";
		}
		else
		{
			m_issuer = issuer;
		}
		if (string.IsNullOrEmpty(originalIssuer))
		{
			m_originalIssuer = m_issuer;
		}
		else
		{
			m_originalIssuer = originalIssuer;
		}
		m_subject = subject;
		if (propertyKey != null)
		{
			Properties.Add(propertyKey, propertyValue);
		}
	}

	protected Claim(Claim other, ClaimsIdentity subject)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		m_issuer = other.m_issuer;
		m_originalIssuer = other.m_originalIssuer;
		m_subject = subject;
		m_type = other.m_type;
		m_value = other.m_value;
		m_valueType = other.m_valueType;
		if (other.m_properties != null)
		{
			m_properties = new Dictionary<string, string>();
			foreach (string key in other.m_properties.Keys)
			{
				m_properties.Add(key, other.m_properties[key]);
			}
		}
		if (other.m_userSerializationData != null)
		{
			m_userSerializationData = other.m_userSerializationData.Clone() as byte[];
		}
	}

	[OnDeserialized]
	private void OnDeserializedMethod(StreamingContext context)
	{
		m_propertyLock = new object();
	}

	public virtual Claim Clone(ClaimsIdentity identity)
	{
		return new Claim(this, identity);
	}

	public override string ToString()
	{
		return string.Format(CultureInfo.InvariantCulture, "{0}: {1}", m_type, m_value);
	}
}
