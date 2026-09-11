using System;
using System.Collections;
using Chess;
using Pathfinding;
using UnityEngine;

public class HexAnimatorExtendBoat : HexAnimator
{
	public string childBoatPath = "Char/6076_tpose";

	private IEnumerator co;

	private Int2 crashPointCoordTmp;

	private GameObject childBoatGo;

	[HideInInspector]
	public HexAnimator childBoatAnimator;

	private Int2 layDownCoord;

	protected override void OnStart()
	{
		isNeedRushState = false;
	}

	public void SlideByDirection(int direction, float speed)
	{
		if (co != null)
		{
			StopCoroutine(co);
		}
		ChessHelper.GetSlideEndPoint(gridPosition.x, gridPosition.z, direction, out var crashPoint, out var slidePath);
		GridNode gridNode = HexManager.Instance.FindEntity(crashPoint.x, crashPoint.y).gridNode;
		if (gridNode == null)
		{
			return;
		}
		for (int i = 0; i < slidePath.Count; i++)
		{
			HexManager.Instance.FindEntity(slidePath[i].x, slidePath[i].y).gridNode.Penalty = 1000u;
		}
		crashPointCoordTmp = crashPoint;
		ABPath aBPath = ABPath.Construct(HexGridCoord.astarPath.GetNearest((Int3)base.transform.position).node.position, gridNode.position);
		aBPath.Claim(this);
		AstarPath.StartPath(aBPath);
		AstarPath.BlockUntilCalculated(aBPath);
		onWalkStop = OnSlideEnd;
		for (int j = 0; j < slidePath.Count; j++)
		{
			HexEntity hexEntity = HexManager.Instance.FindEntity(slidePath[j].x, slidePath[j].y);
			GridConfig gridConfig = ChessMapCfgManager.Instance.GetGridConfig(hexEntity.gridData.typeID, hexEntity.gridData.status);
			if (gridConfig != null)
			{
				hexEntity.gridNode.Penalty = gridConfig.walkable * 1000;
			}
		}
		if (!IsTouchItemWithoutMove(aBPath.vectorPath[aBPath.vectorPath.Count - 1], (Vector3)aBPath.originalEndPoint, 2f))
		{
			co = MoveAlongPath(aBPath, speed);
			StartCoroutine(co);
		}
	}

	protected void OnSlideEnd()
	{
		onWalkStop = onWalkStopOrigin;
		HexEntity hexEntity = HexManager.Instance.FindEntity(crashPointCoordTmp.x, crashPointCoordTmp.y);
		LuaHelper.CallFunction("SlideEnd", hexEntity?.gridData);
		StartToCountRelaxTime();
	}

	public bool LayDownChildBoat(Action callBack = null)
	{
		if (childBoatGo == null)
		{
			childBoatGo = Asset.Instantiate(childBoatPath);
			if (childBoatGo == null)
			{
				Debug.LogError("can not find child boat prefab");
				return false;
			}
			childBoatAnimator = childBoatGo.GetComponent<HexAnimator>();
			childBoatAnimator.transform.position = new Vector3(99999f, 0f, 99999f);
		}
		int index = (ChessHelper.GetDirectionByForward(base.transform.forward) + 3) % 6;
		Int2 @int = new Int2(gridPosition.x, gridPosition.z) + ChessHelper.directionMap[index];
		HexEntity entity = HexManager.Instance.FindEntity(@int.x, @int.y);
		if (ChessMapCfgManager.Instance.GetGridConfig(entity.gridData.typeID, entity.gridData.status).walkable == 0)
		{
			return false;
		}
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole = childBoatAnimator;
		m_animator.Play("skill1");
		ChessHelper.WaitForAnimationEnd(m_animator, delegate
		{
			childBoatAnimator.WantedPosition = entity.go.transform.position;
			childBoatAnimator.ForceRefreshPosition();
			layDownCoord = new Int2(childBoatAnimator.GridPosition.x, childBoatAnimator.GridPosition.z);
			childBoatAnimator.transform.forward = base.transform.forward;
			if (callBack != null)
			{
				callBack();
			}
		});
		return true;
	}

	public void LayDownChildBoatWithoutAnimation(int x, int z)
	{
		if (childBoatGo == null)
		{
			childBoatGo = Asset.Instantiate(childBoatPath);
			if (childBoatGo == null)
			{
				Debug.LogError("can not find child boat prefab");
			}
			childBoatAnimator = childBoatGo.GetComponent<HexAnimator>();
		}
		(NScene.GetCurrentScene() as ChessScene).hexGridCoord.mRole = childBoatAnimator;
		HexEntity hexEntity = HexManager.Instance.FindEntity(x, z);
		childBoatAnimator.WantedPosition = hexEntity.go.transform.position;
		childBoatAnimator.ForceRefreshPosition();
		int index = (ChessHelper.GetDirectionByForward(base.transform.forward) + 3) % 6;
		layDownCoord = new Int2(gridPosition.x, gridPosition.z) + ChessHelper.directionMap[index];
	}

	public bool PutUpChildBoat(Action callBack = null)
	{
		if (childBoatAnimator.GridPosition.x != layDownCoord.x || childBoatAnimator.GridPosition.z != layDownCoord.y)
		{
			return false;
		}
		m_animator.Play("skill2");
		ChessHelper.WaitForAnimationEnd(m_animator, delegate
		{
			layDownCoord = Int2.one;
			UnityEngine.Object.Destroy(childBoatGo);
			if (callBack != null)
			{
				callBack();
			}
		});
		return true;
	}

	protected new void OnDestroy()
	{
		base.OnDestroy();
	}

	public override void StopMove()
	{
		base.StopMove();
		crashPointCoordTmp = new Int2(-1, -1);
		if (co != null)
		{
			StopCoroutine(co);
		}
	}
}
