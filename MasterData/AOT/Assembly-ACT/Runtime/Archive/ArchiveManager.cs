using System;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using Pb;
using UnityEngine;

namespace Runtime.Archive;

public class ArchiveManager : Singleton<ArchiveManager>
{
	private int _counter;

	public bool IsManualArchiving => _counter > 0;

	public void StartManualArchiving(Vector3 pos = default(Vector3))
	{
		if (!IsManualArchiving)
		{
			SyncGameInfoReq syncGameInfoReq = MonoECS.instance.GetSyncGameInfoReq();
			if (pos != default(Vector3))
			{
				syncGameInfoReq.Position = pos.ToPB();
			}
			G.service.SwitchTempArchiveUpdateReq(TempArchiveOperation.Start, syncGameInfoReq, null);
		}
		else
		{
			UpdateArchive();
		}
		_counter++;
	}

	public void FinishManualArchiving(Action<bool> callback = null)
	{
		if (IsManualArchiving)
		{
			_counter--;
			if (!IsManualArchiving)
			{
				G.service.SwitchTempArchiveUpdateReq(TempArchiveOperation.Finish, MonoECS.instance.GetSyncGameInfoReq(), callback);
			}
		}
	}

	public void UpdateArchive()
	{
		if (IsManualArchiving)
		{
			G.service.SwitchTempArchiveUpdateReq(TempArchiveOperation.Update, MonoECS.instance.GetSyncGameInfoReq(), null);
		}
	}

	public void ArchiveScrollBack(Action<bool> callback = null)
	{
		if (IsManualArchiving)
		{
			G.service.SwitchTempArchiveUpdateReq(TempArchiveOperation.DropCurrentStage, null, callback);
		}
	}

	private void DropAllArchive(BaseEventContent eventContent)
	{
		DropAllArchive();
	}

	public void DropAllArchive(Action<bool> callback = null)
	{
		if (IsManualArchiving)
		{
			G.service.SwitchTempArchiveUpdateReq(TempArchiveOperation.DropAllStage, null, callback);
		}
	}

	public override void Init()
	{
		base.Init();
		_counter = 0;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Map_TP, DropAllArchive);
	}

	public override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Map_TP, DropAllArchive);
	}
}
