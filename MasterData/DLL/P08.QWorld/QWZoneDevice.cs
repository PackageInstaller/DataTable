using System;
using UnityEngine;

public abstract class QWZoneDevice : MonoBehaviour
{
	public int zoneId;

	public Action<QWAgent> onEnterZone;

	public Action<QWAgent> onExitZone;

	protected void OnEnterZone(QWAgent agent)
	{
		if (agent == null)
		{
			return;
		}
		if (onEnterZone != null)
		{
			onEnterZone(agent);
			return;
		}
		if (agent is QWCharacterAgent agent2)
		{
			QWorldLuaBridge.OnPlayerEnterZone(zoneId, agent2);
			return;
		}
		QWorldMapEntity component = agent.GetComponent<QWorldMapEntity>();
		if ((bool)component)
		{
			QWorldLuaBridge.OnEntityEnterZone(zoneId, component);
		}
	}

	protected void OnExitZone(QWAgent agent)
	{
		if (agent == null)
		{
			return;
		}
		if (onExitZone != null)
		{
			onExitZone(agent);
			return;
		}
		if (agent is QWCharacterAgent agent2)
		{
			QWorldLuaBridge.OnPlayerExitZone(zoneId, agent2);
			return;
		}
		QWorldMapEntity component = agent.GetComponent<QWorldMapEntity>();
		if ((bool)component)
		{
			QWorldLuaBridge.OnEntityExitZone(zoneId, component);
		}
	}
}
