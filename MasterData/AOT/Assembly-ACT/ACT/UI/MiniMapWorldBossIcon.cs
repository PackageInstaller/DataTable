using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MiniMapWorldBossIcon : MiniMapNormalIcon
{
	public GameObject InTrace;

	public GameObject IsDisabled;

	public GameObject IsExplored;

	private int _uid;

	private int _worldBossId;

	private MapSubArea _subArea;

	private int _collectionUid;

	private int _monsterIcon;

	public int GetUid()
	{
		return _uid;
	}

	public int GetWorldBossId()
	{
		return _worldBossId;
	}

	public int GetCollectionUid()
	{
		return _collectionUid;
	}

	public MapSubArea GetSubArea()
	{
		return _subArea;
	}

	public void Init(BakeStaticMapIconData data, ACT.World.MapArea area)
	{
		_uid = data.uid;
		type = MapIconType.WorldBoss;
		_worldBossId = data.worldBossId;
		mapArea = area;
		worldPos = data.initPos;
		_subArea = (MapSubArea)data.subAreaId;
		_collectionUid = (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(_uid) as MonsterPointData)?.GetWildBossCollectionUid();
		EntityEnemyData data2 = CoreUtils.GetData(CoreUtils.DetermineActualMonster(data.worldBossId), RuntimeConfigs.data.entityEnemyDatas);
		LoadSprite(data2.monsterIcon);
		UpdateImageScale();
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, spriteId, normalAtlasImage);
	}

	public void RefreshState()
	{
		if (IsDisabled.gameObject.activeSelf)
		{
			SetLockStatusMask(isUnlock: true);
			return;
		}
		bool lockStatusMask = Model<WildBossModel>.Interface.CheckWildBossCanBattle(_worldBossId);
		SetLockStatusMask(lockStatusMask);
	}

	private void SetLockStatusMask(bool isUnlock)
	{
		Material material = new Material(normalAtlasImage.icon.material);
		material.SetFloat("_DeSaturate", isUnlock ? 0f : 1f);
		normalAtlasImage.icon.material = material;
	}

	public void SetIsExplored(bool isActive)
	{
		IsExplored.SetActive(isActive);
		IsDisabled.SetActive(!isActive);
	}

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		if (InTrace != null)
		{
			InTrace.SetActive(isTrack);
		}
	}
}
