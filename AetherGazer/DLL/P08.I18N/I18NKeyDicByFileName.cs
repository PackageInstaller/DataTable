using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class I18NKeyDicByFileName : ScriptableObject
{
	public int id;

	[SerializeField]
	public List<TranslateFileGroup> groupList;
}
