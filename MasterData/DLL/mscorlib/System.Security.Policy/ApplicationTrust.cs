using System.Collections.Generic;
using System.IO;
using System.Runtime.InteropServices;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Permissions;
using Mono.Security.Cryptography;

namespace System.Security.Policy;

[Serializable]
[ComVisible(true)]
public sealed class ApplicationTrust : EvidenceBase, ISecurityEncodable
{
	private ApplicationIdentity _appid;

	private PolicyStatement _defaultPolicy;

	private object _xtranfo;

	private bool _trustrun;

	private bool _persist;

	private IList<StrongName> fullTrustAssemblies;

	public PolicyStatement DefaultGrantSet
	{
		get
		{
			if (_defaultPolicy == null)
			{
				_defaultPolicy = GetDefaultGrantSet();
			}
			return _defaultPolicy;
		}
	}

	public bool IsApplicationTrustedToRun => _trustrun;

	public ApplicationTrust()
	{
		fullTrustAssemblies = new List<StrongName>(0);
	}

	public ApplicationTrust(ApplicationIdentity applicationIdentity)
		: this()
	{
		if (applicationIdentity == null)
		{
			throw new ArgumentNullException("applicationIdentity");
		}
		_appid = applicationIdentity;
	}

	public SecurityElement ToXml()
	{
		SecurityElement securityElement = new SecurityElement("ApplicationTrust");
		securityElement.AddAttribute("version", "1");
		if (_appid != null)
		{
			securityElement.AddAttribute("FullName", _appid.FullName);
		}
		if (_trustrun)
		{
			securityElement.AddAttribute("TrustedToRun", "true");
		}
		if (_persist)
		{
			securityElement.AddAttribute("Persist", "true");
		}
		SecurityElement securityElement2 = new SecurityElement("DefaultGrant");
		securityElement2.AddChild(DefaultGrantSet.ToXml());
		securityElement.AddChild(securityElement2);
		if (_xtranfo != null)
		{
			byte[] input = null;
			using (MemoryStream memoryStream = new MemoryStream())
			{
				new BinaryFormatter().Serialize(memoryStream, _xtranfo);
				input = memoryStream.ToArray();
			}
			SecurityElement securityElement3 = new SecurityElement("ExtraInfo");
			securityElement3.AddAttribute("Data", CryptoConvert.ToHex(input));
			securityElement.AddChild(securityElement3);
		}
		return securityElement;
	}

	private PolicyStatement GetDefaultGrantSet()
	{
		return new PolicyStatement(new PermissionSet(PermissionState.None));
	}
}
