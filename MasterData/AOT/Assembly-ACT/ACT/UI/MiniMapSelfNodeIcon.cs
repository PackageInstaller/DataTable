using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class MiniMapSelfNodeIcon : MiniMapIcon
{
	public BImage selfNodeIcon;

	public GameObject InTrace;

	private int _selfNodeId;

	private int _selfNodeIconTypeId;

	private ImageAssetStation _imageAssetStation;

	private SelfNodeData _nodeData;

	public int GetSelfNodeId()
	{
		return _selfNodeId;
	}

	public override int GetId()
	{
		return _selfNodeId;
	}

	public int GetSelfNodeIconTypeId()
	{
		return _selfNodeIconTypeId;
	}

	public SelfNodeData GetNodeData()
	{
		return _nodeData;
	}

	public void Init(SelfNodeData nodeData, ImageAssetStation imageAssetStation)
	{
		_nodeData = nodeData;
		_selfNodeId = nodeData.id;
		_selfNodeIconTypeId = nodeData.iconTypeId;
		worldPos = nodeData.worldPos;
		mapArea = nodeData.mapArea;
		_imageAssetStation = imageAssetStation;
		type = MapIconType.SelfPoint;
		LoadSprite(_selfNodeIconTypeId);
		SetIsTrack(isTrack: false);
		UpdateImageScale();
	}

	public void ChangeIconType(int newIconTypeId)
	{
		_selfNodeIconTypeId = newIconTypeId;
		if (_nodeData != null)
		{
			_nodeData.iconTypeId = newIconTypeId;
		}
		LoadSprite(newIconTypeId);
	}

	public override void UnInit()
	{
		base.UnInit();
		_nodeData = null;
		_selfNodeId = 0;
		_selfNodeIconTypeId = 0;
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		_imageAssetStation?.LoadImage(181, spriteId, selfNodeIcon);
	}

	protected void UpdateImageScale()
	{
		if (selfNodeIcon?.icon != null)
		{
			selfNodeIcon.icon.transform.localScale = Vector3.one * GameLoader.meta.mapConfig.GetMapIconScale(type);
		}
	}

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		if (selfNodeIcon?.icon != null)
		{
			selfNodeIcon.icon.maskable = !isTrack;
			InTrace.SetActive(isTrack);
		}
	}
}
