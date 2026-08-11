using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class HeroScenePoint : MonoBehaviour
{
	public List<ScenePoint> scenePoints = new List<ScenePoint>();

	public ScenePoint GetHeroBornPoint(int index)
	{
		if (scenePoints.Count <= index || index < 0)
		{
			return null;
		}
		return scenePoints[index];
	}
}
