#define LOG_ERROR
using System.Collections.Generic;
using UnityEngine;

public class RefTool : MonoBehaviour
{
	protected static RefTool g_instance;

	public List<TransformItem> transformItems = new List<TransformItem>();

	public List<WorldOBBItem> worldItems = new List<WorldOBBItem>();

	private Dictionary<string, Transform> dicTransfrom = new Dictionary<string, Transform>();

	private Dictionary<string, WorldOBB> dicWorldOBB = new Dictionary<string, WorldOBB>();

	public static RefTool Ins
	{
		get
		{
			if (g_instance == null)
			{
				g_instance = Object.FindObjectOfType<RefTool>();
			}
			return g_instance;
		}
	}

	public void Init()
	{
		dicTransfrom.Clear();
		for (int i = 0; i < transformItems.Count; i++)
		{
			TransformItem transformItem = transformItems.get_Item(i);
			dicTransfrom.Add(transformItem.key, transformItem.value);
		}
		for (int j = 0; j < worldItems.Count; j++)
		{
			WorldOBBItem worldOBBItem = worldItems.get_Item(j);
			dicWorldOBB.Add(worldOBBItem.key, worldOBBItem.value);
		}
	}

	public Transform GetTransformByKey(string key)
	{
		if (dicTransfrom.TryGetValue(key, out var value))
		{
			return value;
		}
		NovaLogger.Error("不存在 " + key);
		return null;
	}

	public WorldOBB GetWorldOBBByKey(string key)
	{
		if (dicWorldOBB.TryGetValue(key, out var value))
		{
			return value;
		}
		NovaLogger.Error("不存在 " + key);
		return null;
	}
}
