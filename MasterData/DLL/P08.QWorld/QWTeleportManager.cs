using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class QWTeleportManager
{
	private Dictionary<int, TeleportContext> targets;

	private TeleportContext stageOrigin;

	public Action OnStartTeleport;

	public Action OnEndTeleport;

	public void Init()
	{
		targets = new Dictionary<int, TeleportContext>();
	}

	public void RegisterTeleport(TeleportType type, TeleportContext ctx)
	{
		switch (type)
		{
		case TeleportType.Teleport:
		case TeleportType.Other:
			if (!targets.ContainsKey(ctx.id))
			{
				targets.Add(ctx.id, ctx);
			}
			break;
		case TeleportType.StageOrigin:
			if (!targets.ContainsKey(ctx.id))
			{
				targets.Add(ctx.id, ctx);
			}
			stageOrigin = ctx;
			break;
		}
	}

	public TeleportContext GetStageOriginTeleport()
	{
		return stageOrigin;
	}

	public void StartTeleport(int targetId, bool needReset = false)
	{
		if (targets.TryGetValue(targetId, out var value))
		{
			QWTeleportAction qWTeleportAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Teleport) as QWTeleportAction;
			qWTeleportAction.pos = value.position;
			qWTeleportAction.rotation = value.rotation;
			QWorldHelper.GetPlayer().Blackboard.ActionAdd(qWTeleportAction);
			QWAgentAction action = QWAgentActionFactory.Create(QWAgentAction.E_Type.Camera_Reset);
			QWorldHelper.GetPlayer().Blackboard.ActionAdd(action);
			OnStartTeleport?.Invoke();
			if (needReset)
			{
				QWorldScene.Scene.ResetWorldStateWithPos(value.position);
			}
			OnEndTeleport?.Invoke();
		}
	}

	public void TeleportToNearest(Vector3 position, bool needReset = false)
	{
		TeleportContext teleportContext = (from target in targets.Values
			where target.teleportType != TeleportType.Other
			orderby Vector3.Distance(target.position, position)
			select target).FirstOrDefault();
		QWTeleportAction qWTeleportAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Teleport) as QWTeleportAction;
		qWTeleportAction.pos = teleportContext.position;
		qWTeleportAction.rotation = teleportContext.rotation;
		QWorldHelper.GetPlayer().Blackboard.ActionAdd(qWTeleportAction);
		OnStartTeleport?.Invoke();
		if (needReset)
		{
			QWorldScene.Scene.ResetWorldStateWithPos(teleportContext.position);
		}
		OnEndTeleport?.Invoke();
	}

	public void TeleportToCachePos(Vector3 position, Quaternion rotation, bool needReset = false, bool ignoreCamera = false)
	{
		QWTeleportAction qWTeleportAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.Teleport) as QWTeleportAction;
		qWTeleportAction.pos = position;
		qWTeleportAction.rotation = rotation;
		QWorldHelper.GetPlayer().Blackboard.ActionAdd(qWTeleportAction);
		if (!ignoreCamera)
		{
			QWAgentAction action = QWAgentActionFactory.Create(QWAgentAction.E_Type.Camera_Reset);
			QWorldHelper.GetPlayer().Blackboard.ActionAdd(action);
		}
		OnStartTeleport?.Invoke();
		if (needReset)
		{
			QWorldScene.Scene.ResetWorldStateWithPos(position);
		}
		OnEndTeleport?.Invoke();
	}
}
