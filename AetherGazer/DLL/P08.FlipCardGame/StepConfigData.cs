using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "CookingGame/StepConfigData")]
public class StepConfigData : ScriptableObject
{
	[Serializable]
	public class StepPrefabEntry
	{
		public string stepID;

		public string prefabPath;

		public StepPrefabEntry(string stepID, string prefabPath)
		{
			this.stepID = stepID;
			this.prefabPath = prefabPath;
		}
	}

	public List<MainStepConfig> stepSequence = new List<MainStepConfig>();

	public List<StepPrefabEntry> stepPrefabPathList = new List<StepPrefabEntry>();

	private Dictionary<string, string> _stepPrefabPathMapCache;

	public int StepCount => stepSequence.Count;

	public MainStepConfig GetConfig(int index)
	{
		return stepSequence[index];
	}

	private void BuildStepPrefabPathMap()
	{
		if (_stepPrefabPathMapCache != null)
		{
			return;
		}
		_stepPrefabPathMapCache = new Dictionary<string, string>();
		foreach (StepPrefabEntry stepPrefabPath in stepPrefabPathList)
		{
			if (!string.IsNullOrEmpty(stepPrefabPath.stepID) && !_stepPrefabPathMapCache.ContainsKey(stepPrefabPath.stepID))
			{
				_stepPrefabPathMapCache.Add(stepPrefabPath.stepID, stepPrefabPath.prefabPath);
			}
		}
	}

	public GameObject GetPrefab(string stepID)
	{
		BuildStepPrefabPathMap();
		if (_stepPrefabPathMapCache.TryGetValue(stepID, out var value))
		{
			int num = value.IndexOf("Widget");
			if (num >= 0)
			{
				value = value.Substring(num);
			}
			GameObject gameObject = AssetManager.Load<GameObject>(value);
			if (gameObject != null)
			{
				return gameObject;
			}
			Debug.LogError("料理玩法加载预制体失败!! \nstepID:" + stepID + "\n路径:" + value);
			return null;
		}
		Debug.LogError("料理玩法没有对应路径!! \nstepID:" + stepID);
		return null;
	}
}
