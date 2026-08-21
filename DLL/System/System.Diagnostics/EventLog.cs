using System.ComponentModel;
using Unity;

namespace System.Diagnostics;

[DefaultEvent("EntryWritten")]
[InstallerType("System.Diagnostics.EventLogInstaller, System.Configuration.Install, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")]
[MonitoringDescription("EventLogDesc")]
public class EventLog : Component, ISupportInitialize
{
	public long MaximumKilobytes
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return default(long);
		}
		set
		{
			Unity.ThrowStub.ThrowNotSupportedException();
		}
	}

	public EventLog(string logName, string machineName, string source)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public static void CreateEventSource(EventSourceCreationData sourceData)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public static void DeleteEventSource(string source, string machineName)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public void EndInit()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	public static string LogNameFromSourceName(string source, string machineName)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
		return null;
	}

	public static bool SourceExists(string source, string machineName)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
		return default(bool);
	}

	public void WriteEntry(string message, EventLogEntryType type, int eventID, short category)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
