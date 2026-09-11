namespace System.Security.Principal;

public interface IIdentity
{
	string Name { get; }

	string AuthenticationType { get; }

	bool IsAuthenticated { get; }
}
