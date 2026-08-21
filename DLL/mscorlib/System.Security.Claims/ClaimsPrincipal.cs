using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Principal;

namespace System.Security.Claims;

[Serializable]
[ComVisible(true)]
public class ClaimsPrincipal : IPrincipal
{
	[OptionalField(VersionAdded = 2)]
	private string m_version = "1.0";

	[OptionalField(VersionAdded = 2)]
	private string m_serializedClaimsIdentities;

	[NonSerialized]
	private List<ClaimsIdentity> m_identities = new List<ClaimsIdentity>();

	[NonSerialized]
	private static Func<IEnumerable<ClaimsIdentity>, ClaimsIdentity> s_identitySelector = SelectPrimaryIdentity;

	[NonSerialized]
	private static Func<ClaimsPrincipal> s_principalSelector = ClaimsPrincipalSelector;

	public static Func<ClaimsPrincipal> ClaimsPrincipalSelector => s_principalSelector;

	public virtual IIdentity Identity
	{
		get
		{
			if (s_identitySelector != null)
			{
				return s_identitySelector(m_identities);
			}
			return SelectPrimaryIdentity(m_identities);
		}
	}

	private static ClaimsIdentity SelectPrimaryIdentity(IEnumerable<ClaimsIdentity> identities)
	{
		if (identities == null)
		{
			throw new ArgumentNullException("identities");
		}
		ClaimsIdentity claimsIdentity = null;
		foreach (ClaimsIdentity identity in identities)
		{
			if (identity is WindowsIdentity)
			{
				claimsIdentity = identity;
				break;
			}
			if (claimsIdentity == null)
			{
				claimsIdentity = identity;
			}
		}
		return claimsIdentity;
	}

	public ClaimsPrincipal()
	{
	}

	protected ClaimsPrincipal(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		Deserialize(info, context);
	}

	[OnSerializing]
	private void OnSerializingMethod(StreamingContext context)
	{
		if (!(this is ISerializable))
		{
			m_serializedClaimsIdentities = SerializeIdentities();
		}
	}

	[OnDeserialized]
	private void OnDeserializedMethod(StreamingContext context)
	{
		if (!(this is ISerializable))
		{
			DeserializeIdentities(m_serializedClaimsIdentities);
			m_serializedClaimsIdentities = null;
		}
	}

	private void Deserialize(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		foreach (string item in info)
		{
			if (!(item == "System.Security.ClaimsPrincipal.Identities"))
			{
				if (item == "System.Security.ClaimsPrincipal.Version")
				{
					m_version = info.GetString("System.Security.ClaimsPrincipal.Version");
				}
			}
			else
			{
				DeserializeIdentities(info.GetString("System.Security.ClaimsPrincipal.Identities"));
			}
		}
	}

	private void DeserializeIdentities(string identities)
	{
		m_identities = new List<ClaimsIdentity>();
		if (string.IsNullOrEmpty(identities))
		{
			return;
		}
		List<string> list = null;
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		using MemoryStream serializationStream = new MemoryStream(Convert.FromBase64String(identities));
		list = (List<string>)binaryFormatter.Deserialize(serializationStream, null, fCheck: false);
		for (int i = 0; i < list.Count; i += 2)
		{
			ClaimsIdentity claimsIdentity = null;
			using (MemoryStream serializationStream2 = new MemoryStream(Convert.FromBase64String(list[i + 1])))
			{
				claimsIdentity = (ClaimsIdentity)binaryFormatter.Deserialize(serializationStream2, null, fCheck: false);
			}
			if (!string.IsNullOrEmpty(list[i]))
			{
				if (!long.TryParse(list[i], NumberStyles.Integer, NumberFormatInfo.InvariantInfo, out var result))
				{
					throw new SerializationException(Environment.GetResourceString("Invalid BinaryFormatter stream."));
				}
				claimsIdentity = new WindowsIdentity(claimsIdentity, new IntPtr(result));
			}
			m_identities.Add(claimsIdentity);
		}
	}

	private string SerializeIdentities()
	{
		List<string> list = new List<string>();
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		foreach (ClaimsIdentity identity in m_identities)
		{
			if (identity.GetType() == typeof(WindowsIdentity))
			{
				WindowsIdentity windowsIdentity = identity as WindowsIdentity;
				list.Add(windowsIdentity.GetTokenInternal().ToInt64().ToString(NumberFormatInfo.InvariantInfo));
				using MemoryStream memoryStream = new MemoryStream();
				binaryFormatter.Serialize(memoryStream, windowsIdentity.CloneAsBase(), null, fCheck: false);
				list.Add(Convert.ToBase64String(memoryStream.GetBuffer(), 0, (int)memoryStream.Length));
			}
			else
			{
				using MemoryStream memoryStream2 = new MemoryStream();
				list.Add("");
				binaryFormatter.Serialize(memoryStream2, identity, null, fCheck: false);
				list.Add(Convert.ToBase64String(memoryStream2.GetBuffer(), 0, (int)memoryStream2.Length));
			}
		}
		using MemoryStream memoryStream3 = new MemoryStream();
		binaryFormatter.Serialize(memoryStream3, list, null, fCheck: false);
		return Convert.ToBase64String(memoryStream3.GetBuffer(), 0, (int)memoryStream3.Length);
	}
}
