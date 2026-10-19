namespace System.Net;

public interface IWebProxy
{
	ICredentials Credentials { get; }

	Uri GetProxy(Uri destination);

	bool IsBypassed(Uri host);
}
