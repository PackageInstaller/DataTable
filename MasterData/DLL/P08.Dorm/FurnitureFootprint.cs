using Sirenix.OdinInspector;
using UnityEngine;

public class FurnitureFootprint : SerializedMonoBehaviour
{
	public enum FootprintType
	{
		Floor,
		WallMount,
		WallMountAttachGround
	}

	[SerializeField]
	private bool visible;

	[SerializeField]
	private FootprintType type;

	[SerializeField]
	private Vector3Int size;

	[SerializeField]
	[ColorUsage(false, true)]
	private Color color;

	private const string FLOOR_FOOTPRINT_PATH = "Dorm/Dormitory/HZ05_occupation_floor_01";

	private const string WALL_FOOTPRINT_PATH = "Dorm/Dormitory/HZ05_occupation_wall_01";

	private const string WALL_ATTACH_GROUND_FOOTPRINT_PATH = "Dorm/Dormitory/HZ05_occupation_wall_floor_01";

	private GameObject footprintObj;

	private bool isCustomFootprintObj;

	private Renderer[] footprintRenderers;

	private const float AVOID_Z_FIGHT_BIAS = 0.01f;

	private static string GetPrefabPathByType(FootprintType type)
	{
		return type switch
		{
			FootprintType.Floor => "Dorm/Dormitory/HZ05_occupation_floor_01", 
			FootprintType.WallMount => "Dorm/Dormitory/HZ05_occupation_wall_01", 
			FootprintType.WallMountAttachGround => "Dorm/Dormitory/HZ05_occupation_wall_floor_01", 
			_ => null, 
		};
	}

	public void OnSetVisible(bool visible)
	{
		if (visible != this.visible)
		{
			if (visible)
			{
				UpdateFootPrint();
			}
			else if (isCustomFootprintObj)
			{
				footprintObj.SetActive(value: false);
			}
			else
			{
				PooledAsset.DestroyOrReturn(footprintObj);
			}
			this.visible = visible;
		}
	}

	public void OnFootprintTypeChange(FootprintType type)
	{
		if (this.type != type)
		{
			this.type = type;
			if (visible)
			{
				UpdateFootPrint();
			}
		}
	}

	public void OnFootprintSizeChange(Vector3Int size)
	{
		this.size = size;
		if (visible && (bool)footprintObj && !isCustomFootprintObj)
		{
			footprintObj.transform.localScale = GetSize(type, size);
		}
	}

	private static Vector3 GetSize(FootprintType type, Vector3Int size)
	{
		if (type == FootprintType.Floor)
		{
			return new Vector3(size.x, size.z, size.y);
		}
		return size;
	}

	private void UpdateFootPrint()
	{
		if (isCustomFootprintObj)
		{
			footprintObj.SetActive(value: true);
			return;
		}
		if ((bool)footprintObj)
		{
			PooledAsset.DestroyOrReturn(footprintObj);
		}
		string prefabPathByType = GetPrefabPathByType(type);
		if (!string.IsNullOrEmpty(prefabPathByType))
		{
			footprintObj = Asset.Instantiate(prefabPathByType);
		}
		if ((bool)footprintObj)
		{
			footprintObj.transform.SetParent(base.transform);
			footprintObj.transform.localPosition = new Vector3(0f, 0.01f, 0.01f);
			footprintObj.transform.localRotation = Quaternion.identity;
			footprintObj.transform.localScale = GetSize(type, size);
			footprintRenderers = footprintObj.transform.GetComponentsInChildren<Renderer>();
			UpdateColorProp();
		}
	}

	public void UseCustomFootprint(MeshRenderer renderer)
	{
		isCustomFootprintObj = true;
		if (footprintObj != renderer.gameObject)
		{
			footprintObj = renderer.gameObject;
			footprintRenderers = footprintObj.transform.GetComponentsInChildren<Renderer>();
			footprintObj.SetActive(visible);
		}
	}

	public void SetColor(Color color)
	{
		if (this.color != color)
		{
			this.color = color;
			if (visible)
			{
				UpdateColorProp();
			}
		}
	}

	private void UpdateColorProp()
	{
		MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
		Renderer[] array = footprintRenderers;
		foreach (Renderer obj in array)
		{
			obj.GetPropertyBlock(materialPropertyBlock);
			materialPropertyBlock.SetColor("_Color", color);
			obj.SetPropertyBlock(materialPropertyBlock);
		}
	}
}
