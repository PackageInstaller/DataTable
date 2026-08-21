using System.Security.Cryptography;
using System.Text;

namespace ES3Internal;

public static class ES3Hash
{
	public static string SHA1Hash(string input)
	{
		using SHA1Managed sHA1Managed = new SHA1Managed();
		return Encoding.UTF8.GetString(sHA1Managed.ComputeHash(Encoding.UTF8.GetBytes(input)));
	}
}
