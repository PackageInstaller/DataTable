using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Net.NetworkInformation;

[Serializable]
public class NetworkInformationException : Win32Exception
{
	public NetworkInformationException()
		: base(Marshal.GetLastWin32Error())
	{
	}

	public NetworkInformationException(int errorCode)
		: base(errorCode)
	{
	}

	protected NetworkInformationException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}
}
