using System.Collections.Generic;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_107 : SoldierPartnerBase
{
	private readonly struct partnerMsg(int buffId, FP timeInterval, int buffLayer)
	{
		public readonly int buffId = buffId;

		public readonly FP timeInterval = timeInterval;

		public readonly int buffLayer = buffLayer;
	}

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.DiLiXieHui;

	private readonly partnerMsg[] _partnerMsg = new partnerMsg[3]
	{
		new partnerMsg(260110711, 5, 1),
		new partnerMsg(260110721, 5, 2),
		new partnerMsg(260110731, 4, 2)
	};

	private SoldierLevelController _levelCtrl;

	private partnerMsg _currentMsg;

	private FP _lastTickTime;

	private bool _battleStarted;

	private readonly List<SoldierActor> _targetBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		_battleStarted = false;
		_targetBuffer.Clear();
		_levelCtrl = null;
		_actor = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		if (_levelCtrl == null)
		{
			return;
		}
		int num = GetTotalMemberStarLv() - 1;
		if (num >= 0)
		{
			if (num >= _partnerMsg.Length)
			{
				num = _partnerMsg.Length - 1;
			}
			_currentMsg = _partnerMsg[num];
			_lastTickTime = LockStepManager.time;
			_battleStarted = true;
		}
	}

	public void OnUpdate()
	{
		if (_battleStarted && !(_levelCtrl == null))
		{
			FP time = LockStepManager.time;
			if (time - _lastTickTime >= _currentMsg.timeInterval)
			{
				_lastTickTime = time;
				ApplyLayerToOurPartners(_currentMsg);
			}
		}
	}

	private int GetTotalMemberStarLv()
	{
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return 0;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
		int num = 0;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				num += soldierActor.GetPotentialLv();
			}
		}
		return num;
	}

	private void ApplyLayerToOurPartners(partnerMsg msg)
	{
		if (_levelCtrl == null)
		{
			return;
		}
		SoldierActor mainControlActor = _levelCtrl.mainControlActor;
		if (mainControlActor == null)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(mainControlActor, _targetBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null) && soldierActor.HasPartnerType(partnerTypes))
			{
				soldierActor.buffComponent.AddBuffNum(msg.buffId, msg.buffLayer, soldierActor);
			}
		}
	}
}
