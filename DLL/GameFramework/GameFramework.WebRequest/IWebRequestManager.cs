using System.Collections.Generic;
using System.Threading.Tasks;

namespace GameFramework.WebRequest;

public interface IWebRequestManager
{
	int TotalAgentCount { get; }

	int FreeAgentCount { get; }

	int WorkingAgentCount { get; }

	int WaitingTaskCount { get; }

	float Timeout { get; set; }

	void AddWebRequestAgentHelper(IWebRequestAgentHelper webRequestAgentHelper);

	TaskInfo GetWebRequestInfo(int serialId);

	TaskInfo[] GetWebRequestInfos(string tag);

	void GetAllWebRequestInfos(string tag, List<TaskInfo> results);

	TaskInfo[] GetAllWebRequestInfos();

	void GetAllWebRequestInfos(List<TaskInfo> results);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, int priority);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, int priority);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, int priority);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, int priority, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, int priority);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, string tag, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, int priority, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, string tag, int priority, object userData);

	Task<WebRequestResponse> AddWebRequest(string webRequestUri, byte[] postData, bool bodyDataSet, string headerName, string headerValue, string tag, int priority, object userData);

	bool RemoveWebRequest(int serialId);

	int RemoveWebRequests(string tag);

	int RemoveAllWebRequests();
}
