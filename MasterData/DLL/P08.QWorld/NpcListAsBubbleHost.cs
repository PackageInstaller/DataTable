using System.Collections.Generic;
using UnityEngine;

public class NpcListAsBubbleHost : IBubbleHost
{
	private List<int> npcIDList;

	private static readonly Bounds INVALID_BOUNDS = new Bounds
	{
		center = Vector3.negativeInfinity
	};

	public int BubbleRootCnt => npcIDList.Count;

	public Bounds Bounds
	{
		get
		{
			bool flag = false;
			Bounds result = default(Bounds);
			for (int i = 0; i < npcIDList.Count; i++)
			{
				QWorldMapEntity entityByEntityID = GetEntityByEntityID(npcIDList[i]);
				if (entityByEntityID != null)
				{
					if (!flag)
					{
						result = entityByEntityID.GetWorldBounds();
						flag = true;
					}
					else
					{
						result.Encapsulate(entityByEntityID.GetWorldBounds());
					}
				}
			}
			if (flag)
			{
				return result;
			}
			return INVALID_BOUNDS;
		}
	}

	public NpcListAsBubbleHost(List<int> id)
	{
		npcIDList = id;
	}

	private static QWorldMapEntity GetEntityByEntityID(int entityID)
	{
		return QWorldScene.Scene.GetMapManager().GetMapEntityByEntityId(entityID);
	}

	private static QWNPCAgent GetNpcByEntityID(int entityID)
	{
		QWorldMapEntity mapEntityByEntityId = QWorldScene.Scene.GetMapManager().GetMapEntityByEntityId(entityID);
		if ((bool)mapEntityByEntityId)
		{
			return mapEntityByEntityId.GetAgent() as QWNPCAgent;
		}
		return null;
	}

	public bool QueryBubbleRoot(int bubbleHandle, out Transform trs, out Vector3 offset)
	{
		if (bubbleHandle < 0 || bubbleHandle >= npcIDList.Count)
		{
			trs = null;
			offset = Vector3.zero;
			return false;
		}
		int entityID = npcIDList[bubbleHandle];
		offset = Vector3.zero;
		QWNPCAgent npcByEntityID = GetNpcByEntityID(entityID);
		if (npcByEntityID == null)
		{
			trs = null;
			return false;
		}
		if ((bool)npcByEntityID.NpcBlackBoard.attachPoint)
		{
			trs = npcByEntityID.NpcBlackBoard.attachPoint.GetHudPoint();
			return true;
		}
		trs = null;
		offset = npcByEntityID.Position + 1.2f * Vector3.up;
		return true;
	}
}
