using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public interface ILevelSaveService
{
	UniTask<bool> RequestData();

	IMessenger GetMessager();

	List<int> GetBonfireActiveList(int levelId);

	void GetMapItemDatas(int levelId, List<LevelSaveService.MapItemViewData> mapItemDatas);

	UniTask<bool> UpdateBonfireMapMaskState(int levelId, int bonfireId, long mapMask = 0L);

	bool GetBornfireIsActive(int levelId, int bornfireId);

	bool GetTreasureIsOpen(int levelId, int mapItemUid);

	LevelSaveService.MapItemData InitMapItemData(int levelId, MapItemNode node, bool isSave);

	void UpdateMapItemDataParadoxData(int levelId, int uid, string key, MapDataNodeParadoxParameter value);

	void UpdateMapItemDataParadoxDatas(int levelId, int uid, Dictionary<string, MapDataNodeParadoxParameter> paradoxs);

	void UpdateMapItemDataIconType(int levelId, int uid, int iconType);

	void UpdateMapItemActiveState(int levelId, int uid, int active);

	void ExcuteMapItemUpdateAction(int levelId, int uid);

	void UpdateMapDataNodeState(int levelId, int uid, MapDataNodeState mapDataNodeState);

	LevelSaveService.NpcData GetNpcData(int levelId, int uid);

	LevelSaveService.NpcData InitNpcData(int levelId, NPCNode node, Dictionary<int, string> dialogButtonLockState, List<int> prologueIds, List<DialogueChainConfig.DialogueButtonConfig> dialogButtonConfigs);

	void UpdateNpcActiveState(int levelId, int npcNodeUid, bool active);

	void UpdateNpcDialogPrologue(int levelId, int npcNodeUid, List<int> dialogPrologue);

	void UpdateNpcData(int levelId, int npcNodeUid, List<DialogueChainConfig.DialogueButtonConfig> dialogButtonGroup);

	void ExcuteNpcUpdateAction(int levelId, int uid);

	void UpdateDialogueButtonState(int levelId, int uId, int buttonId, string state);

	void UpdateNpcParadoxData(int levelId, int npcNodeUid, string key, MapDataNodeParadoxParameter value);

	void AddMapItemOnUpdateAction(int levelId, LevelSaveService.MapItemData mapItemData, Action<LevelSaveService.MapItemData> onUpdateAction);

	void RemoveMapItemOnUpdateAction(LevelSaveService.MapItemData mapItemData);

	void AddNpcDataOnUpdateAction(int levelId, LevelSaveService.NpcData npcData, Action<LevelSaveService.NpcData> onUpdateAction);

	void UpdateNpcParadoxDatas(int levelId, int uid, Dictionary<string, MapDataNodeParadoxParameter> paradoxs);

	void RemoveNpcDataOnUpdateAction(LevelSaveService.NpcData npcData);

	void UpdateNormalPlatformData(int levelId, int platformId, bool isPause, float time, AnimationCurve xCurData, AnimationCurve yCurData, AnimationCurve zCurData, int warpMode, Vector3 pos, Vector3 angle, Vector3 scale);

	LevelSaveService.NormalPlatformData GetNormalPlatformData(int levelId, int platformId);

	long GetMonsterLastDieTime(int levelId, int uid);

	void UpdateMonsterDieTime(int levelId, int uid);

	long GetMonsterGroupLastAllDieTime(int levelId, int uid);

	void UpdateMonsterGroupAllDieTime(int levelId, int uid);

	UniTask EnterLevelGetSaveData(int levelId);

	UniTask SaveLevelData(int levelId);

	void DownLoadData();

	int[,] GetMapMaskData(int levelId);

	UniTask ChangeMapMaskData(int levelId, int index, int value);

	bool GetMapMaskIndexUnLock(int levelId, int index);

	void SetMechanismData(int levelId, int uId, int state);

	void UpdateRockerControlValue(int levelId, int rockerId, int rockerValue);

	int GetRockerControlValue(int levelId, int rockerId);

	LevelSaveService.MechanismData GetMechanismData(int levelId, int uId);

	void SetTriggerData(int levelId, int uId, int executeTime);

	LevelSaveService.TriggerData GetTriggerData(int levelId, int uId);

	bool GetIsTeachGuide(int guideId);

	bool GetFinishTeachGuide(int guideId);

	void TeachGuideDataChangeSave(int guideId, bool isAdd);

	List<int> GetAllTeachGuide();

	void ActiveCaves(int levelId, int cavesId);

	void GetActiveCaves(int levelId, List<int> cavesId);

	void QuitLevel();

	void DeleteSaveData();

	void OpenTreasureSave(int levelId, int uid);

	void UpdateMaskData(int levelId, long value);

	void Dispose();
}
