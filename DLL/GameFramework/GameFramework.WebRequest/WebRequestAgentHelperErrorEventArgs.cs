namespace GameFramework.WebRequest;

public sealed class WebRequestAgentHelperErrorEventArgs : GameFrameworkEventArgs
{
	public string ErrorMessage { get; private set; }

	public WebRequestAgentHelperErrorEventArgs()
	{
		ErrorMessage = null;
	}

	public static WebRequestAgentHelperErrorEventArgs Create(string errorMessage)
	{
		WebRequestAgentHelperErrorEventArgs e = ReferencePool.Acquire<WebRequestAgentHelperErrorEventArgs>();
		e.ErrorMessage = errorMessage;
		return e;
	}

	public override void Clear()
	{
		ErrorMessage = null;
	}
}
