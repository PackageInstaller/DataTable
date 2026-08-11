using System;
using GameFramework.WebRequest;
using UnityEngine;

namespace GameFramework.Runtime;

public abstract class WebRequestAgentHelperBase : MonoBehaviour, IWebRequestAgentHelper
{
	public abstract event EventHandler<WebRequestAgentHelperCompleteEventArgs> WebRequestAgentHelperComplete;

	public abstract event EventHandler<WebRequestAgentHelperErrorEventArgs> WebRequestAgentHelperError;

	public abstract void Request(string webRequestUri, object userData);

	public abstract void Request(string webRequestUri, byte[] postData, object userData);

	public abstract void Request(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue);

	public abstract void Reset();
}
