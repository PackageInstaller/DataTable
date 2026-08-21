using System;
using System.Collections.Generic;
using Chess;
using Pathfinding;
using UnityEngine;

public class ChessLuaBridge
{
	public static HexAnimatorExtendBoat roleTmp;

	public static void Launcher(ChessDataForExchange chessDataForExchange, Action callback)
	{
		callback?.Invoke();
		ChessScene chessScene = NScene.Load<ChessScene>();
		chessScene.SetMapId(chessDataForExchange.mapId);
		ChessMapCfgManager.Instance.SetGridConfig(chessDataForExchange.GridConfig);
		ChessMapCfgManager.Instance.SetMapConfig(chessDataForExchange.MapConfig);
		chessScene.SetMapData(chessDataForExchange.mapInfoS, chessDataForExchange.fogInfo);
		chessScene.bronPos = chessDataForExchange.bronPos;
		chessScene.direction = chessDataForExchange.direction;
		chessScene.cacheAssetS = chessDataForExchange.cacheAssetS;
	}

	public static void MoveToCachePos()
	{
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.MoveToCachePos();
	}

	public static void ClearCachePath()
	{
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.ClearCachePath();
	}

	public static void SlideByDirection(int direction, float speed)
	{
		ChessScene chessScene = NScene.GetCurrentScene() as ChessScene;
		HexAnimatorExtendBoat hexAnimatorExtendBoat = chessScene.hexGridCoord.mRole as HexAnimatorExtendBoat;
		if (hexAnimatorExtendBoat != null)
		{
			chessScene.hexGridCoord.RoleStopMove(delegate
			{
				hexAnimatorExtendBoat.SlideByDirection(direction, speed);
			}, isSkipWalkEnd: true);
		}
	}

	public static void ChangeGridByIndex(int x, int z, int extendIndex, Action callBack = null)
	{
		ChessMapData chessMapData = (NScene.GetCurrentScene() as ChessScene).mapData.chessMapData;
		HexManager.Instance.ChangeGrid(x, z, new GridData(chessMapData.extendInfo[extendIndex - 1]), isExtend: true, callBack);
	}

	public static void ChangeGrid(int x, int z, GridData gridData, Action callBack = null)
	{
		HexManager.Instance.ChangeGrid(x, z, gridData, isExtend: false, callBack);
	}

	public static void ChangeGridStatus(int x, int z, int status, Action func = null)
	{
		HexManager.Instance.ChangeGridStatus(x, z, status, func);
	}

	public static void PlayGridAnimation(int x, int z, string ani, Action func = null)
	{
		HexManager.Instance.PlayGridAnimation(x, z, ani, func);
	}

	public static GridData GetGridData(int x, int z)
	{
		return HexManager.Instance.FindEntity(x, z)?.gridData;
	}

	public static void TelePortRoleToPosition(int x, int z)
	{
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.TelePortRoleToPosition(x, z);
	}

	public static void RoleStopMove()
	{
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.RoleStopMove();
	}

	public static void LookAtPlayer(Action callBack = null)
	{
		HexCameraManager.Instance.LookAtPlayer(callBack);
	}

	public static void MoveTarget(int x, int z, bool _force = true)
	{
		Vector3 vec = HexManager.Instance.FindEntity(x, z).gridNode.position.vec3;
		HexCameraManager.Instance.MoveTarget(vec, _force);
	}

	public static void MoveTargetSmooth(int x, int z, Action callBack = null, bool isUniform = true, float speed = 10f, bool _force = true)
	{
		Vector3 vec = HexManager.Instance.FindEntity(x, z).gridNode.position.vec3;
		HexCameraManager.Instance.MoveTargetSmooth(vec, speed, _force, callBack, isUniform);
	}

	public static void LookAtTargetS(Transform[] targetS, float speed = 10f, Action callBack = null, bool isUniform = true)
	{
		HexCameraManager.Instance.LookAtTargetS(targetS, speed, callBack, isUniform);
	}

	public static void LookAtTarget(int[] x, int[] z, Action callBack = null, bool isUniform = true, float speed = 10f, bool _force = true)
	{
		Transform[] array = new Transform[x.Length];
		if (x.Length == z.Length)
		{
			for (int i = 0; i < x.Length; i++)
			{
				Transform transform = HexManager.Instance.FindEntity(x[i], z[i]).go.transform;
				array[i] = transform;
			}
			HexCameraManager.Instance.LookAtTargetS(array, speed, callBack, isUniform);
		}
	}

	public static void SetCameraControlEnable(bool isEnable)
	{
		HexCameraManager.Instance.IsEnableControl = isEnable;
	}

	public static void SetChessInputEnable(bool isEnable)
	{
		HexInputManager.Instance.IsEnableInput = isEnable;
	}

	public static void SetGridSelectOutline(int x, int z, bool isSelect)
	{
		HexEntity hexEntity = HexManager.Instance.FindEntity(x, z);
		if (hexEntity != null && hexEntity.go != null)
		{
			ChessHelper.SetGridSelectOutline(hexEntity.go, isSelect);
		}
	}

	public static void InitGuider(string path, int x, int z)
	{
		HexGuiderManager.Instance.InitGuider(path, x, z);
	}

	public static void MoveGuiderAlongPath(int[] x, int[] z, float speed = 0f, Action callBack = null)
	{
		if (x.Length == z.Length)
		{
			List<Int2> list = new List<Int2>();
			for (int i = 0; i < x.Length; i++)
			{
				list.Add(new Int2(x[i], z[i]));
			}
			HexGuiderManager.Instance.MoveGuiderAlongPath(list, speed, callBack);
		}
	}

	public static void MoveGuider(int x, int z)
	{
		Vector3 worldPositionByHexCoord = ChessHelper.GetWorldPositionByHexCoord(x, z);
		HexGuiderManager.Instance.hexAnimator.WantedPosition = worldPositionByHexCoord;
	}

	public static void SetCountText(int num, bool isActive = true)
	{
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole.SetCountDownText(num, isActive);
	}

	public static void FireByPlayer()
	{
		ChessScene chessScene = NScene.GetCurrentScene() as ChessScene;
		HexAnimatorExtendFire hexAnimatorExtendFire = chessScene.hexGridCoord.mRole as HexAnimatorExtendFire;
		if (hexAnimatorExtendFire != null)
		{
			hexAnimatorExtendFire.Fire();
			return;
		}
		HexAnimator mRole = chessScene.hexGridCoord.mRole;
		Vector3 forward = mRole.transform.forward;
		HexBulletManager.Instance.FireBullet(mRole.GridPosition.x, mRole.GridPosition.z, ChessHelper.GetDirectionByForward(forward));
	}

	public static int GetPlayerDirection()
	{
		return ChessHelper.GetDirectionByForward((NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole.transform.forward);
	}

	public static void FireBullet(int x, int z, int direction)
	{
		HexBulletManager.Instance.FireBullet(x, z, direction);
	}

	public static void RotateGrid(int x, int z, float angle, float time = 2f, Action callBack = null)
	{
		HexEntity hexEntity = HexManager.Instance.FindEntity(x, z);
		if (hexEntity == null || !(hexEntity.go != null))
		{
			return;
		}
		hexEntity.gridData.rotationY += angle;
		LeanTween.rotateY(hexEntity.go, hexEntity.gridData.rotationY, time).setOnComplete((Action)delegate
		{
			if (callBack != null)
			{
				callBack();
				callBack = null;
			}
			hexEntity.gridData.rotationY = hexEntity.go.transform.localEulerAngles.y;
		});
	}

	public static Vector2 GetCameraLookNearestNode()
	{
		Vector3 cameraLookAtPosition = HexCameraManager.Instance.GetCameraLookAtPosition();
		GridNode gridNode = HexGridCoord.astarPath.data.graphs[0].GetNearest((Int3)cameraLookAtPosition).node as GridNode;
		return new Vector2(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
	}

	public static void ResetCameraYAxis()
	{
		HexCameraManager.Instance.ResetYAxis();
	}

	public static bool LayDownChildBoat(int range = 1, Action callBack = null)
	{
		HexAnimatorExtendBoat hexAnimatorExtendBoat = (NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole as HexAnimatorExtendBoat;
		if (hexAnimatorExtendBoat != null)
		{
			if (!hexAnimatorExtendBoat.LayDownChildBoat(callBack))
			{
				return false;
			}
			hexAnimatorExtendBoat.SetIsMuteTrigger(isMute: true);
			roleTmp = hexAnimatorExtendBoat;
			HexManager.Instance.LimitMoveRange(hexAnimatorExtendBoat.GridPosition.x, hexAnimatorExtendBoat.GridPosition.z, range);
			return true;
		}
		return false;
	}

	public static bool PutUpChildBoat(Action callBack = null)
	{
		bool num = roleTmp.PutUpChildBoat(callBack);
		if (num)
		{
			roleTmp.SetIsMuteTrigger(isMute: false);
			(NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole = roleTmp;
			HexManager.Instance.ClearMoveLimit();
		}
		return num;
	}

	public static void LayDownChildBoatWithoutAnimation(int x, int z, int range = 1)
	{
		HexAnimatorExtendBoat hexAnimatorExtendBoat = (NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole as HexAnimatorExtendBoat;
		if (hexAnimatorExtendBoat != null)
		{
			hexAnimatorExtendBoat.LayDownChildBoatWithoutAnimation(x, z);
			hexAnimatorExtendBoat.SetIsMuteTrigger(isMute: true);
			roleTmp = hexAnimatorExtendBoat;
			HexManager.Instance.LimitMoveRange(hexAnimatorExtendBoat.GridPosition.x, hexAnimatorExtendBoat.GridPosition.z, range);
		}
	}

	public static void PlayRoleAnimation(string ani, Action func = null)
	{
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole.PlayRoleAnimation(ani, func);
	}

	public static void StoneMove(int curx, int curz)
	{
		ChessScene chessScene = NScene.GetCurrentScene() as ChessScene;
		HexEntity stone = HexManager.Instance.FindEntity(curx, curz);
		HexAnimatorExtendStone hexAnimatorExtendStone = chessScene.hexGridCoord.mRole as HexAnimatorExtendStone;
		if (hexAnimatorExtendStone != null)
		{
			hexAnimatorExtendStone.StoneMove(curx, curz);
			return;
		}
		HexAnimator mRole = chessScene.hexGridCoord.mRole;
		HexStoneManager.Instance.StoneStartToMove(stone, mRole.transform.forward);
	}

	public static void StoneContinueMove()
	{
		HexStoneManager.Instance.StoneContinueMove();
	}

	public static void ClearStoneCache()
	{
		HexStoneManager.Instance.ClearStoneCache();
	}
}
