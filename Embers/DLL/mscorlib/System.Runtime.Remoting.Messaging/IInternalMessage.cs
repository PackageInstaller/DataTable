namespace System.Runtime.Remoting.Messaging;

internal interface IInternalMessage
{
	Identity TargetIdentity { get; set; }

	string Uri { get; set; }
}
