using System;

namespace Ase;

public class InteractiveStateChecker
{
	private int interactiveEntityId;

	private float interactiveTime;

	private int interactiveStateId;

	private string icon;

	private string interName;

	private Action<int> interactiveStartCallback;

	private Action<int> interactiveFinishCallback;

	public Action<int> interactiveCloseCallback;

	public bool isRelease;

	public InteractiveStateChecker(int interactiveEntityId, float interactiveTime, int interactiveStateId, string iconType, string interName, Action<int> interactiveStartCallback, Action<int> interactiveFinishCallback, Action<int> interactiveCloseCallback)
	{
		this.interactiveEntityId = interactiveEntityId;
		this.interactiveTime = interactiveTime;
		this.interactiveStateId = interactiveStateId;
		this.interactiveStartCallback = interactiveStartCallback;
		this.interactiveFinishCallback = interactiveFinishCallback;
		this.interactiveCloseCallback = interactiveCloseCallback;
		isRelease = false;
		icon = iconType;
		this.interName = interName;
	}

	public int GetInteractiveEntityId()
	{
		return interactiveEntityId;
	}

	public int GetInteractiveState()
	{
		return interactiveStateId;
	}

	public bool IsSame(InteractiveStateChecker otherInteractive)
	{
		return otherInteractive == this;
	}

	public float GetInteractiveTime()
	{
		return interactiveTime;
	}

	public void InteractiveStartCallback(int heroEntityId)
	{
		if (interactiveStartCallback != null)
		{
			interactiveStartCallback(heroEntityId);
		}
	}

	public void InteractiveFinishCallback(int heroEntityId)
	{
		if (interactiveFinishCallback != null)
		{
			interactiveFinishCallback(heroEntityId);
		}
	}

	public void InteractiveCloseCallback(int heroEntityId)
	{
		if (interactiveCloseCallback != null)
		{
			interactiveCloseCallback(heroEntityId);
		}
	}

	public string GetIcon()
	{
		return icon;
	}

	public string GetName()
	{
		return interName;
	}

	public void Release()
	{
		isRelease = true;
	}
}
