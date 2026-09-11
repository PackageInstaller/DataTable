namespace System.Runtime.Remoting;

internal class ClientIdentity : Identity
{
	private WeakReference _proxyReference;

	public MarshalByRefObject ClientProxy
	{
		get
		{
			return (MarshalByRefObject)(_proxyReference?.Target);
		}
		set
		{
			_proxyReference = new WeakReference(value);
		}
	}

	public string TargetUri => _objRef.URI;

	public ClientIdentity(string objectUri, ObjRef objRef)
		: base(objectUri)
	{
		_objRef = objRef;
		_envoySink = ((_objRef.EnvoyInfo != null) ? _objRef.EnvoyInfo.EnvoySinks : null);
	}

	public override ObjRef CreateObjRef(Type requestedType)
	{
		return _objRef;
	}
}
