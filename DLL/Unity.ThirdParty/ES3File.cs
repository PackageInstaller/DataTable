using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using ES3Internal;

public class ES3File
{
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static Dictionary<string, ES3File> cachedFiles = new Dictionary<string, ES3File>();

	public ES3Settings settings;

	private Dictionary<string, ES3Data> cache = new Dictionary<string, ES3Data>();

	private bool syncWithFile;

	private DateTime timestamp = DateTime.UtcNow;

	public ES3File()
		: this(new ES3Settings(), syncWithFile: true)
	{
	}

	public ES3File(string filePath)
		: this(new ES3Settings(filePath), syncWithFile: true)
	{
	}

	public ES3File(string filePath, ES3Settings settings)
		: this(new ES3Settings(filePath, settings), syncWithFile: true)
	{
	}

	public ES3File(ES3Settings settings)
		: this(settings, syncWithFile: true)
	{
	}

	public ES3File(bool syncWithFile)
		: this(new ES3Settings(), syncWithFile)
	{
	}

	public ES3File(string filePath, bool syncWithFile)
		: this(new ES3Settings(filePath), syncWithFile)
	{
	}

	public ES3File(string filePath, ES3Settings settings, bool syncWithFile)
		: this(new ES3Settings(filePath, settings), syncWithFile)
	{
	}

	public ES3File(ES3Settings settings, bool syncWithFile)
	{
		this.settings = settings;
		this.syncWithFile = syncWithFile;
		if (!syncWithFile)
		{
			return;
		}
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.typeChecking = true;
		using (ES3Reader eS3Reader = ES3Reader.Create(eS3Settings))
		{
			if (eS3Reader == null)
			{
				return;
			}
			foreach (KeyValuePair<string, ES3Data> item in eS3Reader.RawEnumerator)
			{
				cache[item.Key] = item.Value;
			}
		}
		timestamp = ES3.GetTimestamp(eS3Settings);
	}

	public ES3File(byte[] bytes, ES3Settings settings = null)
	{
		if (settings == null)
		{
			this.settings = new ES3Settings();
		}
		else
		{
			this.settings = settings;
		}
		syncWithFile = true;
		SaveRaw(bytes, settings);
	}

	public void Sync()
	{
		Sync(settings);
	}

	public void Sync(string filePath, ES3Settings settings = null)
	{
		Sync(new ES3Settings(filePath, settings));
	}

	public void Sync(ES3Settings settings = null)
	{
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		if (cache.Count == 0)
		{
			ES3.DeleteFile(settings);
			return;
		}
		using ES3Writer eS3Writer = ES3Writer.Create(settings, writeHeaderAndFooter: true, !syncWithFile, append: false);
		foreach (KeyValuePair<string, ES3Data> item in cache)
		{
			eS3Writer.Write(type: (item.Value.type != null) ? item.Value.type.type : typeof(object), key: item.Key, value: item.Value.bytes);
		}
		eS3Writer.Save(!syncWithFile);
	}

	public void Clear()
	{
		cache.Clear();
	}

	public string[] GetKeys()
	{
		Dictionary<string, ES3Data>.KeyCollection keys = cache.Keys;
		string[] array = new string[keys.Count];
		keys.CopyTo(array, 0);
		return array;
	}

	public void Save<T>(string key, T value)
	{
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.encryptionType = ES3.EncryptionType.None;
		eS3Settings.compressionType = ES3.CompressionType.None;
		Type type = ((value != null) ? value.GetType() : typeof(T));
		cache[key] = new ES3Data(ES3TypeMgr.GetOrCreateES3Type(type), ES3.Serialize(value, eS3Settings));
	}

	public void SaveRaw(byte[] bytes, ES3Settings settings = null)
	{
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.typeChecking = true;
		using ES3Reader eS3Reader = ES3Reader.Create(bytes, eS3Settings);
		if (eS3Reader == null)
		{
			return;
		}
		foreach (KeyValuePair<string, ES3Data> item in eS3Reader.RawEnumerator)
		{
			cache[item.Key] = item.Value;
		}
	}

	public void AppendRaw(byte[] bytes, ES3Settings settings = null)
	{
		if (settings == null)
		{
			settings = new ES3Settings();
		}
		SaveRaw(bytes, settings);
	}

	public object Load(string key)
	{
		return Load<object>(key);
	}

	public object Load(string key, object defaultValue)
	{
		return this.Load<object>(key, defaultValue);
	}

	public T Load<T>(string key)
	{
		if (!cache.TryGetValue(key, out var value))
		{
			throw new KeyNotFoundException("Key \"" + key + "\" was not found in this ES3File. Use Load<T>(key, defaultValue) if you want to return a default value if the key does not exist.");
		}
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.encryptionType = ES3.EncryptionType.None;
		eS3Settings.compressionType = ES3.CompressionType.None;
		if (typeof(T) == typeof(object))
		{
			return (T)ES3.Deserialize(value.type, value.bytes, eS3Settings);
		}
		return ES3.Deserialize<T>(value.bytes, eS3Settings);
	}

	public T Load<T>(string key, T defaultValue)
	{
		if (!cache.TryGetValue(key, out var value))
		{
			return defaultValue;
		}
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.encryptionType = ES3.EncryptionType.None;
		eS3Settings.compressionType = ES3.CompressionType.None;
		if (typeof(T) == typeof(object))
		{
			return (T)ES3.Deserialize(value.type, value.bytes, eS3Settings);
		}
		return ES3.Deserialize<T>(value.bytes, eS3Settings);
	}

	public void LoadInto<T>(string key, T obj) where T : class
	{
		if (!cache.TryGetValue(key, out var value))
		{
			throw new KeyNotFoundException("Key \"" + key + "\" was not found in this ES3File. Use Load<T>(key, defaultValue) if you want to return a default value if the key does not exist.");
		}
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.encryptionType = ES3.EncryptionType.None;
		eS3Settings.compressionType = ES3.CompressionType.None;
		if (typeof(T) == typeof(object))
		{
			ES3.DeserializeInto(value.type, value.bytes, obj, eS3Settings);
		}
		else
		{
			ES3.DeserializeInto(value.bytes, obj, eS3Settings);
		}
	}

	public byte[] LoadRawBytes()
	{
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		if (!eS3Settings.postprocessRawCachedData)
		{
			eS3Settings.encryptionType = ES3.EncryptionType.None;
			eS3Settings.compressionType = ES3.CompressionType.None;
		}
		return GetBytes(eS3Settings);
	}

	public string LoadRawString()
	{
		if (cache.Count == 0)
		{
			return "";
		}
		return settings.encoding.GetString(LoadRawBytes());
	}

	internal byte[] GetBytes(ES3Settings settings = null)
	{
		if (cache.Count == 0)
		{
			return new byte[0];
		}
		if (settings == null)
		{
			settings = this.settings;
		}
		using MemoryStream memoryStream = new MemoryStream();
		ES3Settings eS3Settings = (ES3Settings)settings.Clone();
		eS3Settings.location = ES3.Location.InternalMS;
		if (!eS3Settings.postprocessRawCachedData)
		{
			eS3Settings.encryptionType = ES3.EncryptionType.None;
			eS3Settings.compressionType = ES3.CompressionType.None;
		}
		using (ES3Writer eS3Writer = ES3Writer.Create(ES3Stream.CreateStream(memoryStream, eS3Settings, ES3FileMode.Write), eS3Settings, writeHeaderAndFooter: true, overwriteKeys: false))
		{
			foreach (KeyValuePair<string, ES3Data> item in cache)
			{
				eS3Writer.Write(item.Key, item.Value.type.type, item.Value.bytes);
			}
			eS3Writer.Save(overwriteKeys: false);
		}
		return memoryStream.ToArray();
	}

	public void DeleteKey(string key)
	{
		cache.Remove(key);
	}

	public bool KeyExists(string key)
	{
		return cache.ContainsKey(key);
	}

	public int Size()
	{
		int num = 0;
		foreach (KeyValuePair<string, ES3Data> item in cache)
		{
			num += item.Value.bytes.Length;
		}
		return num;
	}

	public Type GetKeyType(string key)
	{
		if (!cache.TryGetValue(key, out var value))
		{
			throw new KeyNotFoundException("Key \"" + key + "\" was not found in this ES3File. Use Load<T>(key, defaultValue) if you want to return a default value if the key does not exist.");
		}
		return value.type.type;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static ES3File GetOrCreateCachedFile(ES3Settings settings)
	{
		if (!cachedFiles.TryGetValue(settings.path, out var value))
		{
			value = new ES3File(settings, syncWithFile: false);
			cachedFiles.Add(settings.path, value);
			value.syncWithFile = true;
		}
		value.settings = settings;
		return value;
	}

	internal static void CacheFile(ES3Settings settings)
	{
		if (settings.location == ES3.Location.Cache)
		{
			settings = (ES3Settings)settings.Clone();
			settings.location = ((ES3Settings.defaultSettings.location != ES3.Location.Cache) ? ES3Settings.defaultSettings.location : ES3.Location.File);
		}
		if (ES3.FileExists(settings))
		{
			ES3Settings eS3Settings = (ES3Settings)settings.Clone();
			eS3Settings.compressionType = ES3.CompressionType.None;
			eS3Settings.encryptionType = ES3.EncryptionType.None;
			cachedFiles[settings.path] = new ES3File(ES3.LoadRawBytes(eS3Settings), settings);
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static void Store(ES3Settings settings = null)
	{
		if (settings == null)
		{
			settings = new ES3Settings(ES3.Location.File);
		}
		else if (settings.location == ES3.Location.Cache)
		{
			settings = (ES3Settings)settings.Clone();
			settings.location = ((ES3Settings.defaultSettings.location != ES3.Location.Cache) ? ES3Settings.defaultSettings.location : ES3.Location.File);
		}
		if (!cachedFiles.TryGetValue(settings.path, out var value))
		{
			throw new FileNotFoundException("The file '" + settings.path + "' could not be stored because it could not be found in the cache.");
		}
		value.Sync(settings);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static void RemoveCachedFile(ES3Settings settings)
	{
		cachedFiles.Remove(settings.path);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static void CopyCachedFile(ES3Settings oldSettings, ES3Settings newSettings)
	{
		if (!cachedFiles.TryGetValue(oldSettings.path, out var value))
		{
			throw new FileNotFoundException("The file '" + oldSettings.path + "' could not be copied because it could not be found in the cache.");
		}
		if (cachedFiles.ContainsKey(newSettings.path))
		{
			throw new InvalidOperationException("Cannot copy file '" + oldSettings.path + "' to '" + newSettings.path + "' because '" + newSettings.path + "' already exists");
		}
		cachedFiles.Add(newSettings.path, (ES3File)value.MemberwiseClone());
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static void DeleteKey(string key, ES3Settings settings)
	{
		if (cachedFiles.TryGetValue(settings.path, out var value))
		{
			value.DeleteKey(key);
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static bool KeyExists(string key, ES3Settings settings)
	{
		if (cachedFiles.TryGetValue(settings.path, out var value))
		{
			return value.KeyExists(key);
		}
		return false;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static bool FileExists(ES3Settings settings)
	{
		return cachedFiles.ContainsKey(settings.path);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static string[] GetKeys(ES3Settings settings)
	{
		if (!cachedFiles.TryGetValue(settings.path, out var value))
		{
			throw new FileNotFoundException("Could not get keys from the file '" + settings.path + "' because it could not be found in the cache.");
		}
		return value.cache.Keys.ToArray();
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static string[] GetFiles()
	{
		return cachedFiles.Keys.ToArray();
	}

	internal static DateTime GetTimestamp(ES3Settings settings)
	{
		if (!cachedFiles.TryGetValue(settings.path, out var value))
		{
			return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
		}
		return value.timestamp;
	}
}
