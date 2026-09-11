using System;
using System.Collections.Generic;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardNPCManager
{
	private static ChessBoardNPCManager sInstance;

	private Dictionary<int, ChessBoardNPCEntity> m_NPCEntityDic = new Dictionary<int, ChessBoardNPCEntity>();

	private ChessBoardNPCData[] m_NPCInitList = new ChessBoardNPCData[0];

	public static ChessBoardNPCManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new ChessBoardNPCManager();
			}
			return sInstance;
		}
	}

	public void SetNPCInitData(ChessBoardNPCData[] NPCList)
	{
		m_NPCInitList = NPCList;
	}

	public void InitNPC()
	{
		for (int i = 0; i < m_NPCInitList.Length; i++)
		{
			ChessBoardNPCData chessBoardNPCData = m_NPCInitList[i];
			AddNPC(chessBoardNPCData.entityID, chessBoardNPCData.x, chessBoardNPCData.z, chessBoardNPCData.dir, chessBoardNPCData.prefab);
		}
	}

	public void AddNPC(int NPCID, int x, int z, int dir, string prefab, int actionType = -1)
	{
		ChessBoardHexEntity chessBoardHexEntity = ChessBoardHexManager.Instance.FindEntity(x, z);
		Vector3 vector = (Vector3)chessBoardHexEntity.gridNode.position;
		vector = vector.NewY(chessBoardHexEntity.gridData.offsetY);
		GameObject gameObject = UnityEngine.Object.Instantiate(Asset.Load<GameObject>("ChessBoard/NPC/" + prefab));
		gameObject.name = NPCID.ToString();
		gameObject.transform.position = vector;
		gameObject.transform.forward = ChessBoardHelper.forwardMap[dir];
		ChessBoardNPCEntity component = gameObject.GetComponent<ChessBoardNPCEntity>();
		m_NPCEntityDic.Add(NPCID, component);
		if (actionType > 0)
		{
			component.wantedPlayActionType = actionType;
		}
		component.InitBronPoint(x, z);
	}

	public void DeleteNPC(int NPCID)
	{
		if (m_NPCEntityDic.Remove(NPCID, out var value))
		{
			UnityEngine.Object.Destroy(value.gameObject);
		}
		else
		{
			Debug.LogError("尝试删除当前不在管理类中的NPC，NPCID：" + NPCID);
		}
	}

	public void NPCMoveTo(int NPCID, Vector3 pos, int x, int z, Action callBack = null)
	{
		if (m_NPCEntityDic.TryGetValue(NPCID, out var value))
		{
			value.MoveTo(pos, x, z, callBack);
		}
		else
		{
			Debug.LogError("尝试移动当前不在管理类中的NPC，NPCID：" + NPCID);
		}
	}

	public void SetNPCPosAndDir(int NPCID, Vector3 pos, int dir, int x, int z)
	{
		if (m_NPCEntityDic.TryGetValue(NPCID, out var value))
		{
			value.SetHeroPosAndDir(pos, dir, x, z);
		}
		else
		{
			Debug.LogError("尝试传送当前不在管理类中的NPC，NPCID：" + NPCID);
		}
	}

	public void DestroyAllNPC()
	{
		List<int> list = new List<int>(m_NPCEntityDic.Keys);
		for (int i = 0; i < list.Count; i++)
		{
			if (m_NPCEntityDic.Remove(list[i], out var value))
			{
				UnityEngine.Object.Destroy(value.gameObject);
			}
		}
		m_NPCEntityDic.Clear();
	}

	public void PlayNPCAction(int NPCID, int actionType)
	{
		if (m_NPCEntityDic.TryGetValue(NPCID, out var value))
		{
			value.PlayAction(actionType);
		}
		else
		{
			Debug.LogError("尝试操作当前不在管理类中的NPC，NPCID：" + NPCID + "actionType" + actionType);
		}
	}

	public void PlayNPCOverlap(int NPCID, bool isShow)
	{
		if (m_NPCEntityDic.TryGetValue(NPCID, out var value))
		{
			value.PlayOverlap(isShow);
		}
		else
		{
			Debug.LogError("尝试操作当前不在管理类中的NPC，NPCID：" + NPCID);
		}
	}

	public void SetNPCToCameraTarget(int NPCID)
	{
		if (m_NPCEntityDic.TryGetValue(NPCID, out var value))
		{
			ChessBoardCameraManager.Instance.SetTargetTransform(value.transform, value.diceLookAtPoint);
		}
		else
		{
			Debug.LogError("尝试操作当前不在管理类中的NPC，NPCID：" + NPCID);
		}
	}

	public Vector3 GetNPCTransPos(int NPCID)
	{
		if (m_NPCEntityDic.TryGetValue(NPCID, out var value))
		{
			return value.transform.position;
		}
		Debug.LogError("尝试操作当前不在管理类中的NPC，NPCID：" + NPCID);
		return Vector3.zero;
	}

	public int GetNPCIDByPos(Vector3 gridPosition)
	{
		foreach (KeyValuePair<int, ChessBoardNPCEntity> item in m_NPCEntityDic)
		{
			if (item.Value.CheckIsSamePos(gridPosition))
			{
				return item.Key;
			}
		}
		return -1;
	}

	public void ChangeSpeedModule(bool isFast)
	{
		if (isFast)
		{
			foreach (ChessBoardNPCEntity value in m_NPCEntityDic.Values)
			{
				if ((bool)value.m_animator)
				{
					value.m_animator.speed = 2f;
				}
			}
			return;
		}
		foreach (ChessBoardNPCEntity value2 in m_NPCEntityDic.Values)
		{
			if ((bool)value2.m_animator)
			{
				value2.m_animator.speed = 1f;
			}
		}
	}
}
