using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Runtime.InteropServices;
using System.Security;
using System.Text;

namespace System.Diagnostics;

[StructLayout(LayoutKind.Sequential)]
[TypeConverter(typeof(ExpandableObjectConverter))]
public sealed class ProcessStartInfo
{
	private string fileName;

	private string arguments;

	private string directory;

	private string verb;

	private ProcessWindowStyle windowStyle;

	private bool errorDialog;

	private IntPtr errorDialogParentHandle;

	private bool useShellExecute = true;

	private string userName;

	private string domain;

	private SecureString password;

	private string passwordInClearText;

	private bool loadUserProfile;

	private bool redirectStandardInput;

	private bool redirectStandardOutput;

	private bool redirectStandardError;

	private Encoding standardOutputEncoding;

	private Encoding standardErrorEncoding;

	private bool createNoWindow;

	private WeakReference weakParentProcess;

	internal StringDictionary environmentVariables;

	private static readonly string[] empty = new string[0];

	private Collection<string> _argumentList;

	private IDictionary<string, string> environment;

	public Collection<string> ArgumentList
	{
		get
		{
			if (_argumentList == null)
			{
				_argumentList = new Collection<string>();
			}
			return _argumentList;
		}
	}

	[TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	[SettingsBindable(true)]
	[DefaultValue("")]
	[MonitoringDescription("Command line arguments that will be passed to the application specified by the FileName property.")]
	[NotifyParentProperty(true)]
	public string Arguments
	{
		get
		{
			if (arguments == null)
			{
				return string.Empty;
			}
			return arguments;
		}
		set
		{
			arguments = value;
		}
	}

	[DesignerSerializationVisibility(DesignerSerializationVisibility.Content)]
	[NotifyParentProperty(true)]
	[DefaultValue(null)]
	[MonitoringDescription("Set of environment variables that apply to this process and child processes.")]
	[Editor("System.Diagnostics.Design.StringDictionaryEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	public StringDictionary EnvironmentVariables
	{
		get
		{
			if (environmentVariables == null)
			{
				environmentVariables = new CaseSensitiveStringDictionary();
				if (weakParentProcess == null || !weakParentProcess.IsAlive || ((Component)weakParentProcess.Target).Site == null || !((Component)weakParentProcess.Target).Site.DesignMode)
				{
					foreach (DictionaryEntry environmentVariable in Environment.GetEnvironmentVariables())
					{
						environmentVariables.Add((string)environmentVariable.Key, (string)environmentVariable.Value);
					}
				}
			}
			return environmentVariables;
		}
	}

	[NotifyParentProperty(true)]
	[MonitoringDescription("Whether the process command input is read from the Process instance's StandardInput member.")]
	[DefaultValue(false)]
	public bool RedirectStandardInput => redirectStandardInput;

	[MonitoringDescription("Whether the process output is written to the Process instance's StandardOutput member.")]
	[DefaultValue(false)]
	[NotifyParentProperty(true)]
	public bool RedirectStandardOutput => redirectStandardOutput;

	[NotifyParentProperty(true)]
	[DefaultValue(false)]
	[MonitoringDescription("Whether the process's error output is written to the Process instance's StandardError member.")]
	public bool RedirectStandardError => redirectStandardError;

	public Encoding StandardErrorEncoding => standardErrorEncoding;

	public Encoding StandardOutputEncoding => standardOutputEncoding;

	[NotifyParentProperty(true)]
	[MonitoringDescription("Whether to use the operating system shell to start the process.")]
	[DefaultValue(true)]
	public bool UseShellExecute
	{
		get
		{
			return useShellExecute;
		}
		set
		{
			useShellExecute = value;
		}
	}

	[NotifyParentProperty(true)]
	public string UserName
	{
		get
		{
			if (userName == null)
			{
				return string.Empty;
			}
			return userName;
		}
		set
		{
			userName = value;
		}
	}

	public SecureString Password
	{
		get
		{
			return password;
		}
		set
		{
			password = value;
		}
	}

	[NotifyParentProperty(true)]
	public string Domain
	{
		get
		{
			if (domain == null)
			{
				return string.Empty;
			}
			return domain;
		}
		set
		{
			domain = value;
		}
	}

	[NotifyParentProperty(true)]
	public bool LoadUserProfile => loadUserProfile;

	[DefaultValue("")]
	[Editor("System.Diagnostics.Design.StartFileNameEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	[NotifyParentProperty(true)]
	[TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	[SettingsBindable(true)]
	[MonitoringDescription("The name of the application, document or URL to start.")]
	public string FileName
	{
		get
		{
			if (fileName == null)
			{
				return string.Empty;
			}
			return fileName;
		}
	}

	[MonitoringDescription("The initial working directory for the process.")]
	[NotifyParentProperty(true)]
	[TypeConverter("System.Diagnostics.Design.StringValueConverter, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	[DefaultValue("")]
	[SettingsBindable(true)]
	[Editor("System.Diagnostics.Design.WorkingDirectoryEditor, System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a", "System.Drawing.Design.UITypeEditor, System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
	public string WorkingDirectory
	{
		get
		{
			if (directory == null)
			{
				return string.Empty;
			}
			return directory;
		}
	}

	internal bool HaveEnvVars => environmentVariables != null;

	public Encoding StandardInputEncoding { get; }

	internal ProcessStartInfo(Process parent)
	{
		weakParentProcess = new WeakReference(parent);
	}

	public ProcessStartInfo(string fileName)
	{
		this.fileName = fileName;
	}

	public ProcessStartInfo(string fileName, string arguments)
	{
		this.fileName = fileName;
		this.arguments = arguments;
	}
}
