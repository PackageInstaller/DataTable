#define ENABLE_FATAL_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.WebRequest;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/Web Request")]
public sealed class WebRequestComponent : GameFrameworkComponent
{
	private const int DefaultPriority = 0;

	private IWebRequestManager m_WebRequestManager = null;

	[SerializeField]
	private Transform m_InstanceRoot = null;

	[SerializeField]
	private string m_WebRequestAgentHelperTypeName = "GameFramework.Runtime.UnityWebRequestAgentHelper";

	[SerializeField]
	private WebRequestAgentHelperBase m_CustomWebRequestAgentHelper = null;

	[SerializeField]
	private int m_WebRequestAgentHelperCount = 1;

	[SerializeField]
	private float m_Timeout = 30f;

	public int TotalAgentCount => m_WebRequestManager.TotalAgentCount;

	public int FreeAgentCount => m_WebRequestManager.FreeAgentCount;

	public int WorkingAgentCount => m_WebRequestManager.WorkingAgentCount;

	public int WaitingTaskCount => m_WebRequestManager.WaitingTaskCount;

	public float Timeout
	{
		get
		{
			return m_WebRequestManager.Timeout;
		}
		set
		{
			m_WebRequestManager.Timeout = (m_Timeout = value);
		}
	}

	protected override void Awake()
	{
		base.Awake();
		m_WebRequestManager = GameFrameworkEntry.GetModule<IWebRequestManager>();
		if (m_WebRequestManager == null)
		{
			Log.Fatal("Web request manager is invalid.");
			return;
		}
		m_WebRequestManager.Timeout = m_Timeout;
		if (m_InstanceRoot == null)
		{
			m_InstanceRoot = new GameObject("Web Request Agent Instances").transform;
			m_InstanceRoot.SetParent(base.gameObject.transform);
			m_InstanceRoot.localScale = Vector3.one;
		}
		for (int i = 0; i < m_WebRequestAgentHelperCount; i++)
		{
			AddWebRequestAgentHelper(i);
		}
	}

	public TaskInfo GetWebRequestInfo(int serialId)
	{
		return m_WebRequestManager.GetWebRequestInfo(serialId);
	}

	public TaskInfo[] GetWebRequestInfos(string tag)
	{
		return m_WebRequestManager.GetWebRequestInfos(tag);
	}

	public void GetAllWebRequestInfos(string tag, List<TaskInfo> results)
	{
		m_WebRequestManager.GetAllWebRequestInfos(tag, results);
	}

	public TaskInfo[] GetAllWebRequestInfos()
	{
		return m_WebRequestManager.GetAllWebRequestInfos();
	}

	public void GetAllWebRequestInfos(List<TaskInfo> results)
	{
		m_WebRequestManager.GetAllWebRequestInfos(results);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri)
	{
		return AddWebRequest(webRequestUri, null, null, null, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData)
	{
		return AddWebRequest(webRequestUri, postData, null, null, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, null, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag)
	{
		return AddWebRequest(webRequestUri, null, null, tag, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, int priority)
	{
		return AddWebRequest(webRequestUri, null, null, null, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, object userData)
	{
		return AddWebRequest(webRequestUri, null, null, null, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag)
	{
		return AddWebRequest(webRequestUri, postData, null, tag, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, string tag)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, tag, 0, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, int priority)
	{
		return AddWebRequest(webRequestUri, postData, null, null, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, int priority)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, null, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, object userData)
	{
		return AddWebRequest(webRequestUri, postData, null, null, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, object userData)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, null, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, int priority)
	{
		return AddWebRequest(webRequestUri, null, null, tag, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, object userData)
	{
		return AddWebRequest(webRequestUri, null, null, tag, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, null, null, null, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, int priority)
	{
		return AddWebRequest(webRequestUri, postData, null, tag, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, string tag, int priority)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, tag, priority, null);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, object userData)
	{
		return AddWebRequest(webRequestUri, postData, null, tag, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, string tag, object userData)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, tag, 0, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, postData, null, null, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, null, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, null, null, tag, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, postData, null, tag, priority, userData);
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, WWWForm wwwForm, string tag, int priority, object userData)
	{
		return AddWebRequest(webRequestUri, null, wwwForm, tag, priority, userData);
	}

	public bool RemoveWebRequest(int serialId)
	{
		return m_WebRequestManager.RemoveWebRequest(serialId);
	}

	public int RemoveWebRequests(string tag)
	{
		return m_WebRequestManager.RemoveWebRequests(tag);
	}

	public int RemoveAllWebRequests()
	{
		return m_WebRequestManager.RemoveAllWebRequests();
	}

	private void AddWebRequestAgentHelper(int index)
	{
		WebRequestAgentHelperBase webRequestAgentHelperBase = Helper.CreateHelper(m_WebRequestAgentHelperTypeName, m_CustomWebRequestAgentHelper, index);
		if (webRequestAgentHelperBase == null)
		{
			Log.Error("Can not create web request agent helper.");
			return;
		}
		webRequestAgentHelperBase.name = Utility.Text.Format("Web Request Agent Helper - {0}", index);
		Transform transform = webRequestAgentHelperBase.transform;
		transform.SetParent(m_InstanceRoot);
		transform.localScale = Vector3.one;
		m_WebRequestManager.AddWebRequestAgentHelper(webRequestAgentHelperBase);
	}

	private Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, WWWForm wwwForm, string tag, int priority, object userData)
	{
		return m_WebRequestManager.AddWebRequest(webRequestUri, postData, bodyDataSet: false, null, null, tag, priority, WWWFormInfo.Create(wwwForm, userData));
	}

	public Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue)
	{
		return m_WebRequestManager.AddWebRequest(webRequestUri, postData, bodyDataSet, headerName, headerValue, null, 0, null);
	}

	public override void Shutdown()
	{
	}
}
