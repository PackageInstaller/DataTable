using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class AiLiNuoGroupController_Activity : GroupControllerBase
{
	private static readonly FP triggerInterval = 7;

	private static readonly FP lockDuration = 4;

	private const string lockFollowAlias = "Area_Desert_Locking";

	private const string boxAttackAlias = "Area_Desert_BoxAttack";

	private const int supplyDropId = 138;

	private CoroutineNode _loopNode;

	private long _lockFxId;

	private TSVector2 _lockedPos;

	protected override void OnStart()
	{
		base.OnStart();
		StartCor(ref _loopNode, ActivityLoop());
	}

	protected override void OnStop()
	{
		base.OnStop();
		if (_lockFxId != 0L)
		{
			ILRuntimeAPI.StopAreaEffect(_lockFxId);
			_lockFxId = 0L;
		}
	}

	private IEnumerator ActivityLoop()
	{
		yield return WaitTime(4);
		while (true)
		{
			yield return StartCor(RunOneCycle());
			yield return WaitTime(triggerInterval);
		}
	}

	private IEnumerator RunOneCycle()
	{
		AdventureActor player = GetCurrentPlayer() as AdventureActor;
		if (player == null)
		{
			yield break;
		}
		_lockFxId = ILRuntimeAPI.PlayAreaEffect(player, "Area_Desert_Locking", player.tsTransform.Position);
		yield return WaitTime(lockDuration);
		_lockedPos = player.tsTransform.Position;
		if (_lockFxId != 0L)
		{
			ILRuntimeAPI.StopAreaEffect(_lockFxId);
			_lockFxId = 0L;
		}
		ILRuntimeAPI.PlayAreaEffect(player, "Area_Desert_LockEnd", _lockedPos);
		yield return WaitTime(1.3);
		ILRuntimeAPI.PlayAreaEffect(player, "Area_Desert_BoxAttack", _lockedPos);
		yield return WaitTime(0.2);
		AiLiNuoGroupController_Activity aiLiNuoGroupController_Activity = this;
		TSVector2 lockedPos = _lockedPos;
		FP radius = 3.4;
		DeterministicShape shapeData = aiLiNuoGroupController_Activity.GetShapeData(DeterministicShape.ShapeType.Circle, lockedPos, default, default, radius);
		foreach (LogicEntity item in GetTargetsFromShape(player, shapeData, null, includeSelf: true))
		{
			if (item.IsConfrontWith(player))
			{
				MonsterAdventureActor monsterAdventureActor = item as MonsterAdventureActor;
				FP fP;
				int buffID;
				if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LORD)
				{
					fP = (double)monsterAdventureActor.actorHealthInfo.hpMax * 0.1;
					buffID = 315010110;
				}
				else if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LEADER)
				{
					fP = (double)monsterAdventureActor.actorHealthInfo.hpMax * 0.3;
					buffID = 315010110;
				}
				else if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE)
				{
					fP = (double)monsterAdventureActor.actorHealthInfo.hpMax * 0.4;
					buffID = 315010100;
				}
				else
				{
					fP = (double)monsterAdventureActor.actorHealthInfo.hpMax * 0.7;
					buffID = 315010100;
				}
				DirectDamage(player, item, (int)(long)fP, null);
				AddBuffToTarget(player, monsterAdventureActor, buffID);
			}
			else if (item == player)
			{
				AddBuffToTarget(player, player, 315010110);
			}
		}
		SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(player, 138, _lockedPos, player.tsTransform.PositionY);
	}
}
