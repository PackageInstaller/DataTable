using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.ComponentModel;

[Serializable]
public class Win32Exception : ExternalException, ISerializable
{
	private readonly int nativeErrorCode;

	public int NativeErrorCode => nativeErrorCode;

	public Win32Exception()
		: this(Marshal.GetLastWin32Error())
	{
	}

	public Win32Exception(int error)
		: this(error, GetErrorMessage(error))
	{
	}

	public Win32Exception(int error, string message)
		: base(message)
	{
		nativeErrorCode = error;
	}

	protected Win32Exception(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		nativeErrorCode = info.GetInt32("NativeErrorCode");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("NativeErrorCode", nativeErrorCode);
		base.GetObjectData(info, context);
	}

	internal static string GetErrorMessage(int error)
	{
		return error switch
		{
			0 => "Success", 
			2 => "Cannot find the specified file", 
			3 => "Cannot find the specified file", 
			4 => "Too many open files", 
			5 => "Access denied", 
			6 => "Invalid handle", 
			13 => "Invalid data", 
			14 => "Out of memory", 
			17 => "Not same device", 
			18 => "No more files", 
			24 => "Bad length", 
			31 => "General failure", 
			32 => "Sharing violation", 
			33 => "Lock violation", 
			50 => "Operation not supported", 
			55 => "Device does not exist", 
			87 => "Invalid parameter", 
			120 => "Call not implemented", 
			123 => "Invalid name", 
			127 => "Process not found", 
			183 => "Already exists", 
			267 => "Is a directory", 
			995 => "Operation aborted", 
			6000 => "Encryption failed", 
			10004 => "interrupted", 
			10009 => "Bad file number", 
			10013 => "Access denied", 
			10014 => "Bad address", 
			10022 => "Invalid arguments", 
			10024 => "Too many open files", 
			10035 => "Operation on non-blocking socket would block", 
			10036 => "Operation in progress", 
			10037 => "Operation already in progress", 
			10038 => "The descriptor is not a socket", 
			10039 => "Destination address required", 
			10040 => "Message too long", 
			10041 => "Protocol wrong type for socket", 
			10042 => "Protocol option not supported", 
			10043 => "Protocol not supported", 
			10044 => "Socket not supported", 
			10045 => "Operation not supported", 
			10046 => "Protocol family not supported", 
			10047 => "An address incompatible with the requested protocol was used", 
			10048 => "Address already in use", 
			10049 => "The requested address is not valid in this context", 
			10050 => "Network subsystem is down", 
			10051 => "Network is unreachable", 
			10052 => "Connection broken, keep-alive detected a problem", 
			10053 => "An established connection was aborted in your host machine.", 
			10054 => "Connection reset by peer", 
			10055 => "Not enough buffer space is available", 
			10056 => "Socket is already connected", 
			10057 => "The socket is not connected", 
			10058 => "The socket has been shut down", 
			10059 => "Too many references: cannot splice", 
			10060 => "Connection timed out", 
			10061 => "Connection refused", 
			10062 => "Too many symbolic links encountered", 
			10063 => "File name too long", 
			10064 => "Host is down", 
			10065 => "No route to host", 
			10066 => "Directory not empty", 
			10067 => "EPROCLIM", 
			10068 => "Too many users", 
			10069 => "Quota exceeded", 
			10070 => "Stale NFS file handle", 
			10071 => "Object is remote", 
			10091 => "SYSNOTREADY", 
			10092 => "VERNOTSUPPORTED", 
			10093 => "Winsock not initialised", 
			10101 => "EDISCON", 
			10102 => "ENOMORE", 
			10103 => "Operation canceled", 
			10104 => "EINVALIDPROCTABLE", 
			10105 => "EINVALIDPROVIDER", 
			10106 => "EPROVIDERFAILEDINIT", 
			10107 => "System call failed", 
			10108 => "SERVICE_NOT_FOUND", 
			10109 => "TYPE_NOT_FOUND", 
			10112 => "EREFUSED", 
			11001 => "No such host is known", 
			11002 => "A temporary error occurred on an authoritative name server.  Try again later.", 
			11003 => "No recovery", 
			11004 => "No data", 
			_ => $"mono-io-layer-error ({error})", 
		};
	}
}
