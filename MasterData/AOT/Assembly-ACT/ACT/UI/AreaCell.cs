using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using ACT.World;
using ACT.World.Asset;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AreaCell : MonoBehaviour
{
	public ActButton btn;

	public BImage areaIcon;

	public GameObject missionHereGo;

	public BImage trackMissionTypeImage;

	public GameObject playerHereGo;

	public GameObject trackMonsterPointHere;

	public BImage trackMonsterPointAtlasImage;

	public GameObject selfTrackPointHere;

	public BImage selfTrackPointAtlasImage;

	public LocalizeStringEvent areaNameLocalize;

	public RedDotItem redDotItem;

	private UnityAction clickAction;

	private MapArea area;

	public void Init(bool missionHere, bool playerHere, bool selfTrackHere, bool trackSpecialPoint, ImageAssetStation station, UnityAction clickAction, MapArea mapArea = MapArea.None)
	{
		area = mapArea;
		if (area == MapArea.None)
		{
			return;
		}
		BindClickAction(clickAction);
		station.LoadImage(183, (int)area, areaIcon);
		areaNameLocalize.StringReference.TableEntryReference = CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas).name;
		missionHereGo.SetActive(missionHere);
		if (missionHere)
		{
			int tracingMission = Singleton<MissionManager>.instance.GetTracingMission();
			if (tracingMission != 0)
			{
				MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(tracingMission);
				this.GetImageStation().LoadImage(200, missionConfig.MissionType, trackMissionTypeImage);
			}
		}
		playerHereGo.SetActive(playerHere);
		trackMonsterPointHere.SetActive(trackSpecialPoint);
		if (trackSpecialPoint)
		{
			if (Model<TrackModel>.Interface.IsTrackingCollectionPoint)
			{
				this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, Model<TrackModel>.Interface.GetTrackCollectionSpriteId(), trackMonsterPointAtlasImage);
			}
			else if (Model<TrackModel>.Interface.IsTrackingMonsterPoint)
			{
				this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(Model<MaterialTrackModel>.Interface.GetTrackEnemyId()), trackMonsterPointAtlasImage);
			}
		}
		selfTrackPointHere.SetActive(selfTrackHere);
		if (selfTrackHere)
		{
			MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
			switch (currentTraceMapPoint.iconType)
			{
			case MapIconType.SelfPoint:
			{
				SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(currentTraceMapPoint.pointId);
				this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, selfNode.iconTypeId, selfTrackPointAtlasImage);
				break;
			}
			case MapIconType.WorldBoss:
			{
				MonsterPointData monsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(currentTraceMapPoint.pointId) as MonsterPointData;
				bool flag = Model<MonsterHandModel>.Interface.WildBossUnLock(monsterPointData.monsterPointId);
				HashSet<BakeStaticMapIconData> mapIconDataBy = MapUtility.ConfigWorldMapGraph.GetMapIconDataBy(currentTraceMapPoint.mapArea);
				if (mapIconDataBy == null)
				{
					break;
				}
				foreach (BakeStaticMapIconData item in mapIconDataBy)
				{
					if (item.uid == currentTraceMapPoint.pointId)
					{
						int monsterIcon = CoreUtils.GetData(CoreUtils.DetermineActualMonster(item.worldBossId), RuntimeConfigs.data.entityEnemyDatas).monsterIcon;
						this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, flag ? monsterIcon : 99, selfTrackPointAtlasImage);
						break;
					}
				}
				break;
			}
			case MapIconType.Npc:
			{
				if (Model<MapModel>.Interface.MapNpcIdToSpriteId.TryGetValue(currentTraceMapPoint.pointId, out var value))
				{
					this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, value, selfTrackPointAtlasImage);
				}
				else
				{
					selfTrackPointHere.SetActive(value: false);
				}
				break;
			}
			default:
				this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, MapUtility.GetInteractObjSpriteId(currentTraceMapPoint.pointId), selfTrackPointAtlasImage);
				break;
			}
		}
		string text = string.Format(RedDotPathDefine.MapExploreReward, (int)mapArea);
		redDotItem.redDotType = RedDotType.Dot;
		redDotItem.fullPath = text.Split("|").ToList();
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
	}

	public void UnInit()
	{
		trackMonsterPointAtlasImage.UnLoad();
		RemoveClickAction();
	}

	private void BindClickAction(UnityAction action)
	{
		if (clickAction != null)
		{
			btn.OnClick.RemoveListener(clickAction);
		}
		clickAction = action;
		btn.OnClick.AddListener(action);
	}

	private void RemoveClickAction()
	{
		if (clickAction != null)
		{
			btn.OnClick.RemoveListener(clickAction);
			clickAction = null;
		}
	}

	private void OnDestroy()
	{
		UnInit();
		RemoveClickAction();
	}
}
