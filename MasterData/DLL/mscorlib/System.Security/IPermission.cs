namespace System.Security;

public interface IPermission : ISecurityEncodable
{
	void Demand();

	bool IsSubsetOf(IPermission target);
}
