#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using Sirenix.OdinInspector;

namespace Ase;

public class ScenePointGroup : SerializedMonoBehaviour
{
	public Dictionary<string, ScenePoint> scenePoints = new Dictionary<string, ScenePoint>();

	public ScenePoint GetScenePoint(string pointKey)
	{
		if (scenePoints.ContainsKey(pointKey))
		{
			return scenePoints[pointKey];
		}
		Log.Error("没有找到索引 = " + pointKey + "的场景点配置。");
		return null;
	}
}
