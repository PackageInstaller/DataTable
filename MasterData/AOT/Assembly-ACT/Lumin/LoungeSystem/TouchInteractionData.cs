using System;
using System.Collections.Generic;

namespace Lumin.LoungeSystem;

[Serializable]
public class TouchInteractionData
{
	public string touchZone;

	public int minFavorLevel;

	public int favorChange;

	public List<string> reactions;

	public string animationName;

	public bool isSpecial;

	public TouchInteractionData(string zone, int minLevel)
	{
		touchZone = zone;
		minFavorLevel = minLevel;
		reactions = new List<string>();
	}
}
