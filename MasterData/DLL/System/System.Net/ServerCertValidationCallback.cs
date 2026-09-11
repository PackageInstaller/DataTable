using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Threading;

namespace System.Net;

internal class ServerCertValidationCallback
{
	private class CallbackContext
	{
		internal readonly object request;

		internal readonly X509Certificate certificate;

		internal readonly X509Chain chain;

		internal readonly SslPolicyErrors sslPolicyErrors;

		internal bool result;

		internal CallbackContext(object request, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
		{
			this.request = request;
			this.certificate = certificate;
			this.chain = chain;
			this.sslPolicyErrors = sslPolicyErrors;
		}
	}

	private readonly RemoteCertificateValidationCallback m_ValidationCallback;

	private readonly ExecutionContext m_Context;

	internal RemoteCertificateValidationCallback ValidationCallback => m_ValidationCallback;

	internal ServerCertValidationCallback(RemoteCertificateValidationCallback validationCallback)
	{
		m_ValidationCallback = validationCallback;
		m_Context = ExecutionContext.Capture();
	}

	internal void Callback(object state)
	{
		CallbackContext callbackContext = (CallbackContext)state;
		callbackContext.result = m_ValidationCallback(callbackContext.request, callbackContext.certificate, callbackContext.chain, callbackContext.sslPolicyErrors);
	}

	internal bool Invoke(object request, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
	{
		if (m_Context == null)
		{
			return m_ValidationCallback(request, certificate, chain, sslPolicyErrors);
		}
		ExecutionContext executionContext = m_Context.CreateCopy();
		CallbackContext callbackContext = new CallbackContext(request, certificate, chain, sslPolicyErrors);
		ExecutionContext.Run(executionContext, Callback, callbackContext);
		return callbackContext.result;
	}
}
