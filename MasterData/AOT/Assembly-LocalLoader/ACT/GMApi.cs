using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using ACT.Error;
using ACT.UI.AOT;
using AOT.CryptographyCode;
using Newtonsoft.Json;
using UnityEngine;

namespace ACT;

public class GMApi
{
	private const string RequestRemoteConfigUrl = "https://lmapi-dev.zhuziplay.com";

	public static string BaseUrl { get; private set; } = "https://lmapi-dev.zhuziplay.com";

	public static void SetBaseUrl(string url)
	{
		BaseUrl = url;
	}

	public async Task<AnnouncementList> GetAnnouncements(int place, int category = 3, int page = 1, int pageSize = 100)
	{
		string value = Application.platform switch
		{
			RuntimePlatform.WindowsEditor => "1", 
			RuntimePlatform.WindowsPlayer => "1", 
			RuntimePlatform.IPhonePlayer => "2", 
			RuntimePlatform.Android => "3", 
			_ => "1", 
		};
		AnnouncementList announcementList = await Request<AnnouncementList>("announcement/list", new Dictionary<string, string>
		{
			{
				"page",
				page.ToString()
			},
			{
				"page_size",
				pageSize.ToString()
			},
			{ "publish_plat", value },
			{
				"publish_place",
				place.ToString()
			},
			{
				"category",
				category.ToString()
			},
			{
				"region",
				LuminApplication.AppRegion
			},
			{
				"env",
				LuminApplication.AppEnv
			},
			{
				"channel",
				LuminApplication.AppChannel
			},
			{
				"client_version",
				LuminApplication.AppClientVersion
			}
		});
		if (announcementList != null && announcementList.List != null)
		{
			if (category != 5)
			{
				AnnouncementRedDot.RecordKnownIds(category == 3, announcementList.List.Select((AnnouncementData a) => a.Id.ToString()).ToList(), (AnnouncementPlace)place);
			}
			else
			{
				AnnouncementData announcementData = announcementList.List.FirstOrDefault();
				if (announcementData != null)
				{
					AnnouncementRedDot.SetKnownTimelineId(announcementData.Id.ToString());
				}
				else
				{
					AnnouncementRedDot.SetKnownTimelineId(string.Empty);
				}
			}
		}
		return announcementList;
	}

	private async Task<T> Request<T>(string function, Dictionary<string, string> body)
	{
		using HttpClient httpClient = new HttpClient();
		using FormUrlEncodedContent content = new FormUrlEncodedContent(body);
		content.Headers.Clear();
		content.Headers.Add("Content-Type", "application/x-www-form-urlencoded");
		HttpResponseMessage httpResponseMessage = await BambooSafeHttpRequest.PostAsync(httpClient, BaseUrl + "/" + function, content);
		if (!httpResponseMessage.IsSuccessStatusCode)
		{
			LuminErrorAOT.ReportGameLoadingError("C01-0009", "01", 0, httpResponseMessage.StatusCode.ToString());
			throw new Exception($"[C01-0009] GM http error: {httpResponseMessage.StatusCode}");
		}
		GMReturn<T> gMReturn = JsonConvert.DeserializeObject<GMReturn<T>>(settings: new JsonSerializerSettings
		{
			NullValueHandling = NullValueHandling.Ignore
		}, value: await httpResponseMessage.Content.ReadAsStringAsync());
		if (gMReturn.Code != 0)
		{
			LuminErrorAOT.ReportGameLoadingError("C01-0010", "10", 0, gMReturn.Code.ToString());
			throw new Exception($"[C01-0010] GM error: {gMReturn.Code}");
		}
		return gMReturn.Data;
	}
}
