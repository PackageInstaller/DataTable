using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11301;

public class ParallelScript : ParallelBase
{
	public int skillId_S1 = 11331001;

	public int skillId_S2 = 11331002;

	public int buff_Water = 4011;

	public int buff_Cold = 4021;

	public int buff_Frozen = 4100;

	public int buffTag_Cold = CommonHelper.StringToHash("Cold");

	public int buffTag_Frozen = CommonHelper.StringToHash("Frozen");

	public int hitTag_NA = CommonHelper.StringToHash("NA");

	public int hitTag_A1_1 = CommonHelper.StringToHash("A1_1");

	public int hitTag_A1_2 = CommonHelper.StringToHash("A1_2");

	public int hitTag_A2 = CommonHelper.StringToHash("A2");

	public int hitTag_A3 = CommonHelper.StringToHash("A3");

	public int hitTag_SM = CommonHelper.StringToHash("MC");

	public int hitTag_SM1 = CommonHelper.StringToHash("Main_S1");

	public int hitTag_SM2 = CommonHelper.StringToHash("Main_S2");

	public int hitTag_SS_Default = CommonHelper.StringToHash("SS_Prepare");

	public int hitTag_SS = CommonHelper.StringToHash("SS");

	public int hitTag_Ultra = CommonHelper.StringToHash("US");

	public int hitTag_Cold = CommonHelper.StringToHash("Cold");

	private FP visionAttackRng = 15;

	private FP hearAttackRng = 15;

	private FP visionRng = 15;

	private FP hearRng = 15;

	private int skillId_NormalAtk_Support = 11332001;

	private int evt_EnterUltra = CommonHelper.StringToHash("EnterUltra");

	private int evt_ExitUltra = CommonHelper.StringToHash("ExitUltra");

	private int evt_TriggerP43 = CommonHelper.StringToHash("TriggerP43");

	private const string tipsKey_TriggerMark = "WaterMark_Trigger_Effect_05";

	private const string areaEffectKey_TriggerWaterCorrosion = "AreaEffect_113_WaterTag1_Boom";

	protected const int maxCount_ColdBuff = 3;

	private const int buffId_Cold = 4021;

	private const int buffId_Freezing = 4100;

	private const int perkId_29 = 511329;

	private const int perkId_30 = 511330;

	private const int perkId_41 = 511341;

	private int once_41 = 11341001;

	private const int perkId_42 = 511342;

	private Dictionary<int, int> dicOnce_42 = new Dictionary<int, int>
	{
		[0] = 0,
		[1] = 11342001,
		[2] = 11342002,
		[3] = 11342003,
		[4] = 11342004,
		[5] = 11342005,
		[6] = 11342006,
		[7] = 11342007,
		[8] = 11342008,
		[9] = 11342009
	};

	private FP hpPercent_42 = 10;

	private const int perkId_43 = 511343;

	private int minCount_43 = 3;

	private int maxCount_43 = 10;

	private FP interval_43 = 0.1f;

	private string areaEffect_43 = "AreaEffect_11301_Ultra_P43_PuddleBoom";

	private string effect_43 = "fx_11301_loop_Ultra_Skill_3";

	private FP delay_43 = 0.5f;

	private FP forwardDis_43 = 1;

	private FP radius_out_43 = 10;

	private FP radius_in_43 = 1;

	private FP angle_43 = 160;

	private int buffId_F1 = 11396111;

	private int buffId_F2 = 11396211;

	private int buffId_F3 = 11396311;

	private int buffId_F4 = 11396411;

	private int buffId_F5 = 11396511;

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public PlayerAdventureActor mainCtrActor;

	public PlayerSkillCd skillMgr;

	private int castCount;

	private List<PlayFX> playFxes = new List<PlayFX>();

	private readonly List<CoroutineNode> corList = new List<CoroutineNode>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PLAYER_SPAWN_COMPLETE", OnMainPlayerSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		perkCd.Clear();
		castCount = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("PLAYER_SPAWN_COMPLETE", OnMainPlayerSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		perkCd.Clear();
		foreach (CoroutineNode cor in corList)
		{
			_actor.StopLogicCoroutine(cor);
		}
		corList.Clear();
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPerfectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (_actor != null)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor);
			}
		}
		else if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			OnHurt(adventureActorReceiveDamageEvent);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnMainPlayerSpawn(IEvent evt)
	{
		if (evt is AdventurePlayeSpawnCompleteEvent evt2)
		{
			OnMainPlayerSpawn(evt2);
		}
	}

	private void OnActorEnter(IEvent _evt)
	{
		if (_evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent && adventurePlayerEnterEvent.player == _actor)
		{
			OnActorEnter(adventurePlayerEnterEvent);
		}
	}

	private void OnActorLeave(IEvent _evt)
	{
		if (_evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent && adventurePlayerLeaveEvent.player == _actor)
		{
			OnActorLeave(adventurePlayerLeaveEvent);
		}
	}

	public virtual void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (CheckTalentLevel(1) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.buffComponent.AddBuff(buffId_F1, _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (CheckTalentLevel(3) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_F3);
		}
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (GetPerkLv(511341, out var lv) & flag)
		{
			BuffCom buffComponent = monster.buffComponent;
			if (buffComponent.CheckBuffByBuffTag(buffTag_Cold) || buffComponent.CheckBuffByBuffTag(buffTag_Frozen) || buffComponent.CheckBuffByBuffTag(CommonDefine.WaterMark1))
			{
				AdventureActor.AddFromAttr(once_41, _actor);
			}
		}
		if (!(GetPerkLv(511342, out lv) & flag))
		{
			return;
		}
		BuffCom buffComponent2 = monster.buffComponent;
		if (buffComponent2.CheckBuffByBuffTag(buffTag_Cold) || buffComponent2.CheckBuffByBuffTag(buffTag_Frozen))
		{
			int key = TSMath.FloorToInt((1 - (FP)monster.actorHealthInfo.hpPercentage) * 100 / hpPercent_42);
			if (dicOnce_42.get_Item(key) > 0)
			{
				AdventureActor.AddFromAttr(dicOnce_42.get_Item(key), _actor);
			}
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		HandleHitTag(monster, evt.hitDamageTag);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if ((GetPerkLv(511343, out var _) & flag) && evt.isKill)
		{
			castCount++;
		}
		if (CheckTalentLevel(3))
		{
			bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SM);
			bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS);
			if (flag2 | flag3)
			{
				_actor.buffComponent.AddBuff(buffId_F3, _actor);
			}
		}
		if (CheckTalentLevel(4) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_NA))
		{
			_actor.buffComponent.AddBuff(buffId_F4, _actor);
		}
		if (CheckTalentLevel(5) && evt.isKill)
		{
			_actor.buffComponent.AddBuff(buffId_F5, _actor);
		}
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent _evt)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == evt_EnterUltra)
		{
			EnterUltraState();
		}
		else if (evt.eventHashCode == evt_ExitUltra)
		{
			ExitUltraState();
		}
		else if (evt.eventHashCode == evt_TriggerP43)
		{
			TriggerP43();
		}
	}

	public virtual void OnMainPlayerSpawn(AdventurePlayeSpawnCompleteEvent evt)
	{
		if (_actor is PlayerAdventureActor { isAssist: not false } playerAdventureActor)
		{
			_actor.ReplaceAnimationGroup();
			_actor.actorSearchTargetInfo.visionAttackRange = visionAttackRng;
			_actor.actorSearchTargetInfo.hearAttackRange = hearAttackRng;
			_actor.actorSearchTargetInfo.hearRange = hearRng;
			_actor.actorSearchTargetInfo.visionRange = visionRng;
			playerAdventureActor.searchType = PlayerActorSearchType.Range;
			playerAdventureActor.moveControlType = PlayerActorMoveType.Range;
			skillMgr.BindSkillIdToButton(ActionKey.Normal, skillId_NormalAtk_Support);
			string localData = playerAdventureActor.GetLocalData("AILeftTime");
			if (!string.IsNullOrEmpty(localData) && CommonUtils.TryParseStringParamToInt(localData, out var intValue) && intValue > 0)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActiveActor(playerAdventureActor);
				(_actor as PlayerAdventureActor).isAssistAIFinish = false;
			}
		}
	}

	public virtual void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
	}

	public virtual void OnActorLeave(AdventurePlayerLeaveEvent evt)
	{
	}

	private void EnterUltraState()
	{
		_actor.ReplaceAnimationGroup();
	}

	private void ExitUltraState()
	{
		_actor.StartLogicCoroutine(DelayReset(0));
	}

	private IEnumerator DelayReset(FP time)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(time));
		_actor.ResumeAnimationGroup();
	}

	private IEnumerator PlayPreEffect(TSVector2 pos, int index)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval_43 * index));
		PlayFX playFX = new PlayFX();
		playFxes.Add(playFX);
		playFX.Play(_actor, effect_43, 1f, 0, pos, _actor.transform.rotation);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(delay_43));
		playFX.Stop();
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_43, pos);
	}

	public int[] DistributeBallsAtLeastOne(int M, int N)
	{
		int[] array = new int[N];
		for (int i = 0; i < N; i++)
		{
			array[i] = 1;
		}
		int num = M - N;
		for (int j = 0; j < num; j++)
		{
			int num2 = TSRandom.Range(0, N);
			array[num2]++;
		}
		return array;
	}

	public void HandleHitTag(MonsterAdventureActor monster, IList<int> hitDamageTags)
	{
		bool flag = CommonUtils.CheckHitByTag(hitDamageTags, hitTag_Cold);
		CommonUtils.CheckHitByTag(hitDamageTags, hitTag_SM);
		CommonUtils.CheckHitByTag(hitDamageTags, hitTag_SS);
		CommonUtils.CheckHitByTag(hitDamageTags, hitTag_A1_2);
		CommonUtils.CheckHitByTag(hitDamageTags, hitTag_A3);
		CommonUtils.CheckHitByTag(hitDamageTags, hitTag_Ultra);
		if (flag)
		{
			TriggerCold(monster);
		}
	}

	private void TriggerCold(MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckElementMark(CommonDefine.WaterMark1, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			monster.buffComponent.RemoveBuffByTag(CommonDefine.WaterMark1);
			monster.buffComponent.AddBuff(4021, _actor);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_113_WaterTag1_Boom", monster.tsTransform.Position);
			if (monster.buffComponent.GetBuffNum(0, 0, buffTag_Cold) >= 3)
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_Cold);
				monster.buffComponent.AddBuff(4100, _actor);
			}
			CommonUtils.TriggerElementMarkEvent(CommonDefine.WaterMark1, HotfixEnum.AdventureActorElementTriggerType.WaterElementTriggerType1, _actor, monster, "WaterMark_Trigger_Effect_05");
			if (CheckTalentLevel(2))
			{
				_actor.buffComponent.AddBuff(buffId_F2, _actor);
			}
		}
	}

	private void TriggerP43()
	{
		if (!GetPerkLv(511343, out var _))
		{
			return;
		}
		int num = Mathf.Clamp(castCount + 3, minCount_43, maxCount_43);
		TSVector2 position = _actor.tsTransform.Position + forwardDis_43 * _actor.tsTransform.Forward;
		DeterministicShape deterministicFanShape = CommonUtils.GetDeterministicFanShape(radius_out_43, radius_in_43, angle_43, position, _actor.tsTransform.Rotation);
		List<LogicEntity> monstersFromShape = ILRuntimeAPI.GetMonstersFromShape(_actor, deterministicFanShape);
		if (monstersFromShape.Count == 0)
		{
			for (int i = 0; i < num; i++)
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, deterministicFanShape);
				CoroutineNode item = _actor.StartLogicCoroutine(PlayPreEffect(randomPointInShape, i));
				corList.Add(item);
			}
		}
		else if (monstersFromShape.Count == 1)
		{
			for (int j = 0; j < num; j++)
			{
				TSVector2 position2 = monstersFromShape.get_Item(0).tsTransform.Position;
				CoroutineNode item2 = _actor.StartLogicCoroutine(PlayPreEffect(position2, j), runImmediately: true);
				corList.Add(item2);
			}
		}
		else if (num > monstersFromShape.Count)
		{
			int[] array = DistributeBallsAtLeastOne(num, monstersFromShape.Count);
			for (int k = 0; k < monstersFromShape.Count; k++)
			{
				TSVector2 position3 = monstersFromShape.get_Item(k).tsTransform.Position;
				int num2 = array[k];
				for (int l = 0; l < num2; l++)
				{
					CoroutineNode item3 = _actor.StartLogicCoroutine(PlayPreEffect(position3, l), runImmediately: true);
					corList.Add(item3);
				}
			}
		}
		else
		{
			for (int m = 0; m < num; m++)
			{
				TSVector2 position4 = monstersFromShape.get_Item(m).tsTransform.Position;
				CoroutineNode item4 = _actor.StartLogicCoroutine(PlayPreEffect(position4, m), runImmediately: true);
				corList.Add(item4);
			}
		}
		castCount = 0;
	}

	public bool CheckCd(int perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, _actor.LogicTime);
			}
		}
		else
		{
			perkCd.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
