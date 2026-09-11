namespace System.ComponentModel;

[DefaultEvent("DoWork")]
public class BackgroundWorker : Component
{
	private bool _cancellationPending;

	public bool CancellationPending => _cancellationPending;
}
