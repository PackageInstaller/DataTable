namespace System.Runtime.Remoting.Channels;

[Serializable]
internal class CrossAppDomainData
{
	private object _ContextID;

	private int _DomainID;

	private string _processGuid;

	internal int DomainID => _DomainID;

	internal string ProcessID => _processGuid;

	internal CrossAppDomainData(int domainId)
	{
		_ContextID = 0;
		_DomainID = domainId;
		_processGuid = RemotingConfiguration.ProcessId;
	}
}
