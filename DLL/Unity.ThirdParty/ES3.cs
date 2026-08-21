using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using ES3Internal;
using ES3Types;
using UnityEngine;
using UnityEngine.Networking;

public class ES3
{
	public enum Location
	{
		File,
		PlayerPrefs,
		InternalMS,
		Resources,
		Cache
	}

	public enum Directory
	{
		PersistentDataPath,
		DataPath
	}

	public enum EncryptionType
	{
		None,
		AES
	}

	public enum CompressionType
	{
		None,
		Gzip
	}

	public enum Format
	{
		JSON
	}

	public enum ReferenceMode
	{
		ByRef,
		ByValue,
		ByRefAndValue
	}

	public enum ImageType
	{
		JPEG,
		PNG
	}

	public static void Save(string key, object value)
	{
		ES3.Save<object>(key, value, new ES3Settings());
	}

	public static void Save(string key, object value, string filePath)
	{
		ES3.Save<object>(key, value, new ES3Settings(filePath));
	}

	public static void Save(string key, object value, string filePath, ES3Settings settings)
	{
		ES3.Save<object>(key, value, new ES3Settings(filePath, settings));
	}

	public static void Save(string key, object value, ES3Settings settings)
	{
		ES3.Save<object>(key, value, settings);
	}

	public static void Save<T>(string key, T value)
	{
		Save(key, value, new ES3Settings());
	}

	public static void Save<T>(string key, T value, string filePath)
	{
		Save(key, value, new ES3Settings(filePath));
	}

	public static void Save<T>(string key, T value, string filePath, ES3Settings settings)
	{
		Save(key, value, new ES3Settings(filePath, settings));
	}

	public static void Save<T>(string key, T value, ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			ES3File.GetOrCreateCachedFile(settings).Save(key, value);
			return;
		}
		using ES3Writer eS3Writer = ES3Writer.Create(settings);
		eS3Writer.Write<T>(key, value);
		eS3Writer.Save();
	}

	public static void SaveRaw(byte[] bytes)
	{
		SaveRaw(bytes, new ES3Settings());
	}

	public static void SaveRaw(byte[] bytes, string filePath)
	{
		SaveRaw(bytes, new ES3Settings(filePath));
	}

	public static void SaveRaw(byte[] bytes, string filePath, ES3Settings settings)
	{
		SaveRaw(bytes, new ES3Settings(filePath, settings));
	}

	public static void SaveRaw(byte[] bytes, ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			ES3File.GetOrCreateCachedFile(settings).SaveRaw(bytes, settings);
			return;
		}
		using (Stream stream = ES3Stream.CreateStream(settings, ES3FileMode.Write))
		{
			stream.Write(bytes, 0, bytes.Length);
		}
		ES3IO.CommitBackup(settings);
	}

	public static void SaveRaw(string str)
	{
		SaveRaw(str, new ES3Settings());
	}

	public static void SaveRaw(string str, string filePath)
	{
		SaveRaw(str, new ES3Settings(filePath));
	}

	public static void SaveRaw(string str, string filePath, ES3Settings settings)
	{
		SaveRaw(str, new ES3Settings(filePath, settings));
	}

	public static void SaveRaw(string str, ES3Settings settings)
	{
		SaveRaw(settings.encoding.GetBytes(str), settings);
	}

	public static void AppendRaw(byte[] bytes)
	{
		AppendRaw(bytes, new ES3Settings());
	}

	public static void AppendRaw(byte[] bytes, string filePath, ES3Settings settings)
	{
		AppendRaw(bytes, new ES3Settings(filePath, settings));
	}

	public static void AppendRaw(byte[] bytes, ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			ES3File.GetOrCreateCachedFile(settings).AppendRaw(bytes);
			return;
		}
		using Stream stream = ES3Stream.CreateStream(new ES3Settings(settings.path, settings)
		{
			encryptionType = EncryptionType.None,
			compressionType = CompressionType.None
		}, ES3FileMode.Append);
		stream.Write(bytes, 0, bytes.Length);
	}

	public static void AppendRaw(string str)
	{
		AppendRaw(str, new ES3Settings());
	}

	public static void AppendRaw(string str, string filePath)
	{
		AppendRaw(str, new ES3Settings(filePath));
	}

	public static void AppendRaw(string str, string filePath, ES3Settings settings)
	{
		AppendRaw(str, new ES3Settings(filePath, settings));
	}

	public static void AppendRaw(string str, ES3Settings settings)
	{
		byte[] bytes = settings.encoding.GetBytes(str);
		ES3Settings eS3Settings = new ES3Settings(settings.path, settings);
		eS3Settings.encryptionType = EncryptionType.None;
		eS3Settings.compressionType = CompressionType.None;
		if (settings.location == Location.Cache)
		{
			ES3File.GetOrCreateCachedFile(settings).SaveRaw(bytes);
			return;
		}
		using Stream stream = ES3Stream.CreateStream(eS3Settings, ES3FileMode.Append);
		stream.Write(bytes, 0, bytes.Length);
	}

	public static void SaveImage(Texture2D texture, string imagePath)
	{
		SaveImage(texture, new ES3Settings(imagePath));
	}

	public static void SaveImage(Texture2D texture, string imagePath, ES3Settings settings)
	{
		SaveImage(texture, new ES3Settings(imagePath, settings));
	}

	public static void SaveImage(Texture2D texture, ES3Settings settings)
	{
		SaveImage(texture, 75, settings);
	}

	public static void SaveImage(Texture2D texture, int quality, string imagePath)
	{
		SaveImage(texture, quality, new ES3Settings(imagePath));
	}

	public static void SaveImage(Texture2D texture, int quality, string imagePath, ES3Settings settings)
	{
		SaveImage(texture, quality, new ES3Settings(imagePath, settings));
	}

	public static void SaveImage(Texture2D texture, int quality, ES3Settings settings)
	{
		string text = ES3IO.GetExtension(settings.path).ToLower();
		if (string.IsNullOrEmpty(text))
		{
			throw new ArgumentException("File path must have a file extension when using ES3.SaveImage.");
		}
		byte[] bytes;
		switch (text)
		{
		case ".jpg":
		case ".jpeg":
			bytes = ImageConversion.EncodeToJPG(texture, quality);
			break;
		case ".png":
			bytes = ImageConversion.EncodeToPNG(texture);
			break;
		default:
			throw new ArgumentException("File path must have extension of .png, .jpg or .jpeg when using ES3.SaveImage.");
		}
		SaveRaw(bytes, settings);
	}

	public static byte[] SaveImageToBytes(Texture2D texture, int quality, ImageType imageType)
	{
		if (imageType == ImageType.JPEG)
		{
			return ImageConversion.EncodeToJPG(texture, quality);
		}
		return ImageConversion.EncodeToPNG(texture);
	}

	public static object Load(string key)
	{
		return Load<object>(key, new ES3Settings());
	}

	public static object Load(string key, string filePath)
	{
		return Load<object>(key, new ES3Settings(filePath));
	}

	public static object Load(string key, string filePath, ES3Settings settings)
	{
		return Load<object>(key, new ES3Settings(filePath, settings));
	}

	public static object Load(string key, ES3Settings settings)
	{
		return Load<object>(key, settings);
	}

	public static object Load(string key, object defaultValue)
	{
		return ES3.Load<object>(key, defaultValue, new ES3Settings());
	}

	public static object Load(string key, string filePath, object defaultValue)
	{
		return ES3.Load<object>(key, defaultValue, new ES3Settings(filePath));
	}

	public static object Load(string key, string filePath, object defaultValue, ES3Settings settings)
	{
		return ES3.Load<object>(key, defaultValue, new ES3Settings(filePath, settings));
	}

	public static object Load(string key, object defaultValue, ES3Settings settings)
	{
		return ES3.Load<object>(key, defaultValue, settings);
	}

	public static T Load<T>(string key)
	{
		return Load<T>(key, new ES3Settings());
	}

	public static T Load<T>(string key, string filePath)
	{
		return Load<T>(key, new ES3Settings(filePath));
	}

	public static T Load<T>(string key, string filePath, ES3Settings settings)
	{
		return Load<T>(key, new ES3Settings(filePath, settings));
	}

	public static T Load<T>(string key, ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			return ES3File.GetOrCreateCachedFile(settings).Load<T>(key);
		}
		using ES3Reader eS3Reader = ES3Reader.Create(settings);
		if (eS3Reader == null)
		{
			throw new FileNotFoundException("File \"" + settings.FullPath + "\" could not be found.");
		}
		return eS3Reader.Read<T>(key);
	}

	public static T Load<T>(string key, T defaultValue)
	{
		return Load(key, defaultValue, new ES3Settings());
	}

	public static T Load<T>(string key, string filePath, T defaultValue)
	{
		return Load(key, defaultValue, new ES3Settings(filePath));
	}

	public static T Load<T>(string key, string filePath, T defaultValue, ES3Settings settings)
	{
		return Load(key, defaultValue, new ES3Settings(filePath, settings));
	}

	public static T Load<T>(string key, T defaultValue, ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			return ES3File.GetOrCreateCachedFile(settings).Load(key, defaultValue);
		}
		using ES3Reader eS3Reader = ES3Reader.Create(settings);
		if (eS3Reader == null)
		{
			return defaultValue;
		}
		return eS3Reader.Read(key, defaultValue);
	}

	public static void LoadInto<T>(string key, object obj) where T : class
	{
		ES3.LoadInto<object>(key, obj, new ES3Settings());
	}

	public static void LoadInto(string key, string filePath, object obj)
	{
		ES3.LoadInto<object>(key, obj, new ES3Settings(filePath));
	}

	public static void LoadInto(string key, string filePath, object obj, ES3Settings settings)
	{
		ES3.LoadInto<object>(key, obj, new ES3Settings(filePath, settings));
	}

	public static void LoadInto(string key, object obj, ES3Settings settings)
	{
		ES3.LoadInto<object>(key, obj, settings);
	}

	public static void LoadInto<T>(string key, T obj) where T : class
	{
		LoadInto(key, obj, new ES3Settings());
	}

	public static void LoadInto<T>(string key, string filePath, T obj) where T : class
	{
		LoadInto(key, obj, new ES3Settings(filePath));
	}

	public static void LoadInto<T>(string key, string filePath, T obj, ES3Settings settings) where T : class
	{
		LoadInto(key, obj, new ES3Settings(filePath, settings));
	}

	public static void LoadInto<T>(string key, T obj, ES3Settings settings) where T : class
	{
		if (ES3Reflection.IsValueType(obj.GetType()))
		{
			throw new InvalidOperationException("ES3.LoadInto can only be used with reference types, but the data you're loading is a value type. Use ES3.Load instead.");
		}
		if (settings.location == Location.Cache)
		{
			ES3File.GetOrCreateCachedFile(settings).LoadInto(key, obj);
			return;
		}
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		using ES3Reader eS3Reader = ES3Reader.Create(settings);
		if (eS3Reader == null)
		{
			throw new FileNotFoundException("File \"" + settings.FullPath + "\" could not be found.");
		}
		eS3Reader.ReadInto(key, obj);
	}

	public static string LoadString(string key, string defaultValue, ES3Settings settings)
	{
		return Load(key, null, defaultValue, settings);
	}

	public static string LoadString(string key, string defaultValue, string filePath = null, ES3Settings settings = null)
	{
		return Load(key, filePath, defaultValue, settings);
	}

	public static byte[] LoadRawBytes()
	{
		return LoadRawBytes(new ES3Settings());
	}

	public static byte[] LoadRawBytes(string filePath)
	{
		return LoadRawBytes(new ES3Settings(filePath));
	}

	public static byte[] LoadRawBytes(string filePath, ES3Settings settings)
	{
		return LoadRawBytes(new ES3Settings(filePath, settings));
	}

	public static byte[] LoadRawBytes(ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			return ES3File.GetOrCreateCachedFile(settings).LoadRawBytes();
		}
		using Stream stream = ES3Stream.CreateStream(settings, ES3FileMode.Read);
		if (stream == null)
		{
			throw new FileNotFoundException("File " + settings.path + " could not be found");
		}
		if (stream.GetType() == typeof(GZipStream))
		{
			GZipStream source = (GZipStream)stream;
			using MemoryStream memoryStream = new MemoryStream();
			ES3Stream.CopyTo(source, memoryStream);
			return memoryStream.ToArray();
		}
		byte[] array = new byte[stream.Length];
		stream.Read(array, 0, array.Length);
		return array;
	}

	public static string LoadRawString()
	{
		return LoadRawString(new ES3Settings());
	}

	public static string LoadRawString(string filePath)
	{
		return LoadRawString(new ES3Settings(filePath));
	}

	public static string LoadRawString(string filePath, ES3Settings settings)
	{
		return LoadRawString(new ES3Settings(filePath, settings));
	}

	public static string LoadRawString(ES3Settings settings)
	{
		byte[] array = LoadRawBytes(settings);
		return settings.encoding.GetString(array, 0, array.Length);
	}

	public static Texture2D LoadImage(string imagePath)
	{
		return LoadImage(new ES3Settings(imagePath));
	}

	public static Texture2D LoadImage(string imagePath, ES3Settings settings)
	{
		return LoadImage(new ES3Settings(imagePath, settings));
	}

	public static Texture2D LoadImage(ES3Settings settings)
	{
		return LoadImage(LoadRawBytes(settings));
	}

	public static Texture2D LoadImage(byte[] bytes)
	{
		Texture2D texture2D = new Texture2D(1, 1);
		ImageConversion.LoadImage(texture2D, bytes);
		return texture2D;
	}

	public static AudioClip LoadAudio(string audioFilePath, AudioType audioType)
	{
		return LoadAudio(audioFilePath, audioType, new ES3Settings());
	}

	public static AudioClip LoadAudio(string audioFilePath, AudioType audioType, ES3Settings settings)
	{
		if (settings.location != Location.File)
		{
			throw new InvalidOperationException("ES3.LoadAudio can only be used with the File save location");
		}
		if (Application.platform == RuntimePlatform.WebGLPlayer)
		{
			throw new InvalidOperationException("You cannot use ES3.LoadAudio with WebGL");
		}
		string text = ES3IO.GetExtension(audioFilePath).ToLower();
		if (text == ".mp3" && (Application.platform == RuntimePlatform.WindowsPlayer || Application.platform == RuntimePlatform.OSXPlayer))
		{
			throw new InvalidOperationException("You can only load Ogg, WAV, XM, IT, MOD or S3M on Unity Standalone");
		}
		if (text == ".ogg" && (Application.platform == RuntimePlatform.IPhonePlayer || Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.MetroPlayerARM))
		{
			throw new InvalidOperationException("You can only load MP3, WAV, XM, IT, MOD or S3M on Unity Standalone");
		}
		ES3Settings eS3Settings = new ES3Settings(audioFilePath, settings);
		UnityWebRequest audioClip = UnityWebRequestMultimedia.GetAudioClip("file://" + eS3Settings.FullPath, audioType);
		try
		{
			audioClip.SendWebRequest();
			while (!audioClip.isDone)
			{
			}
			if (ES3WebClass.IsNetworkError(audioClip))
			{
				throw new Exception(audioClip.error);
			}
			return DownloadHandlerAudioClip.GetContent(audioClip);
		}
		finally
		{
			((IDisposable)audioClip)?.Dispose();
		}
	}

	public static byte[] Serialize<T>(T value, ES3Settings settings = null)
	{
		return Serialize(value, ES3TypeMgr.GetOrCreateES3Type(typeof(T)), settings);
	}

	internal static byte[] Serialize(object value, ES3Type type, ES3Settings settings = null)
	{
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		using MemoryStream memoryStream = new MemoryStream();
		using Stream stream = ES3Stream.CreateStream(memoryStream, settings, ES3FileMode.Write);
		using (ES3Writer eS3Writer = ES3Writer.Create(stream, settings, writeHeaderAndFooter: false, overwriteKeys: false))
		{
			eS3Writer.Write(value, type, settings.referenceMode);
		}
		return memoryStream.ToArray();
	}

	public static T Deserialize<T>(byte[] bytes, ES3Settings settings = null)
	{
		return (T)Deserialize(ES3TypeMgr.GetOrCreateES3Type(typeof(T)), bytes, settings);
	}

	internal static object Deserialize(ES3Type type, byte[] bytes, ES3Settings settings = null)
	{
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		using MemoryStream stream = new MemoryStream(bytes, writable: false);
		using Stream stream2 = ES3Stream.CreateStream(stream, settings, ES3FileMode.Read);
		using ES3Reader eS3Reader = ES3Reader.Create(stream2, settings, readHeaderAndFooter: false);
		return eS3Reader.Read<object>(type);
	}

	public static void DeserializeInto<T>(byte[] bytes, T obj, ES3Settings settings = null) where T : class
	{
		DeserializeInto(ES3TypeMgr.GetOrCreateES3Type(typeof(T)), bytes, obj, settings);
	}

	public static void DeserializeInto<T>(ES3Type type, byte[] bytes, T obj, ES3Settings settings = null) where T : class
	{
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		using MemoryStream stream = new MemoryStream(bytes, writable: false);
		using ES3Reader eS3Reader = ES3Reader.Create(stream, settings, readHeaderAndFooter: false);
		eS3Reader.ReadInto<T>(obj, type);
	}

	public static byte[] EncryptBytes(byte[] bytes, string password = null)
	{
		if (string.IsNullOrEmpty(password))
		{
			password = ES3Settings.defaultSettings.encryptionPassword;
		}
		return new AESEncryptionAlgorithm().Encrypt(bytes, password, ES3Settings.defaultSettings.bufferSize);
	}

	public static byte[] DecryptBytes(byte[] bytes, string password = null)
	{
		if (string.IsNullOrEmpty(password))
		{
			password = ES3Settings.defaultSettings.encryptionPassword;
		}
		return new AESEncryptionAlgorithm().Decrypt(bytes, password, ES3Settings.defaultSettings.bufferSize);
	}

	public static string EncryptString(string str, string password = null)
	{
		return Convert.ToBase64String(EncryptBytes(ES3Settings.defaultSettings.encoding.GetBytes(str), password));
	}

	public static string DecryptString(string str, string password = null)
	{
		return ES3Settings.defaultSettings.encoding.GetString(DecryptBytes(Convert.FromBase64String(str), password));
	}

	public static byte[] CompressBytes(byte[] bytes)
	{
		using MemoryStream memoryStream = new MemoryStream();
		ES3Settings eS3Settings = new ES3Settings();
		eS3Settings.location = Location.InternalMS;
		eS3Settings.compressionType = CompressionType.Gzip;
		eS3Settings.encryptionType = EncryptionType.None;
		using (Stream stream = ES3Stream.CreateStream(memoryStream, eS3Settings, ES3FileMode.Write))
		{
			stream.Write(bytes, 0, bytes.Length);
		}
		return memoryStream.ToArray();
	}

	public static byte[] DecompressBytes(byte[] bytes)
	{
		using MemoryStream stream = new MemoryStream(bytes);
		ES3Settings eS3Settings = new ES3Settings();
		eS3Settings.location = Location.InternalMS;
		eS3Settings.compressionType = CompressionType.Gzip;
		eS3Settings.encryptionType = EncryptionType.None;
		using MemoryStream memoryStream = new MemoryStream();
		using (Stream source = ES3Stream.CreateStream(stream, eS3Settings, ES3FileMode.Read))
		{
			ES3Stream.CopyTo(source, memoryStream);
		}
		return memoryStream.ToArray();
	}

	public static string CompressString(string str)
	{
		return Convert.ToBase64String(CompressBytes(ES3Settings.defaultSettings.encoding.GetBytes(str)));
	}

	public static string DecompressString(string str)
	{
		return ES3Settings.defaultSettings.encoding.GetString(DecompressBytes(Convert.FromBase64String(str)));
	}

	public static void DeleteFile()
	{
		DeleteFile(new ES3Settings());
	}

	public static void DeleteFile(string filePath)
	{
		DeleteFile(new ES3Settings(filePath));
	}

	public static void DeleteFile(string filePath, ES3Settings settings)
	{
		DeleteFile(new ES3Settings(filePath, settings));
	}

	public static void DeleteFile(ES3Settings settings)
	{
		if (settings.location == Location.File)
		{
			ES3IO.DeleteFile(settings.FullPath);
		}
		else if (settings.location == Location.PlayerPrefs)
		{
			PlayerPrefs.DeleteKey(settings.FullPath);
		}
		else if (settings.location == Location.Cache)
		{
			ES3File.RemoveCachedFile(settings);
		}
		else if (settings.location == Location.Resources)
		{
			throw new NotSupportedException("Deleting files from Resources is not possible.");
		}
	}

	public static void CopyFile(string oldFilePath, string newFilePath)
	{
		CopyFile(new ES3Settings(oldFilePath), new ES3Settings(newFilePath));
	}

	public static void CopyFile(string oldFilePath, string newFilePath, ES3Settings oldSettings, ES3Settings newSettings)
	{
		CopyFile(new ES3Settings(oldFilePath, oldSettings), new ES3Settings(newFilePath, newSettings));
	}

	public static void CopyFile(ES3Settings oldSettings, ES3Settings newSettings)
	{
		if (oldSettings.location != newSettings.location)
		{
			throw new InvalidOperationException("Cannot copy file from " + oldSettings.location.ToString() + " to " + newSettings.location.ToString() + ". Location must be the same for both source and destination.");
		}
		if (oldSettings.location == Location.File)
		{
			if (ES3IO.FileExists(oldSettings.FullPath))
			{
				string directoryPath = ES3IO.GetDirectoryPath(newSettings.FullPath);
				if (!ES3IO.DirectoryExists(directoryPath))
				{
					ES3IO.CreateDirectory(directoryPath);
				}
				else
				{
					ES3IO.DeleteFile(newSettings.FullPath);
				}
				ES3IO.CopyFile(oldSettings.FullPath, newSettings.FullPath);
			}
		}
		else if (oldSettings.location == Location.PlayerPrefs)
		{
			PlayerPrefs.SetString(newSettings.FullPath, PlayerPrefs.GetString(oldSettings.FullPath));
		}
		else if (oldSettings.location == Location.Cache)
		{
			ES3File.CopyCachedFile(oldSettings, newSettings);
		}
		else if (oldSettings.location == Location.Resources)
		{
			throw new NotSupportedException("Modifying files from Resources is not allowed.");
		}
	}

	public static void RenameFile(string oldFilePath, string newFilePath)
	{
		RenameFile(new ES3Settings(oldFilePath), new ES3Settings(newFilePath));
	}

	public static void RenameFile(string oldFilePath, string newFilePath, ES3Settings oldSettings, ES3Settings newSettings)
	{
		RenameFile(new ES3Settings(oldFilePath, oldSettings), new ES3Settings(newFilePath, newSettings));
	}

	public static void RenameFile(ES3Settings oldSettings, ES3Settings newSettings)
	{
		if (oldSettings.location != newSettings.location)
		{
			throw new InvalidOperationException("Cannot rename file in " + oldSettings.location.ToString() + " to " + newSettings.location.ToString() + ". Location must be the same for both source and destination.");
		}
		if (oldSettings.location == Location.File)
		{
			if (ES3IO.FileExists(oldSettings.FullPath))
			{
				ES3IO.DeleteFile(newSettings.FullPath);
				ES3IO.MoveFile(oldSettings.FullPath, newSettings.FullPath);
			}
		}
		else if (oldSettings.location == Location.PlayerPrefs)
		{
			PlayerPrefs.SetString(newSettings.FullPath, PlayerPrefs.GetString(oldSettings.FullPath));
			PlayerPrefs.DeleteKey(oldSettings.FullPath);
		}
		else if (oldSettings.location == Location.Cache)
		{
			ES3File.CopyCachedFile(oldSettings, newSettings);
			ES3File.RemoveCachedFile(oldSettings);
		}
		else if (oldSettings.location == Location.Resources)
		{
			throw new NotSupportedException("Modifying files from Resources is not allowed.");
		}
	}

	public static void CopyDirectory(string oldDirectoryPath, string newDirectoryPath)
	{
		CopyDirectory(new ES3Settings(oldDirectoryPath), new ES3Settings(newDirectoryPath));
	}

	public static void CopyDirectory(string oldDirectoryPath, string newDirectoryPath, ES3Settings oldSettings, ES3Settings newSettings)
	{
		CopyDirectory(new ES3Settings(oldDirectoryPath, oldSettings), new ES3Settings(newDirectoryPath, newSettings));
	}

	public static void CopyDirectory(ES3Settings oldSettings, ES3Settings newSettings)
	{
		if (oldSettings.location != Location.File)
		{
			throw new InvalidOperationException("ES3.CopyDirectory can only be used when the save location is 'File'");
		}
		if (!DirectoryExists(oldSettings))
		{
			throw new DirectoryNotFoundException("Directory " + oldSettings.FullPath + " not found");
		}
		if (!DirectoryExists(newSettings))
		{
			ES3IO.CreateDirectory(newSettings.FullPath);
		}
		string[] files = GetFiles(oldSettings);
		foreach (string fileOrDirectoryName in files)
		{
			CopyFile(ES3IO.CombinePathAndFilename(oldSettings.path, fileOrDirectoryName), ES3IO.CombinePathAndFilename(newSettings.path, fileOrDirectoryName));
		}
		files = GetDirectories(oldSettings);
		foreach (string fileOrDirectoryName2 in files)
		{
			CopyDirectory(ES3IO.CombinePathAndFilename(oldSettings.path, fileOrDirectoryName2), ES3IO.CombinePathAndFilename(newSettings.path, fileOrDirectoryName2));
		}
	}

	public static void RenameDirectory(string oldDirectoryPath, string newDirectoryPath)
	{
		RenameDirectory(new ES3Settings(oldDirectoryPath), new ES3Settings(newDirectoryPath));
	}

	public static void RenameDirectory(string oldDirectoryPath, string newDirectoryPath, ES3Settings oldSettings, ES3Settings newSettings)
	{
		RenameDirectory(new ES3Settings(oldDirectoryPath, oldSettings), new ES3Settings(newDirectoryPath, newSettings));
	}

	public static void RenameDirectory(ES3Settings oldSettings, ES3Settings newSettings)
	{
		if (oldSettings.location == Location.File)
		{
			if (ES3IO.DirectoryExists(oldSettings.FullPath))
			{
				ES3IO.DeleteDirectory(newSettings.FullPath);
				ES3IO.MoveDirectory(oldSettings.FullPath, newSettings.FullPath);
			}
			return;
		}
		if (oldSettings.location == Location.PlayerPrefs || oldSettings.location == Location.Cache)
		{
			throw new NotSupportedException("Directories cannot be renamed when saving to Cache, PlayerPrefs, tvOS or using WebGL.");
		}
		if (oldSettings.location != Location.Resources)
		{
			return;
		}
		throw new NotSupportedException("Modifying files from Resources is not allowed.");
	}

	public static void DeleteDirectory(string directoryPath)
	{
		DeleteDirectory(new ES3Settings(directoryPath));
	}

	public static void DeleteDirectory(string directoryPath, ES3Settings settings)
	{
		DeleteDirectory(new ES3Settings(directoryPath, settings));
	}

	public static void DeleteDirectory(ES3Settings settings)
	{
		if (settings.location == Location.File)
		{
			ES3IO.DeleteDirectory(settings.FullPath);
			return;
		}
		if (settings.location == Location.PlayerPrefs || settings.location == Location.Cache)
		{
			throw new NotSupportedException("Deleting Directories using Cache or PlayerPrefs is not supported.");
		}
		if (settings.location != Location.Resources)
		{
			return;
		}
		throw new NotSupportedException("Deleting directories from Resources is not allowed.");
	}

	public static void DeleteKey(string key)
	{
		DeleteKey(key, new ES3Settings());
	}

	public static void DeleteKey(string key, string filePath)
	{
		DeleteKey(key, new ES3Settings(filePath));
	}

	public static void DeleteKey(string key, string filePath, ES3Settings settings)
	{
		DeleteKey(key, new ES3Settings(filePath, settings));
	}

	public static void DeleteKey(string key, ES3Settings settings)
	{
		if (settings.location == Location.Resources)
		{
			throw new NotSupportedException("Modifying files in Resources is not allowed.");
		}
		if (settings.location == Location.Cache)
		{
			ES3File.DeleteKey(key, settings);
		}
		else if (FileExists(settings))
		{
			using (ES3Writer eS3Writer = ES3Writer.Create(settings))
			{
				eS3Writer.MarkKeyForDeletion(key);
				eS3Writer.Save();
			}
		}
	}

	public static bool KeyExists(string key)
	{
		return KeyExists(key, new ES3Settings());
	}

	public static bool KeyExists(string key, string filePath)
	{
		return KeyExists(key, new ES3Settings(filePath));
	}

	public static bool KeyExists(string key, string filePath, ES3Settings settings)
	{
		return KeyExists(key, new ES3Settings(filePath, settings));
	}

	public static bool KeyExists(string key, ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			return ES3File.KeyExists(key, settings);
		}
		using ES3Reader eS3Reader = ES3Reader.Create(settings);
		return eS3Reader?.Goto(key) ?? false;
	}

	public static bool FileExists()
	{
		return FileExists(new ES3Settings());
	}

	public static bool FileExists(string filePath)
	{
		return FileExists(new ES3Settings(filePath));
	}

	public static bool FileExists(string filePath, ES3Settings settings)
	{
		return FileExists(new ES3Settings(filePath, settings));
	}

	public static bool FileExists(ES3Settings settings)
	{
		if (settings.location == Location.File)
		{
			return ES3IO.FileExists(settings.FullPath);
		}
		if (settings.location == Location.PlayerPrefs)
		{
			return PlayerPrefs.HasKey(settings.FullPath);
		}
		if (settings.location == Location.Cache)
		{
			return ES3File.FileExists(settings);
		}
		if (settings.location == Location.Resources)
		{
			return Resources.Load(settings.FullPath) != null;
		}
		return false;
	}

	public static bool DirectoryExists(string folderPath)
	{
		return DirectoryExists(new ES3Settings(folderPath));
	}

	public static bool DirectoryExists(string folderPath, ES3Settings settings)
	{
		return DirectoryExists(new ES3Settings(folderPath, settings));
	}

	public static bool DirectoryExists(ES3Settings settings)
	{
		if (settings.location == Location.File)
		{
			return ES3IO.DirectoryExists(settings.FullPath);
		}
		if (settings.location == Location.PlayerPrefs || settings.location == Location.Cache)
		{
			throw new NotSupportedException("Directories are not supported for the Cache and PlayerPrefs location.");
		}
		if (settings.location == Location.Resources)
		{
			throw new NotSupportedException("Checking existence of folder in Resources not supported.");
		}
		return false;
	}

	public static string[] GetKeys()
	{
		return GetKeys(new ES3Settings());
	}

	public static string[] GetKeys(string filePath)
	{
		return GetKeys(new ES3Settings(filePath));
	}

	public static string[] GetKeys(string filePath, ES3Settings settings)
	{
		return GetKeys(new ES3Settings(filePath, settings));
	}

	public static string[] GetKeys(ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			return ES3File.GetKeys(settings);
		}
		List<string> list = new List<string>();
		using (ES3Reader eS3Reader = ES3Reader.Create(settings))
		{
			foreach (string property in eS3Reader.Properties)
			{
				list.Add(property);
				eS3Reader.Skip();
			}
		}
		return list.ToArray();
	}

	public static string[] GetFiles()
	{
		ES3Settings eS3Settings = new ES3Settings();
		if (eS3Settings.location == Location.File)
		{
			if (eS3Settings.directory == Directory.PersistentDataPath)
			{
				eS3Settings.path = ES3IO.persistentDataPath;
			}
			else
			{
				eS3Settings.path = ES3IO.dataPath;
			}
		}
		return GetFiles(new ES3Settings());
	}

	public static string[] GetFiles(string directoryPath)
	{
		return GetFiles(new ES3Settings(directoryPath));
	}

	public static string[] GetFiles(string directoryPath, ES3Settings settings)
	{
		return GetFiles(new ES3Settings(directoryPath, settings));
	}

	public static string[] GetFiles(ES3Settings settings)
	{
		if (settings.location == Location.Cache)
		{
			return ES3File.GetFiles();
		}
		if (settings.location != Location.File)
		{
			throw new NotSupportedException("ES3.GetFiles can only be used when the location is set to File or Cache.");
		}
		return ES3IO.GetFiles(settings.FullPath, getFullPaths: false);
	}

	public static string[] GetDirectories()
	{
		return GetDirectories(new ES3Settings());
	}

	public static string[] GetDirectories(string directoryPath)
	{
		return GetDirectories(new ES3Settings(directoryPath));
	}

	public static string[] GetDirectories(string directoryPath, ES3Settings settings)
	{
		return GetDirectories(new ES3Settings(directoryPath, settings));
	}

	public static string[] GetDirectories(ES3Settings settings)
	{
		if (settings.location != Location.File)
		{
			throw new NotSupportedException("ES3.GetDirectories can only be used when the location is set to File.");
		}
		return ES3IO.GetDirectories(settings.FullPath, getFullPaths: false);
	}

	public static void CreateBackup()
	{
		CreateBackup(new ES3Settings());
	}

	public static void CreateBackup(string filePath)
	{
		CreateBackup(new ES3Settings(filePath));
	}

	public static void CreateBackup(string filePath, ES3Settings settings)
	{
		CreateBackup(new ES3Settings(filePath, settings));
	}

	public static void CreateBackup(ES3Settings settings)
	{
		ES3Settings newSettings = new ES3Settings(settings.path + ".bac", settings);
		CopyFile(settings, newSettings);
	}

	public static bool RestoreBackup(string filePath)
	{
		return RestoreBackup(new ES3Settings(filePath));
	}

	public static bool RestoreBackup(string filePath, ES3Settings settings)
	{
		return RestoreBackup(new ES3Settings(filePath, settings));
	}

	public static bool RestoreBackup(ES3Settings settings)
	{
		ES3Settings eS3Settings = new ES3Settings(settings.path + ".bac", settings);
		if (!FileExists(eS3Settings))
		{
			return false;
		}
		RenameFile(eS3Settings, settings);
		return true;
	}

	public static DateTime GetTimestamp()
	{
		return GetTimestamp(new ES3Settings());
	}

	public static DateTime GetTimestamp(string filePath)
	{
		return GetTimestamp(new ES3Settings(filePath));
	}

	public static DateTime GetTimestamp(string filePath, ES3Settings settings)
	{
		return GetTimestamp(new ES3Settings(filePath, settings));
	}

	public static DateTime GetTimestamp(ES3Settings settings)
	{
		if (settings.location == Location.File)
		{
			return ES3IO.GetTimestamp(settings.FullPath);
		}
		if (settings.location == Location.PlayerPrefs)
		{
			return new DateTime(long.Parse(PlayerPrefs.GetString("timestamp_" + settings.FullPath, "0")), DateTimeKind.Utc);
		}
		if (settings.location == Location.Cache)
		{
			return ES3File.GetTimestamp(settings);
		}
		return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
	}

	public static void StoreCachedFile()
	{
		ES3File.Store();
	}

	public static void StoreCachedFile(string filePath)
	{
		StoreCachedFile(new ES3Settings(filePath));
	}

	public static void StoreCachedFile(string filePath, ES3Settings settings)
	{
		StoreCachedFile(new ES3Settings(filePath, settings));
	}

	public static void StoreCachedFile(ES3Settings settings)
	{
		ES3File.Store(settings);
	}

	public static void CacheFile()
	{
		CacheFile(new ES3Settings());
	}

	public static void CacheFile(string filePath)
	{
		CacheFile(new ES3Settings(filePath));
	}

	public static void CacheFile(string filePath, ES3Settings settings)
	{
		CacheFile(new ES3Settings(filePath, settings));
	}

	public static void CacheFile(ES3Settings settings)
	{
		ES3File.CacheFile(settings);
	}

	public static void Init()
	{
		_ = ES3Settings.defaultSettings;
		_ = ES3IO.persistentDataPath;
		ES3TypeMgr.Init();
	}
}
