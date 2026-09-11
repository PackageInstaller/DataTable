using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;

public class QWorldPatrolPathDeviceEntityDataMono : QWorldEntityDataMono<QWorldPatrolPathDeviceEntityData>
{
	public List<QWorldPatrolPathNodeDeviceEntityDataMono> nodes;

	private static QWorldMapData GetEditorLoadingMapData()
	{
		return Type.GetType("QWorldStageEditor, P08.QWorld.Editor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null").GetProperty("currentMapdata", BindingFlags.Static | BindingFlags.Public).GetValue(null) as QWorldMapData;
	}

	protected override void OnLoadState(QWorldPatrolPathDeviceEntityData loadData)
	{
		base.OnLoadState(loadData);
	}

	protected override void OnSaveState(ref QWorldPatrolPathDeviceEntityData saveData)
	{
		base.OnSaveState(ref saveData);
		saveData.patrolPath = nodes.Select((QWorldPatrolPathNodeDeviceEntityDataMono n) => n.transform.position).ToArray();
	}
}
