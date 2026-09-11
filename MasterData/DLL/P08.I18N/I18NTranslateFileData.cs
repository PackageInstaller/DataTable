using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class I18NTranslateFileData : ScriptableObject
{
	public string fileName;

	[SerializeField]
	public List<string> translates;

	private I18NTranslateFileData()
	{
		translates = new List<string>();
	}
}
