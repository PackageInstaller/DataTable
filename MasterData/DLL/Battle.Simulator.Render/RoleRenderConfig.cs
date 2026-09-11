using System.Collections.Generic;
using UnityEngine;

public class RoleRenderConfig : ScriptableObject
{
	public int ID;

	public bool UsePendant;

	public List<int> PreloadTimlines;

	[SerializeField]
	public List<AnimationTransitionInfo> AnimationTransition = new List<AnimationTransitionInfo>();

	public List<LineConnectionConfig> LineConnectionConfigs = new List<LineConnectionConfig>();

	public void Merge(RoleRenderConfig other)
	{
		foreach (AnimationTransitionInfo item in other.AnimationTransition)
		{
			AnimationTransition.Add(item);
		}
		foreach (LineConnectionConfig lineConnectionConfig in other.LineConnectionConfigs)
		{
			LineConnectionConfigs.Add(lineConnectionConfig);
		}
	}
}
