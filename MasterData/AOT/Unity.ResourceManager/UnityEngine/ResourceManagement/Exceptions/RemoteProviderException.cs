using System;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.Exceptions;

public class RemoteProviderException : ProviderException
{
	public override string Message => ToString();

	public UnityWebRequestResult WebRequestResult { get; }

	public RemoteProviderException(string message, IResourceLocation location = null, UnityWebRequestResult uwrResult = null, Exception innerException = null)
		: base(message, location, innerException)
	{
		WebRequestResult = uwrResult;
	}

	public override string ToString()
	{
		if (WebRequestResult != null)
		{
			return $"{GetType().Name} : {base.Message}\nUnityWebRequest result : {WebRequestResult}\n{InnerException}";
		}
		return base.ToString();
	}
}
