using System;

namespace GameFramework.WebRequest;

public interface IWebRequestAgentHelper
{
	event EventHandler<WebRequestAgentHelperCompleteEventArgs> WebRequestAgentHelperComplete;

	event EventHandler<WebRequestAgentHelperErrorEventArgs> WebRequestAgentHelperError;

	void Request(string webRequestUri, object userData);

	void Request(string webRequestUri, byte[] postData, object userData);

	void Request(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue);

	void Reset();
}
