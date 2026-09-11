using System;
using System.Collections.Generic;
using ChessBoard;
using UnityEngine;

public class ChessBoardLuaBridge
{
	public static void InitChessBoardConfigData(ChessBoardConfigData chessBoardConfigData)
	{
		ChessBoardMapCfgManager.Instance.SetGridConfig(chessBoardConfigData.GridConfig);
		ChessBoardMapCfgManager.Instance.SetThingConfig(chessBoardConfigData.ThingConfig);
	}

	public static void Launcher(ChessBoardDataForExchange chessDataForExchange, Action callback)
	{
		callback?.Invoke();
		ChessBoardScene chessBoardScene = NScene.Load<ChessBoardScene>();
		chessBoardScene.SetMapId(chessDataForExchange.mapId);
		ChessBoardMapCfgManager.Instance.SetMapConfig(chessDataForExchange.MapConfig);
		chessBoardScene.SetMapChangeData(chessDataForExchange.mapInfoS, chessDataForExchange.thingInfoS, chessDataForExchange.banDirInfoS);
		ChessBoardNPCManager.Instance.SetNPCInitData(chessDataForExchange.NPCInfos);
		chessBoardScene.bronPos = new Int2((int)chessDataForExchange.bronPos.x, (int)chessDataForExchange.bronPos.y);
		chessBoardScene.direction = chessDataForExchange.direction;
	}

	public static void SetInputEnable(bool isEnable)
	{
		ChessBoardInputManager.Instance.IsEnableInput = isEnable;
	}

	public static void LookAtPlayer(Action callBack = null)
	{
		ChessBoardCameraManager.Instance.LookAtPlayer(callBack);
	}

	public static List<ChessBoardGridData> FindNextMovePos(int x, int z, int dir)
	{
		List<ChessBoardGridData> list = new List<ChessBoardGridData>();
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		int num = (dir + 3) % 6;
		List<Int2> rangeNodeS = ChessBoardHelper.GetRangeNodeS(x, z, 1);
		for (int i = 0; i < rangeNodeS.Count; i++)
		{
			if (rangeNodeS[i].x != x || rangeNodeS[i].y != z)
			{
				ChessBoardHexEntity chessBoardHexEntity2 = ChessBoardHexManager.Instance.FindEntity(rangeNodeS[i].x, rangeNodeS[i].y);
				int offsetx = rangeNodeS[i].x - x;
				int offsetz = rangeNodeS[i].y - z;
				int dirByOffset = ChessBoardHelper.GetDirByOffset(offsetx, offsetz);
				if (chessBoardHexEntity2.gridData.walkable && dirByOffset != num && !chessBoardHexEntity.gridData.banDir[dirByOffset])
				{
					list.Add(chessBoardHexEntity2.gridData);
				}
			}
		}
		return list;
	}

	public static void ExitChessBoard()
	{
	}

	public static void MoveHeroToPos(int x, int z, Action callBack)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		ChessBoardScene obj = NScene.GetCurrentScene() as ChessBoardScene;
		Vector3 vector = (Vector3)chessBoardHexEntity.gridNode.position;
		vector = vector.NewY(chessBoardHexEntity.gridData.offsetY);
		obj.hexGridCoord.heroEntity.MoveTo(vector, x, z, callBack);
	}

	public static ChessBoardGridData GetGridData(int x, int z)
	{
		return ChessBoardHexManager.Instance.FindEntity(x, z)?.gridData;
	}

	public static void SetSelectingMovePos(bool isSelecting)
	{
		(NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.isSelectingMovePos = isSelecting;
	}

	public static void SetSelectingNPCMovePos(bool isSelecting)
	{
		(NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.isSelectingNpc = isSelecting;
	}

	public static void SetSelectingMapPos(bool isSelecting)
	{
		(NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.isSelectingMapPos = isSelecting;
	}

	public static void ChangeGridByIndex(int x, int z, int extendIndex, bool isInheritDir, Action callBack = null)
	{
		ChessBoardMapData chessBoardMapData = (NScene.GetCurrentScene() as ChessBoardScene).mapData.chessBoardMapData;
		ChessBoardHexManager.Instance.ChangeGrid(x, z, new ChessBoardGridData(chessBoardMapData.extendInfo[extendIndex - 1]), isInheritDir, isExtend: true, callBack);
	}

	public static void ChangeThingByIndex(int x, int z, int extendIndex, Action callBack = null)
	{
		ChessBoardMapData chessBoardMapData = (NScene.GetCurrentScene() as ChessBoardScene).mapData.chessBoardMapData;
		ChessBoardHexManager.Instance.ChangeThing(x, z, new ChessBoardGridData(chessBoardMapData.thingExtendInfo[extendIndex - 1]), isExtend: true, callBack);
	}

	public static void DeleteThing(int x, int z, Action callBack = null)
	{
		ChessBoardHexManager.Instance.DeleteThing(x, z, callBack);
	}

	public static void SetCameraControlEnable(bool isEnable)
	{
		ChessBoardCameraManager.Instance.IsEnableControl = isEnable;
	}

	public static void AddNPC(int NPCID, int x, int z, int dir, string prefab, int actionType)
	{
		ChessBoardNPCManager.Instance.AddNPC(NPCID, x, z, dir, prefab, actionType);
	}

	public static void DeleteNPC(int NPCID)
	{
		ChessBoardNPCManager.Instance.DeleteNPC(NPCID);
	}

	public static void NPCMoveTo(int NPCID, int x, int z, Action callBack = null)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		ChessBoardNPCManager.Instance.NPCMoveTo(NPCID, (Vector3)chessBoardHexEntity.gridNode.position, x, z, callBack);
	}

	public static void PlayGridAnimation(int x, int z, string ani, int target, Action func = null)
	{
		ChessBoardHexManager.Instance.PlayGridAnimation(x, z, ani, target, func);
	}

	public static void ShowArrowEffect(int x, int z, int dir)
	{
		ChessBoardEffectManager.Instance.ShowNormalArrow(x, z, dir);
	}

	public static void ShowMultArrowEffect(int x, int z, int dir)
	{
		ChessBoardEffectManager.Instance.ShowMultArrowEffect(x, z, dir);
	}

	public static void ShowChoiceEffect(int x, int z)
	{
		ChessBoardEffectManager.Instance.ShowChoiceEffect(x, z);
	}

	public static void ShowTranferEffect(int x, int z)
	{
		ChessBoardEffectManager.Instance.ShowTranferEffect(x, z);
	}

	public static void ClearMoveEffect()
	{
		ChessBoardEffectManager.Instance.ClearMoveEffect();
	}

	public static void ClearChoiceEffect()
	{
		ChessBoardEffectManager.Instance.ClearChoiceEffect();
	}

	public static void ClearTranferEffect()
	{
		ChessBoardEffectManager.Instance.ClearTranferEffect();
	}

	public static void PlayEntityAction(int entityID, int actionType)
	{
		if (entityID == 0)
		{
			(NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.PlayAction(actionType);
		}
		else
		{
			ChessBoardNPCManager.Instance.PlayNPCAction(entityID, actionType);
		}
	}

	public static void PlayEntityOverlap(int entityID, bool isShow)
	{
		if (entityID == 0)
		{
			(NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.SetOverlapState(Value: true);
		}
		else
		{
			ChessBoardNPCManager.Instance.PlayNPCOverlap(entityID, isShow);
		}
	}

	public static void SetHeroPosAndDir(int x, int z, int dir)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		ChessBoardScene obj = NScene.GetCurrentScene() as ChessBoardScene;
		Vector3 vector = (Vector3)chessBoardHexEntity.gridNode.position;
		vector = vector.NewY(chessBoardHexEntity.gridData.offsetY);
		obj.hexGridCoord.heroEntity.SetHeroPosAndDir(vector, dir, x, z);
	}

	public static void SetNPCPosAndDir(int NPCID, int x, int z, int dir)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		Vector3 vector = (Vector3)chessBoardHexEntity.gridNode.position;
		vector = vector.NewY(chessBoardHexEntity.gridData.offsetY);
		ChessBoardNPCManager.Instance.SetNPCPosAndDir(NPCID, vector, dir, x, z);
	}

	public static Vector3 GetHeroTransPos()
	{
		return (NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.gameObject.transform.position;
	}

	public static Vector3 GetNPCTransPos(int NPCID)
	{
		return ChessBoardNPCManager.Instance.GetNPCTransPos(NPCID);
	}

	public static Transform GetHeroTrans()
	{
		return (NScene.GetCurrentScene() as ChessBoardScene).hexGridCoord.heroEntity.gameObject.transform;
	}

	public static void ChangeCameraToDiceCamera()
	{
		ChessBoardCameraManager.Instance.ChangeCameraToDiceCamera();
	}

	public static void ChangeCameraToCloseCamera()
	{
		ChessBoardCameraManager.Instance.ChangeCameraToCloseCamera();
	}

	public static ChessBoardSmallMapData GetCurSmallMapData()
	{
		return ChessBoardHexManager.Instance.GetCurSmallMapData();
	}

	public static void MoveTargetSmooth(int x, int z, Action callBack = null, bool isUniform = true, float speed = 10f, bool _force = true)
	{
		Vector3 vec = ChessBoardHexManager.Instance.FindEntity(x, z).gridNode.position.vec3;
		ChessBoardCameraManager.Instance.MoveTargetSmooth(vec, speed, _force, callBack, isUniform);
	}

	public static void SetNPCToCameraTarget(int NPCID)
	{
		ChessBoardNPCManager.Instance.SetNPCToCameraTarget(NPCID);
	}

	public static void SetStepEffectActive(int x, int z, bool active)
	{
		NScene.GetCurrentScene();
		if (active)
		{
			if (ChessBoardEffectManager.Instance.stepEffect == null)
			{
				ChessBoardEffectManager.Instance.stepEffect = Asset.Instantiate("ChessBoard/Effects/fx_zhanqi_step");
			}
			ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
			Vector3 vector = (Vector3)chessBoardHexEntity.gridNode.position;
			vector = vector.NewY(chessBoardHexEntity.gridData.offsetY);
			ChessBoardEffectManager.Instance.stepEffect.transform.position = vector;
			ChessBoardEffectManager.Instance.stepEffect.SetActive(value: true);
		}
		else if (ChessBoardEffectManager.Instance.stepEffect != null)
		{
			ChessBoardEffectManager.Instance.stepEffect.SetActive(value: false);
		}
	}

	public static void ShowNPCDestoryEffectActive(int x, int z)
	{
		ChessBoardEffectManager.Instance.ShowNPCDestoryEffectActive(x, z);
	}

	public static void ClearNPCDestoryEffect()
	{
		ChessBoardEffectManager.Instance.ClearNPCDestoryEffect();
	}

	public static void ShowAllThingChoiceEffect()
	{
		ChessBoardHexManager.Instance.ShowAllThingChoiceEffect();
	}

	public static void ShowAllNoThingGridChoiceEffect(int curX, int curZ)
	{
		ChessBoardHexManager.Instance.ShowAllNoThingGridChoiceEffect(curX, curZ);
	}

	public static void ChangeSpeedModule(bool isFast)
	{
		ChessBoardScene chessBoardScene = NScene.GetCurrentScene() as ChessBoardScene;
		if (isFast)
		{
			chessBoardScene.hexGridCoord.heroEntity.roleSpeed = 4f;
			chessBoardScene.hexGridCoord.heroEntity.m_animator.speed = 2f;
			ChessBoardNPCManager.Instance.ChangeSpeedModule(isFast);
		}
		else
		{
			chessBoardScene.hexGridCoord.heroEntity.roleSpeed = 2f;
			chessBoardScene.hexGridCoord.heroEntity.m_animator.speed = 1f;
			ChessBoardNPCManager.Instance.ChangeSpeedModule(isFast);
		}
	}

	public static bool CheckHaveThingCanDestory()
	{
		return ChessBoardHexManager.Instance.CheckHaveThingCanDestory();
	}
}
