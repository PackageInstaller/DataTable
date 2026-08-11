namespace System.Runtime.Remoting.Messaging;

internal class CADObjRef
{
	internal ObjRef objref;

	internal int SourceDomain;

	internal byte[] TypeInfo;

	public CADObjRef(ObjRef o, int sourceDomain)
	{
		objref = o;
		TypeInfo = o.SerializeType();
		SourceDomain = sourceDomain;
	}
}
