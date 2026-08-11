using System.Collections.Generic;
using Sirenix.OdinInspector;

namespace Ase;

public class HeroBornPointConfig : SerializedMonoBehaviour
{
	public Dictionary<string, HeroScenePoint> heroBornPoints = new Dictionary<string, HeroScenePoint>();

	public ScenePoint GetHeroBornPoint(string heroBornPointKey, int index)
	{
		if (heroBornPoints.ContainsKey(heroBornPointKey))
		{
			return heroBornPoints[heroBornPointKey].GetHeroBornPoint(index);
		}
		return null;
	}

	public HeroScenePoint GetHeroBornPoint(string heroBornPointKey)
	{
		if (heroBornPoints.ContainsKey(heroBornPointKey))
		{
			return heroBornPoints[heroBornPointKey];
		}
		return null;
	}
}
