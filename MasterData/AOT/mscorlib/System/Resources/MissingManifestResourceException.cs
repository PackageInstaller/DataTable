using System.Runtime.Serialization;

namespace System.Resources;

[Serializable]
public class MissingManifestResourceException : SystemException
{
	public MissingManifestResourceException()
		: base("Unable to find manifest resource.")
	{
		HResult = -2146233038;
	}

	protected MissingManifestResourceException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
