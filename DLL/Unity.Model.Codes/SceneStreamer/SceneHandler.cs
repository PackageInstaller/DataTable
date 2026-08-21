using System;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.Serialization;

namespace SceneStreamer;

[Serializable]
public class SceneHandler
{
	public string sceneName;

	[FormerlySerializedAs("aabb")]
	[FormerlySerializedAs("customAABB")]
	public AABBData aabbData;

	public Scene scene;

	public GameObject sceneGo;

	public bool active = true;

	public bool loaded;

	public bool loadingFinished;

	public SceneCollectionManager sceneCollectionManager;

	public void SetSceneGo(GameObject sceneGo)
	{
		this.sceneGo = sceneGo;
	}

	public void ClearSceneGo()
	{
		sceneGo = null;
	}

	public void OnSceneActive()
	{
		active = true;
		OnSceneActiveUpdate();
	}

	public void OnSceneInActive()
	{
		active = false;
		OnSceneActiveUpdate();
	}

	public void OnSceneActiveUpdate()
	{
		if ((bool)sceneGo)
		{
			sceneGo.SetActive(active);
		}
	}
}
