using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class LargeMapWorldBossIcon : LargeMapNormalIcon
{
	public GameObject IsDisabled;

	public GameObject IsExplored;

	private int _uid;

	private int _iconDataId;

	private int _stateId;

	private int _worldBossId;

	private int _collectionUid;

	private MapSubArea _subArea;

	public void Init(BakeStaticMapIconData data, ACT.World.MapArea area)
	{
		_uid = data.uid;
		_iconDataId = data.iconDescId;
		type = MapIconType.WorldBoss;
		_worldBossId = data.worldBossId;
		mapArea = area;
		worldPos = data.initPos;
		_subArea = (MapSubArea)data.subAreaId;
		EntityEnemyData data2 = CoreUtils.GetData(CoreUtils.DetermineActualMonster(data.worldBossId), RuntimeConfigs.data.entityEnemyDatas);
		MonsterPointData monsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(_uid) as MonsterPointData;
		_collectionUid = ((monsterPointData != null) ? ((int)monsterPointData.GetWildBossCollectionUid()) : 0);
		_stateId = ((monsterPointData != null) ? MonoECS.instance.ruleManager.SharedGetState(_collectionUid) : 0);
		LoadSprite(data2.monsterIcon);
		UpdateImageScale();
		name = $"{type.ToString()}_{data.uid}";
	}

	protected override void LoadSprite(int spriteId)
	{
		base.LoadSprite(spriteId);
		this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, spriteId, normalAtlasImage);
	}

	public override int GetId()
	{
		return _uid;
	}

	public MapSubArea GetSubArea()
	{
		return _subArea;
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

	public int GetIconDataId()
	{
		return _iconDataId;
	}

	public int GetStateId()
	{
		return _stateId;
	}

	public int GetWorldBossId()
	{
		return _worldBossId;
	}
}
