using Unity;

namespace System.Diagnostics;

public class EventSourceCreationData
{
	public string MachineName
	{
		set
		{
			Unity.ThrowStub.ThrowNotSupportedException();
		}
	}

	public EventSourceCreationData(string source, string logName)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
