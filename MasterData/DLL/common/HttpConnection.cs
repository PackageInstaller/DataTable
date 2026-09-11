using System;
using System.Collections.Generic;
using System.Net;
using System.Text;
using LitJson;

public class HttpConnection
{
	private struct RequestNode
	{
		public string Opcode;

		public Action<HttpReply> ResponseCallBack;
	}

	private static HttpConnection sInstance;

	private Dictionary<string, object> mParams;

	private Encoding mUTF8 = Encoding.UTF8;

	private byte[] mCache = new byte[1048576];

	private int mTimeOutMiliseconds = 3000;

	private string url = "http://192.168.199.141:9980/auth";

	private Queue<HttpReply> m_ResponseQueue;

	private Dictionary<string, RequestNode> m_ProcessRequests;

	public static HttpConnection Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new HttpConnection();
			}
			return sInstance;
		}
	}

	public int TimeOutMiliseconds
	{
		get
		{
			return mTimeOutMiliseconds;
		}
		set
		{
			mTimeOutMiliseconds = value;
		}
	}

	public void SetUrl(string url)
	{
		this.url = url;
	}

	public HttpConnection()
	{
		m_ResponseQueue = new Queue<HttpReply>();
		mParams = new Dictionary<string, object>();
		m_ProcessRequests = new Dictionary<string, RequestNode>();
	}

	private void post(string url, string funcname, Action<HttpReply> response, params object[] paras)
	{
		if (checkAlreadyInRequest(funcname))
		{
			return;
		}
		mParams["func_name"] = funcname;
		mParams["params"] = paras;
		string text = JsonMapper.ToJson(mParams);
		RequestNode value = new RequestNode
		{
			Opcode = funcname,
			ResponseCallBack = response
		};
		m_ProcessRequests.Add(funcname, value);
		byte[] bytes = mUTF8.GetBytes(text);
		WebRequest request = WebRequest.Create(url);
		request.Method = "POST";
		try
		{
			request.GetRequestStream().Write(bytes, 0, bytes.Length);
			request.GetRequestStream().Close();
			request.Timeout = mTimeOutMiliseconds;
			request.BeginGetResponse(delegate
			{
				HttpWebResponse httpWebResponse = request.GetResponse() as HttpWebResponse;
				string rawjson = string.Empty;
				if (httpWebResponse.StatusCode == HttpStatusCode.OK)
				{
					httpWebResponse.GetResponseStream().Read(mCache, 0, (int)httpWebResponse.ContentLength);
					rawjson = mUTF8.GetString(mCache, 0, (int)httpWebResponse.ContentLength);
				}
				m_ResponseQueue.Enqueue(new HttpReply(httpWebResponse.StatusCode, funcname, rawjson));
			}, null);
			XLogger.Debug("send http{0}, url:{1}", text, url);
		}
		catch (Exception ex)
		{
			request.Abort();
			request = null;
			JsonData jsonData = new JsonData();
			jsonData.set_Item("err_msg", (JsonData)ex.Message);
			m_ResponseQueue.Enqueue(new HttpReply(HttpStatusCode.BadRequest, funcname, jsonData));
		}
	}

	private bool checkAlreadyInRequest(string opcode)
	{
		return m_ProcessRequests.ContainsKey(opcode);
	}

	public void Update()
	{
		if (m_ResponseQueue == null)
		{
			return;
		}
		while (m_ResponseQueue.Count > 0)
		{
			HttpReply obj = m_ResponseQueue.Dequeue();
			if (m_ProcessRequests.ContainsKey(obj.Opcode))
			{
				RequestNode requestNode = m_ProcessRequests[obj.Opcode];
				if (requestNode.ResponseCallBack != null)
				{
					requestNode.ResponseCallBack(obj);
				}
				m_ProcessRequests.Remove(requestNode.Opcode);
			}
		}
	}

	public void Post(string funcname, Action<HttpReply> response, params object[] paras)
	{
		post(url, funcname, response, paras);
	}

	public void Reset()
	{
		m_ResponseQueue.Clear();
		m_ProcessRequests.Clear();
	}
}
