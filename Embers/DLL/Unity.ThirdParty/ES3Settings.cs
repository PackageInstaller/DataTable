using System;
using System.ComponentModel;
using System.IO;
using System.Text;
using ES3Internal;
using UnityEngine;

public class ES3Settings : ICloneable
{
	private static ES3Settings _defaults = null;

	private static ES3Defaults _defaultSettingsScriptableObject;

	private const string defaultSettingsPath = "ES3/ES3Defaults";

	private static ES3Settings _unencryptedUncompressedSettings = null;

	private static readonly string[] resourcesExtensions = new string[9] { ".txt", ".htm", ".html", ".xml", ".bytes", ".json", ".csv", ".yaml", ".fnt" };

	[SerializeField]
	private ES3.Location _location;

	public string path = "SaveFile.es3";

	public ES3.EncryptionType encryptionType;

	public ES3.CompressionType compressionType;

	public string encryptionPassword = "password";

	public ES3.Directory directory;

	public ES3.Format format;

	public bool prettyPrint = true;

	public int bufferSize = 2048;

	public Encoding encoding = Encoding.UTF8;

	public bool saveChildren = true;

	public bool postprocessRawCachedData;

	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool typeChecking = true;

	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool safeReflection = true;

	[EditorBrowsable(EditorBrowsableState.Never)]
	public ES3.ReferenceMode memberReferenceMode;

	[EditorBrowsable(EditorBrowsableState.Never)]
	public ES3.ReferenceMode referenceMode = ES3.ReferenceMode.ByRefAndValue;

	[EditorBrowsable(EditorBrowsableState.Never)]
	public int serializationDepthLimit = 64;

	[EditorBrowsable(EditorBrowsableState.Never)]
	public string[] assemblyNames = new string[2] { "Assembly-CSharp-firstpass", "Assembly-CSharp" };

	public static ES3Defaults defaultSettingsScriptableObject
	{
		get
		{
			if (_defaultSettingsScriptableObject == null)
			{
				_defaultSettingsScriptableObject = Resources.Load<ES3Defaults>("ES3/ES3Defaults");
			}
			return _defaultSettingsScriptableObject;
		}
	}

	public static ES3Settings defaultSettings
	{
		get
		{
			if (_defaults == null && defaultSettingsScriptableObject != null)
			{
				_defaults = defaultSettingsScriptableObject.settings;
			}
			return _defaults;
		}
	}

	internal static ES3Settings unencryptedUncompressedSettings
	{
		get
		{
			if (_unencryptedUncompressedSettings == null)
			{
				_unencryptedUncompressedSettings = new ES3Settings(ES3.EncryptionType.None, ES3.CompressionType.None);
			}
			return _unencryptedUncompressedSettings;
		}
	}

	public ES3.Location location
	{
		get
		{
			if (_location == ES3.Location.File && (Application.platform == RuntimePlatform.WebGLPlayer || Application.platform == RuntimePlatform.tvOS))
			{
				return ES3.Location.PlayerPrefs;
			}
			return _location;
		}
		set
		{
			_location = value;
		}
	}

	public string FullPath
	{
		get
		{
			if (path == null)
			{
				throw new NullReferenceException("The 'path' field of this ES3Settings is null, indicating that it was not possible to load the default settings from Resources. Please check that the ES3 Default Settings.prefab exists in Assets/Plugins/Resources/ES3/");
			}
			if (IsAbsolute(path))
			{
				return path;
			}
			if (location == ES3.Location.File)
			{
				if (directory == ES3.Directory.PersistentDataPath)
				{
					return ES3IO.persistentDataPath + "/" + path;
				}
				if (directory == ES3.Directory.DataPath)
				{
					return Application.dataPath + "/" + path;
				}
				throw new NotImplementedException("File directory \"" + directory.ToString() + "\" has not been implemented.");
			}
			if (location == ES3.Location.Resources)
			{
				string extension = Path.GetExtension(path);
				bool flag = false;
				string[] array = resourcesExtensions;
				foreach (string text in array)
				{
					if (extension == text)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					throw new ArgumentException("Extension of file in Resources must be .json, .bytes, .txt, .csv, .htm, .html, .xml, .yaml or .fnt, but path given was \"" + path + "\"");
				}
				return path.Replace(extension, "");
			}
			return path;
		}
	}

	public ES3Settings(string path = null, ES3Settings settings = null)
		: this(applyDefaults: true)
	{
		settings?.CopyInto(this);
		if (path != null)
		{
			this.path = path;
		}
	}

	public ES3Settings(string path, params Enum[] enums)
		: this(enums)
	{
		if (path != null)
		{
			this.path = path;
		}
	}

	public ES3Settings(params Enum[] enums)
		: this(applyDefaults: true)
	{
		foreach (Enum obj in enums)
		{
			if (obj is ES3.EncryptionType)
			{
				encryptionType = (ES3.EncryptionType)(object)obj;
			}
			else if (obj is ES3.Location)
			{
				location = (ES3.Location)(object)obj;
			}
			else if (obj is ES3.CompressionType)
			{
				compressionType = (ES3.CompressionType)(object)obj;
			}
			else if (obj is ES3.ReferenceMode)
			{
				referenceMode = (ES3.ReferenceMode)(object)obj;
			}
			else if (obj is ES3.Format)
			{
				format = (ES3.Format)(object)obj;
			}
			else if (obj is ES3.Directory)
			{
				directory = (ES3.Directory)(object)obj;
			}
		}
	}

	public ES3Settings(ES3.EncryptionType encryptionType, string encryptionPassword)
		: this(applyDefaults: true)
	{
		this.encryptionType = encryptionType;
		this.encryptionPassword = encryptionPassword;
	}

	public ES3Settings(string path, ES3.EncryptionType encryptionType, string encryptionPassword, ES3Settings settings = null)
		: this(path, settings)
	{
		this.encryptionType = encryptionType;
		this.encryptionPassword = encryptionPassword;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public ES3Settings(bool applyDefaults)
	{
		if (applyDefaults && defaultSettings != null)
		{
			_defaults.CopyInto(this);
		}
	}

	private static bool IsAbsolute(string path)
	{
		if (path.Length > 0 && (path[0] == '/' || path[0] == '\\'))
		{
			return true;
		}
		if (path.Length > 1 && path[1] == ':')
		{
			return true;
		}
		return false;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public object Clone()
	{
		ES3Settings eS3Settings = new ES3Settings();
		CopyInto(eS3Settings);
		return eS3Settings;
	}

	private void CopyInto(ES3Settings newSettings)
	{
		newSettings._location = _location;
		newSettings.directory = directory;
		newSettings.format = format;
		newSettings.prettyPrint = prettyPrint;
		newSettings.path = path;
		newSettings.encryptionType = encryptionType;
		newSettings.encryptionPassword = encryptionPassword;
		newSettings.compressionType = compressionType;
		newSettings.bufferSize = bufferSize;
		newSettings.encoding = encoding;
		newSettings.typeChecking = typeChecking;
		newSettings.safeReflection = safeReflection;
		newSettings.referenceMode = referenceMode;
		newSettings.memberReferenceMode = memberReferenceMode;
		newSettings.assemblyNames = assemblyNames;
		newSettings.saveChildren = saveChildren;
		newSettings.serializationDepthLimit = serializationDepthLimit;
		newSettings.postprocessRawCachedData = postprocessRawCachedData;
	}
}
