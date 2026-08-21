namespace System.Threading.Tasks;

public class UnobservedTaskExceptionEventArgs : EventArgs
{
	private AggregateException m_exception;

	internal bool m_observed;

	public UnobservedTaskExceptionEventArgs(AggregateException exception)
	{
		m_exception = exception;
	}
}
