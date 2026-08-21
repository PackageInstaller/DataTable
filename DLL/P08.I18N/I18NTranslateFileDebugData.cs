using System.Collections.Generic;
using UnityEngine;

public class I18NTranslateFileDebugData : ScriptableObject
{
	public int id;

	public string fileName;

	[SerializeField]
	public List<string> translates;

	[SerializeField]
	public List<string> sources;
}
