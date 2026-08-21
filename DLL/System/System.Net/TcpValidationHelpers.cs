namespace System.Net;

internal static class TcpValidationHelpers
{
	public static bool ValidatePortNumber(int port)
	{
		if (port >= 0)
		{
			return port <= 65535;
		}
		return false;
	}
}
