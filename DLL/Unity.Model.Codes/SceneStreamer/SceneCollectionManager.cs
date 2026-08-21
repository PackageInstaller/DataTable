using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace SceneStreamer;

[Serializable]
public class SceneCollectionManager : ScriptableObject
{
	[Serializable]
	public struct SceneSplitData
	{
		[FormerlySerializedAs("customAABB")]
		[FormerlySerializedAs("aabb")]
		public AABBData aabbData;

		public bool extra;

		public string name;
	}

	public bool active = true;

	public int maxParallelSceneLoading = 1;

	public Vector3 checkSize;

	[Header("Settings")]
	public string prefixName = "stream";

	public string prefixScene = "Scene";

	public string path = "Assets/WorldStreamer/SplitScenes/";

	[Space(5f)]
	public SceneSplitData[] sceneSplitDatas;

	[Space(5f)]
	public Vector3Int splitSize = new Vector3Int(500, 0, 500);

	[Space(5f)]
	public Color color = Color.red;

	public bool showGrid;

	[Space(5f)]
	public bool isDebugEnabled;

	public bool showEndDepth;

	public bool showTargetDepth;

	[Range(0f, 10f)]
	public int displayDepth;

	[HideInInspector]
	public int currentlySceneLoading;

	public List<SceneHandler> loadedScenes = new List<SceneHandler>();

	private DynamicBvhSpace<SceneSplitBVHData> sahSpace;

	[HideInInspector]
	public Dictionary<string, SceneHandler> scenesArray;

	private Vector3 currentPosition;

	private Vector3 checkSizeTmp;

	public Vector3 CheckSize
	{
		get
		{
			checkSizeTmp = checkSize;
			if (!ySplitIs)
			{
				checkSizeTmp.y = 2.1474836E+09f;
			}
			return checkSizeTmp;
		}
	}

	public bool xSplitIs => splitSize.x > 0;

	public bool ySplitIs => splitSize.y > 0;

	public bool zSplitIs => splitSize.z > 0;

	public int xSize => splitSize.x;

	public int ySize => splitSize.y;

	public int zSize => splitSize.z;

	public void PrepareSceneBvhSpace()
	{
		scenesArray = new Dictionary<string, SceneHandler>();
		path = path.Replace("\\", "/");
		sahSpace = new DynamicBvhSpace<SceneSplitBVHData>();
		SceneSplitData[] array = sceneSplitDatas;
		for (int i = 0; i < array.Length; i++)
		{
			SceneSplitData sceneSplitData = array[i];
			SceneHandler sceneHandler = new SceneHandler();
			sceneHandler.aabbData = sceneSplitData.aabbData;
			sceneHandler.sceneName = path + sceneSplitData.name;
			sceneHandler.sceneCollectionManager = this;
			sceneHandler.loadingFinished = false;
			scenesArray.Add(sceneSplitData.name.Replace(".unity", ""), sceneHandler);
			DynamicBvhSpace<SceneSplitBVHData> dynamicBvhSpace = sahSpace;
			SceneSplitBVHData obj = new SceneSplitBVHData
			{
				aabbData = sceneSplitData.aabbData
			};
			AABBData aabbData = sceneSplitData.aabbData;
			obj.position = aabbData.center;
			obj.sceneHandler = sceneHandler;
			dynamicBvhSpace.AddNode(obj);
		}
		loadedScenes.Clear();
		currentlySceneLoading = 0;
		currentPosition = new Vector3(-2.1474836E+09f, -2.1474836E+09f, -2.1474836E+09f);
	}

	public void OnDestroy()
	{
		sahSpace = null;
	}

	public List<SceneHandler> Query(Vector3 position)
	{
		AABBData other = new AABBData(position - CheckSize * 0.5f, position + CheckSize * 0.5f);
		List<SceneHandler> result = new List<SceneHandler>();
		sahSpace.root.RestActiveState();
		if (sahSpace.root.Contains(other))
		{
			Query(other, sahSpace.root, ref result);
		}
		return result;
	}

	public void Query(AABBData other, BvhNode<SceneSplitBVHData> checkNode, ref List<SceneHandler> result)
	{
		if (checkNode.leftNode == null && checkNode.rightNode == null)
		{
			checkNode.SetActive(value: true);
			result.Add(checkNode.bvhObject.sceneHandler);
		}
		else
		{
			checkNode.SetActive(value: false);
		}
		BvhNode<SceneSplitBVHData> leftNode = checkNode.leftNode;
		if (leftNode != null && leftNode.Contains(other))
		{
			Query(other, checkNode.leftNode, ref result);
		}
		BvhNode<SceneSplitBVHData> rightNode = checkNode.rightNode;
		if (rightNode != null && rightNode.Contains(other))
		{
			Query(other, checkNode.rightNode, ref result);
		}
	}

	public void OnDrawGizmos()
	{
		if (showTargetDepth)
		{
			sahSpace?.root?.DrawTargetDepth(displayDepth);
		}
		else if (showEndDepth)
		{
			sahSpace?.root?.DrawEndDepth();
		}
		else
		{
			sahSpace?.root?.DrawDepth(displayDepth);
		}
	}

	public bool CheckPosition(Vector3 pos)
	{
		if (ySplitIs)
		{
			pos.y = currentPosition.y;
		}
		float num = Vector3.Distance(currentPosition, pos);
		float num2 = new Vector3(checkSize.x, ySplitIs ? checkSize.y : 0f, checkSize.z).magnitude * 0.25f * 0.5f;
		bool num3 = num > num2;
		if (num3)
		{
			currentPosition = pos;
		}
		return num3;
	}
}
