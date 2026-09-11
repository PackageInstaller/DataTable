using System.Collections;
using System.IO;
using UnityEngine;
using UnityEngine.Networking;

public class UserProtocol : MonoBehaviour
{
	public string Url;

	public WebViewObject webViewObject;

	public Transform panel;

	public string js;

	public string ready = "ready";

	public IEnumerator Load()
	{
		if (panel != null)
		{
			webViewObject.transform.parent = panel;
			RectTransform rectTransform = panel as RectTransform;
			webViewObject.SetMargins((int)rectTransform.offsetMin.x, -(int)rectTransform.offsetMax.y, -(int)rectTransform.offsetMax.x, (int)rectTransform.offsetMin.y, relative: true);
		}
		else
		{
			webViewObject.SetMargins(5, 100, 5, Screen.height / 4);
		}
		if (Url.StartsWith("http"))
		{
			webViewObject.LoadURL(Url.Replace(" ", "%20"));
			yield break;
		}
		string[] array = new string[3] { ".jpg", ".js", ".html" };
		string[] array2 = array;
		foreach (string ext in array2)
		{
			string path = Url.Replace(".html", ext);
			string text = Path.Combine(Application.streamingAssetsPath, path);
			string dst = Path.Combine(Application.persistentDataPath, path);
			byte[] bytes;
			if (text.Contains("://"))
			{
				UnityWebRequest unityWebRequest = UnityWebRequest.Get(text);
				yield return unityWebRequest.SendWebRequest();
				bytes = unityWebRequest.downloadHandler.data;
			}
			else
			{
				bytes = File.ReadAllBytes(text);
			}
			File.WriteAllBytes(dst, bytes);
			if (ext == ".html")
			{
				webViewObject.LoadURL("file://" + dst.Replace(" ", "%20"));
				break;
			}
		}
	}

	private void OnDisable()
	{
		webViewObject.SetVisibility(v: false);
	}

	private void Update()
	{
		webViewObject.Progress();
		string text = "$(window).scroll(function(){\n            //滚动条所在位置的高度\n            totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());\n            //当前文档高度   小于或等于   滚动条所在位置高度  则是页面底部\n            if (($(document).height()) <= totalheight) {\n                //页面到达底部\n            }\n        });";
		webViewObject.EvaluateJS(text);
	}
}
