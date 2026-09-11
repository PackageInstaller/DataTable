using System.Collections.Generic;
using System.Net;
using LitJson;

public struct HttpReply
{
	public string Opcode;

	public string rawJson;

	public HttpStatusCode code;

	public IDictionary<string, JsonData> dict;

	public HttpReply(HttpStatusCode hcode, string opcode, string rawjson)
	{
		code = hcode;
		Opcode = opcode;
		rawJson = rawjson;
		if (!string.IsNullOrEmpty(rawjson))
		{
			dict = JsonMapper.ToObject(rawjson).toDict();
		}
		else
		{
			dict = null;
		}
	}

	public HttpReply(HttpStatusCode hcode, string opcode, JsonData dataJson)
	{
		code = hcode;
		Opcode = opcode;
		rawJson = dataJson.ToString();
		dict = dataJson.toDict();
	}
}
