using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class BoardPartActionEntry
{
	[Tooltip("动画轨道")]
	public int TrackIndex;

	public List<AudioClipData> Audios;

	public List<AudioParameterSerializable> AudioParameters;

	[Tooltip("播放策略")]
	public BoardPartPlayMode PlayMode;

	[Tooltip("动作名列表: Fixed 取第一个; RandomFromList 随机")]
	public List<string> Actions;

	[Tooltip("解锁条件列表: 默认 AND 关系")]
	public List<BoardPartCondition> Conditions;

	public bool HasActions
	{
		get
		{
			if (Actions != null)
			{
				return Actions.Count > 0;
			}
			return false;
		}
	}

	public bool HasConditions
	{
		get
		{
			if (Conditions != null)
			{
				return Conditions.Count > 0;
			}
			return false;
		}
	}
}
