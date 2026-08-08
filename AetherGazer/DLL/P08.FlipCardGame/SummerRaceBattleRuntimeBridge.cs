using System;

public sealed class SummerRaceBattleRuntimeBridge
{
	private readonly SummerRaceBattleRuntime runtime;

	private bool snapshotLuaPublishBlockedLogged;

	public SummerRaceBattleRuntimeBridge(SummerRaceBattleRuntime runtime)
	{
		this.runtime = runtime ?? throw new ArgumentNullException("runtime");
	}

	public void PublishStageResolved(string mode, SummerRaceActivityStageContract stage, string reportedStageId = null)
	{
		if (stage != null)
		{
			SummerRaceLuaBridge.PushStageResolved(runtime.SetStageResolved(new SummerRaceBattleStageResolved
			{
				stageId = (string.IsNullOrWhiteSpace(reportedStageId) ? stage.Id : reportedStageId),
				mode = mode,
				sortOrder = stage.SortOrder,
				isMainline = stage.IsMainline
			}));
		}
	}

	public void PublishSnapshot(bool force)
	{
		if (!runtime.TryGetSnapshotForPublish(force, out var snapshot))
		{
			return;
		}
		if (!SummerRaceFightManager.IsLuaUiContextReady())
		{
			if (!snapshotLuaPublishBlockedLogged)
			{
				snapshotLuaPublishBlockedLogged = true;
				SummerRaceRuntimeLog.Log("[SummerRace][BattleRuntime] Lua UI context not ready; snapshot remains in C# runtime and will be pushed on the next ready tick.");
			}
		}
		else
		{
			snapshotLuaPublishBlockedLogged = false;
			SummerRaceLuaBridge.PushRuntimeSnapshot(snapshot);
			runtime.MarkSnapshotPublished();
		}
	}

	public void PublishSettlement()
	{
		SummerRaceBattleSettlement settlement = runtime.GetSettlement();
		if (settlement != null)
		{
			SummerRaceLuaBridge.PushSettlement(settlement);
		}
	}
}
