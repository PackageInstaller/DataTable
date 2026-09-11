using System;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Security;
using System.Security.Cryptography;
using System.Text;
using Mono.Xml;

namespace Mono.Security.Cryptography;

internal class KeyPairPersistence
{
	private static bool _userPathExists;

	private static string _userPath;

	private static bool _machinePathExists;

	private static string _machinePath;

	private CspParameters _params;

	private string _keyvalue;

	private string _filename;

	private string _container;

	private static object lockobj = new object();

	public string Filename
	{
		get
		{
			if (_filename == null)
			{
				_filename = string.Format(CultureInfo.InvariantCulture, "[{0}][{1}][{2}].xml", _params.ProviderType, ContainerName, _params.KeyNumber);
				if (UseMachineKeyStore)
				{
					_filename = Path.Combine(MachinePath, _filename);
				}
				else
				{
					_filename = Path.Combine(UserPath, _filename);
				}
			}
			return _filename;
		}
	}

	public string KeyValue
	{
		get
		{
			return _keyvalue;
		}
		set
		{
			if (CanChange)
			{
				_keyvalue = value;
			}
		}
	}

	private static string UserPath
	{
		get
		{
			lock (lockobj)
			{
				if (_userPath == null || !_userPathExists)
				{
					_userPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData), ".mono");
					_userPath = Path.Combine(_userPath, "keypairs");
					_userPathExists = Directory.Exists(_userPath);
					if (!_userPathExists)
					{
						try
						{
							Directory.CreateDirectory(_userPath);
						}
						catch (Exception inner)
						{
							throw new CryptographicException(string.Format(Locale.GetText("Could not create user key store '{0}'."), _userPath), inner);
						}
						_userPathExists = true;
					}
				}
				if (!IsUserProtected(_userPath) && !ProtectUser(_userPath))
				{
					throw new IOException(string.Format(Locale.GetText("Could not secure user key store '{0}'."), _userPath));
				}
			}
			if (!IsUserProtected(_userPath))
			{
				throw new CryptographicException(string.Format(Locale.GetText("Improperly protected user's key pairs in '{0}'."), _userPath));
			}
			return _userPath;
		}
	}

	private static string MachinePath
	{
		get
		{
			lock (lockobj)
			{
				if (_machinePath == null || !_machinePathExists)
				{
					_machinePath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData), ".mono");
					_machinePath = Path.Combine(_machinePath, "keypairs");
					_machinePathExists = Directory.Exists(_machinePath);
					if (!_machinePathExists)
					{
						try
						{
							Directory.CreateDirectory(_machinePath);
						}
						catch (Exception inner)
						{
							throw new CryptographicException(string.Format(Locale.GetText("Could not create machine key store '{0}'."), _machinePath), inner);
						}
						_machinePathExists = true;
					}
				}
				if (!IsMachineProtected(_machinePath) && !ProtectMachine(_machinePath))
				{
					throw new IOException(string.Format(Locale.GetText("Could not secure machine key store '{0}'."), _machinePath));
				}
			}
			if (!IsMachineProtected(_machinePath))
			{
				throw new CryptographicException(string.Format(Locale.GetText("Improperly protected machine's key pairs in '{0}'."), _machinePath));
			}
			return _machinePath;
		}
	}

	private bool CanChange => _keyvalue == null;

	private bool UseDefaultKeyContainer => (_params.Flags & CspProviderFlags.UseDefaultKeyContainer) == CspProviderFlags.UseDefaultKeyContainer;

	private bool UseMachineKeyStore => (_params.Flags & CspProviderFlags.UseMachineKeyStore) == CspProviderFlags.UseMachineKeyStore;

	private string ContainerName
	{
		get
		{
			if (_container == null)
			{
				if (UseDefaultKeyContainer)
				{
					_container = "default";
				}
				else if (_params.KeyContainerName == null || _params.KeyContainerName.Length == 0)
				{
					_container = Guid.NewGuid().ToString();
				}
				else
				{
					byte[] bytes = Encoding.UTF8.GetBytes(_params.KeyContainerName);
					byte[] b = MD5.Create().ComputeHash(bytes);
					_container = new Guid(b).ToString();
				}
			}
			return _container;
		}
	}

	public KeyPairPersistence(CspParameters parameters)
		: this(parameters, null)
	{
	}

	public KeyPairPersistence(CspParameters parameters, string keyPair)
	{
		if (parameters == null)
		{
			throw new ArgumentNullException("parameters");
		}
		_params = Copy(parameters);
		_keyvalue = keyPair;
	}

	public bool Load()
	{
		bool flag = File.Exists(Filename);
		if (flag)
		{
			using StreamReader streamReader = File.OpenText(Filename);
			FromXml(streamReader.ReadToEnd());
		}
		return flag;
	}

	public void Save()
	{
		using (FileStream stream = File.Open(Filename, FileMode.Create))
		{
			StreamWriter streamWriter = new StreamWriter(stream, Encoding.UTF8);
			streamWriter.Write(ToXml());
			streamWriter.Close();
		}
		if (UseMachineKeyStore)
		{
			ProtectMachine(Filename);
		}
		else
		{
			ProtectUser(Filename);
		}
	}

	public void Remove()
	{
		File.Delete(Filename);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern bool _CanSecure(char* root);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern bool _ProtectUser(char* path);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern bool _ProtectMachine(char* path);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern bool _IsUserProtected(char* path);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern bool _IsMachineProtected(char* path);

	private unsafe static bool CanSecure(string path)
	{
		int platform = (int)Environment.OSVersion.Platform;
		if (platform == 4 || platform == 128 || platform == 6)
		{
			return true;
		}
		fixed (char* root = path)
		{
			return _CanSecure(root);
		}
	}

	private unsafe static bool ProtectUser(string path)
	{
		if (CanSecure(path))
		{
			fixed (char* path2 = path)
			{
				return _ProtectUser(path2);
			}
		}
		return true;
	}

	private unsafe static bool ProtectMachine(string path)
	{
		if (CanSecure(path))
		{
			fixed (char* path2 = path)
			{
				return _ProtectMachine(path2);
			}
		}
		return true;
	}

	private unsafe static bool IsUserProtected(string path)
	{
		if (CanSecure(path))
		{
			fixed (char* path2 = path)
			{
				return _IsUserProtected(path2);
			}
		}
		return true;
	}

	private unsafe static bool IsMachineProtected(string path)
	{
		if (CanSecure(path))
		{
			fixed (char* path2 = path)
			{
				return _IsMachineProtected(path2);
			}
		}
		return true;
	}

	private CspParameters Copy(CspParameters p)
	{
		return new CspParameters(p.ProviderType, p.ProviderName, p.KeyContainerName)
		{
			KeyNumber = p.KeyNumber,
			Flags = p.Flags
		};
	}

	private void FromXml(string xml)
	{
		SecurityParser securityParser = new SecurityParser();
		securityParser.LoadXml(xml);
		SecurityElement securityElement = securityParser.ToXml();
		if (securityElement.Tag == "KeyPair")
		{
			SecurityElement securityElement2 = securityElement.SearchForChildByTag("KeyValue");
			if (securityElement2.Children.Count > 0)
			{
				_keyvalue = securityElement2.Children[0].ToString();
			}
		}
	}

	private string ToXml()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendFormat("<KeyPair>{0}\t<Properties>{0}\t\t<Provider ", Environment.NewLine);
		if (_params.ProviderName != null && _params.ProviderName.Length != 0)
		{
			stringBuilder.AppendFormat("Name=\"{0}\" ", _params.ProviderName);
		}
		stringBuilder.AppendFormat("Type=\"{0}\" />{1}\t\t<Container ", _params.ProviderType, Environment.NewLine);
		stringBuilder.AppendFormat("Name=\"{0}\" />{1}\t</Properties>{1}\t<KeyValue", ContainerName, Environment.NewLine);
		if (_params.KeyNumber != -1)
		{
			stringBuilder.AppendFormat(" Id=\"{0}\" ", _params.KeyNumber);
		}
		stringBuilder.AppendFormat(">{1}\t\t{0}{1}\t</KeyValue>{1}</KeyPair>{1}", KeyValue, Environment.NewLine);
		return stringBuilder.ToString();
	}
}
