using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace GameFramework.WebRequest;

internal sealed class WebRequestManager : GameFrameworkModule, IWebRequestManager
{
	private sealed class WebRequestAgent : ITaskAgent<WebRequestTask>
	{
		private readonly IWebRequestAgentHelper m_Helper;

		private WebRequestTask m_Task;

		private float m_WaitTime;

		public GameFrameworkAction<WebRequestAgent> WebRequestAgentStart;

		public GameFrameworkAction<WebRequestAgent, byte[]> WebRequestAgentSuccess;

		public GameFrameworkAction<WebRequestAgent, string> WebRequestAgentFailure;

		public WebRequestTask Task => m_Task;

		public float WaitTime => m_WaitTime;

		public WebRequestAgent(IWebRequestAgentHelper webRequestAgentHelper)
		{
			if (webRequestAgentHelper == null)
			{
				throw new GameFrameworkException("Web request agent helper is invalid.");
			}
			m_Helper = webRequestAgentHelper;
			m_Task = null;
			m_WaitTime = 0f;
			WebRequestAgentStart = null;
			WebRequestAgentSuccess = null;
			WebRequestAgentFailure = null;
		}

		public void Initialize()
		{
			m_Helper.WebRequestAgentHelperComplete += OnWebRequestAgentHelperComplete;
			m_Helper.WebRequestAgentHelperError += OnWebRequestAgentHelperError;
		}

		public void Update(float elapseSeconds, float realElapseSeconds)
		{
			if (m_Task.Status == WebRequestTaskStatus.Doing)
			{
				m_WaitTime += realElapseSeconds;
				if (m_WaitTime >= m_Task.Timeout)
				{
					WebRequestAgentHelperErrorEventArgs e = WebRequestAgentHelperErrorEventArgs.Create("Timeout");
					OnWebRequestAgentHelperError(this, e);
					ReferencePool.Release(e);
				}
			}
		}

		public void Shutdown()
		{
			Reset();
			m_Helper.WebRequestAgentHelperComplete -= OnWebRequestAgentHelperComplete;
			m_Helper.WebRequestAgentHelperError -= OnWebRequestAgentHelperError;
		}

		public StartTaskStatus Start(WebRequestTask task)
		{
			if (task == null)
			{
				throw new GameFrameworkException("Task is invalid.");
			}
			m_Task = task;
			m_Task.Status = WebRequestTaskStatus.Doing;
			if (WebRequestAgentStart != null)
			{
				WebRequestAgentStart(this);
			}
			byte[] postData = m_Task.GetPostData();
			bool bodyDataSet = m_Task.GetBodyDataSet();
			if (postData == null)
			{
				m_Helper.Request(m_Task.WebRequestUri, m_Task.UserData);
			}
			else if (bodyDataSet)
			{
				m_Helper.Request(m_Task.WebRequestUri, postData, bodyDataSet, m_Task.GetHeaderName(), m_Task.GetHeaderValue());
			}
			else
			{
				m_Helper.Request(m_Task.WebRequestUri, postData, m_Task.UserData);
			}
			m_WaitTime = 0f;
			return StartTaskStatus.CanResume;
		}

		public void Reset()
		{
			m_Helper.Reset();
			m_Task = null;
			m_WaitTime = 0f;
		}

		private void OnWebRequestAgentHelperComplete(object sender, WebRequestAgentHelperCompleteEventArgs e)
		{
			m_Helper.Reset();
			m_Task.Status = WebRequestTaskStatus.Done;
			if (WebRequestAgentSuccess != null)
			{
				WebRequestAgentSuccess(this, e.GetWebResponseBytes());
			}
			m_Task.Done = true;
		}

		private void OnWebRequestAgentHelperError(object sender, WebRequestAgentHelperErrorEventArgs e)
		{
			m_Helper.Reset();
			m_Task.Status = WebRequestTaskStatus.Error;
			if (WebRequestAgentFailure != null)
			{
				WebRequestAgentFailure(this, e.ErrorMessage);
			}
			m_Task.Done = true;
		}
	}

	private sealed class WebRequestTask : TaskBase
	{
		private static int s_Serial;

		private WebRequestTaskStatus m_Status;

		private string m_WebRequestUri;

		private byte[] m_PostData;

		private float m_Timeout;

		private bool m_BodyDataSet;

		private string m_HeaderName;

		private string m_HeaderValue;

		public WebRequestTaskStatus Status
		{
			get
			{
				return m_Status;
			}
			set
			{
				m_Status = value;
			}
		}

		public string WebRequestUri => m_WebRequestUri;

		public float Timeout => m_Timeout;

		public override string Description => m_WebRequestUri;

		public WebRequestTask()
		{
			m_Status = WebRequestTaskStatus.Todo;
			m_WebRequestUri = null;
			m_PostData = null;
			m_Timeout = 0f;
		}

		public static WebRequestTask Create(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue, string tag, int priority, float timeout, object userData)
		{
			WebRequestTask webRequestTask = ReferencePool.Acquire<WebRequestTask>();
			webRequestTask.Initialize(++s_Serial, tag, priority, userData);
			webRequestTask.m_WebRequestUri = webRequestUri;
			webRequestTask.m_PostData = postData;
			webRequestTask.m_Timeout = timeout;
			webRequestTask.m_BodyDataSet = bodyDataSet;
			webRequestTask.m_HeaderName = headerName;
			webRequestTask.m_HeaderValue = headerValue;
			return webRequestTask;
		}

		public override void Clear()
		{
			base.Clear();
			m_Status = WebRequestTaskStatus.Todo;
			m_WebRequestUri = null;
			m_PostData = null;
			m_Timeout = 0f;
		}

		public byte[] GetPostData()
		{
			return m_PostData;
		}

		public bool GetBodyDataSet()
		{
			return m_BodyDataSet;
		}

		public string GetHeaderName()
		{
			return m_HeaderName;
		}

		public string GetHeaderValue()
		{
			return m_HeaderValue;
		}
	}

	private enum WebRequestTaskStatus : byte
	{
		Todo,
		Doing,
		Done,
		Error
	}

	private readonly TaskPool<WebRequestTask> m_TaskPool;

	private float m_Timeout;

	private readonly ConcurrentDictionary<int, WebRequestTaskCompletionSource> promises = new ConcurrentDictionary<int, WebRequestTaskCompletionSource>();

	public int TotalAgentCount => m_TaskPool.TotalAgentCount;

	public int FreeAgentCount => m_TaskPool.FreeAgentCount;

	public int WorkingAgentCount => m_TaskPool.WorkingAgentCount;

	public int WaitingTaskCount => m_TaskPool.WaitingTaskCount;

	public float Timeout
	{
		get
		{
			return m_Timeout;
		}
		set
		{
			m_Timeout = value;
		}
	}

	public WebRequestManager()
	{
		m_TaskPool = new TaskPool<WebRequestTask>();
		m_Timeout = 30f;
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
		m_TaskPool.Update(elapseSeconds, realElapseSeconds);
	}

	internal override void Shutdown()
	{
		m_TaskPool.Shutdown();
	}

	public void AddWebRequestAgentHelper(IWebRequestAgentHelper webRequestAgentHelper)
	{
		WebRequestAgent webRequestAgent = new WebRequestAgent(webRequestAgentHelper);
		webRequestAgent.WebRequestAgentStart = (GameFrameworkAction<WebRequestAgent>)Delegate.Combine(webRequestAgent.WebRequestAgentStart, new GameFrameworkAction<WebRequestAgent>(OnWebRequestAgentStart));
		webRequestAgent.WebRequestAgentSuccess = (GameFrameworkAction<WebRequestAgent, byte[]>)Delegate.Combine(webRequestAgent.WebRequestAgentSuccess, new GameFrameworkAction<WebRequestAgent, byte[]>(OnWebRequestAgentSuccess));
		webRequestAgent.WebRequestAgentFailure = (GameFrameworkAction<WebRequestAgent, string>)Delegate.Combine(webRequestAgent.WebRequestAgentFailure, new GameFrameworkAction<WebRequestAgent, string>(OnWebRequestAgentFailure));
		m_TaskPool.AddAgent(webRequestAgent);
	}

	public TaskInfo GetWebRequestInfo(int serialId)
	{
		return m_TaskPool.GetTaskInfo(serialId);
	}

	public TaskInfo[] GetWebRequestInfos(string tag)
	{
		return m_TaskPool.GetTaskInfos(tag);
	}

	public void GetAllWebRequestInfos(string tag, List<TaskInfo> results)
	{
		m_TaskPool.GetTaskInfos(tag, results);
	}

	public TaskInfo[] GetAllWebRequestInfos()
	{
		return m_TaskPool.GetAllTaskInfos();
	}

	public void GetAllWebRequestInfos(List<TaskInfo> results)
	{
		m_TaskPool.GetAllTaskInfos(results);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, null, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, null, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, tag, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, int priority)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, null, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, object userData)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, null, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet, headerName, headerValue, null, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, tag, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, int priority)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, null, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, object userData)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, null, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, int priority)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, tag, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, object userData)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, tag, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, null, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, int priority)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, tag, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, object userData)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, tag, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, null, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, null, bodyDataSet: false, null, null, tag, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue, string tag, int priority, object userData)
	{
		if (string.IsNullOrEmpty(webRequestUri))
		{
			throw new GameFrameworkException("Web request uri is invalid.");
		}
		if (TotalAgentCount <= 0)
		{
			throw new GameFrameworkException("You must add web request agent first.");
		}
		WebRequestTask webRequestTask = WebRequestTask.Create(webRequestUri, postData, bodyDataSet, headerName, headerValue, tag, priority, m_Timeout, userData);
		m_TaskPool.AddTask(webRequestTask);
		WebRequestTaskCompletionSource webRequestTaskCompletionSource = WebRequestTaskCompletionSource.Create(webRequestUri, postData);
		promises.TryAdd(webRequestTask.SerialId, webRequestTaskCompletionSource);
		return webRequestTaskCompletionSource.Task;
	}

	public bool RemoveWebRequest(int serialId)
	{
		return m_TaskPool.RemoveTask(serialId);
	}

	public int RemoveWebRequests(string tag)
	{
		return m_TaskPool.RemoveTasks(tag);
	}

	public int RemoveAllWebRequests()
	{
		return m_TaskPool.RemoveAllTasks();
	}

	private void OnWebRequestAgentStart(WebRequestAgent sender)
	{
	}

	private void OnWebRequestAgentSuccess(WebRequestAgent sender, byte[] webResponseBytes)
	{
		if (promises.TryRemove(sender.Task.SerialId, out WebRequestTaskCompletionSource value))
		{
			value?.TrySetResult(WebRequestResponse.Create(webResponseBytes));
		}
	}

	private void OnWebRequestAgentFailure(WebRequestAgent sender, string errorMessage)
	{
		if (promises.TryRemove(sender.Task.SerialId, out WebRequestTaskCompletionSource value))
		{
			value?.TrySetResult(WebRequestResponse.Create(errorMessage));
		}
	}
}
