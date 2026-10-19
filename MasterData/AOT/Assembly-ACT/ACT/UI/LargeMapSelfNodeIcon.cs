using ACT.World;
using Bamboo.ImageCenter;
using DG.Tweening;
using UnityEngine;

namespace ACT.UI;

public class LargeMapSelfNodeIcon : LargeMapIcon
{
	public BImage selfNodeIcon;

	public RectTransform accurateSelectCircle;

	private int _selfNodeId;

	private int _selfNodeIconTypeId;

	private ImageAssetStation _imageAssetStation;

	private SelfNodeData _nodeData;

	private bool _canDelete;

	private float _fixedScale;

	public bool CanDelete
	{
		get
		{
			return _canDelete;
		}
		set
		{
			_canDelete = value;
		}
	}

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
		UpdateImageScale();
		CanDelete = false;
	}

	public void Init(int selfNodeId, int iconTypeId, Vector3 worldPos, MapArea area, ImageAssetStation imageAssetStation)
	{
		_selfNodeId = selfNodeId;
		_selfNodeIconTypeId = iconTypeId;
		base.worldPos = worldPos;
		mapArea = area;
		_imageAssetStation = imageAssetStation;
		type = MapIconType.SelfPoint;
		_nodeData = new SelfNodeData
		{
			id = selfNodeId,
			iconTypeId = iconTypeId,
			worldPos = worldPos,
			mapArea = area
		};
		LoadSprite(iconTypeId);
		UpdateImageScale();
		CanDelete = false;
	}

	public void Init(int selfNodeId, ImageAssetStation imageAssetStation)
	{
		_selfNodeId = selfNodeId;
		_selfNodeIconTypeId = selfNodeId;
		_imageAssetStation = imageAssetStation;
		type = MapIconType.SelfPoint;
		LoadSprite(selfNodeId);
	}

	public void SetFixedScale(float fixedScale)
	{
		_fixedScale = fixedScale;
	}

	public override void UpdateScale(float mapScale)
	{
		SetScale(_fixedScale / mapScale);
		SetIsFade(mapScale <= 0.33f);
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
		CanDelete = false;
	}

	public override void AccurateSelectEffect()
	{
		base.AccurateSelectEffect();
		accurateSelectCircle.DOScale(Vector3.one, 0.1f).OnPlay(() =>
		{
			accurateSelectCircle.gameObject.SetActive(value: true);
		}).ChangeStartValue(Vector3.zero)
			.SetEase(Ease.InOutBack);
		CanDelete = true;
	}

	public override void DeAccurateSelectEffect()
	{
		base.DeAccurateSelectEffect();
		accurateSelectCircle.gameObject.SetActive(value: false);
		accurateSelectCircle.localScale = Vector3.one;
		CanDelete = false;
	}

	public override void SetIsFade(bool fade)
	{
		base.SetIsFade(fade);
		transform.gameObject.SetActive(!fade);
	}

	public override void VagueSelectEffect()
	{
		base.VagueSelectEffect();
		accurateSelectCircle.DOScale(Vector3.one * 1.5f, 0.1f).OnPlay(() =>
		{
			accurateSelectCircle.gameObject.SetActive(value: true);
		}).ChangeStartValue(Vector3.zero)
			.SetEase(Ease.InOutBack);
	}

	public override void DeVagueSelectEffect()
	{
		base.DeVagueSelectEffect();
		accurateSelectCircle.gameObject.SetActive(value: false);
		accurateSelectCircle.localScale = Vector3.one;
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
}
