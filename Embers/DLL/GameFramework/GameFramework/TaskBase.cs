namespace GameFramework;

internal abstract class TaskBase : IReference
{
	public const int DefaultPriority = 0;

	private int m_SerialId;

	private string m_Tag;

	private int m_Priority;

	private object m_UserData;

	private bool m_Done;

	public int SerialId => m_SerialId;

	public string Tag => m_Tag;

	public int Priority => m_Priority;

	public object UserData => m_UserData;

	public bool Done
	{
		get
		{
			return m_Done;
		}
		set
		{
			m_Done = value;
		}
	}

	public virtual string Description => null;

	public TaskBase()
	{
		m_SerialId = 0;
		m_Tag = null;
		m_Priority = 0;
		m_Done = false;
		m_UserData = null;
	}

	internal void Initialize(int serialId, string tag, int priority, object userData)
	{
		m_SerialId = serialId;
		m_Tag = tag;
		m_Priority = priority;
		m_UserData = userData;
		m_Done = false;
	}

	public virtual void Clear()
	{
		m_SerialId = 0;
		m_Tag = null;
		m_Priority = 0;
		m_UserData = null;
		m_Done = false;
	}
}
