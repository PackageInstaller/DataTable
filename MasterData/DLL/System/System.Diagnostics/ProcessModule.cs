using System.ComponentModel;
using Unity;

namespace System.Diagnostics;

public class ProcessModule : Component
{
	private IntPtr baseaddr;

	private IntPtr entryaddr;

	private string filename;

	private FileVersionInfo version_info;

	private int memory_size;

	private string modulename;

	[MonitoringDescription("The file name of this module")]
	public string FileName => filename;

	[MonitoringDescription("The name of this module")]
	public string ModuleName => modulename;

	public override string ToString()
	{
		return ModuleName;
	}

	internal ProcessModule()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
