using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101;

public class ParallelScript_Support : ParallelScript
{
	private const int maxLevel = 4;

	private static readonly int summonId_FangWeiBiao = 16100021;

	private static readonly FP fangWeiBiaoLeftTime = 11.5;

	private static readonly FP summonForwardDist = 3;

	private const int fangWeiBiaoMaxCount = 1;

	private const int buff_ChaCha = 16123011;

	private const int hitDmgId_ChaCha = 161320003;

	private const string hittedFx_ChaCha = "Fx_16101_ChaCha_Hitted";

	private static readonly FP chaChaDelay = 3;

	private const int chaChaMaxStack = 3;

	private static readonly int areaTag_TanCe = CommonHelper.StringToHash("TanCe");

	private const int perkId_21 = 516121;

	private int buff_21 = 16121011;

	private int maxCount_FWB_P21 = 2;

	private const int perkId_22 = 516122;

	private int once_22 = 16122011;

	private int buff_22;

	private const int perkId_23 = 516123;

	private int buff_23 = 16123012;

	private int once_23 = 16123011;

	private const int perkId_24 = 516124;

	private int once_24 = 16124011;

	private const int perkId_25 = 516125;

	private int buff_25 = 16125011;

	private FP radius_25 = 6;

	private const int perkId_26 = 516126;

	private int once_26 = 16126001;

	private const int perkId_27 = 516127;

	private int buff_27 = 16127011;

	private int once_27 = 16127001;

	private const int perkId_28 = 516128;

	private int once_28 = 16128001;

	private FP chachaCd_28 = 1;

	private const int perkId_29 = 516129;

	private int buff_29 = 16129011;

	private int buff_29_team = 16129012;

	private int buff_29_vul = 16129013;

	private const int perkId_30 = 516130;

	private int once_30 = 16130001;

	private const int perkId_31 = 516131;

	private int buff_31 = 16131011;

	private const int perkId_32 = 516132;

	private int buff_32 = 16132011;

	private const int perkId_33 = 516133;

	private int buff_33 = 16133011;

	private int buff_33_A = 16133012;

	private int buff_33_B = 16133013;

	private SummonCfg summonCfg_FWB;

	private readonly List<MonsterAdventureActor> _fwbList = new List<MonsterAdventureActor>();

	private readonly Dictionary<long, CoroutineNode> _chachaTimers = new Dictionary<long, CoroutineNode>();

	private readonly Dictionary<long, FP> _chachaCd28Time = new Dictionary<long, FP>();

	private int _seTeamCount;

	private bool _isAllTeamEarth;

	public override void OnEnable()
	{
		base.OnEnable();
		summonCfg_FWB = new SummonCfg
		{
			summonFollowType = SummonFollowType.NotFollow,
			summonAttrType = SummonAttrType.InheritByInitialSnapshot,
			summonRelation = SummonRelation.Independent,
			summonType = SummonType.None,
			useSummonHit = true
		};
		_fwbList.Clear();
		List<PlayerAdventureActor> actorLs = SceneSingleton<AdventurePlayerController>.Instance.ActorLs;
		_seTeamCount = 0;
		for (int i = 0; i < actorLs.Count; i++)
		{
			if (actorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				_seTeamCount++;
			}
		}
		_isAllTeamEarth = actorLs.Count > 0 && _seTeamCount == actorLs.Count;
		if (GetPerk(516133))
		{
			if (_isAllTeamEarth)
			{
				for (int j = 0; j < actorLs.Count; j++)
				{
					if (actorLs.get_Item(j).actorElementInfo.elementType == HotfixEnum.elementType.SE)
					{
						actorLs.get_Item(j).buffComponent.AddBuff(buff_33, _actor);
					}
				}
			}
			else if (_seTeamCount == 1)
			{
				int num = actorLs.Count - _seTeamCount;
				if (num > 0)
				{
					Singleton<BuffManager>.Instance.AddBufftoGroup(buff_33_A, _actor, num);
					_actor.buffComponent.AddBuffNum(buff_33_B, num, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamageForP28);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamageForP28);
		for (int i = 0; i < _fwbList.Count; i++)
		{
			if (_fwbList.get_Item(i) != null && _fwbList.get_Item(i).actorHealthInfo.isAlive)
			{
				_fwbList.get_Item(i).DestroySelf();
			}
		}
		_fwbList.Clear();
		foreach (KeyValuePair<long, CoroutineNode> chachaTimer in _chachaTimers)
		{
			_actor.StopLogicCoroutine(chachaTimer.Value);
		}
		_chachaTimers.Clear();
		_chachaCd28Time.Clear();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerk(516122))
		{
			int num = ((!GetPerk(516127)) ? 1 : 2);
			int num2 = (int)(long)_actor.logicVariable.GetLogicTagValue("161_FangWeiBiaoLv");
			int num3 = num2 + num;
			if (num3 > 4)
			{
				num3 = 4;
			}
			_actor.logicVariable.SetLogicTagValue("161_FangWeiBiaoLv", num3);
			if (num3 > num2)
			{
				AddFWBLevelBuff(num3 - num2);
			}
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		IList<int> hitDamageTag = evt.hitDamageTag;
		if (CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_FWB_CeHui))
		{
			int num = (int)(long)_actor.logicVariable.GetLogicTagValue("161_FangWeiBiaoLv");
			if (GetPerk(516122) && num > 0)
			{
				AdventureActor.AddFromAttr(once_22, _actor, num);
			}
			if (GetPerk(516126) && num >= 2)
			{
				AdventureActor.AddFromAttr(once_26, _actor);
			}
			if (GetPerk(516127))
			{
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(buff_27);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(once_27, _actor, buffNumByID);
				}
			}
		}
		if (CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_ChaCha_Damage))
		{
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(buff_23);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(once_23, _actor, buffNumByID2);
			}
			if (GetPerk(516124))
			{
				AdventureActor.AddFromAttr(once_24, _actor);
			}
			if (GetPerk(516128))
			{
				AdventureActor.AddFromAttr(once_28, _actor);
			}
			if (GetPerk(516130))
			{
				AdventureActor.AddFromAttr(once_30, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		IList<int> hitDamageTag = evt.hitDamageTag;
		bool flag = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_FWB_Probe);
		bool flag2 = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_FWB_Probe_Strong);
		bool flag3 = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_FWB_CeHui);
		bool flag4 = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_FWB_Mark);
		bool flag5 = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_Ultra);
		bool flag6 = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_ChaCha);
		if (flag4)
		{
			EarthMarkUtil.Attach(_actor, monster);
		}
		if (flag3)
		{
			if (GetPerk(516131))
			{
				_actor.buffComponent.AddBuff(buff_31, _actor);
			}
			if (GetPerk(516121) && _isAllTeamEarth)
			{
				monster.buffComponent.AddBuff(buff_21, _actor);
			}
			if (GetPerk(516127))
			{
				_actor.buffComponent.AddBuff(buff_27, _actor);
			}
		}
		if (flag && GetPerk(516123))
		{
			_actor.buffComponent.AddBuff(buff_23, _actor);
		}
		if (flag2)
		{
			int num = (GetPerk(516130) ? 2 : (GetPerk(516124) ? 1 : 0));
			if (num > 0)
			{
				monster.buffComponent.AddBuffNum(16123011, num, _actor);
				TriggerDetonate(monster);
			}
		}
		if (flag6 && GetPerk(516129))
		{
			if (_isAllTeamEarth)
			{
				monster.buffComponent.AddBuff(buff_29, _actor);
			}
			else if (_seTeamCount == 1)
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buff_29_team, _actor);
				monster.buffComponent.AddBuff(buff_29_vul, _actor);
			}
		}
		if (flag5 && GetPerk(516132))
		{
			EarthMarkUtil.Attach(_actor, monster);
			_actor.buffComponent.AddBuff(buff_32, _actor);
		}
	}

	private void OnReceiveDamageForP28(IEvent evt)
	{
		if (GetPerk(516128) && evt is AdventureActorReceiveDamageEvent { from: PlayerAdventureActor { isAssist: false } playerAdventureActor } adventureActorReceiveDamageEvent && playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Vanguard && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.buffComponent.CheckBuffByBuffID(16123011) && (!_chachaCd28Time.TryGetValue(monsterAdventureActor.Id, out var value) || !(_actor.LogicTime - value <= chachaCd_28)))
		{
			_chachaCd28Time.set_Item(monsterAdventureActor.Id, _actor.LogicTime);
			monsterAdventureActor.buffComponent.AddBuff(16123011, _actor);
			TriggerDetonate(monsterAdventureActor);
		}
	}

	public override void OnAreaEnterExit(AdventureAreaEnterExitEvent evt)
	{
		base.OnAreaEnterExit(evt);
		if (evt.iEnter && evt.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag(areaTag_TanCe) && evt.triggerCollider != null && evt.triggerCollider.Entity is MonsterAdventureActor monsterAdventureActor && CommonHelper.IsEntityAlive(monsterAdventureActor) && _actor.IsEntityConfrontAndSearchable(monsterAdventureActor))
		{
			monsterAdventureActor.buffComponent.AddBuff(16123011, _actor);
			TriggerDetonate(monsterAdventureActor);
		}
	}

	private void TriggerDetonate(MonsterAdventureActor monster)
	{
		if (GetPerk(516124) && monster.buffComponent.GetBuffNumByID(16123011) >= 3)
		{
			StopChaChaTimer(monster.Id);
			Detonate(monster, 3);
		}
		else if (!_chachaTimers.ContainsKey(monster.Id))
		{
			_chachaTimers.set_Item(monster.Id, _actor.StartLogicCoroutine(ChaChaTimer(monster)));
		}
	}

	public override void OnBattleReady(AdventureBattleReadyEvent evt)
	{
		for (int i = 0; i < _fwbList.Count; i++)
		{
			if (_fwbList.get_Item(i) != null && _fwbList.get_Item(i).actorHealthInfo.isAlive)
			{
				_fwbList.get_Item(i).DestroySelf();
			}
		}
		_fwbList.Clear();
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == Config.summonFWBEvt)
		{
			DoSummonFangWeiBiao();
		}
		else if (evt.eventHashCode == Config.debuffP25Evt && GetPerk(516125))
		{
			ApplyDebuffInFWBRange();
		}
	}

	private void DoSummonFangWeiBiao()
	{
		CleanDeadFWB();
		int num = ((!GetPerk(516121)) ? 1 : maxCount_FWB_P21);
		while (_fwbList.Count >= num && _fwbList.Count > 0)
		{
			MonsterAdventureActor monsterAdventureActor = _fwbList.get_Item(0);
			_fwbList.RemoveAt(0);
			if (monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				monsterAdventureActor.DestroySelf();
			}
		}
		summonCfg_FWB.leftTime = (GetPerk(516121) ? (fangWeiBiaoLeftTime + 10) : fangWeiBiaoLeftTime);
		TSVector2 linecastHitPoint = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * summonForwardDist;
		if (!_actor.QueryPositionReachable(linecastHitPoint))
		{
			_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
		}
		ILRuntimeAPI.SummonMonster(_actor, 0, summonId_FangWeiBiao, linecastHitPoint, _actor.tsTransform.Forward, summonCfg_FWB, null, (MonsterAdventureActor m) =>
		{
			if (!(m == null))
			{
				_fwbList.Add(m);
				if (GetPerk(516122))
				{
					int num2 = (int)(long)_actor.logicVariable.GetLogicTagValue("161_FangWeiBiaoLv");
					if (num2 > 0)
					{
						m.buffComponent.AddBuffNum(buff_22, num2, _actor);
					}
				}
			}
		}, useTerrainHeight: true);
	}

	private void AddFWBLevelBuff(int stack)
	{
		CleanDeadFWB();
		for (int i = 0; i < _fwbList.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = _fwbList.get_Item(i);
			if (!(monsterAdventureActor == null) && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				monsterAdventureActor.buffComponent.AddBuffNum(buff_22, stack, _actor);
			}
		}
	}

	private void CleanDeadFWB()
	{
		for (int num = _fwbList.Count - 1; num >= 0; num--)
		{
			if (_fwbList.get_Item(num) == null || !_fwbList.get_Item(num).actorHealthInfo.isAlive)
			{
				_fwbList.RemoveAt(num);
			}
		}
	}

	private void ApplyDebuffInFWBRange()
	{
		if (!_isAllTeamEarth)
		{
			return;
		}
		CleanDeadFWB();
		for (int i = 0; i < _fwbList.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = _fwbList.get_Item(i);
			if (monsterAdventureActor == null)
			{
				continue;
			}
			List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(monsterAdventureActor, monsterAdventureActor.tsTransform.Position, radius_25, null, isConfront: true);
			if (list == null)
			{
				continue;
			}
			for (int j = 0; j < list.Count; j++)
			{
				if (list.get_Item(j) is MonsterAdventureActor monsterAdventureActor2)
				{
					monsterAdventureActor2.buffComponent.AddBuff(buff_25, _actor);
				}
			}
		}
	}

	private IEnumerator ChaChaTimer(MonsterAdventureActor monster)
	{
		yield return _actor.WaitTime(chaChaDelay);
		_chachaTimers.Remove(monster.Id);
		Detonate(monster);
	}

	private void Detonate(MonsterAdventureActor monster, int removeCount = 0)
	{
		if (monster == null || monster.buffComponent == null || !monster.actorHealthInfo.isAlive)
		{
			return;
		}
		int buffNumByID = monster.buffComponent.GetBuffNumByID(16123011);
		if (buffNumByID > 0)
		{
			int num = ((removeCount > 0 && removeCount < buffNumByID) ? removeCount : buffNumByID);
			for (int i = 0; i < num; i++)
			{
				ILRuntimeAPI.HitActor(_actor, monster, 161320003, "Fx_16101_ChaCha_Hitted");
			}
			if (removeCount > 0)
			{
				monster.buffComponent.RemoveBuffByBuffId(16123011, num);
			}
			else
			{
				monster.buffComponent.RemoveBuffByBuffId(16123011);
			}
		}
	}

	private void StopChaChaTimer(long id)
	{
		if (_chachaTimers.TryGetValue(id, out var value))
		{
			_actor.StopLogicCoroutine(value);
			_chachaTimers.Remove(id);
		}
	}
}
