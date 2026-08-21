using System;
using System.Collections.Generic;
using Dorm.Furniture;
using UnityEngine;
using UnityEngine.Serialization;

namespace Dorm;

public class RoomWallTag : MonoBehaviour
{
	public Vector3 originalPoint;

	[FormerlySerializedAs("titleType")]
	public TileType tileType;

	public int width;

	public int height;

	public int depth;

	public static Transform mainCameraTrs;

	public MeshRenderer meshRenderer;

	public MeshRenderer gridMeshRenderer;

	[SerializeField]
	internal Collider collider;

	public Vector3 defaultSetPoint;

	[NonSerialized]
	[HideInInspector]
	public bool isShow;

	private bool colliderActive;

	[NonSerialized]
	[HideInInspector]
	public float currentDot;

	[HideInInspector]
	[SerializeField]
	public List<SceneDitherControl> sceneDitherControls;

	public static float wallHideDot;

	public Vector3 originalPointWorldPos => base.transform.TransformPoint(originalPoint);

	public bool? OverrideShowGridRenderer { get; set; }

	private void Start()
	{
		if (!collider)
		{
			collider = GetComponent<Collider>();
		}
		sceneDitherControls = new List<SceneDitherControl>();
		SceneDitherControl component = GetComponent<SceneDitherControl>();
		if ((bool)component)
		{
			sceneDitherControls.Add(component);
		}
		if ((bool)DormRoomManager.Instance)
		{
			SceneDitherControl component2 = DormRoomManager.Instance.GetTrsByType(tileType).GetComponent<SceneDitherControl>();
			if ((bool)component2)
			{
				sceneDitherControls.Add(component2);
			}
		}
	}

	private void Update()
	{
		if (!Application.isPlaying || !(mainCameraTrs != null))
		{
			return;
		}
		TileType tileType = this.tileType;
		if ((uint)(tileType - 1) <= 4u)
		{
			currentDot = Vector3.Dot(mainCameraTrs.forward, base.transform.forward);
			isShow = currentDot < wallHideDot;
		}
		else
		{
			isShow = true;
		}
		foreach (SceneDitherControl sceneDitherControl in sceneDitherControls)
		{
			sceneDitherControl.FadeDitherAlpha = (isShow ? 1 : 0);
		}
		collider.enabled = colliderActive && isShow;
		UpdateGridMeshRender(isShow);
	}

	private void UpdateGridMeshRender(bool isMainShow)
	{
		if (!(gridMeshRenderer == null))
		{
			if (!isMainShow)
			{
				gridMeshRenderer.enabled = false;
			}
			else
			{
				gridMeshRenderer.enabled = UpdateGridMeshRendererEnabled();
			}
		}
	}

	private bool UpdateGridMeshRendererEnabled()
	{
		if (OverrideShowGridRenderer.HasValue)
		{
			return OverrideShowGridRenderer.Value;
		}
		FurnitureEntity furnitureEntity = FurnitureManager.Instance?.editingFurniture;
		if (furnitureEntity != null)
		{
			if (tileType == TileType.FLOOR)
			{
				return furnitureEntity.TileType == TileType.FLOOR;
			}
			if (tileType != TileType.CEIL)
			{
				return DormLuaBridge.IsWallTileType(furnitureEntity.TileType);
			}
			return false;
		}
		return false;
	}

	internal void SetColliderActive(bool v)
	{
		colliderActive = v;
		collider.enabled = colliderActive && isShow;
	}
}
