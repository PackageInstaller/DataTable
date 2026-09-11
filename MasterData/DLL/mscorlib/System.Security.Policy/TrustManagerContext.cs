using System.Runtime.InteropServices;

namespace System.Security.Policy;

[ComVisible(true)]
public class TrustManagerContext
{
	private bool _ignorePersistedDecision;

	private bool _noPrompt;

	private bool _keepAlive;

	private bool _persist;

	private TrustManagerUIContext _ui;

	public TrustManagerContext()
		: this(TrustManagerUIContext.Run)
	{
	}

	public TrustManagerContext(TrustManagerUIContext uiContext)
	{
		_ignorePersistedDecision = false;
		_noPrompt = false;
		_keepAlive = false;
		_persist = false;
		_ui = uiContext;
	}
}
