using System;
using System.Collections.Generic;

[Serializable]
public struct TranslateKeyValue
{
	public string key;

	public string source;

	public Dictionary<string, string> translateDic;
}
