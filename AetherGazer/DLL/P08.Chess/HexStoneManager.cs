using System.Collections.Generic;
using Chess;
using UnityEngine;

public class HexStoneManager
{
	private static HexStoneManager sInstance;

	private HexEntity m_curHexEntity;

	private HexStone m_curStone;

	private Vector3 m_Forward = Vector3.zero;

	private List<Int2> m_Path;

	private int m_curPathIndex;

	public static HexStoneManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new HexStoneManager();
			}
			return sInstance;
		}
	}

	public void ClearStoneCache()
	{
		m_curHexEntity = null;
		m_curStone = null;
	}

	public void StoneContinueMove()
	{
		if (m_curStone == null)
		{
			LuaHelper.CallFunction("OnStoneMoveEnd", null, null);
		}
		else
		{
			StoneMove();
		}
	}

	public void StoneStartToMove(HexEntity stone, Vector3 forward)
	{
		m_curHexEntity = stone;
		HexStone gridStone = ChessHelper.GetGridStone(stone.go);
		if (gridStone == null)
		{
			Debug.LogError("当前移动的石头上没有HexStone组件！！！");
		}
		m_curStone = gridStone;
		m_Forward = forward;
		m_Path = ChessHelper.GetStonePath(stone.gridData.x, stone.gridData.z, ChessHelper.GetDirectionByForward(m_Forward));
		m_curPathIndex = -1;
		if (m_Path.Count == 0)
		{
			LuaHelper.CallFunction("OnStoneMoveEnd", null, null);
			m_Path.Clear();
		}
		else
		{
			StoneMove();
		}
	}

	protected void StoneMove()
	{
		m_curPathIndex++;
		if (m_curPathIndex < m_Path.Count)
		{
			HexEntity endHexEntity = HexManager.Instance.FindEntity(m_Path[m_curPathIndex].x, m_Path[m_curPathIndex].y);
			m_curStone.StartToMove(endHexEntity.gridNode.position.vec3, delegate
			{
				LuaHelper.CallFunction("OnStoneInteract", m_curHexEntity.gridData, endHexEntity.gridData);
			});
		}
		else
		{
			HexEntity hexEntity = HexManager.Instance.FindEntity(m_Path[m_curPathIndex - 1].x, m_Path[m_curPathIndex - 1].y);
			LuaHelper.CallFunction("OnStoneMoveEnd", m_curHexEntity.gridData, hexEntity.gridData);
			m_Path.Clear();
		}
	}
}
