using System.Runtime.InteropServices;
using System.Security;

namespace System.Net;

internal static class UnsafeNclNativeMethods
{
	internal static class HttpApi
	{
		internal static class HTTP_REQUEST_HEADER_ID
		{
			private static string[] m_Strings = new string[41]
			{
				"Cache-Control", "Connection", "Date", "Keep-Alive", "Pragma", "Trailer", "Transfer-Encoding", "Upgrade", "Via", "Warning",
				"Allow", "Content-Length", "Content-Type", "Content-Encoding", "Content-Language", "Content-Location", "Content-MD5", "Content-Range", "Expires", "Last-Modified",
				"Accept", "Accept-Charset", "Accept-Encoding", "Accept-Language", "Authorization", "Cookie", "Expect", "From", "Host", "If-Match",
				"If-Modified-Since", "If-None-Match", "If-Range", "If-Unmodified-Since", "Max-Forwards", "Proxy-Authorization", "Referer", "Range", "Te", "Translate",
				"User-Agent"
			};

			internal static string ToString(int position)
			{
				return m_Strings[position];
			}
		}

		private static string[] m_Strings = new string[30]
		{
			"Cache-Control", "Connection", "Date", "Keep-Alive", "Pragma", "Trailer", "Transfer-Encoding", "Upgrade", "Via", "Warning",
			"Allow", "Content-Length", "Content-Type", "Content-Encoding", "Content-Language", "Content-Location", "Content-MD5", "Content-Range", "Expires", "Last-Modified",
			"Accept-Ranges", "Age", "ETag", "Location", "Proxy-Authenticate", "Retry-After", "Server", "Set-Cookie", "Vary", "WWW-Authenticate"
		};
	}

	internal static class SecureStringHelper
	{
		internal static string CreateString(SecureString secureString)
		{
			IntPtr intPtr = IntPtr.Zero;
			if (secureString == null || secureString.Length == 0)
			{
				return string.Empty;
			}
			try
			{
				intPtr = Marshal.SecureStringToGlobalAllocUnicode(secureString);
				return Marshal.PtrToStringUni(intPtr);
			}
			finally
			{
				if (intPtr != IntPtr.Zero)
				{
					Marshal.ZeroFreeGlobalAllocUnicode(intPtr);
				}
			}
		}

		internal unsafe static SecureString CreateSecureString(string plainString)
		{
			if (plainString == null || plainString.Length == 0)
			{
				return new SecureString();
			}
			SecureString result;
			fixed (char* value = plainString)
			{
				result = new SecureString(value, plainString.Length);
			}
			return result;
		}
	}
}
