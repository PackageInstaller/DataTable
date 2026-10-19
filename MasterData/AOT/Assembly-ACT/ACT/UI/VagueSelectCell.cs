using ACT.Config;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class VagueSelectCell : MonoBehaviour
{
	public BImage iconAtlasImage;

	public BImage iconImage;

	public LocalizeStringEvent nameLocalize;

	public Button btn;

	public void Init(LargeMapIcon icon, UnityAction<LargeMapIcon> clickAction, ImageAssetStation _imageAssetStation = null)
	{
		if (icon is LargeMapInteractObjIcon largeMapInteractObjIcon)
		{
			if (largeMapInteractObjIcon.type == MapIconType.WorldBoss)
			{
				SetBossInfo(largeMapInteractObjIcon.GetWorldBossId());
			}
			else
			{
				LoadInteractObjSprite(MapUtility.GetInteractObjSpriteId(largeMapInteractObjIcon.GetSwId()));
				IconData data = CoreUtils.GetData(largeMapInteractObjIcon.GetIconDataId(), RuntimeConfigs.data.iconDatas);
				nameLocalize.StringReference.TableEntryReference = data.nameLocal;
			}
		}
		else if (icon is LargeMapSelfNodeIcon largeMapSelfNodeIcon)
		{
			_imageAssetStation?.LoadImage(181, largeMapSelfNodeIcon.GetSelfNodeIconTypeId(), iconImage);
			SubIconData data2 = CoreUtils.GetData(largeMapSelfNodeIcon.GetSelfNodeIconTypeId(), RuntimeConfigs.data.subIconDatas);
			nameLocalize.StringReference.TableEntryReference = data2.name;
		}
		else if (icon is LargeMapReceiveSideMissionIcon largeMapReceiveSideMissionIcon)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, largeMapReceiveSideMissionIcon.GetSpriteId(), iconAtlasImage);
			MissionBase missionBase = Singleton<MissionManager>.instance.GetMissionConfig(largeMapReceiveSideMissionIcon.GetMissionId()).MissionBase;
			nameLocalize.StringReference.TableEntryReference = missionBase.name;
		}
		else if (icon is LargeMapNpcIcon largeMapNpcIcon)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.interactIconNameAssetID, largeMapNpcIcon.GetSpriteId(), iconAtlasImage);
			NpcConfig data3 = CoreUtils.GetData(largeMapNpcIcon.GetSwId(), RuntimeConfigs.data.npcConfigs);
			nameLocalize.StringReference.TableEntryReference = data3.name;
		}
		else if (icon is LargeMapMissionIcon largeMapMissionIcon)
		{
			LoadMissionSprite(largeMapMissionIcon.GetSpriteId());
			MissionBase data4 = CoreUtils.GetData(largeMapMissionIcon.GetMissionId(), RuntimeConfigs.data.missionBases);
			if (data4 != null)
			{
				nameLocalize.StringReference.TableEntryReference = data4.name;
			}
		}
		else if (icon is LargeMapReceiveSideMissionIcon largeMapReceiveSideMissionIcon2)
		{
			iconAtlasImage.icon.sprite = largeMapReceiveSideMissionIcon2.normalAtlasImage.icon.sprite;
			MissionBase data5 = CoreUtils.GetData(largeMapReceiveSideMissionIcon2.GetMissionId(), RuntimeConfigs.data.missionBases);
			if (data5 != null)
			{
				nameLocalize.StringReference.TableEntryReference = data5.name;
			}
		}
		else if (icon is LargeMapWorldBossIcon largeMapWorldBossIcon)
		{
			EntityData data6 = CoreUtils.GetData(CoreUtils.DetermineActualMonster(largeMapWorldBossIcon.GetWorldBossId()), RuntimeConfigs.data.entityDatas);
			if (largeMapWorldBossIcon.IsExplored.activeSelf)
			{
				iconAtlasImage.icon.sprite = largeMapWorldBossIcon.normalAtlasImage.icon.sprite;
				nameLocalize.StringReference.SetReference("shortcommon", data6.nameLocal);
			}
			else
			{
				iconAtlasImage.icon.sprite = largeMapWorldBossIcon.IsDisabled.GetComponent<Image>().sprite;
				nameLocalize.StringReference.SetReference("Common", LocalizationCommonData.CommonString.UnknowEnemy);
			}
		}
		else if (icon is LargeMapMonsterPointIcon largeMapMonsterPointIcon)
		{
			LoadMonsterSprite(Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(largeMapMonsterPointIcon.GetEnemyId()));
			nameLocalize.StringReference.TableEntryReference = Model<MaterialTrackModel>.Interface.GetMonsterTypeName(largeMapMonsterPointIcon.GetEnemyId());
		}
		else if (icon is LargeMapCollectionPointIcon largeMapCollectionPointIcon)
		{
			LoadCollectionSprite();
			CollectionPoint data7 = CoreUtils.GetData(largeMapCollectionPointIcon.GetConfigId(), RuntimeConfigs.data.collectionPoints);
			nameLocalize.StringReference.TableEntryReference = data7.pointName;
		}
		btn.onClick.AddListener(() =>
		{
			clickAction(icon);
		});
	}

	private void SetBossInfo(int worldBossId)
	{
		WorldBossMonster data = CoreUtils.GetData(worldBossId, RuntimeConfigs.data.worldBossMonsters);
		EntityData data2 = CoreUtils.GetData(data.worldBossID, RuntimeConfigs.data.entityDatas);
		EntityEnemyData data3 = CoreUtils.GetData(data.worldBossID, RuntimeConfigs.data.entityEnemyDatas);
		LoadBossSprite(data3.monsterIcon);
		nameLocalize.StringReference.TableEntryReference = data2.nameLocal;
	}

	private void LoadInteractObjSprite(int spriteId)
	{
		this.GetImageStation().LoadSpriteAsync(GameLoader.meta.mapIconNameAssetID, spriteId, iconAtlasImage).Forget();
	}

	private void LoadBossSprite(int spriteId)
	{
		this.GetImageStation().LoadSpriteAsync(GameLoader.meta.monsterheadiconAtlasAssetID, spriteId, iconAtlasImage).Forget();
	}

	private void LoadMissionSprite(int spriteId)
	{
		if (spriteId >= 0)
		{
			this.GetImageStation().LoadImage(200, spriteId, iconAtlasImage);
		}
	}

	private void LoadMonsterSprite(int spriteId)
	{
		if (spriteId >= 0)
		{
			this.GetImageStation().LoadSpriteAsync(GameLoader.meta.monsterheadiconAtlasAssetID, spriteId, iconAtlasImage).Forget();
		}
	}

	private void LoadCollectionSprite()
	{
		this.GetImageStation().LoadSpriteAsync(GameLoader.meta.mapIconNameAssetID, Model<TrackModel>.Interface.GetTrackCollectionSpriteId(), iconAtlasImage).Forget();
	}
}
