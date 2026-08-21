using System.Runtime.InteropServices;

namespace GameFramework;

[StructLayout(LayoutKind.Auto)]
public struct TaskInfo(int serialId, string tag, int priority, object userData, TaskStatus status, string description)
{
	private readonly bool m_IsValid = true;

	private readonly int m_SerialId = serialId;

	private readonly string m_Tag = tag;

	private readonly int m_Priority = priority;

	private readonly object m_UserData = userData;

	private readonly TaskStatus m_Status = status;

	private readonly string m_Description = description;

	public bool IsValid => m_IsValid;

	public int SerialId
	{
		get
		{
			if (!m_IsValid)
			{
				throw new GameFrameworkException("Data is invalid.");
			}
			return m_SerialId;
		}
	}

	public string Tag
	{
		get
		{
			if (!m_IsValid)
			{
				throw new GameFrameworkException("Data is invalid.");
			}
			return m_Tag;
		}
	}

	public int Priority
	{
		get
		{
			if (!m_IsValid)
			{
				throw new GameFrameworkException("Data is invalid.");
			}
			return m_Priority;
		}
	}

	public object UserData
	{
		get
		{
			if (!m_IsValid)
			{
				throw new GameFrameworkException("Data is invalid.");
			}
			return m_UserData;
		}
	}

	public TaskStatus Status
	{
		get
		{
			if (!m_IsValid)
			{
				throw new GameFrameworkException("Data is invalid.");
			}
			return m_Status;
		}
	}

	public string Description
	{
		get
		{
			if (!m_IsValid)
			{
				throw new GameFrameworkException("Data is invalid.");
			}
			return m_Description;
		}
	}
}
