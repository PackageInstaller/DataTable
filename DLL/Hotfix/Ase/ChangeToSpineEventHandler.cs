using System;

namespace Ase;

public class ChangeToSpineEventHandler : IStringArgHandler, IArgHandler
{
	private Action<string, int> onChangeToInvoke;

	private Action onActionFinish;

	public string EventName => "changeto";

	public ChangeToSpineEventHandler(Action<string, int> onChangeToInvoke, Action onActionFinish = null)
	{
		this.onChangeToInvoke = onChangeToInvoke;
		this.onActionFinish = onActionFinish;
	}

	public bool Handle(string eventName, string arg, int trackIndex)
	{
		if (eventName == null || eventName.Substring(0, EventName.Length) != EventName)
		{
			return false;
		}
		try
		{
			string arg2 = eventName.Substring(EventName.Length + 1);
			if (onChangeToInvoke != null)
			{
				onChangeToInvoke(arg2, trackIndex);
				onActionFinish?.Invoke();
			}
			return true;
		}
		catch
		{
			return false;
		}
	}
}
