using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Soldier.SoldierPartner;

public class SoldierPartner_104 : SoldierPartnerBase
{
	private const HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.EnCiYiZhi;

	private const int BUFF_ID_MARK_LV1 = 260110411;

	private const int BUFF_ID_MARK_LV2 = 260110421;

	private const int BUFF_ID_MARK_LV3 = 260110422;

	private const int EXPLODE_THRESHOLD = 5;

	private const int EXPLODE_DAMAGE_LAYER = 10;

	private const string HIT_FX_EXPLODE = "fx_common_hit_light_strike";

	private static readonly FP TICK_INTERVAL_LV1 = FP.One * 2;

	private static readonly FP TICK_INTERVAL_LV2 = FP.One * 2;

	private static readonly FP[] AtkDmgPercent = new FP[3]
	{
		new FP(10) / 100,
		new FP(10) / 100,
		new FP(20) / 100
	};

	private SoldierLevelController _levelCtrl;

	private Dictionary<long, FP> _markAppliedTime = new Dictionary<long, FP>();

	private Dictionary<long, FP> _lastTickTime = new Dictionary<long, FP>();

	private List<SoldierActor> _enemyBuffer = new List<SoldierActor>();

	private List<SoldierActor> _memberBuffer = new List<SoldierActor>();

	protected override void OnPartnerEnable()
	{
		base.OnPartnerEnable();
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (_levelCtrl != null)
		{
			partnerLv = _levelCtrl.GetPartnerLv(HotfixEnum.ChessPartnerType.EnCiYiZhi);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnCauseDead);
	}

	protected override void OnPartnerDisable()
	{
		base.OnPartnerDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnCauseDead);
		_markAppliedTime.Clear();
		_lastTickTime.Clear();
		_enemyBuffer.Clear();
		_memberBuffer.Clear();
		_levelCtrl = null;
	}

	protected override void OnPartnerBattleStart()
	{
		base.OnPartnerBattleStart();
		_ = _levelCtrl == null;
	}

	protected override void OnOurSoldierCastSkill(SoldierActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		if (partnerLv < 1 || actor == null || !actor.HasPartnerType(HotfixEnum.ChessPartnerType.EnCiYiZhi) || _levelCtrl == null || castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			return;
		}
		int markBuffIdByLevel = GetMarkBuffIdByLevel();
		if (markBuffIdByLevel <= 0)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _enemyBuffer);
		FP time = LockStepManager.time;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuffNum(markBuffIdByLevel, 1, actor);
				if (!_markAppliedTime.ContainsKey(soldierActor.Id))
				{
					_markAppliedTime.set_Item(soldierActor.Id, time);
				}
				if (partnerLv == 3)
				{
					CheckExplode(soldierActor);
				}
			}
		}
	}

	public void OnUpdate()
	{
		if (_levelCtrl == null || _levelCtrl.mainControlActor == null || partnerLv < 1)
		{
			return;
		}
		int markBuffIdByLevel = GetMarkBuffIdByLevel();
		FP fP = ((partnerLv == 1) ? TICK_INTERVAL_LV1 : TICK_INTERVAL_LV2);
		FP time = LockStepManager.time;
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _enemyBuffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (soldierActor == null || soldierActor.isDead || soldierActor.buffComponent == null)
			{
				continue;
			}
			FP value;
			if (soldierActor.buffComponent.GetBuffNumByID(markBuffIdByLevel) <= 0)
			{
				_markAppliedTime.Remove(soldierActor.Id);
				_lastTickTime.Remove(soldierActor.Id);
			}
			else if (_markAppliedTime.TryGetValue(soldierActor.Id, out value))
			{
				_lastTickTime.TryGetValue(soldierActor.Id, out var value2);
				FP fP2 = ((value2 > value) ? value2 : value);
				if (!(time - fP2 < fP))
				{
					_lastTickTime.set_Item(soldierActor.Id, time);
					ApplyMarkDamageToTarget(soldierActor);
				}
			}
		}
	}

	private void ApplyMarkDamageToTarget(SoldierActor enemy)
	{
		if (_levelCtrl == null || _levelCtrl.mainControlActor == null)
		{
			return;
		}
		int num = partnerLv - 1;
		if (num < 0)
		{
			return;
		}
		if (num >= AtkDmgPercent.Length)
		{
			num = AtkDmgPercent.Length - 1;
		}
		int markBuffIdByLevel = GetMarkBuffIdByLevel();
		if (markBuffIdByLevel <= 0 || enemy.buffComponent == null)
		{
			return;
		}
		int buffNumByID = enemy.buffComponent.GetBuffNumByID(markBuffIdByLevel);
		if (buffNumByID > 0)
		{
			long num2 = (long)(GetTotalPartnerAtk() * AtkDmgPercent[num] * buffNumByID);
			if (num2 > 0)
			{
				enemy.DirectDamage(num2, "", _levelCtrl.mainControlActor.Id);
			}
		}
	}

	private FP GetTotalPartnerAtk()
	{
		if (_levelCtrl == null || _levelCtrl.mainControlActor == null)
		{
			return FP.Zero;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.mainControlActor, _memberBuffer);
		FP zero = FP.Zero;
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(HotfixEnum.ChessPartnerType.EnCiYiZhi))
			{
				zero += (FP)soldierActor.actorInfo.atk;
			}
		}
		return zero;
	}

	private void OnCauseDead(IEvent evt)
	{
		if (_levelCtrl == null || _levelCtrl.mainControlActor == null || !(evt is AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent))
		{
			return;
		}
		int markBuffIdByLevel = GetMarkBuffIdByLevel();
		if (markBuffIdByLevel <= 0)
		{
			return;
		}
		List<SoldierActor> allActors = _levelCtrl.GetAllActors(_levelCtrl.enemyMainControlActor, _enemyBuffer);
		long id = adventureActorReceiveDamageCanCauseDeadEvent.to.Id;
		SoldierActor soldierActor = null;
		for (int i = 0; i < allActors.Count; i++)
		{
			if (allActors.get_Item(i) != null && allActors.get_Item(i).Id == id)
			{
				soldierActor = allActors.get_Item(i);
				break;
			}
		}
		if (soldierActor == null || soldierActor.buffComponent == null)
		{
			return;
		}
		int buffNumByID = soldierActor.buffComponent.GetBuffNumByID(markBuffIdByLevel);
		_markAppliedTime.Remove(id);
		_lastTickTime.Remove(id);
		if (buffNumByID <= 0)
		{
			return;
		}
		SoldierActor soldierActor2 = null;
		FP fP = FP.MaxValue;
		for (int j = 0; j < allActors.Count; j++)
		{
			SoldierActor soldierActor3 = allActors.get_Item(j);
			if (!(soldierActor3 == null) && soldierActor3.Id != id && !soldierActor3.isDead)
			{
				FP fP2 = TSVector2.DistanceSquared(soldierActor.tsTransform.Position, soldierActor3.tsTransform.Position);
				if (fP2 < fP)
				{
					fP = fP2;
					soldierActor2 = soldierActor3;
				}
			}
		}
		if (!(soldierActor2 == null))
		{
			soldierActor.buffComponent.RemoveBuffByBuffId(markBuffIdByLevel);
			soldierActor2.buffComponent.AddBuffNum(markBuffIdByLevel, buffNumByID, _levelCtrl.mainControlActor);
			if (!_markAppliedTime.ContainsKey(soldierActor2.Id))
			{
				_markAppliedTime.set_Item(soldierActor2.Id, LockStepManager.time);
			}
			if (partnerLv == 3)
			{
				CheckExplode(soldierActor2);
			}
		}
	}

	private void CheckExplode(SoldierActor enemy)
	{
		if (enemy == null || enemy.isDead || enemy.buffComponent == null || enemy.buffComponent.GetBuffNumByID(260110422) < 5)
		{
			return;
		}
		enemy.buffComponent.RemoveBuffByBuffId(260110422);
		_markAppliedTime.Remove(enemy.Id);
		_lastTickTime.Remove(enemy.Id);
		int num = partnerLv - 1;
		if (num >= 0)
		{
			if (num >= AtkDmgPercent.Length)
			{
				num = AtkDmgPercent.Length - 1;
			}
			int num2 = (GetTotalPartnerAtk() * 10 * AtkDmgPercent[num]).AsInt();
			if (num2 > 0)
			{
				ILRuntimeAPI.DirectDamage(_levelCtrl.mainControlActor, enemy, num2, null, "fx_common_hit_light_strike");
			}
		}
	}

	private int GetMarkBuffIdByLevel()
	{
		if (partnerLv == 1)
		{
			return 260110411;
		}
		if (partnerLv == 2)
		{
			return 260110421;
		}
		return 260110422;
	}
}
