namespace YS.CustomTimelineTrack;

public class QTEContext
{
	public QTEConditionType type;

	public int clickCount;

	public EQTEStatus status;

	private static QTEContext m_instance;

	public static QTEContext GetInstance()
	{
		if (m_instance == null)
		{
			m_instance = new QTEContext();
		}
		return m_instance;
	}

	public void Reset()
	{
		clickCount = 0;
		status = EQTEStatus.None;
	}
}
