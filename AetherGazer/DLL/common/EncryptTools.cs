using System;
using System.Security.Cryptography;
using System.Text;

public static class EncryptTools
{
	private static string sGodkey;

	public static byte[] sGodBts;

	public static string sPbublicKey = "<RSAKeyValue><Modulus>1NtzalpNobpDX8hGaIxBlTyl2/FRbWQO+s/3JWOF8OTutYhnD1nfi0teAPclO0NOEXmXVbToF3D4MlSyyupq1wo6WF8/S1abWrVf80otqhYAAzOempuEnKmKLLDwzY4bFzjzARljxzlv6sfMl5OHrJlMgIUmS7FKIHcXWLwgOHk=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>";

	public static string Godkey
	{
		get
		{
			return sGodkey;
		}
		set
		{
			sGodkey = value;
			sGodBts = Encoding.UTF8.GetBytes(sGodkey);
		}
	}

	public static string GenerateKey(string seedstr, int len = 16)
	{
		Random random = new Random();
		string text = "";
		for (int i = 0; i < len; i++)
		{
			text += seedstr[random.Next(seedstr.Length)];
		}
		return text;
	}

	public static byte[] GetMD5(byte[] buffers)
	{
		using MD5CryptoServiceProvider mD5CryptoServiceProvider = new MD5CryptoServiceProvider();
		return mD5CryptoServiceProvider.ComputeHash(buffers);
	}

	public static string GetMD5Str(string str)
	{
		return Convert.ToBase64String(GetMD5(Encoding.UTF8.GetBytes(str)));
	}

	public static string GetMD5Str(byte[] buffers)
	{
		return Convert.ToBase64String(GetMD5(buffers));
	}

	public static byte[] RSAEncrypt(string publickey, byte[] buffers)
	{
		using RSACryptoServiceProvider rSACryptoServiceProvider = new RSACryptoServiceProvider();
		rSACryptoServiceProvider.FromXmlString(publickey);
		return rSACryptoServiceProvider.Encrypt(buffers, fOAEP: false);
	}

	public static byte[] RSADecrypt(string privatekey, byte[] buffers)
	{
		using RSACryptoServiceProvider rSACryptoServiceProvider = new RSACryptoServiceProvider();
		rSACryptoServiceProvider.FromXmlString(privatekey);
		return rSACryptoServiceProvider.Decrypt(buffers, fOAEP: false);
	}
}
