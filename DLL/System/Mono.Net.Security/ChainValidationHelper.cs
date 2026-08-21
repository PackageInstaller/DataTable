using System;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using Mono.Net.Security.Private;
using Mono.Security.Interface;

namespace Mono.Net.Security;

internal class ChainValidationHelper : ICertificateValidator
{
	private readonly WeakReference<SslStream> owner;

	private readonly MonoTlsSettings settings;

	private readonly MobileTlsProvider provider;

	private readonly ServerCertValidationCallback certValidationCallback;

	private readonly LocalCertSelectionCallback certSelectionCallback;

	private readonly MonoTlsStream tlsStream;

	private readonly HttpWebRequest request;

	public MonoTlsSettings Settings => settings;

	internal static ChainValidationHelper GetInternalValidator(SslStream owner, MobileTlsProvider provider, MonoTlsSettings settings)
	{
		if (settings == null)
		{
			return new ChainValidationHelper(owner, provider, null, cloneSettings: false, null);
		}
		if (settings.CertificateValidator != null)
		{
			return (ChainValidationHelper)settings.CertificateValidator;
		}
		return new ChainValidationHelper(owner, provider, settings, cloneSettings: false, null);
	}

	internal static ChainValidationHelper Create(MobileTlsProvider provider, ref MonoTlsSettings settings, MonoTlsStream stream)
	{
		ChainValidationHelper chainValidationHelper = new ChainValidationHelper(null, provider, settings, cloneSettings: true, stream);
		settings = chainValidationHelper.settings;
		return chainValidationHelper;
	}

	private ChainValidationHelper(SslStream owner, MobileTlsProvider provider, MonoTlsSettings settings, bool cloneSettings, MonoTlsStream stream)
	{
		if (settings == null)
		{
			settings = MonoTlsSettings.CopyDefaultSettings();
		}
		if (cloneSettings)
		{
			settings = settings.CloneWithValidator(this);
		}
		if (provider == null)
		{
			provider = MonoTlsProviderFactory.GetProviderInternal();
		}
		this.provider = provider;
		this.settings = settings;
		tlsStream = stream;
		if (owner != null)
		{
			this.owner = new WeakReference<SslStream>(owner);
		}
		bool flag = false;
		if (settings != null)
		{
			certValidationCallback = GetValidationCallback(settings);
			certSelectionCallback = CallbackHelpers.MonoToInternal(settings.ClientCertificateSelectionCallback);
			flag = settings.UseServicePointManagerCallback ?? (stream != null);
		}
		if (stream != null)
		{
			request = stream.Request;
			if (certValidationCallback == null)
			{
				certValidationCallback = request.ServerCertValidationCallback;
			}
			if (certSelectionCallback == null)
			{
				certSelectionCallback = DefaultSelectionCallback;
			}
			if (settings == null)
			{
				flag = true;
			}
		}
		if (flag && certValidationCallback == null)
		{
			certValidationCallback = ServicePointManager.ServerCertValidationCallback;
		}
	}

	private static ServerCertValidationCallback GetValidationCallback(MonoTlsSettings settings)
	{
		if (settings.RemoteCertificateValidationCallback == null)
		{
			return null;
		}
		return new ServerCertValidationCallback(delegate(object s, X509Certificate c, X509Chain ch, SslPolicyErrors e)
		{
			string text = null;
			if (s is SslStream sslStream)
			{
				text = sslStream.InternalTargetHost;
			}
			else if (s is HttpWebRequest httpWebRequest)
			{
				text = httpWebRequest.Host;
				if (!string.IsNullOrEmpty(text))
				{
					int num = text.IndexOf(':');
					if (num > 0)
					{
						text = text.Substring(0, num);
					}
				}
			}
			return settings.RemoteCertificateValidationCallback(text, c, ch, (MonoSslPolicyErrors)e);
		});
	}

	private static X509Certificate DefaultSelectionCallback(string targetHost, X509CertificateCollection localCertificates, X509Certificate remoteCertificate, string[] acceptableIssuers)
	{
		if (localCertificates == null || localCertificates.Count == 0)
		{
			return null;
		}
		return localCertificates[0];
	}

	public bool SelectClientCertificate(string targetHost, X509CertificateCollection localCertificates, X509Certificate remoteCertificate, string[] acceptableIssuers, out X509Certificate clientCertificate)
	{
		if (certSelectionCallback == null)
		{
			clientCertificate = null;
			return false;
		}
		clientCertificate = certSelectionCallback(targetHost, localCertificates, remoteCertificate, acceptableIssuers);
		return true;
	}

	public ValidationResult ValidateCertificate(string host, bool serverMode, X509Certificate leaf, X509Chain chain)
	{
		try
		{
			ValidationResult validationResult = ValidateChain(host, serverMode, leaf, chain, null, SslPolicyErrors.None);
			if (tlsStream != null)
			{
				tlsStream.CertificateValidationFailed = validationResult == null || !validationResult.Trusted || validationResult.UserDenied;
			}
			return validationResult;
		}
		catch
		{
			if (tlsStream != null)
			{
				tlsStream.CertificateValidationFailed = true;
			}
			throw;
		}
	}

	private ValidationResult ValidateChain(string host, bool server, X509Certificate leaf, X509Chain chain, X509CertificateCollection certs, SslPolicyErrors errors)
	{
		X509Chain x509Chain = chain;
		bool flag = chain == null;
		try
		{
			ValidationResult result = ValidateChain(host, server, leaf, ref chain, certs, errors);
			if (chain != x509Chain)
			{
				flag = true;
			}
			return result;
		}
		finally
		{
			if (flag)
			{
				chain?.Dispose();
			}
		}
	}

	private ValidationResult ValidateChain(string host, bool server, X509Certificate leaf, ref X509Chain chain, X509CertificateCollection certs, SslPolicyErrors errors)
	{
		bool user_denied = false;
		bool flag = false;
		if (tlsStream != null)
		{
			request.ServicePoint.UpdateServerCertificate(leaf);
		}
		if (leaf == null)
		{
			errors |= SslPolicyErrors.RemoteCertificateNotAvailable;
			if (certValidationCallback != null)
			{
				flag = InvokeCallback(leaf, null, errors);
				user_denied = !flag;
			}
			return new ValidationResult(flag, user_denied, 0, (MonoSslPolicyErrors)errors);
		}
		if (!string.IsNullOrEmpty(host))
		{
			int num = host.IndexOf(':');
			if (num > 0)
			{
				host = host.Substring(0, num);
			}
		}
		ICertificatePolicy legacyCertificatePolicy = ServicePointManager.GetLegacyCertificatePolicy();
		int status = 0;
		bool flag2 = SystemCertificateValidator.NeedsChain(settings);
		if (!flag2 && certValidationCallback != null && (settings == null || settings.CallbackNeedsCertificateChain))
		{
			flag2 = true;
		}
		flag = provider.ValidateCertificate(this, host, server, certs, flag2, ref chain, ref errors, ref status);
		if (status == 0 && errors != SslPolicyErrors.None)
		{
			status = -2146762485;
		}
		if (legacyCertificatePolicy != null && (!(legacyCertificatePolicy is DefaultCertificatePolicy) || certValidationCallback == null))
		{
			ServicePoint srvPoint = null;
			if (request != null)
			{
				srvPoint = request.ServicePointNoLock;
			}
			flag = legacyCertificatePolicy.CheckValidationResult(srvPoint, leaf, request, status);
			user_denied = !flag && !(legacyCertificatePolicy is DefaultCertificatePolicy);
		}
		if (certValidationCallback != null)
		{
			flag = InvokeCallback(leaf, chain, errors);
			user_denied = !flag;
		}
		return new ValidationResult(flag, user_denied, status, (MonoSslPolicyErrors)errors);
	}

	private bool InvokeCallback(X509Certificate leaf, X509Chain chain, SslPolicyErrors errors)
	{
		object obj = null;
		SslStream target;
		if (request != null)
		{
			obj = request;
		}
		else if (owner != null && owner.TryGetTarget(out target))
		{
			obj = target;
		}
		return certValidationCallback.Invoke(obj, leaf, chain, errors);
	}
}
