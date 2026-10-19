using System;
using System.Runtime.Serialization;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.Exceptions;

public class UnknownResourceProviderException : ResourceManagerException
{
	public IResourceLocation Location { get; private set; }

	public override string Message => base.Message + ", ProviderId=" + Location.ProviderId + ", Location=" + Location;

	public UnknownResourceProviderException(IResourceLocation location)
	{
		Location = location;
	}

	public UnknownResourceProviderException()
	{
	}

	public UnknownResourceProviderException(string message)
		: base(message)
	{
	}

	public UnknownResourceProviderException(string message, Exception innerException)
		: base(message, innerException)
	{
	}

	protected UnknownResourceProviderException(SerializationInfo message, StreamingContext context)
		: base(message, context)
	{
	}

	public override string ToString()
	{
		return Message;
	}
}
