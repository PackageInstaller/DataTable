using System;

namespace Ase;

public class EndSpineEventHandler : IStringArgHandler, IArgHandler
{
	private Action<int> onEndInvoke;

	public string EventName => "end";

	public EndSpineEventHandler(Action<int> onEndInvoke)
	{
		this.onEndInvoke = onEndInvoke;
	}

	public bool Handle(string eventName, string arg, int trackIndex)
	{
		if (eventName == null || eventName != EventName)
		{
			return false;
		}
		try
		{
			onEndInvoke(trackIndex);
			return true;
		}
		catch
		{
			return false;
		}
	}
}
