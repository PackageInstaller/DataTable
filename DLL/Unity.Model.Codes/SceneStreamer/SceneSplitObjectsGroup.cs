using UnityEngine;

namespace SceneStreamer;

public class SceneSplitObjectsGroup : MonoBehaviour
{
	[HideInInspector]
	public int instanceId;

	[HideInInspector]
	public bool created;

	public void CalcuteInstanceId()
	{
		if (!created)
		{
			instanceId = base.gameObject.GetInstanceID();
		}
	}
}
