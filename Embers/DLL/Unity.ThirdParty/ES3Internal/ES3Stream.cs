using System;
using System.IO;
using System.IO.Compression;
using System.Security.Cryptography;
using UnityEngine;

namespace ES3Internal;

public static class ES3Stream
{
	public static Stream CreateStream(ES3Settings settings, ES3FileMode fileMode)
	{
		bool flag = fileMode != ES3FileMode.Read;
		Stream stream = null;
		new FileInfo(settings.FullPath);
		try
		{
			if (settings.location == ES3.Location.InternalMS)
			{
				if (!flag)
				{
					return null;
				}
				stream = new MemoryStream(settings.bufferSize);
			}
			else if (settings.location == ES3.Location.File)
			{
				if (!flag && !ES3IO.FileExists(settings.FullPath))
				{
					return null;
				}
				stream = new ES3FileStream(settings.FullPath, fileMode, settings.bufferSize, useAsync: false);
			}
			else if (settings.location == ES3.Location.PlayerPrefs)
			{
				if (flag)
				{
					stream = new ES3PlayerPrefsStream(settings.FullPath, settings.bufferSize, fileMode == ES3FileMode.Append);
				}
				else
				{
					if (!PlayerPrefs.HasKey(settings.FullPath))
					{
						return null;
					}
					stream = new ES3PlayerPrefsStream(settings.FullPath);
				}
			}
			else if (settings.location == ES3.Location.Resources)
			{
				if (flag)
				{
					if (Application.isEditor)
					{
						throw new NotSupportedException("Cannot write directly to Resources folder. Try writing to a directory outside of Resources, and then manually move the file there.");
					}
					throw new NotSupportedException("Cannot write to Resources folder at runtime. Use a different save location at runtime instead.");
				}
				ES3ResourcesStream eS3ResourcesStream = new ES3ResourcesStream(settings.FullPath);
				if (!eS3ResourcesStream.Exists)
				{
					eS3ResourcesStream.Dispose();
					return null;
				}
				stream = eS3ResourcesStream;
			}
			return CreateStream(stream, settings, fileMode);
		}
		catch (Exception ex)
		{
			stream?.Dispose();
			throw ex;
		}
	}

	public static Stream CreateStream(Stream stream, ES3Settings settings, ES3FileMode fileMode)
	{
		try
		{
			bool flag = fileMode != ES3FileMode.Read;
			if (settings.encryptionType != ES3.EncryptionType.None && stream.GetType() != typeof(UnbufferedCryptoStream))
			{
				EncryptionAlgorithm alg = null;
				if (settings.encryptionType == ES3.EncryptionType.AES)
				{
					alg = new AESEncryptionAlgorithm();
				}
				stream = new UnbufferedCryptoStream(stream, !flag, settings.encryptionPassword, settings.bufferSize, alg);
			}
			if (settings.compressionType != ES3.CompressionType.None && stream.GetType() != typeof(GZipStream) && settings.compressionType == ES3.CompressionType.Gzip)
			{
				stream = (flag ? new GZipStream(stream, CompressionMode.Compress) : new GZipStream(stream, CompressionMode.Decompress));
			}
			return stream;
		}
		catch (Exception ex)
		{
			stream?.Dispose();
			if (ex.GetType() == typeof(CryptographicException))
			{
				throw new CryptographicException("Could not decrypt file. Please ensure that you are using the same password used to encrypt the file.");
			}
			throw ex;
		}
	}

	public static void CopyTo(Stream source, Stream destination)
	{
		source.CopyTo(destination);
	}
}
