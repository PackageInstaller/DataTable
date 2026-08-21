using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Principal;

namespace System.Security.Claims;

[Serializable]
[ComVisible(true)]
public class ClaimsIdentity : IIdentity
{
	[NonSerialized]
	private byte[] m_userSerializationData;

	[NonSerialized]
	private List<Claim> m_instanceClaims = new List<Claim>();

	[NonSerialized]
	private Collection<IEnumerable<Claim>> m_externalClaims = new Collection<IEnumerable<Claim>>();

	[NonSerialized]
	private string m_nameType = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name";

	[NonSerialized]
	private string m_roleType = "http://schemas.microsoft.com/ws/2008/06/identity/claims/role";

	[OptionalField(VersionAdded = 2)]
	private string m_version = "1.0";

	[OptionalField(VersionAdded = 2)]
	private ClaimsIdentity m_actor;

	[OptionalField(VersionAdded = 2)]
	private string m_authenticationType;

	[OptionalField(VersionAdded = 2)]
	private object m_bootstrapContext;

	[OptionalField(VersionAdded = 2)]
	private string m_label;

	[OptionalField(VersionAdded = 2)]
	private string m_serializedNameType;

	[OptionalField(VersionAdded = 2)]
	private string m_serializedRoleType;

	[OptionalField(VersionAdded = 2)]
	private string m_serializedClaims;

	public virtual string AuthenticationType => m_authenticationType;

	public ClaimsIdentity Actor
	{
		get
		{
			return m_actor;
		}
		set
		{
			if (value != null && IsCircular(value))
			{
				throw new InvalidOperationException(Environment.GetResourceString("Actor cannot be set so that circular directed graph will exist chaining the subjects together."));
			}
			m_actor = value;
		}
	}

	public virtual IEnumerable<Claim> Claims
	{
		get
		{
			for (int i = 0; i < m_instanceClaims.Count; i++)
			{
				yield return m_instanceClaims[i];
			}
			if (m_externalClaims == null)
			{
				yield break;
			}
			for (int i = 0; i < m_externalClaims.Count; i++)
			{
				if (m_externalClaims[i] == null)
				{
					continue;
				}
				foreach (Claim item in m_externalClaims[i])
				{
					yield return item;
				}
			}
		}
	}

	public virtual string Name => FindFirst(m_nameType)?.Value;

	public string NameClaimType => m_nameType;

	public ClaimsIdentity()
		: this((IEnumerable<Claim>)null)
	{
	}

	public ClaimsIdentity(IEnumerable<Claim> claims)
		: this(null, claims, null, null, null)
	{
	}

	public ClaimsIdentity(IIdentity identity, IEnumerable<Claim> claims, string authenticationType, string nameType, string roleType)
		: this(identity, claims, authenticationType, nameType, roleType, checkAuthType: true)
	{
	}

	internal ClaimsIdentity(IIdentity identity, IEnumerable<Claim> claims, string authenticationType, string nameType, string roleType, bool checkAuthType)
	{
		bool flag = false;
		bool flag2 = false;
		if (checkAuthType && identity != null && string.IsNullOrEmpty(authenticationType))
		{
			if (identity is WindowsIdentity)
			{
				try
				{
					m_authenticationType = identity.AuthenticationType;
				}
				catch (UnauthorizedAccessException)
				{
					m_authenticationType = null;
				}
			}
			else
			{
				m_authenticationType = identity.AuthenticationType;
			}
		}
		else
		{
			m_authenticationType = authenticationType;
		}
		if (!string.IsNullOrEmpty(nameType))
		{
			m_nameType = nameType;
			flag = true;
		}
		if (!string.IsNullOrEmpty(roleType))
		{
			m_roleType = roleType;
			flag2 = true;
		}
		if (identity is ClaimsIdentity claimsIdentity)
		{
			m_label = claimsIdentity.m_label;
			if (!flag)
			{
				m_nameType = claimsIdentity.m_nameType;
			}
			if (!flag2)
			{
				m_roleType = claimsIdentity.m_roleType;
			}
			m_bootstrapContext = claimsIdentity.m_bootstrapContext;
			if (claimsIdentity.Actor != null)
			{
				if (IsCircular(claimsIdentity.Actor))
				{
					throw new InvalidOperationException(Environment.GetResourceString("Actor cannot be set so that circular directed graph will exist chaining the subjects together."));
				}
				if (!AppContextSwitches.SetActorAsReferenceWhenCopyingClaimsIdentity)
				{
					m_actor = claimsIdentity.Actor.Clone();
				}
				else
				{
					m_actor = claimsIdentity.Actor;
				}
			}
			if (claimsIdentity is WindowsIdentity && !(this is WindowsIdentity))
			{
				SafeAddClaims(claimsIdentity.Claims);
			}
			else
			{
				SafeAddClaims(claimsIdentity.m_instanceClaims);
			}
			if (claimsIdentity.m_userSerializationData != null)
			{
				m_userSerializationData = claimsIdentity.m_userSerializationData.Clone() as byte[];
			}
		}
		else if (identity != null && !string.IsNullOrEmpty(identity.Name))
		{
			SafeAddClaim(new Claim(m_nameType, identity.Name, "http://www.w3.org/2001/XMLSchema#string", "LOCAL AUTHORITY", "LOCAL AUTHORITY", this));
		}
		if (claims != null)
		{
			SafeAddClaims(claims);
		}
	}

	protected ClaimsIdentity(ClaimsIdentity other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (other.m_actor != null)
		{
			m_actor = other.m_actor.Clone();
		}
		m_authenticationType = other.m_authenticationType;
		m_bootstrapContext = other.m_bootstrapContext;
		m_label = other.m_label;
		m_nameType = other.m_nameType;
		m_roleType = other.m_roleType;
		if (other.m_userSerializationData != null)
		{
			m_userSerializationData = other.m_userSerializationData.Clone() as byte[];
		}
		SafeAddClaims(other.m_instanceClaims);
	}

	protected ClaimsIdentity(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		Deserialize(info, context, useContext: true);
	}

	public virtual ClaimsIdentity Clone()
	{
		ClaimsIdentity claimsIdentity = new ClaimsIdentity(m_instanceClaims);
		claimsIdentity.m_authenticationType = m_authenticationType;
		claimsIdentity.m_bootstrapContext = m_bootstrapContext;
		claimsIdentity.m_label = m_label;
		claimsIdentity.m_nameType = m_nameType;
		claimsIdentity.m_roleType = m_roleType;
		if (Actor != null)
		{
			if (IsCircular(Actor))
			{
				throw new InvalidOperationException(Environment.GetResourceString("Actor cannot be set so that circular directed graph will exist chaining the subjects together."));
			}
			if (!AppContextSwitches.SetActorAsReferenceWhenCopyingClaimsIdentity)
			{
				claimsIdentity.Actor = Actor.Clone();
			}
			else
			{
				claimsIdentity.Actor = Actor;
			}
		}
		return claimsIdentity;
	}

	public virtual void AddClaim(Claim claim)
	{
		if (claim == null)
		{
			throw new ArgumentNullException("claim");
		}
		if (claim.Subject == this)
		{
			m_instanceClaims.Add(claim);
		}
		else
		{
			m_instanceClaims.Add(claim.Clone(this));
		}
	}

	private void SafeAddClaims(IEnumerable<Claim> claims)
	{
		foreach (Claim claim in claims)
		{
			if (claim.Subject == this)
			{
				m_instanceClaims.Add(claim);
			}
			else
			{
				m_instanceClaims.Add(claim.Clone(this));
			}
		}
	}

	private void SafeAddClaim(Claim claim)
	{
		if (claim.Subject == this)
		{
			m_instanceClaims.Add(claim);
		}
		else
		{
			m_instanceClaims.Add(claim.Clone(this));
		}
	}

	public virtual Claim FindFirst(string type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		foreach (Claim claim in Claims)
		{
			if (claim != null && string.Equals(claim.Type, type, StringComparison.OrdinalIgnoreCase))
			{
				return claim;
			}
		}
		return null;
	}

	[OnSerializing]
	private void OnSerializingMethod(StreamingContext context)
	{
		if (!(this is ISerializable))
		{
			m_serializedClaims = SerializeClaims();
			m_serializedNameType = m_nameType;
			m_serializedRoleType = m_roleType;
		}
	}

	[OnDeserialized]
	private void OnDeserializedMethod(StreamingContext context)
	{
		if (!(this is ISerializable))
		{
			if (!string.IsNullOrEmpty(m_serializedClaims))
			{
				DeserializeClaims(m_serializedClaims);
				m_serializedClaims = null;
			}
			m_nameType = (string.IsNullOrEmpty(m_serializedNameType) ? "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name" : m_serializedNameType);
			m_roleType = (string.IsNullOrEmpty(m_serializedRoleType) ? "http://schemas.microsoft.com/ws/2008/06/identity/claims/role" : m_serializedRoleType);
		}
	}

	[OnDeserializing]
	private void OnDeserializingMethod(StreamingContext context)
	{
		if (!(this is ISerializable))
		{
			m_instanceClaims = new List<Claim>();
			m_externalClaims = new Collection<IEnumerable<Claim>>();
		}
	}

	protected virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		info.AddValue("System.Security.ClaimsIdentity.version", m_version);
		if (!string.IsNullOrEmpty(m_authenticationType))
		{
			info.AddValue("System.Security.ClaimsIdentity.authenticationType", m_authenticationType);
		}
		info.AddValue("System.Security.ClaimsIdentity.nameClaimType", m_nameType);
		info.AddValue("System.Security.ClaimsIdentity.roleClaimType", m_roleType);
		if (!string.IsNullOrEmpty(m_label))
		{
			info.AddValue("System.Security.ClaimsIdentity.label", m_label);
		}
		if (m_actor != null)
		{
			using MemoryStream memoryStream = new MemoryStream();
			binaryFormatter.Serialize(memoryStream, m_actor, null, fCheck: false);
			info.AddValue("System.Security.ClaimsIdentity.actor", Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length));
		}
		info.AddValue("System.Security.ClaimsIdentity.claims", SerializeClaims());
		if (m_bootstrapContext != null)
		{
			using (MemoryStream memoryStream2 = new MemoryStream())
			{
				binaryFormatter.Serialize(memoryStream2, m_bootstrapContext, null, fCheck: false);
				info.AddValue("System.Security.ClaimsIdentity.bootstrapContext", Convert.ToBase64String(memoryStream2.GetBuffer(), 0, (int)memoryStream2.Length));
			}
		}
	}

	private void DeserializeClaims(string serializedClaims)
	{
		if (!string.IsNullOrEmpty(serializedClaims))
		{
			using MemoryStream serializationStream = new MemoryStream(Convert.FromBase64String(serializedClaims));
			m_instanceClaims = (List<Claim>)new BinaryFormatter().Deserialize(serializationStream, null, fCheck: false);
			for (int i = 0; i < m_instanceClaims.Count; i++)
			{
				m_instanceClaims[i].Subject = this;
			}
		}
		if (m_instanceClaims == null)
		{
			m_instanceClaims = new List<Claim>();
		}
	}

	private string SerializeClaims()
	{
		using MemoryStream memoryStream = new MemoryStream();
		new BinaryFormatter().Serialize(memoryStream, m_instanceClaims, null, fCheck: false);
		return Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length);
	}

	private bool IsCircular(ClaimsIdentity subject)
	{
		if (this == subject)
		{
			return true;
		}
		ClaimsIdentity claimsIdentity = subject;
		while (claimsIdentity.Actor != null)
		{
			if (this == claimsIdentity.Actor)
			{
				return true;
			}
			claimsIdentity = claimsIdentity.Actor;
		}
		return false;
	}

	private void Deserialize(SerializationInfo info, StreamingContext context, bool useContext)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		BinaryFormatter binaryFormatter = ((!useContext) ? new BinaryFormatter() : new BinaryFormatter(null, context));
		foreach (string item in info)
		{
			switch (item)
			{
			case "System.Security.ClaimsIdentity.version":
				info.GetString("System.Security.ClaimsIdentity.version");
				break;
			case "System.Security.ClaimsIdentity.authenticationType":
				m_authenticationType = info.GetString("System.Security.ClaimsIdentity.authenticationType");
				break;
			case "System.Security.ClaimsIdentity.nameClaimType":
				m_nameType = info.GetString("System.Security.ClaimsIdentity.nameClaimType");
				break;
			case "System.Security.ClaimsIdentity.roleClaimType":
				m_roleType = info.GetString("System.Security.ClaimsIdentity.roleClaimType");
				break;
			case "System.Security.ClaimsIdentity.label":
				m_label = info.GetString("System.Security.ClaimsIdentity.label");
				break;
			case "System.Security.ClaimsIdentity.actor":
			{
				using (MemoryStream serializationStream2 = new MemoryStream(Convert.FromBase64String(info.GetString("System.Security.ClaimsIdentity.actor"))))
				{
					m_actor = (ClaimsIdentity)binaryFormatter.Deserialize(serializationStream2, null, fCheck: false);
				}
				break;
			}
			case "System.Security.ClaimsIdentity.claims":
				DeserializeClaims(info.GetString("System.Security.ClaimsIdentity.claims"));
				break;
			case "System.Security.ClaimsIdentity.bootstrapContext":
			{
				using (MemoryStream serializationStream = new MemoryStream(Convert.FromBase64String(info.GetString("System.Security.ClaimsIdentity.bootstrapContext"))))
				{
					m_bootstrapContext = binaryFormatter.Deserialize(serializationStream, null, fCheck: false);
				}
				break;
			}
			}
		}
	}
}
