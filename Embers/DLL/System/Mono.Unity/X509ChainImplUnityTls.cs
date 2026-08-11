using System;
using System.Collections.Generic;
using System.Security.Cryptography.X509Certificates;

namespace Mono.Unity;

internal class X509ChainImplUnityTls : X509ChainImpl
{
	private X509ChainElementCollection elements;

	private UnityTls.unitytls_x509list_ref nativeCertificateChain;

	private X509ChainPolicy policy = new X509ChainPolicy();

	private List<X509ChainStatus> chainStatusList;

	private bool reverseOrder;

	public override bool IsValid => nativeCertificateChain.handle != UnityTls.NativeInterface.UNITYTLS_INVALID_HANDLE;

	internal UnityTls.unitytls_x509list_ref NativeCertificateChain => nativeCertificateChain;

	public unsafe override X509ChainElementCollection ChainElements
	{
		get
		{
			ThrowIfContextInvalid();
			if (elements != null)
			{
				return elements;
			}
			elements = new X509ChainElementCollection();
			UnityTls.unitytls_errorstate unitytls_errorstate = UnityTls.NativeInterface.unitytls_errorstate_create();
			UnityTls.unitytls_x509_ref cert = UnityTls.NativeInterface.unitytls_x509list_get_x509(nativeCertificateChain, (IntPtr)0, &unitytls_errorstate);
			int num = 1;
			while (cert.handle != UnityTls.NativeInterface.UNITYTLS_INVALID_HANDLE)
			{
				IntPtr intPtr = UnityTls.NativeInterface.unitytls_x509_export_der(cert, null, (IntPtr)0, &unitytls_errorstate);
				byte[] array = new byte[(int)intPtr];
				fixed (byte* buffer = array)
				{
					UnityTls.NativeInterface.unitytls_x509_export_der(cert, buffer, intPtr, &unitytls_errorstate);
				}
				elements.Add(new X509Certificate2(array));
				cert = UnityTls.NativeInterface.unitytls_x509list_get_x509(nativeCertificateChain, (IntPtr)num, &unitytls_errorstate);
				num++;
			}
			if (reverseOrder)
			{
				X509ChainElementCollection x509ChainElementCollection = new X509ChainElementCollection();
				for (int num2 = elements.Count - 1; num2 >= 0; num2--)
				{
					x509ChainElementCollection.Add(elements[num2].Certificate);
				}
				elements = x509ChainElementCollection;
			}
			return elements;
		}
	}

	public override X509ChainPolicy ChainPolicy => policy;

	public override X509ChainStatus[] ChainStatus => chainStatusList?.ToArray() ?? new X509ChainStatus[0];

	internal X509ChainImplUnityTls(UnityTls.unitytls_x509list_ref nativeCertificateChain, bool reverseOrder = false)
	{
		elements = null;
		this.nativeCertificateChain = nativeCertificateChain;
		this.reverseOrder = reverseOrder;
	}

	public override void AddStatus(X509ChainStatusFlags error)
	{
		if (chainStatusList == null)
		{
			chainStatusList = new List<X509ChainStatus>();
		}
		chainStatusList.Add(new X509ChainStatus(error));
	}

	public override bool Build(X509Certificate2 certificate)
	{
		return false;
	}

	public override void Reset()
	{
		if (elements != null)
		{
			nativeCertificateChain.handle = UnityTls.NativeInterface.UNITYTLS_INVALID_HANDLE;
			elements.Clear();
			elements = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		Reset();
		base.Dispose(disposing);
	}
}
