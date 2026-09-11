using System.Threading;

public class VideoSyncEvents
{
	private WaitHandle[] m_eventArray;

	private EventWaitHandle m_newCmdsEvent;

	private EventWaitHandle m_exitThreadEvent;

	public WaitHandle[] EventArray => m_eventArray;

	public EventWaitHandle NewCmdsEvent => m_newCmdsEvent;

	public EventWaitHandle ExitThreadEvent => m_exitThreadEvent;

	public VideoSyncEvents()
	{
		m_newCmdsEvent = new AutoResetEvent(initialState: false);
		m_exitThreadEvent = new ManualResetEvent(initialState: false);
		m_eventArray = new WaitHandle[2];
		m_eventArray[0] = m_newCmdsEvent;
		m_eventArray[1] = m_exitThreadEvent;
	}
}
