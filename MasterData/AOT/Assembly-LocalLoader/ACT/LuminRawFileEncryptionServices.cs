using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;
using YooAsset;

namespace ACT;

public sealed class LuminRawFileEncryptionServices : IEncryptionServices, IFileEncryptionServices, IDecryptionServices, IRawFileDecryptionServices
{
	private sealed class AesCtrReadStream : Stream
	{
		private readonly FileStream _input;

		private readonly AesCtrTransform _transform;

		private readonly byte[] _iv = new byte[16];

		private long _position;

		public override bool CanRead => true;

		public override bool CanSeek => true;

		public override bool CanWrite => false;

		public override long Length => _input.Length - 21;

		public override long Position
		{
			get
			{
				return _position;
			}
			set
			{
				if (value < 0 || value > Length)
				{
					throw new ArgumentOutOfRangeException("value");
				}
				_position = value;
				_input.Position = 21 + value;
			}
		}

		public AesCtrReadStream(string path)
		{
			_input = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.Read, 262144);
			try
			{
				ReadHeader(_input, _iv);
				_transform = new AesCtrTransform();
				_input.Position = 21L;
			}
			catch
			{
				_input.Dispose();
				throw;
			}
		}

		public override int Read(byte[] buffer, int offset, int count)
		{
			int num = _input.Read(buffer, offset, count);
			if (num > 0)
			{
				_transform.Transform(buffer, offset, num, _position, _iv);
				_position += num;
			}
			return num;
		}

		public override long Seek(long offset, SeekOrigin origin)
		{
			Position = origin switch
			{
				SeekOrigin.Current => _position + offset, 
				SeekOrigin.Begin => offset, 
				_ => Length + offset, 
			};
			return _position;
		}

		public override void Flush()
		{
		}

		public override void SetLength(long value)
		{
			throw new NotSupportedException();
		}

		public override void Write(byte[] buffer, int offset, int count)
		{
			throw new NotSupportedException();
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing)
			{
				_transform?.Dispose();
				_input?.Dispose();
			}
			base.Dispose(disposing);
		}
	}

	private sealed class AesCtrTransform : IDisposable
	{
		private readonly Aes _aes = Aes.Create();

		private readonly ICryptoTransform _encryptor;

		private readonly byte[] _counter = new byte[16];

		private readonly byte[] _keyStream = new byte[16];

		public AesCtrTransform()
		{
			_aes.Key = Key;
			_aes.Mode = CipherMode.ECB;
			_aes.Padding = PaddingMode.None;
			_encryptor = _aes.CreateEncryptor();
		}

		public void Transform(byte[] data, int offset, int count, long position, byte[] iv)
		{
			int num3;
			for (int i = 0; i < count; i += num3)
			{
				long num = position + i;
				long index = num / 16;
				int num2 = (int)(num % 16);
				num3 = Math.Min(16 - num2, count - i);
				Buffer.BlockCopy(iv, 0, _counter, 0, 16);
				AddBlockIndex(_counter, index);
				_encryptor.TransformBlock(_counter, 0, 16, _keyStream, 0);
				for (int j = 0; j < num3; j++)
				{
					data[offset + i + j] ^= _keyStream[num2 + j];
				}
			}
		}

		private static void AddBlockIndex(byte[] counter, long index)
		{
			ulong num = (ulong)index;
			int num2 = counter.Length - 1;
			while (num2 >= 0 && num != 0L)
			{
				ulong num3 = counter[num2] + (num & 0xFF);
				counter[num2] = (byte)num3;
				num = (num >> 8) + (num3 >> 8);
				num2--;
			}
		}

		public void Dispose()
		{
			_encryptor.Dispose();
			_aes.Dispose();
		}
	}

	private static readonly byte[] Magic = new byte[4] { 76, 82, 65, 87 };

	private const byte Version = 1;

	private const int IvSize = 16;

	private const int HeaderSize = 21;

	private const int BufferSize = 262144;

	private static readonly byte[] Key = CreateKey();

	public EncryptResult Encrypt(EncryptFileInfo fileInfo)
	{
		using MemoryStream memoryStream = new MemoryStream();
		EncryptToStream(fileInfo.FileLoadPath, fileInfo.BundleName, memoryStream);
		return new EncryptResult
		{
			Encrypted = true,
			EncryptedData = memoryStream.ToArray()
		};
	}

	public bool EncryptFile(EncryptFileInfo fileInfo, string outputFilePath)
	{
		string directoryName = Path.GetDirectoryName(outputFilePath);
		if (!string.IsNullOrEmpty(directoryName))
		{
			Directory.CreateDirectory(directoryName);
		}
		using FileStream output = new FileStream(outputFilePath, FileMode.Create, FileAccess.Write, FileShare.None, 262144);
		EncryptToStream(fileInfo.FileLoadPath, fileInfo.BundleName, output);
		return true;
	}

	public DecryptResult LoadAssetBundle(DecryptFileInfo fileInfo)
	{
		Stream stream = OpenRawFileStream(fileInfo);
		return new DecryptResult
		{
			Result = AssetBundle.LoadFromStream(stream, fileInfo.FileLoadCRC),
			ManagedStream = stream
		};
	}

	public DecryptResult LoadAssetBundleAsync(DecryptFileInfo fileInfo)
	{
		Stream stream = OpenRawFileStream(fileInfo);
		return new DecryptResult
		{
			CreateRequest = AssetBundle.LoadFromStreamAsync(stream, fileInfo.FileLoadCRC),
			ManagedStream = stream
		};
	}

	public DecryptResult LoadAssetBundleFallback(DecryptFileInfo fileInfo)
	{
		return LoadAssetBundle(fileInfo);
	}

	public byte[] ReadFileData(DecryptFileInfo fileInfo)
	{
		using Stream stream = OpenRawFileStream(fileInfo);
		using MemoryStream memoryStream = new MemoryStream((int)Math.Min(stream.Length, 2147483647L));
		stream.CopyTo(memoryStream);
		return memoryStream.ToArray();
	}

	public string ReadFileText(DecryptFileInfo fileInfo)
	{
		using Stream stream = OpenRawFileStream(fileInfo);
		using StreamReader streamReader = new StreamReader(stream, Encoding.UTF8, detectEncodingFromByteOrderMarks: true);
		return streamReader.ReadToEnd();
	}

	public Stream OpenRawFileStream(DecryptFileInfo fileInfo)
	{
		if (string.IsNullOrEmpty(fileInfo.FileLoadPath) || !File.Exists(fileInfo.FileLoadPath))
		{
			throw new FileNotFoundException("Encrypted YooAsset RawFile does not exist.", fileInfo.FileLoadPath);
		}
		return new AesCtrReadStream(fileInfo.FileLoadPath);
	}

	public string GetDecryptedRawFilePath(DecryptFileInfo fileInfo)
	{
		long plainLength = GetPlainLength(fileInfo.FileLoadPath);
		string cachePath = GetCachePath(fileInfo);
		if (File.Exists(cachePath) && new FileInfo(cachePath).Length == plainLength)
		{
			return cachePath;
		}
		string directoryName = Path.GetDirectoryName(cachePath);
		if (!string.IsNullOrEmpty(directoryName))
		{
			Directory.CreateDirectory(directoryName);
		}
		string text = cachePath + ".tmp";
		try
		{
			using (Stream stream = OpenRawFileStream(fileInfo))
			{
				using FileStream destination = new FileStream(text, FileMode.Create, FileAccess.Write, FileShare.None, 262144);
				stream.CopyTo(destination, 262144);
			}
			if (File.Exists(cachePath))
			{
				File.Delete(cachePath);
			}
			File.Move(text, cachePath);
			return cachePath;
		}
		finally
		{
			if (File.Exists(text))
			{
				File.Delete(text);
			}
		}
	}

	private static void EncryptToStream(string inputPath, string bundleName, Stream output)
	{
		if (string.IsNullOrEmpty(inputPath) || !File.Exists(inputPath))
		{
			throw new FileNotFoundException("YooAsset source file to encrypt does not exist.", inputPath);
		}
		byte[] array = CreateDeterministicIv(inputPath, bundleName);
		output.Write(Magic, 0, Magic.Length);
		output.WriteByte(1);
		output.Write(array, 0, array.Length);
		using AesCtrTransform aesCtrTransform = new AesCtrTransform();
		using FileStream fileStream = new FileStream(inputPath, FileMode.Open, FileAccess.Read, FileShare.Read, 262144);
		byte[] array2 = new byte[262144];
		long num = 0L;
		int num2;
		while ((num2 = fileStream.Read(array2, 0, array2.Length)) > 0)
		{
			aesCtrTransform.Transform(array2, 0, num2, num, array);
			output.Write(array2, 0, num2);
			num += num2;
		}
	}

	private static byte[] CreateDeterministicIv(string inputPath, string bundleName)
	{
		using FileStream inputStream = new FileStream(inputPath, FileMode.Open, FileAccess.Read, FileShare.Read, 262144);
		using SHA256 sHA = SHA256.Create();
		byte[] array = sHA.ComputeHash(inputStream);
		byte[] bytes = Encoding.UTF8.GetBytes(bundleName ?? string.Empty);
		byte[] array2 = new byte[bytes.Length + array.Length];
		Buffer.BlockCopy(bytes, 0, array2, 0, bytes.Length);
		Buffer.BlockCopy(array, 0, array2, bytes.Length, array.Length);
		using HMACSHA256 hMACSHA = new HMACSHA256(Key);
		byte[] src = hMACSHA.ComputeHash(array2);
		byte[] array3 = new byte[16];
		Buffer.BlockCopy(src, 0, array3, 0, array3.Length);
		return array3;
	}

	private static long GetPlainLength(string encryptedPath)
	{
		FileInfo fileInfo = new FileInfo(encryptedPath);
		if (!fileInfo.Exists || fileInfo.Length < 21)
		{
			throw new InvalidDataException("Invalid encrypted YooAsset RawFile: " + encryptedPath);
		}
		return fileInfo.Length - 21;
	}

	private static string GetCachePath(DecryptFileInfo fileInfo)
	{
		string extension = Path.GetExtension(fileInfo.BundleName);
		if (string.IsNullOrEmpty(extension))
		{
			extension = Path.GetExtension(fileInfo.FileLoadPath);
		}
		string s = fileInfo.FileLoadPath + "|" + new FileInfo(fileInfo.FileLoadPath).Length + "|" + File.GetLastWriteTimeUtc(fileInfo.FileLoadPath).Ticks;
		using SHA256 sHA = SHA256.Create();
		string text = BitConverter.ToString(sHA.ComputeHash(Encoding.UTF8.GetBytes(s))).Replace("-", string.Empty);
		return Path.Combine(Application.temporaryCachePath, "YooAssetRawFile", text + extension);
	}

	private static byte[] CreateKey()
	{
		using SHA256 sHA = SHA256.Create();
		return sHA.ComputeHash(Encoding.UTF8.GetBytes("Lumin.YooAsset.RawFile.AES-CTR.v1"));
	}

	private static void ReadHeader(Stream input, byte[] iv)
	{
		byte[] array = new byte[21];
		int num;
		for (int i = 0; i < array.Length; i += num)
		{
			num = input.Read(array, i, array.Length - i);
			if (num == 0)
			{
				throw new InvalidDataException("Encrypted YooAsset RawFile header is incomplete.");
			}
		}
		for (int j = 0; j < Magic.Length; j++)
		{
			if (array[j] != Magic[j])
			{
				throw new InvalidDataException("Encrypted YooAsset RawFile header is invalid.");
			}
		}
		if (array[Magic.Length] != 1)
		{
			throw new InvalidDataException($"Unsupported YooAsset RawFile encryption version: {array[Magic.Length]}");
		}
		Buffer.BlockCopy(array, Magic.Length + 1, iv, 0, 16);
	}
}
