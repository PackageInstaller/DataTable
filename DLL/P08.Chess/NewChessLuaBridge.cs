using System;
using System.Collections.Generic;
using NewChess;
using Pathfinding;
using UnityEngine;

public class NewChessLuaBridge
{
	public static void InitNewChessConfigData(NewChessConfigData newChessConfigData)
	{
		NewChessMapCfgManager.Instance.SetGridConfig(newChessConfigData.GridConfig);
		NewChessMapCfgManager.Instance.SetThingConfig(newChessConfigData.ThingConfig);
		NewChessMapCfgManager.Instance.SetConveyorIDList(newChessConfigData.ConveyorIDList);
		NewChessMapCfgManager.Instance.SetReverseConveyorIDList(newChessConfigData.ReverseConveyorIDList);
	}

	public static void Launcher(NewChessDataForExchange chessDataForExchange, Action callback)
	{
		callback?.Invoke();
		NewChessScene newChessScene = NScene.Load<NewChessScene>();
		newChessScene.SetMapId(chessDataForExchange.mapId);
		NewChessMapCfgManager.Instance.SetMapConfig(chessDataForExchange.MapConfig);
		newChessScene.SetMapData(chessDataForExchange.mapInfoS, chessDataForExchange.fogInfo);
		newChessScene.bronPos = new Int2((int)chessDataForExchange.bronPos.x, (int)chessDataForExchange.bronPos.y);
		newChessScene.direction = chessDataForExchange.direction;
		newChessScene.cacheAssetS = chessDataForExchange.cacheAssetS;
	}

	public static Vector2 GetCameraLookNearestNode()
	{
		Vector3 cameraLookAtPosition = NewHexCameraManager.Instance.GetCameraLookAtPosition();
		GridNode gridNode = NewHexGridCoord.astarPath.data.graphs[0].GetNearest((Int3)cameraLookAtPosition).node as GridNode;
		return new Vector2(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
	}

	public static void LookAtPlayer(Action callBack = null)
	{
		NewHexCameraManager.Instance.LookAtPlayer(callBack);
	}

	public static void MoveToCachePos()
	{
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.MoveToCachePos();
	}

	public static void ClearCachePath()
	{
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.ClearCachePath();
	}

	public static void RoleStopMove()
	{
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.RoleStopMove();
	}

	public static void ShowGridSelectEffect()
	{
		ABPath ab = (NScene.GetCurrentScene() as NewChessScene).hexGridCoord.ab;
		for (int i = 1; i < ab.path.Count; i++)
		{
			GridNode gridNode = ab.path[i] as GridNode;
			NewChessHelper.SetGridSelectOutline(NewHexManager.Instance.FindEntity(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid).rendererPosition);
		}
	}

	public static void ClearGridSelectEffect(int x, int z)
	{
		NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (newHexEntity != null && newHexEntity.go != null)
		{
			NewChessHelper.ClearGridSelectOutline(newHexEntity.rendererPosition);
		}
	}

	public static void ClearAllSelectEffect()
	{
		NewChessHelper.ClearAllSelectEffect();
	}

	public static void SetChessInputEnable(bool isEnable)
	{
		NewHexInputManager.Instance.IsEnableInput = isEnable;
	}

	public static NewGridData GetNewGridData(int x, int z)
	{
		return NewHexManager.Instance.FindEntity(x, z)?.gridData;
	}

	public static void MoveTargetSmooth(int x, int z, Action callBack = null, bool isUniform = true, float speed = 10f, bool _force = true)
	{
		Vector3 vec = NewHexManager.Instance.FindEntity(x, z).gridNode.position.vec3;
		NewHexCameraManager.Instance.MoveTargetSmooth(vec, speed, _force, callBack, isUniform);
	}

	public static void ChangeGridByIndex(int x, int z, int extendIndex, bool isInheritDir, Action callBack = null)
	{
		NewChessMapData chessMapData = (NScene.GetCurrentScene() as NewChessScene).mapData.chessMapData;
		NewHexManager.Instance.ChangeGrid(x, z, new NewGridData(chessMapData.extendInfo[extendIndex - 1]), isInheritDir, isExtend: true, callBack);
	}

	public static void ChangeGrid(int x, int z, NewGridData gridData, Action callBack = null)
	{
		NewHexManager.Instance.ChangeGrid(x, z, gridData, isInheritDir: false, isExtend: false, callBack);
	}

	public static void ChangeObjectByIndex(int x, int z, int extendIndex, Action callBack = null)
	{
		NewChessMapData chessMapData = (NScene.GetCurrentScene() as NewChessScene).mapData.chessMapData;
		NewHexManager.Instance.ChangeObject(x, z, new NewGridData(chessMapData.thingExtendInfo[extendIndex - 1]), isExtend: true, callBack);
	}

	public static void ChangeObject(int x, int z, NewGridData gridData, Action callBack = null)
	{
		NewHexManager.Instance.ChangeObject(x, z, gridData, isExtend: false, callBack);
	}

	public static void DeleteObject(int x, int z, Action callBack = null)
	{
		NewHexManager.Instance.DeleteObject(x, z, callBack);
	}

	public static void ChangeGridStatus(int x, int z, int status, Action func = null)
	{
		NewHexManager.Instance.ChangeGridStatus(x, z, status, func);
	}

	public static void OpenAreaFog(int x, int z, int length, Action func = null)
	{
		NewHexFogManager.Instance.OpenAreaFog(x, z, length, func);
	}

	public static void TelePortRoleToPosition(int x, int z, Action func = null)
	{
		NewChessScene obj = NScene.GetCurrentScene() as NewChessScene;
		NewChessHelper.ClearAllSelectEffect();
		obj.hexGridCoord.TelePortRoleToPosition(x, z, func);
	}

	public static void MoveConveyor(int x, int z, bool isReverse, Action func = null)
	{
		int num = NewChessHelper.GetDirByRotation((int)NewHexManager.Instance.FindEntity(x, z).gridData.rotationY);
		if (isReverse)
		{
			num += 3;
			num %= 6;
		}
		int x2 = x + NewHexGridCoord.mGridDirection[num].x;
		int z2 = z + NewHexGridCoord.mGridDirection[num].y;
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.RoleSlideToPos(x2, z2, func);
	}

	public static void JumpBoard(int x, int z, int length, int dir, Action func = null)
	{
		int x2 = x + NewHexGridCoord.mGridDirection[dir].x * length;
		int z2 = z + NewHexGridCoord.mGridDirection[dir].y * length;
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.RoleJumpToPos(x2, z2, func);
	}

	public static void SetCameraControlEnable(bool isEnable)
	{
		NewHexCameraManager.Instance.IsEnableControl = isEnable;
	}

	public static int GetPlayerDirection()
	{
		return NewChessHelper.GetDirectionByForward((NScene.GetCurrentScene() as NewChessScene).hexGridCoord.mRole.transform.forward);
	}

	public static void PlayGridAnimation(int x, int z, string ani, int target, Action func = null)
	{
		NewHexManager.Instance.PlayGridAnimation(x, z, ani, target, func);
	}

	public static void ExitNewWarChess()
	{
		NewChessHelper.ClearAllSelectEffect();
		NewHexFogManager.Instance.ClearCacheData();
	}

	public static void FixRolePositon()
	{
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.FixRolePosition();
	}

	public static void MoveRoleLogicPosition(int x, int z)
	{
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.MoveRoleLogicPosition(x, z);
	}

	public static void OpenBarFog(int x, int z, int dir, int length, Action callBack = null)
	{
		List<Int2> list = new List<Int2>();
		for (int i = 0; i < length; i++)
		{
			int x2 = x + NewHexGridCoord.mGridDirection[dir].x * i;
			int y = z + NewHexGridCoord.mGridDirection[dir].y * i;
			list.Add(new Int2(x2, y));
		}
		NewHexFogManager.Instance.OpenBarFog(list);
		callBack?.Invoke();
	}

	public static void FixRoleY(int subLayer, int fixtime)
	{
		float newY = (float)subLayer * NewChessHelper.m_layHeight;
		NewChessScene obj = NScene.GetCurrentScene() as NewChessScene;
		float fixtime2 = (float)fixtime / 1000f;
		obj.hexGridCoord.mRole.YMoveTo(newY, fixtime2);
	}

	public static void StopRoleMoving()
	{
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.StopRoleMoving();
	}

	public static void MoveByDir(int x, int z, int dir, Action func = null)
	{
		NewHexManager.Instance.FindEntity(x, z);
		dir %= 6;
		int x2 = x + NewHexGridCoord.mGridDirection[dir].x;
		int z2 = z + NewHexGridCoord.mGridDirection[dir].y;
		(NScene.GetCurrentScene() as NewChessScene).hexGridCoord.RoleSlipToPos(x2, z2, func);
	}

	public static void RotateGrid(int x, int z, float angle, float time = 2000f, Action callBack = null)
	{
		NewHexEntity hexEntity = NewHexManager.Instance.FindEntity(x, z);
		if (hexEntity == null || !(hexEntity.go != null))
		{
			return;
		}
		hexEntity.gridData.rotationY += angle;
		LeanTween.rotateY(hexEntity.go, hexEntity.gridData.rotationY, time / 1000f).setOnComplete((Action)delegate
		{
			hexEntity.gridData.rotationY = hexEntity.go.transform.localEulerAngles.y;
			if (callBack != null)
			{
				callBack();
				callBack = null;
			}
		});
	}
}
