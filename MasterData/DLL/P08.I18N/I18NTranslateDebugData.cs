using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class I18NTranslateDebugData : ScriptableObject
{
	public int count;

	[SerializeField]
	public List<TranslateKeyValueDebug> translateDataList;

	public I18NTranslateDebugData()
	{
		translateDataList = new List<TranslateKeyValueDebug>();
	}
}
