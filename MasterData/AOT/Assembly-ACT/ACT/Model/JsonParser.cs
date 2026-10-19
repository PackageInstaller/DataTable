using System;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ACT.Model;

public class JsonParser
{
	public static NewbieConfig ParseNewbieConfig(string json)
	{
		try
		{
			return JObject.Parse(json.Replace("“", "\"").Replace("”", "\""))["newbie"].ToObject<NewbieConfig>();
		}
		catch (JsonReaderException innerException)
		{
			throw new ArgumentException("无效的JSON格式", innerException);
		}
		catch (NullReferenceException)
		{
			throw new ArgumentException("JSON中缺少newbie节点");
		}
	}
}
