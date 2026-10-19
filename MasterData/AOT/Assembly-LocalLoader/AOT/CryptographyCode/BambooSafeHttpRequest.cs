using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using ACT;
using UnityEngine;
using UnityEngine.Networking;

namespace AOT.CryptographyCode;

public static class BambooSafeHttpRequest
{
	public const string HeaderAppId = "x_app_id";

	public const string HeaderDeviceId = "x_device_id";

	public const string HeaderNonce = "x_nonce";

	public const string HeaderPlatform = "x_platform";

	public const string HeaderTimestamp = "x_timestamp";

	public const string HeaderSignature = "x_signature";

	public const string PlatformServer = "Android";

	public const string PlatformSecretServer = "e0794649e4363692af3e26c4bc739e82";

	private const int HeaderNonceLength = 32;

	private const int AesGcmNonceSize = 12;

	private const int AesGcmTagSize = 16;

	private const string NonceCharset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	public static UnityWebRequest Post(string url, WWWForm content)
	{
		UnityWebRequest unityWebRequest = UnityWebRequest.Post(url, content);
		AttachSignatureHeaders(unityWebRequest, url, "POST");
		return unityWebRequest;
	}

	public static UnityWebRequest Post(string url)
	{
		UnityWebRequest unityWebRequest = new UnityWebRequest(url, "POST");
		AttachSignatureHeaders(unityWebRequest, url, "POST");
		return unityWebRequest;
	}

	public static UnityWebRequest Get(string url)
	{
		UnityWebRequest unityWebRequest = UnityWebRequest.Get(url);
		AttachSignatureHeaders(unityWebRequest, url, "GET");
		return unityWebRequest;
	}

	private static void AttachSignatureHeaders(UnityWebRequest request, string url, string method)
	{
		Dictionary<string, string> dictionary = GenerateSignatureHeaders(url, method);
		if (dictionary == null)
		{
			return;
		}
		foreach (KeyValuePair<string, string> item in dictionary)
		{
			request.SetRequestHeader(item.Key, item.Value);
		}
	}

	public static async Task<HttpResponseMessage> PostAsync(HttpClient httpClient, string url, HttpContent content)
	{
		HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, url)
		{
			Content = content
		};
		AttachSignatureHeaders(request, url, "POST");
		return await httpClient.SendAsync(request);
	}

	public static async Task<HttpResponseMessage> GetAsync(HttpClient httpClient, string url)
	{
		HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, url);
		AttachSignatureHeaders(request, url, "GET");
		return await httpClient.SendAsync(request);
	}

	private static void AttachSignatureHeaders(HttpRequestMessage request, string url, string method)
	{
		Dictionary<string, string> dictionary = GenerateSignatureHeaders(url, method);
		if (dictionary == null)
		{
			return;
		}
		foreach (KeyValuePair<string, string> item in dictionary)
		{
			request.Headers.TryAddWithoutValidation(item.Key, item.Value);
		}
	}

	public static Dictionary<string, string> GenerateSignatureHeaders(string url, string method)
	{
		if (!Uri.TryCreate(url, UriKind.Absolute, out var result))
		{
			Debug.LogError("[BambooSafeHttpRequest] 签名失败：URL 无效 -> " + url);
			return null;
		}
		string method2 = (string.IsNullOrEmpty(method) ? "POST" : method.ToUpperInvariant());
		string path = (string.IsNullOrEmpty(result.AbsolutePath) ? "/" : result.AbsolutePath);
		string appID = LuminApplication.AppID;
		string value = (string.IsNullOrEmpty(LuminApplication.DeviceId) ? SystemInfo.deviceUniqueIdentifier : LuminApplication.DeviceId);
		SortedDictionary<string, string> sortedDictionary = new SortedDictionary<string, string>(StringComparer.Ordinal)
		{
			["x_app_id"] = appID,
			["x_device_id"] = value,
			["x_nonce"] = GenerateNonce(32),
			["x_platform"] = "Android",
			["x_timestamp"] = DateTimeOffset.UtcNow.ToUnixTimeSeconds().ToString()
		};
		string secret = "e0794649e4363692af3e26c4bc739e82";
		string value2 = EncryptSignature(HmacSha256Hex(BuildSigningPayload(sortedDictionary, method2, path, secret), secret), secret);
		Dictionary<string, string> dictionary = new Dictionary<string, string>(sortedDictionary.Count + 1);
		foreach (KeyValuePair<string, string> item in sortedDictionary)
		{
			dictionary[item.Key] = item.Value;
		}
		dictionary["x_signature"] = value2;
		return dictionary;
	}

	private static string BuildSigningPayload(IReadOnlyDictionary<string, string> parameters, string method, string path, string secret)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(Uri.EscapeDataString(method));
		stringBuilder.Append(Uri.EscapeDataString(path));
		stringBuilder.Append('&');
		foreach (KeyValuePair<string, string> item in parameters.OrderBy((KeyValuePair<string, string> p) => p.Key, StringComparer.Ordinal))
		{
			stringBuilder.Append(item.Key);
			stringBuilder.Append('=');
			stringBuilder.Append(item.Value ?? string.Empty);
			stringBuilder.Append('&');
		}
		stringBuilder.Append("key=");
		stringBuilder.Append(secret ?? string.Empty);
		return stringBuilder.ToString();
	}

	private static string HmacSha256Hex(string text, string secret)
	{
		byte[] bytes = Encoding.UTF8.GetBytes(text ?? string.Empty);
		using HMACSHA256 hMACSHA = new HMACSHA256(Encoding.UTF8.GetBytes(secret ?? string.Empty));
		byte[] array = hMACSHA.ComputeHash(bytes);
		StringBuilder stringBuilder = new StringBuilder(array.Length * 2);
		byte[] array2 = array;
		foreach (byte b in array2)
		{
			stringBuilder.Append(b.ToString("x2"));
		}
		return stringBuilder.ToString();
	}

	private static string EncryptSignature(string signature, string secret)
	{
		byte[] key;
		using (SHA256 sHA = SHA256.Create())
		{
			key = sHA.ComputeHash(Encoding.UTF8.GetBytes(secret + "_aes"));
		}
		byte[] bytes = Encoding.UTF8.GetBytes(signature);
		byte[] array = new byte[12];
		using (RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider())
		{
			rNGCryptoServiceProvider.GetBytes(array);
		}
		byte[] array2 = new byte[bytes.Length];
		byte[] array3 = new byte[16];
		AesGcmEncrypt(key, array, bytes, array2, array3);
		byte[] array4 = new byte[array.Length + array2.Length + array3.Length];
		Buffer.BlockCopy(array, 0, array4, 0, array.Length);
		Buffer.BlockCopy(array2, 0, array4, array.Length, array2.Length);
		Buffer.BlockCopy(array3, 0, array4, array.Length + array2.Length, array3.Length);
		return Convert.ToBase64String(array4);
	}

	private static void AesGcmEncrypt(byte[] key, byte[] nonce, byte[] plaintext, byte[] ciphertext, byte[] tag)
	{
		using Aes aes = Aes.Create();
		aes.Mode = CipherMode.ECB;
		aes.Padding = PaddingMode.None;
		aes.Key = key;
		using ICryptoTransform cryptoTransform = aes.CreateEncryptor();
		byte[] array = new byte[16];
		cryptoTransform.TransformBlock(new byte[16], 0, 16, array, 0);
		byte[] array2 = new byte[16];
		Buffer.BlockCopy(nonce, 0, array2, 0, 12);
		array2[15] = 1;
		byte[] array3 = new byte[16];
		cryptoTransform.TransformBlock(array2, 0, 16, array3, 0);
		byte[] array4 = (byte[])array2.Clone();
		Inc32(array4);
		byte[] array5 = new byte[16];
		int num = plaintext.Length / 16;
		int num2 = plaintext.Length % 16;
		for (int i = 0; i < num; i++)
		{
			cryptoTransform.TransformBlock(array4, 0, 16, array5, 0);
			int num3 = i * 16;
			for (int j = 0; j < 16; j++)
			{
				ciphertext[num3 + j] = (byte)(plaintext[num3 + j] ^ array5[j]);
			}
			Inc32(array4);
		}
		if (num2 > 0)
		{
			cryptoTransform.TransformBlock(array4, 0, 16, array5, 0);
			int num4 = num * 16;
			for (int k = 0; k < num2; k++)
			{
				ciphertext[num4 + k] = (byte)(plaintext[num4 + k] ^ array5[k]);
			}
		}
		byte[] array6 = GHash(array, ciphertext, ciphertext.Length);
		for (int l = 0; l < 16; l++)
		{
			tag[l] = (byte)(array6[l] ^ array3[l]);
		}
	}

	private static void Inc32(byte[] block)
	{
		int num = 15;
		while (num >= 12 && ++block[num] == 0)
		{
			num--;
		}
	}

	private static byte[] GHash(byte[] h, byte[] data, int dataLen)
	{
		byte[] array = new byte[16];
		int num = (dataLen + 15) / 16;
		for (int i = 0; i < num; i++)
		{
			int num2 = i * 16;
			int num3 = Math.Min(16, dataLen - num2);
			for (int j = 0; j < num3; j++)
			{
				array[j] ^= data[num2 + j];
			}
			GfMul(array, h, array);
		}
		byte[] array2 = new byte[16];
		long num4 = (long)dataLen * 8L;
		array2[8] = (byte)(num4 >> 56);
		array2[9] = (byte)(num4 >> 48);
		array2[10] = (byte)(num4 >> 40);
		array2[11] = (byte)(num4 >> 32);
		array2[12] = (byte)(num4 >> 24);
		array2[13] = (byte)(num4 >> 16);
		array2[14] = (byte)(num4 >> 8);
		array2[15] = (byte)num4;
		for (int k = 0; k < 16; k++)
		{
			array[k] ^= array2[k];
		}
		GfMul(array, h, array);
		return array;
	}

	private static void GfMul(byte[] x, byte[] y, byte[] result)
	{
		byte[] array = new byte[16];
		byte[] array2 = (byte[])y.Clone();
		for (int i = 0; i < 128; i++)
		{
			if ((x[i >> 3] & (1 << 7 - (i & 7))) != 0)
			{
				for (int j = 0; j < 16; j++)
				{
					array[j] ^= array2[j];
				}
			}
			bool flag = (array2[15] & 1) != 0;
			for (int num = 15; num > 0; num--)
			{
				array2[num] = (byte)((array2[num] >> 1) | ((array2[num - 1] & 1) << 7));
			}
			array2[0] >>= 1;
			if (flag)
			{
				array2[0] ^= 225;
			}
		}
		Buffer.BlockCopy(array, 0, result, 0, 16);
	}

	private static string GenerateNonce(int length)
	{
		byte[] array = new byte[length];
		using (RNGCryptoServiceProvider rNGCryptoServiceProvider = new RNGCryptoServiceProvider())
		{
			rNGCryptoServiceProvider.GetBytes(array);
		}
		char[] array2 = new char[length];
		for (int i = 0; i < length; i++)
		{
			array2[i] = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"[array[i] % "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".Length];
		}
		return new string(array2);
	}
}
