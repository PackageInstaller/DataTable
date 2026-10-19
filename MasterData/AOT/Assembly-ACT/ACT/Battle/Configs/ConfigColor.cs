using ACT.Core;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigColor : ScriptableObject
{
	public Color Born;

	public Color Disturb;

	public Color Ash;

	public Color Operate;

	public Color Promote;

	public Color Dark;

	public Color GetColor(ElementBitmask element)
	{
		return element switch
		{
			ElementBitmask.Promote => Promote, 
			ElementBitmask.Disturb => Disturb, 
			ElementBitmask.Operate => Operate, 
			ElementBitmask.Born => Born, 
			ElementBitmask.Ash => Ash, 
			_ => Dark, 
		};
	}
}
