using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Ase;

[Serializable]
public class CopySettleInfo
{
	public int deaths;

	public int passTime;

	public int settleMode;

	public float bossHpLeft;

	public long checkCode;

	public List<CopySettleUserInfoCache> userInfos;

	public string ToJson()
	{
		return JsonConvert.SerializeObject(this);
	}

	public CopySettleInfo LoadJson(string jsonStr)
	{
		return JsonConvert.DeserializeObject<CopySettleInfo>(jsonStr);
	}
}
