using System.Runtime.CompilerServices;

namespace System.IO;

public struct WaitForChangedResult
{
	internal static readonly WaitForChangedResult TimedOutResult = new WaitForChangedResult((WatcherChangeTypes)0, null, null, timedOut: true);

	[CompilerGenerated]
	private WatcherChangeTypes _003CChangeType_003Ek__BackingField;

	[CompilerGenerated]
	private string _003CName_003Ek__BackingField;

	[CompilerGenerated]
	private string _003COldName_003Ek__BackingField;

	[CompilerGenerated]
	private bool _003CTimedOut_003Ek__BackingField;

	public WatcherChangeTypes ChangeType
	{
		[CompilerGenerated]
		set
		{
			_003CChangeType_003Ek__BackingField = value;
		}
	}

	public string Name
	{
		[CompilerGenerated]
		set
		{
			_003CName_003Ek__BackingField = value;
		}
	}

	public string OldName
	{
		[CompilerGenerated]
		set
		{
			_003COldName_003Ek__BackingField = value;
		}
	}

	public bool TimedOut
	{
		[CompilerGenerated]
		set
		{
			_003CTimedOut_003Ek__BackingField = value;
		}
	}

	internal WaitForChangedResult(WatcherChangeTypes changeType, string name, string oldName, bool timedOut)
	{
		ChangeType = changeType;
		Name = name;
		OldName = oldName;
		TimedOut = timedOut;
	}
}
