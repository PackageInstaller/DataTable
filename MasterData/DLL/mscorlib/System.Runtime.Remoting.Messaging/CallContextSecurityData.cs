using System.Security.Principal;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
internal class CallContextSecurityData : ICloneable
{
	private IPrincipal _principal;

	internal IPrincipal Principal
	{
		get
		{
			return _principal;
		}
		set
		{
			_principal = value;
		}
	}

	internal bool HasInfo => _principal != null;

	public object Clone()
	{
		return new CallContextSecurityData
		{
			_principal = _principal
		};
	}
}
