using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class DcValueGroupController_Activity : GroupControllerBase
{
	private const string message_DcValue = "DcValue";

	private const int buffId_DcValue = 318010200;

	private const int addNum_Once = 3;

	private const int reduceNum = 9;

	private const int buffId_DcValue_Fx = 318010300;

	private static readonly FP fxDuration = 1;

	private static readonly FP summonDelay = 1;

	private const int summonMonsterId = 3180015;

	private static readonly TSVector2 summonOffset = new TSVector2(0, 0);

	private bool _waitBurst;

	private bool _fxAdded;

	private CoroutineNode _fxNode;

	protected override void OnStart()
	{
		base.OnStart();
		_waitBurst = false;
		_fxAdded = false;
		AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
		if (adventureActor != null)
		{
			CommonUtils_MonsterAPI.AddBuffNumToTarget(adventureActor, 318010200, adventureActor, 1);
		}
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ReceiveMonsterOperation, active: true, OnReceiveMonsterMessage);
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (_waitBurst)
		{
			TryBurst();
		}
	}

	protected override void OnStop()
	{
		base.OnStop();
		_waitBurst = false;
		_fxAdded = false;
		_fxNode = null;
	}

	private void OnReceiveMonsterMessage(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterToGroupControllerMessage adventureMonsterToGroupControllerMessage && !(adventureMonsterToGroupControllerMessage.operationType != "DcValue"))
		{
			AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
			if (!(adventureActor == null))
			{
				CommonUtils_MonsterAPI.AddBuffNumToTarget(adventureActor, 318010200, adventureActor, 3);
				TryBurst();
			}
		}
	}

	private void TryBurst()
	{
		AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
		if (adventureActor == null || adventureActor.buffComponent == null)
		{
			return;
		}
		if (!adventureActor.buffComponent.HaveBuffNumMax(318010200))
		{
			_waitBurst = false;
			_fxAdded = false;
			return;
		}
		if (!_fxAdded)
		{
			_fxAdded = true;
			CommonUtils_MonsterAPI.AddBuffToTarget(adventureActor, 318010300, adventureActor);
			StartCor(ref _fxNode, RemoveFxDelay());
		}
		if (adventureActor.attackTarget == null)
		{
			_waitBurst = true;
			return;
		}
		_waitBurst = false;
		CommonUtils_MonsterAPI.RemoveBuffByNumFromTarget(adventureActor, 318010200, 9);
		StartCor(SummonDelay());
	}

	private IEnumerator RemoveFxDelay()
	{
		yield return WaitTime(fxDuration);
		AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
		if (adventureActor != null)
		{
			CommonUtils_MonsterAPI.RemoveBuffFromTarget(adventureActor, 318010300);
		}
	}

	private IEnumerator SummonDelay()
	{
		yield return WaitTime(summonDelay);
		AdventureActor adventureActor = GetCurrentPlayer() as AdventureActor;
		if (!(adventureActor == null))
		{
			TSVector2 position = adventureActor.tsTransform.Position;
			TSVector2 forward = adventureActor.tsTransform.Forward;
			TSVector2 spawnPosition = TransLocalPosToWorldPos(position, forward, summonOffset);
			LogicEntity attackTarget = adventureActor.attackTarget;
			TSVector2 tSVector = ((attackTarget != null) ? (attackTarget.tsTransform.Position - position) : TSVector2.zero);
			SummonMonster(adventureActor, 3180015, spawnPosition, (tSVector.magnitude > 0) ? tSVector : forward);
		}
	}
}
