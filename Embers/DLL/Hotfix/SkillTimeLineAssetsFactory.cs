#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using ParadoxNotion.Services;
using UnityEngine;

public class SkillTimeLineAssetsFactory : MonoBehaviour
{
	private static SkillTimeLineAssetsFactory _current;

	private Dictionary<string, Queue<SkillTimelineAsset>> _skillTimeLineAssetDic = new Dictionary<string, Queue<SkillTimelineAsset>>();

	public static SkillTimeLineAssetsFactory Current
	{
		get
		{
			if (_current == null && Threader.applicationIsPlaying)
			{
				_current = UnityEngine.Object.FindObjectOfType<SkillTimeLineAssetsFactory>();
				if (_current == null)
				{
					_current = new GameObject("SkillTimeLineAssetsFactory").AddComponent<SkillTimeLineAssetsFactory>();
				}
			}
			return _current;
		}
	}

	public int CheckGraphInitialized(SkillTimelineAsset originalLine, int number)
	{
		if (originalLine == null)
		{
			Log.Error("初始化行为树失败：行为树文件为空!");
			return -1;
		}
		if (_skillTimeLineAssetDic.TryGetValue(originalLine.name, out var value))
		{
			if (value.Count >= number)
			{
				return 0;
			}
			return number - value.Count;
		}
		return number;
	}

	public SkillTimelineAsset GetInstance(SkillTimelineAsset skillTimelineAsset)
	{
		if (skillTimelineAsset == null)
		{
			return null;
		}
		if (!_skillTimeLineAssetDic.TryGetValue(skillTimelineAsset.name, out var value))
		{
			value = new Queue<SkillTimelineAsset>();
			SkillTimelineAsset item = SkillTimelineAsset.Clone(skillTimelineAsset);
			value.Enqueue(item);
			_skillTimeLineAssetDic[skillTimelineAsset.name] = value;
		}
		if (value.Count == 0)
		{
			SkillTimelineAsset item2 = SkillTimelineAsset.Clone(skillTimelineAsset);
			value.Enqueue(item2);
			_skillTimeLineAssetDic[skillTimelineAsset.name] = value;
		}
		return value.Dequeue();
	}

	public void SetInstance(string lineName, SkillTimelineAsset lineClone)
	{
		if (_skillTimeLineAssetDic.ContainsKey(lineClone.name))
		{
			_skillTimeLineAssetDic[lineName].Enqueue(lineClone);
			return;
		}
		Queue<SkillTimelineAsset> queue = new Queue<SkillTimelineAsset>();
		queue.Enqueue(lineClone);
		_skillTimeLineAssetDic.Add(lineName, queue);
	}

	public void RecycleTree(SkillTimelineAsset lineClone)
	{
		if (_skillTimeLineAssetDic.TryGetValue(lineClone.name, out var value))
		{
			value.Enqueue(lineClone);
		}
	}

	public void ClearCache()
	{
		foreach (Queue<SkillTimelineAsset> value in _skillTimeLineAssetDic.Values)
		{
			foreach (SkillTimelineAsset item in value)
			{
				UnityEngine.Object.DestroyImmediate(item);
			}
		}
		_skillTimeLineAssetDic.Clear();
		GC.Collect();
	}
}
