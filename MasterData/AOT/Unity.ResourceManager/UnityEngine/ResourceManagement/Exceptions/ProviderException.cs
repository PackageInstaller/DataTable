using System;
using UnityEngine.ResourceManagement.ResourceLocations;

namespace UnityEngine.ResourceManagement.Exceptions;

public class ProviderException : OperationException
{
	public IResourceLocation Location { get; }

	public ProviderException(string message, IResourceLocation location = null, Exception innerException = null)
		: base(message, innerException)
	{
		Location = location;
	}
}
