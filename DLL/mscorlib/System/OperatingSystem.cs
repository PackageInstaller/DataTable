using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class OperatingSystem : ISerializable, ICloneable
{
	private readonly Version _version;

	private readonly PlatformID _platform;

	private readonly string _servicePack;

	private string _versionString;

	public PlatformID Platform => _platform;

	public Version Version => _version;

	public string VersionString
	{
		get
		{
			if (_versionString == null)
			{
				string text = _platform switch
				{
					PlatformID.Win32S => "Microsoft Win32S ", 
					PlatformID.Win32Windows => (_version.Major > 4 || (_version.Major == 4 && _version.Minor > 0)) ? "Microsoft Windows 98 " : "Microsoft Windows 95 ", 
					PlatformID.Win32NT => "Microsoft Windows NT ", 
					PlatformID.WinCE => "Microsoft Windows CE ", 
					PlatformID.Unix => "Unix ", 
					PlatformID.Xbox => "Xbox ", 
					PlatformID.MacOSX => "Mac OS X ", 
					_ => "<unknown> ", 
				};
				_versionString = (string.IsNullOrEmpty(_servicePack) ? (text + _version.ToString()) : (text + _version.ToString(3) + " " + _servicePack));
			}
			return _versionString;
		}
	}

	public OperatingSystem(PlatformID platform, Version version)
		: this(platform, version, null)
	{
	}

	internal OperatingSystem(PlatformID platform, Version version, string servicePack)
	{
		if (platform < PlatformID.Win32S || platform > PlatformID.MacOSX)
		{
			throw new ArgumentOutOfRangeException("platform", platform, SR.Format("Illegal enum value: {0}.", platform));
		}
		if (version == null)
		{
			throw new ArgumentNullException("version");
		}
		_platform = platform;
		_version = version;
		_servicePack = servicePack;
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw new PlatformNotSupportedException();
	}

	public object Clone()
	{
		return new OperatingSystem(_platform, _version, _servicePack);
	}

	public override string ToString()
	{
		return VersionString;
	}
}
