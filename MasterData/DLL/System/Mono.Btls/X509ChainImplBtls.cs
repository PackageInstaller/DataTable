using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Btls;

internal class X509ChainImplBtls : X509ChainImpl
{
	private MonoBtlsX509StoreCtx storeCtx;

	private MonoBtlsX509Chain chain;

	private MonoBtlsX509Chain untrustedChain;

	private X509ChainElementCollection elements;

	private X509Certificate2Collection untrusted;

	private X509Certificate2[] certificates;

	private X509ChainPolicy policy;

	private List<X509ChainStatus> chainStatusList;

	public override bool IsValid
	{
		get
		{
			if (chain != null)
			{
				return chain.IsValid;
			}
			return false;
		}
	}

	internal MonoBtlsX509StoreCtx StoreCtx
	{
		get
		{
			ThrowIfContextInvalid();
			return storeCtx;
		}
	}

	public override X509ChainElementCollection ChainElements
	{
		get
		{
			ThrowIfContextInvalid();
			if (elements != null)
			{
				return elements;
			}
			elements = new X509ChainElementCollection();
			certificates = new X509Certificate2[chain.Count];
			for (int i = 0; i < certificates.Length; i++)
			{
				using (X509CertificateImplBtls impl = new X509CertificateImplBtls(chain.GetCertificate(i)))
				{
					certificates[i] = new X509Certificate2(impl);
				}
				elements.Add(certificates[i]);
			}
			return elements;
		}
	}

	public override X509ChainPolicy ChainPolicy => policy;

	internal X509ChainImplBtls(MonoBtlsX509Chain chain)
	{
		this.chain = chain.Copy();
		policy = new X509ChainPolicy();
	}

	internal X509ChainImplBtls(MonoBtlsX509StoreCtx storeCtx)
	{
		this.storeCtx = storeCtx.Copy();
		chain = storeCtx.GetChain();
		policy = new X509ChainPolicy();
		untrustedChain = storeCtx.GetUntrusted();
		if (untrustedChain == null)
		{
			return;
		}
		untrusted = new X509Certificate2Collection();
		policy.ExtraStore = untrusted;
		for (int i = 0; i < untrustedChain.Count; i++)
		{
			using X509CertificateImplBtls impl = new X509CertificateImplBtls(untrustedChain.GetCertificate(i));
			untrusted.Add(new X509Certificate2(impl));
		}
	}

	public override void AddStatus(X509ChainStatusFlags errorCode)
	{
		if (chainStatusList == null)
		{
			chainStatusList = new List<X509ChainStatus>();
		}
		chainStatusList.Add(new X509ChainStatus(errorCode));
	}

	public override bool Build(X509Certificate2 certificate)
	{
		return false;
	}

	public override void Reset()
	{
		if (certificates != null)
		{
			X509Certificate2[] array = certificates;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Dispose();
			}
			certificates = null;
		}
		if (elements != null)
		{
			elements.Clear();
			elements = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (chain != null)
			{
				chain.Dispose();
				chain = null;
			}
			if (storeCtx != null)
			{
				storeCtx.Dispose();
				storeCtx = null;
			}
			if (untrustedChain != null)
			{
				untrustedChain.Dispose();
				untrustedChain = null;
			}
			if (untrusted != null)
			{
				foreach (X509Certificate2 item in untrusted)
				{
					item.Dispose();
				}
				untrusted = null;
			}
			if (certificates != null)
			{
				X509Certificate2[] array = certificates;
				for (int i = 0; i < array.Length; i++)
				{
					array[i].Dispose();
				}
				certificates = null;
			}
		}
		base.Dispose(disposing);
	}
}
