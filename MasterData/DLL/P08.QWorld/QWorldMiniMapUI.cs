using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class QWorldMiniMapUI : MonoBehaviour
{
	private const string MINI_MAP_UNIT_PATH = "Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_MiniMapNode";

	public Image image;

	public RectTransform agentArror;

	public RectTransform cameraViewTrans;

	public RectTransform mapImag;

	public RectTransform miniEntityContent;

	public RectTransform mapContent;

	public static float MINI_MAP_RATIO = 1f;

	public static Vector3 AGENT_POSITION_OFFSET = new Vector3(-7.66f, 0f, -35.6f);

	private Transform agent;

	private List<QWorldMiniMapUnitDisplay> pool;

	private Dictionary<QWorldMiniMapUnit, QWorldMiniMapUnitDisplay> unitDict;

	private void Awake()
	{
		pool = new List<QWorldMiniMapUnitDisplay>();
		unitDict = new Dictionary<QWorldMiniMapUnit, QWorldMiniMapUnitDisplay>();
	}

	public void Init(string path, float width, float height, float map_rate, Vector3 center_offset)
	{
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.GetMap() != null)
		{
			QWorldMap map = qWorldScene.GetMap();
			map.MiniMapUpdateAction = (Action<List<QWorldMiniMapUnit>>)Delegate.Combine(map.MiniMapUpdateAction, new Action<List<QWorldMiniMapUnit>>(UpdateMiniMap));
			UpdateMiniMap(qWorldScene.GetMap().miniMapUnitsList);
			agent = qWorldScene.Agent.transform;
		}
		mapImag.sizeDelta = new Vector2(width, height);
		MINI_MAP_RATIO = width / map_rate;
		AGENT_POSITION_OFFSET = center_offset;
		AtlasManager.GetSpriteWithoutAtlas(image, path);
	}

	public void Dispose()
	{
		unitDict.Clear();
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.GetMap() != null)
		{
			QWorldMap map = qWorldScene.GetMap();
			map.MiniMapUpdateAction = (Action<List<QWorldMiniMapUnit>>)Delegate.Remove(map.MiniMapUpdateAction, new Action<List<QWorldMiniMapUnit>>(UpdateMiniMap));
		}
	}

	private void UpdateMiniMap(List<QWorldMiniMapUnit> miniMapUnitsList)
	{
		unitDict.Clear();
		int count = miniMapUnitsList.Count;
		int count2 = pool.Count;
		for (int i = 0; i < count; i++)
		{
			QWorldMiniMapUnit qWorldMiniMapUnit = miniMapUnitsList[i];
			QWorldMiniMapUnitDisplay qWorldMiniMapUnitDisplay;
			if (i < count2)
			{
				qWorldMiniMapUnitDisplay = pool[i];
			}
			else
			{
				qWorldMiniMapUnitDisplay = CreatMiniDisplay();
				pool.Add(qWorldMiniMapUnitDisplay);
			}
			qWorldMiniMapUnitDisplay.Render(qWorldMiniMapUnit);
			qWorldMiniMapUnitDisplay.UpdatePosition(qWorldMiniMapUnit.Position);
			unitDict.Add(qWorldMiniMapUnit, qWorldMiniMapUnitDisplay);
		}
		for (int j = count; j < count2; j++)
		{
			pool[j].OnReturn();
		}
	}

	private QWorldMiniMapUnitDisplay CreatMiniDisplay()
	{
		GameObject obj = Asset.Instantiate("Widget/System/SandPlay/SandPlay_InScenes/item/SandPlay_MiniMapNode");
		obj.transform.SetParent(miniEntityContent, worldPositionStays: false);
		QWorldMiniMapUnitDisplay component = obj.GetComponent<QWorldMiniMapUnitDisplay>();
		component.Init(this, mapContent);
		return component;
	}

	private void Update()
	{
		if (null == agent)
		{
			return;
		}
		Vector3 vector = (agent.position - AGENT_POSITION_OFFSET) * MINI_MAP_RATIO;
		mapImag.localPosition = new Vector3(0f - vector.x, 0f - vector.z, 0f);
		Vector3 eulerAngles = agent.eulerAngles;
		agentArror.eulerAngles = new Vector3(0f, 180f, eulerAngles.y);
		Transform transform = QWorldCameraManager.Instance.MainCamera.transform;
		cameraViewTrans.eulerAngles = new Vector3(0f, 180f, transform.eulerAngles.y);
		foreach (KeyValuePair<QWorldMiniMapUnit, QWorldMiniMapUnitDisplay> item in unitDict)
		{
			QWorldMiniMapUnit key = item.Key;
			QWorldMiniMapUnitDisplay value = item.Value;
			bool isTrackMini = key.IsTrackMini;
			if (key.m_miniDirty || value.track_show != isTrackMini)
			{
				value.Render(key);
				if (isTrackMini)
				{
					value.UpdatePosition(key.Position, agent.position);
				}
				else
				{
					value.UpdatePosition(key.Position);
				}
				key.m_miniDirty = false;
			}
			else if (isTrackMini)
			{
				value.UpdatePosition(key.Position, agent.position);
			}
			else
			{
				value.UpdatePosition(key.Position);
			}
		}
	}
}
