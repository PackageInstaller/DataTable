using System.Collections;
using System.Diagnostics;
using System.Diagnostics.Contracts;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Security;
using System.Text;
using System.Threading;
using Mono;

namespace System;

[ComVisible(true)]
public static class Environment
{
	[ComVisible(true)]
	public enum SpecialFolder
	{
		MyDocuments = 5,
		Desktop = 0,
		MyComputer = 17,
		Programs = 2,
		Personal = MyDocuments,
		Favorites = 6,
		Startup = 7,
		Recent = 8,
		SendTo = 9,
		StartMenu = 11,
		MyMusic = 13,
		DesktopDirectory = 16,
		Templates = 21,
		ApplicationData = 26,
		LocalApplicationData = 28,
		InternetCache = 32,
		Cookies = 33,
		History = 34,
		CommonApplicationData = 35,
		System = 37,
		ProgramFiles = 38,
		MyPictures = 39,
		CommonProgramFiles = 43,
		MyVideos = 14,
		NetworkShortcuts = 19,
		Fonts = 20,
		CommonStartMenu = 22,
		CommonPrograms = 23,
		CommonStartup = 24,
		CommonDesktopDirectory = 25,
		PrinterShortcuts = 27,
		Windows = 36,
		UserProfile = 40,
		SystemX86 = 41,
		ProgramFilesX86 = 42,
		CommonProgramFilesX86 = 44,
		CommonTemplates = 45,
		CommonDocuments = 46,
		CommonAdminTools = 47,
		AdminTools = 48,
		CommonMusic = 53,
		CommonPictures = 54,
		CommonVideos = 55,
		Resources = 56,
		LocalizedResources = 57,
		CommonOemLinks = 58,
		CDBurning = 59
	}

	public enum SpecialFolderOption
	{
		None = 0,
		DoNotVerify = 0x4000,
		Create = 0x8000
	}

	private const string mono_corlib_version = "1A5E0066-58DC-428A-B21C-0AD6CDAE2789";

	private static string nl;

	private static OperatingSystem os;

	internal static bool IsWindows8OrAbove => false;

	public static string CommandLine
	{
		get
		{
			StringBuilder stringBuilder = new StringBuilder();
			string[] commandLineArgs = GetCommandLineArgs();
			foreach (string obj in commandLineArgs)
			{
				bool flag = false;
				string text = "";
				string text2 = obj;
				for (int j = 0; j < text2.Length; j++)
				{
					if (text.Length == 0 && char.IsWhiteSpace(text2[j]))
					{
						text = "\"";
					}
					else if (text2[j] == '"')
					{
						flag = true;
					}
				}
				if (flag && text.Length != 0)
				{
					text2 = text2.Replace("\"", "\\\"");
				}
				stringBuilder.AppendFormat("{0}{1}{0} ", text, text2);
			}
			if (stringBuilder.Length > 0)
			{
				stringBuilder.Length--;
			}
			return stringBuilder.ToString();
		}
	}

	public static string CurrentDirectory
	{
		get
		{
			return Directory.InsecureGetCurrentDirectory();
		}
		set
		{
			Directory.InsecureSetCurrentDirectory(value);
		}
	}

	public static int CurrentManagedThreadId => Thread.CurrentThread.ManagedThreadId;

	public static extern int ExitCode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern bool HasShutdownStarted
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern string MachineName
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static string NewLine
	{
		get
		{
			if (nl != null)
			{
				return nl;
			}
			nl = GetNewLine();
			return nl;
		}
	}

	internal static extern PlatformID Platform
	{
		[MethodImpl((MethodImplOptions)4096)]
		[CompilerGenerated]
		get;
	}

	public static OperatingSystem OSVersion
	{
		get
		{
			if (os == null)
			{
				Version version = CreateVersionFromString(GetOSVersionString());
				PlatformID platformID = Platform;
				if (platformID == PlatformID.MacOSX)
				{
					platformID = PlatformID.Unix;
				}
				os = new OperatingSystem(platformID, version);
			}
			return os;
		}
	}

	public static string StackTrace => new StackTrace(0, fNeedFileInfo: true).ToString();

	public static string SystemDirectory => GetFolderPath(SpecialFolder.System);

	public static extern int TickCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static string UserDomainName => MachineName;

	[MonoTODO("Currently always returns false, regardless of interactive state")]
	public static bool UserInteractive => false;

	public static extern string UserName
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static Version Version => new Version("4.0.30319.17020");

	[MonoTODO("Currently always returns zero")]
	public static long WorkingSet => 0L;

	public static bool Is64BitOperatingSystem => GetIs64BitOperatingSystem();

	public static int SystemPageSize => GetPageSize();

	public static bool Is64BitProcess => IntPtr.Size == 8;

	public static extern int ProcessorCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	internal static bool IsRunningOnWindows => Platform < PlatformID.Unix;

	internal static bool IsUnix
	{
		get
		{
			int platform = (int)Platform;
			if (platform != 4 && platform != 128)
			{
				return platform == 6;
			}
			return true;
		}
	}

	internal static bool IsMacOS => Platform == PlatformID.MacOSX;

	internal static bool IsCLRHosted => false;

	internal static bool IsWinRTSupported => true;

	internal static string GetResourceString(string key)
	{
		return key;
	}

	internal static string GetResourceString(string key, CultureInfo culture)
	{
		return key;
	}

	internal static string GetResourceString(string key, params object[] values)
	{
		return string.Format(CultureInfo.InvariantCulture, key, values);
	}

	internal static string GetRuntimeResourceString(string key)
	{
		return key;
	}

	internal static string GetRuntimeResourceString(string key, params object[] values)
	{
		return string.Format(CultureInfo.InvariantCulture, key, values);
	}

	internal static string GetResourceStringEncodingName(int codePage)
	{
		return codePage switch
		{
			1200 => GetResourceString("Unicode"), 
			1201 => GetResourceString("Unicode (Big-Endian)"), 
			12000 => GetResourceString("Unicode (UTF-32)"), 
			12001 => GetResourceString("Unicode (UTF-32 Big-Endian)"), 
			20127 => GetResourceString("US-ASCII"), 
			65000 => GetResourceString("Unicode (UTF-7)"), 
			65001 => GetResourceString("Unicode (UTF-8)"), 
			_ => codePage.ToString(CultureInfo.InvariantCulture), 
		};
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string GetNewLine();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string GetOSVersionString();

	internal static Version CreateVersionFromString(string info)
	{
		int major = 0;
		int minor = 0;
		int build = 0;
		int revision = 0;
		int num = 1;
		int num2 = -1;
		if (info == null)
		{
			return new Version(0, 0, 0, 0);
		}
		foreach (char c in info)
		{
			if (char.IsDigit(c))
			{
				num2 = ((num2 >= 0) ? (num2 * 10 + (c - 48)) : (c - 48));
			}
			else if (num2 >= 0)
			{
				switch (num)
				{
				case 1:
					major = num2;
					break;
				case 2:
					minor = num2;
					break;
				case 3:
					build = num2;
					break;
				case 4:
					revision = num2;
					break;
				}
				num2 = -1;
				num++;
			}
			if (num == 5)
			{
				break;
			}
		}
		if (num2 >= 0)
		{
			switch (num)
			{
			case 1:
				major = num2;
				break;
			case 2:
				minor = num2;
				break;
			case 3:
				build = num2;
				break;
			case 4:
				revision = num2;
				break;
			}
		}
		return new Version(major, minor, build, revision);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void Exit(int exitCode);

	internal static void _Exit(int exitCode)
	{
		Exit(exitCode);
	}

	public static string ExpandEnvironmentVariables(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		int num = name.IndexOf('%');
		if (num == -1)
		{
			return name;
		}
		int length = name.Length;
		int num2 = 0;
		if (num == length - 1 || (num2 = name.IndexOf('%', num + 1)) == -1)
		{
			return name;
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(name, 0, num);
		Hashtable hashtable = null;
		do
		{
			string text = name.Substring(num + 1, num2 - num - 1);
			string text2 = GetEnvironmentVariable(text);
			if (text2 == null && IsRunningOnWindows)
			{
				if (hashtable == null)
				{
					hashtable = GetEnvironmentVariablesNoCase();
				}
				text2 = hashtable[text] as string;
			}
			int num3 = num2;
			if (text2 == null)
			{
				stringBuilder.Append('%');
				stringBuilder.Append(text);
				num2--;
			}
			else
			{
				stringBuilder.Append(text2);
			}
			int num4 = num2;
			num = name.IndexOf('%', num2 + 1);
			num2 = ((num == -1 || num2 > length - 1) ? (-1) : name.IndexOf('%', num + 1));
			int count = ((num == -1 || num2 == -1) ? (length - num4 - 1) : ((text2 == null) ? (num - num3) : (num - num4 - 1)));
			if (num >= num4 || num == -1)
			{
				stringBuilder.Append(name, num4 + 1, count);
			}
		}
		while (num2 > -1 && num2 < length);
		return stringBuilder.ToString();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern string[] GetCommandLineArgs();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string internalGetEnvironmentVariable_native(IntPtr variable);

	internal static string internalGetEnvironmentVariable(string variable)
	{
		if (variable == null)
		{
			return null;
		}
		using SafeStringMarshal safeStringMarshal = RuntimeMarshal.MarshalString(variable);
		return internalGetEnvironmentVariable_native(safeStringMarshal.Value);
	}

	public static string GetEnvironmentVariable(string variable)
	{
		return internalGetEnvironmentVariable(variable);
	}

	private static Hashtable GetEnvironmentVariablesNoCase()
	{
		Hashtable hashtable = new Hashtable(CaseInsensitiveHashCodeProvider.Default, CaseInsensitiveComparer.Default);
		string[] environmentVariableNames = GetEnvironmentVariableNames();
		foreach (string text in environmentVariableNames)
		{
			hashtable[text] = internalGetEnvironmentVariable(text);
		}
		return hashtable;
	}

	public static IDictionary GetEnvironmentVariables()
	{
		Hashtable hashtable = new Hashtable();
		string[] environmentVariableNames = GetEnvironmentVariableNames();
		foreach (string text in environmentVariableNames)
		{
			hashtable[text] = internalGetEnvironmentVariable(text);
		}
		return hashtable;
	}

	public static string GetFolderPath(SpecialFolder folder)
	{
		return GetFolderPath(folder, SpecialFolderOption.None);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string GetWindowsFolderPath(int folder);

	public static string GetFolderPath(SpecialFolder folder, SpecialFolderOption option)
	{
		SecurityManager.EnsureElevatedPermissions();
		string text = null;
		if (IsRunningOnWindows)
		{
			return GetWindowsFolderPath((int)folder);
		}
		return UnixGetFolderPath(folder, option);
	}

	private static string ReadXdgUserDir(string config_dir, string home_dir, string key, string fallback)
	{
		string text = internalGetEnvironmentVariable(key);
		if (text != null && text != string.Empty)
		{
			return text;
		}
		string path = Path.Combine(config_dir, "user-dirs.dirs");
		if (!File.Exists(path))
		{
			return Path.Combine(home_dir, fallback);
		}
		try
		{
			using StreamReader streamReader = new StreamReader(path);
			string text2;
			while ((text2 = streamReader.ReadLine()) != null)
			{
				text2 = text2.Trim();
				int num = text2.IndexOf('=');
				if (num > 8 && text2.Substring(0, num) == key)
				{
					string text3 = text2.Substring(num + 1).Trim('"');
					bool flag = false;
					if (text3.StartsWithOrdinalUnchecked("$HOME/"))
					{
						flag = true;
						text3 = text3.Substring(6);
					}
					else if (!text3.StartsWithOrdinalUnchecked("/"))
					{
						flag = true;
					}
					return flag ? Path.Combine(home_dir, text3) : text3;
				}
			}
		}
		catch
		{
		}
		return Path.Combine(home_dir, fallback);
	}

	internal static string UnixGetFolderPath(SpecialFolder folder, SpecialFolderOption option)
	{
		string text = internalGetHome();
		string text2 = internalGetEnvironmentVariable("XDG_DATA_HOME");
		if (text2 == null || text2 == string.Empty)
		{
			text2 = Path.Combine(text, ".local");
			text2 = Path.Combine(text2, "share");
		}
		string text3 = internalGetEnvironmentVariable("XDG_CONFIG_HOME");
		if (text3 == null || text3 == string.Empty)
		{
			text3 = Path.Combine(text, ".config");
		}
		switch (folder)
		{
		case SpecialFolder.MyComputer:
			return string.Empty;
		case SpecialFolder.MyDocuments:
			return text;
		case SpecialFolder.ApplicationData:
			return text3;
		case SpecialFolder.LocalApplicationData:
			return text2;
		case SpecialFolder.Desktop:
		case SpecialFolder.DesktopDirectory:
			return ReadXdgUserDir(text3, text, "XDG_DESKTOP_DIR", "Desktop");
		case SpecialFolder.MyMusic:
			if (Platform == PlatformID.MacOSX)
			{
				return Path.Combine(text, "Music");
			}
			return ReadXdgUserDir(text3, text, "XDG_MUSIC_DIR", "Music");
		case SpecialFolder.MyPictures:
			if (Platform == PlatformID.MacOSX)
			{
				return Path.Combine(text, "Pictures");
			}
			return ReadXdgUserDir(text3, text, "XDG_PICTURES_DIR", "Pictures");
		case SpecialFolder.Templates:
			return ReadXdgUserDir(text3, text, "XDG_TEMPLATES_DIR", "Templates");
		case SpecialFolder.MyVideos:
			return ReadXdgUserDir(text3, text, "XDG_VIDEOS_DIR", "Videos");
		case SpecialFolder.CommonTemplates:
			return "/usr/share/templates";
		case SpecialFolder.Fonts:
			if (Platform == PlatformID.MacOSX)
			{
				return Path.Combine(text, "Library", "Fonts");
			}
			return Path.Combine(text, ".fonts");
		case SpecialFolder.Favorites:
			if (Platform == PlatformID.MacOSX)
			{
				return Path.Combine(text, "Library", "Favorites");
			}
			return string.Empty;
		case SpecialFolder.ProgramFiles:
			if (Platform == PlatformID.MacOSX)
			{
				return "/Applications";
			}
			return string.Empty;
		case SpecialFolder.InternetCache:
			if (Platform == PlatformID.MacOSX)
			{
				return Path.Combine(text, "Library", "Caches");
			}
			return string.Empty;
		case SpecialFolder.UserProfile:
			return text;
		case SpecialFolder.Programs:
		case SpecialFolder.Startup:
		case SpecialFolder.Recent:
		case SpecialFolder.SendTo:
		case SpecialFolder.StartMenu:
		case SpecialFolder.NetworkShortcuts:
		case SpecialFolder.CommonStartMenu:
		case SpecialFolder.CommonPrograms:
		case SpecialFolder.CommonStartup:
		case SpecialFolder.CommonDesktopDirectory:
		case SpecialFolder.PrinterShortcuts:
		case SpecialFolder.Cookies:
		case SpecialFolder.History:
		case SpecialFolder.Windows:
		case SpecialFolder.System:
		case SpecialFolder.SystemX86:
		case SpecialFolder.ProgramFilesX86:
		case SpecialFolder.CommonProgramFiles:
		case SpecialFolder.CommonProgramFilesX86:
		case SpecialFolder.CommonDocuments:
		case SpecialFolder.CommonAdminTools:
		case SpecialFolder.AdminTools:
		case SpecialFolder.CommonMusic:
		case SpecialFolder.CommonPictures:
		case SpecialFolder.CommonVideos:
		case SpecialFolder.Resources:
		case SpecialFolder.LocalizedResources:
		case SpecialFolder.CommonOemLinks:
		case SpecialFolder.CDBurning:
			return string.Empty;
		case SpecialFolder.CommonApplicationData:
			return "/usr/share";
		default:
			throw new ArgumentException("Invalid SpecialFolder");
		}
	}

	public static string[] GetLogicalDrives()
	{
		return GetLogicalDrivesInternal();
	}

	public static string GetEnvironmentVariable(string variable, EnvironmentVariableTarget target)
	{
		if (target == EnvironmentVariableTarget.Process)
		{
			return GetEnvironmentVariable(variable);
		}
		return null;
	}

	public static IDictionary GetEnvironmentVariables(EnvironmentVariableTarget target)
	{
		if (target == EnvironmentVariableTarget.Process)
		{
			return GetEnvironmentVariables();
		}
		return new Hashtable();
	}

	public static void SetEnvironmentVariable(string variable, string value)
	{
		if (variable == null)
		{
			throw new ArgumentNullException("variable");
		}
		if (variable == string.Empty)
		{
			throw new ArgumentException("String cannot be of zero length.", "variable");
		}
		if (variable.IndexOf('=') != -1)
		{
			throw new ArgumentException("Environment variable name cannot contain an equal character.", "variable");
		}
		if (variable[0] == '\0')
		{
			throw new ArgumentException("The first char in the string is the null character.", "variable");
		}
		InternalSetEnvironmentVariable(variable, value);
	}

	public static void SetEnvironmentVariable(string variable, string value, EnvironmentVariableTarget target)
	{
		if (target == EnvironmentVariableTarget.Process)
		{
			SetEnvironmentVariable(variable, value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern void InternalSetEnvironmentVariable(char* variable, int variable_length, char* value, int value_length);

	internal unsafe static void InternalSetEnvironmentVariable(string variable, string value)
	{
		fixed (char* variable2 = variable)
		{
			fixed (char* value2 = value)
			{
				InternalSetEnvironmentVariable(variable2, variable?.Length ?? 0, value2, value?.Length ?? 0);
			}
		}
	}

	public static void FailFast(string message)
	{
		FailFast(message, null, null);
	}

	internal static void FailFast(string message, uint exitCode)
	{
		FailFast(message, null, null);
	}

	public static void FailFast(string message, Exception exception)
	{
		FailFast(message, exception, null);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void FailFast(string message, Exception exception, string errorSource);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetIs64BitOperatingSystem();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string[] GetLogicalDrivesInternal();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string[] GetEnvironmentVariableNames();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string GetMachineConfigPath();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string internalGetHome();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int GetPageSize();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string get_bundled_machine_config();

	internal static string GetBundledMachineConfig()
	{
		return get_bundled_machine_config();
	}

	internal static void TriggerCodeContractFailure(ContractFailureKind failureKind, string message, string condition, string exceptionAsString)
	{
	}

	internal static string GetStackTrace(Exception e, bool needFileInfo)
	{
		StackTrace stackTrace = ((e != null) ? new StackTrace(e, needFileInfo) : new StackTrace(needFileInfo));
		return stackTrace.ToString(System.Diagnostics.StackTrace.TraceFormat.Normal);
	}
}
