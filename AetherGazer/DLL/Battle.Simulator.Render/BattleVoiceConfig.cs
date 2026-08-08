using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "BattleVoiceConfig", menuName = "ScriptableObjects/BattleVoiceConfig", order = 1)]
public class BattleVoiceConfig : ScriptableObject
{
	public List<BattleVoiceConfigItem> data = new List<BattleVoiceConfigItem>();

	private Dictionary<string, BattleVoiceConfigItem> _dictData;

	private void OnEnable()
	{
		if (_dictData == null)
		{
			_dictData = new Dictionary<string, BattleVoiceConfigItem>();
			for (int i = 0; i < data.Count; i++)
			{
				BattleVoiceConfigItem value = data[i];
				_dictData.Add(value.m_Name, value);
			}
		}
	}

	public bool TryGetData(string name, out BattleVoiceConfigItem item)
	{
		if (_dictData == null)
		{
			OnEnable();
		}
		return _dictData.TryGetValue(name, out item);
	}
}
