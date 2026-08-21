using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class I18NTranslateData : ScriptableObject
{
	[SerializeField]
	public List<TranslateKeyValue> translates;
}
