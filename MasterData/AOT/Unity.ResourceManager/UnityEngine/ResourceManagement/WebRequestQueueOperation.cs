using System;
using UnityEngine.Networking;

namespace UnityEngine.ResourceManagement;

public class WebRequestQueueOperation
{
	private bool m_Completed;

	public UnityWebRequestAsyncOperation Result;

	public Action<UnityWebRequestAsyncOperation> OnComplete;

	internal UnityWebRequest m_WebRequest;

	public bool IsDone
	{
		get
		{
			if (!m_Completed)
			{
				return Result != null;
			}
			return true;
		}
	}

	public UnityWebRequest WebRequest
	{
		get
		{
			return m_WebRequest;
		}
		internal set
		{
			m_WebRequest = value;
		}
	}

	public WebRequestQueueOperation(UnityWebRequest request)
	{
		m_WebRequest = request;
	}

	internal void Complete(UnityWebRequestAsyncOperation asyncOp)
	{
		m_Completed = true;
		Result = asyncOp;
		OnComplete?.Invoke(Result);
	}
}
