#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public class SceneSundryMapData : SerializedMonoBehaviour
{
	public Dictionary<int, MeshRenderer> MaterialDics = new Dictionary<int, MeshRenderer>();

	public Dictionary<int, GameObject> GameObjectDics = new Dictionary<int, GameObject>();

	public void ChangeMaterialMagicBlend(int dicKey, int index, float changeValue)
	{
		if (MaterialDics.TryGetValue(dicKey, out var value))
		{
			if (!(value == null))
			{
				List<Material> list = new List<Material>();
				value.GetMaterials(list);
				if (list.Count > index)
				{
					list[index].SetFloat("_MagicBlend", changeValue);
				}
			}
		}
		else
		{
			Log.Error("这个材质球没有添加进去");
		}
	}

	public void ChangeSceneGobjActive(int dicKey, bool active)
	{
		if (GameObjectDics.TryGetValue(dicKey, out var value))
		{
			if (value != null)
			{
				value.SetActive(active);
			}
			value.SetActive(active);
		}
	}
}
