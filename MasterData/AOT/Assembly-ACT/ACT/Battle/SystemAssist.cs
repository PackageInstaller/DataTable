using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class SystemAssist : EntitySystem
{
	private int m_LastCharacterId;

	private bool m_IsTriggerAssistBack;

	private float m_HitCoolDown;

	private static readonly int WeaponAnimExit = Animator.StringToHash("weaponAnimExit");

	public int LastCharacterId => m_LastCharacterId;

	public bool IsTriggerAssistBack => m_IsTriggerAssistBack;

	public override Filter MajorFilter => null;

	protected override void OnCreate()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnBeforeBattleCharacterChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleOnHit, OnBattleHit);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnPerfectDodge, OnPerfectDodge);
	}

	protected override void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnBeforeBattleCharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleOnHit, OnBattleHit);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnPerfectDodge, OnPerfectDodge);
	}

	private void DispatchAssistBackEvt()
	{
		AssistBackEvt evt = Singleton<EventManager>.instance.GetEvt<AssistBackEvt>();
		evt.isTriggerAssistBack = IsTriggerAssistBack;
		evt.lastCharacterId = m_LastCharacterId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Assist_AssistBack, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnPerfectDodge(BaseEventContent content)
	{
		if (content is PerfectDodgeEvent { entity: { IsValid: not false } } perfectDodgeEvent && perfectDodgeEvent.entity.IsCharacter())
		{
			ChangeAssistValueForCharacter(perfectDodgeEvent.entity, perfectDodgeEvent.entity.GetCompAbility().PerfectDodgeRecoverAssistValue, CompAbility.AssistChangeReason.PerfectDodge);
		}
	}

	private void OnBattleHit(BaseEventContent content)
	{
		if (m_HitCoolDown <= 0f && content is HitEvt { target: { IsValid: not false } } hitEvt && hitEvt.target.IsCharacter())
		{
			CompAbility compAbility = hitEvt.target.GetCompAbility();
			ChangeAssistValueForCharacter(hitEvt.target, compAbility.BeHitRecoverAssistValue, CompAbility.AssistChangeReason.Hit);
			m_HitCoolDown = compAbility.HitRecoveryAssistCD;
		}
	}

	private void OnBeforeBattleCharacterChange(BaseEventContent content)
	{
		if (content is BattleCharacterChangeEvt { newEb: { IsValid: not false } } battleCharacterChangeEvt && battleCharacterChangeEvt.newEb.GetCompMotion().IsRemain)
		{
			EndRemain(battleCharacterChangeEvt.newEb);
		}
	}

	private void OnBattleCharacterChange(BaseEventContent content)
	{
		if (content is BattleCharacterChangeEvt { lastEb: { IsValid: not false } } battleCharacterChangeEvt)
		{
			m_LastCharacterId = battleCharacterChangeEvt.lastEb.GetCompCharacter().characterSource.Id();
		}
		m_IsTriggerAssistBack = false;
		DispatchAssistBackEvt();
	}

	public void TriggerAssistBack(Entity entityReference, Ability ability)
	{
		if (entityReference.IsValid && !m_IsTriggerAssistBack)
		{
			m_IsTriggerAssistBack = true;
			DispatchAssistBackEvt();
			SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
			EvtTriggerAssistBack evt = systemAbility.GetEvt<EvtTriggerAssistBack>(entityReference, ability);
			evt.mainEntity = entityReference;
			systemAbility.FireEvt(evt);
			systemAbility.ReleaseEvt(evt);
		}
	}

	public void CancelAssistBack(Entity entityReference, Ability ability)
	{
		if (entityReference.IsValid)
		{
			m_IsTriggerAssistBack = false;
			DispatchAssistBackEvt();
		}
	}

	public bool TryAssist(Entity before, Entity after, SwitchSkillPosData data)
	{
		if (!before.IsValid || !after.IsValid || MonoECS.instance.playState != PlayState.Battle || before.InTag(MotionTag_backUp.ForbidSwitchSkill))
		{
			return false;
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtFindSwitchPos evt = systemAbility.GetEvt<EvtFindSwitchPos>(after, null);
		evt.mainEntity = after;
		evt.beforeEntity = before;
		evt.forwardBounds = after.GetConfig().switchSkillForwardBounds;
		evt.backBounds = after.GetConfig().switchSkillBackBounds;
		evt.data = data;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
		if (data.target == null)
		{
			return false;
		}
		EvtTryAssist evt2 = systemAbility.GetEvt<EvtTryAssist>(before, null);
		evt2.mainEntity = before;
		evt2.before = before;
		evt2.after = after;
		systemAbility.FireEvt(evt2);
		bool canAssist = evt2.canAssist;
		systemAbility.ReleaseEvt(evt2);
		if (!canAssist)
		{
			return false;
		}
		int num = after.GetCompCharacter().characterSource.Id();
		if (IsTriggerAssistBack && num == LastCharacterId)
		{
			m_IsTriggerAssistBack = false;
			DispatchAssistBackEvt();
			EvtAssistBackChange evt3 = systemAbility.GetEvt<EvtAssistBackChange>(after, null);
			evt3.mainEntity = after;
			systemAbility.FireEvt(evt3);
			systemAbility.ReleaseEvt(evt3);
			before.GetCompAbility().CostAssist();
			return true;
		}
		if (!before.GetCompAbility().CanAssist(after.GetCompAbility().AssistCost))
		{
			return false;
		}
		before.GetCompAbility().CostAssist();
		return true;
	}

	public (bool, bool) CanRemain(Entity before, Entity after)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtSetCanRemain evt = systemAbility.GetEvt<EvtSetCanRemain>(before, null);
		evt.mainEntity = before;
		evt.after = after;
		systemAbility.FireEvt(evt);
		bool canRemain = evt.canRemain;
		bool showCharacter = evt.showCharacter;
		systemAbility.ReleaseEvt(evt);
		return (canRemain, showCharacter);
	}

	public void TriggerRemain(Entity entity, bool showCharacter)
	{
		if (entity.IsValid)
		{
			CompMotion compMotion = entity.GetCompMotion();
			compMotion.IsRemain = true;
			if (showCharacter)
			{
				compMotion.IsRemainShowCharacter = true;
				compMotion.SetTrigger("assistRemain");
				CompBehave? compBehave = entity.GetCompBehave();
				compBehave.EntityTags.AddTag(EntityTag.IgnoreAttack);
				compBehave.EntityTags.AddTag(EntityTag.IgnoreTrap);
			}
		}
	}

	public override void FixedUpdate()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsBehaveAvailable() && m_HitCoolDown > 0f)
		{
			m_HitCoolDown -= mainEntity.GetCompTime().fixedDeltaTime;
		}
	}

	public void ChangeAssistValueForCharacter(Entity entity, float value, CompAbility.AssistChangeReason reason)
	{
		if (entity.IsValid && !(value <= 0f))
		{
			CompAbility? compAbility = entity.GetCompAbility();
			float assistValue = compAbility.AssistValue;
			compAbility.ChangeAssistValue(value);
			float assistValue2 = compAbility.AssistValue;
			float valueChange = assistValue2 - assistValue;
			AssistValueChange evt = EventTrackSolver.Instance.GetEvt<AssistValueChange>();
			evt.valueBefore = assistValue;
			evt.valueAfter = assistValue2;
			evt.valueChange = valueChange;
			evt.reason = reason.ToString();
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public void ClearAssistValueForCharacter(Entity entity, CompAbility.AssistChangeReason reason)
	{
		if (entity.IsValid)
		{
			CompAbility? compAbility = entity.GetCompAbility();
			float assistValue = compAbility.AssistValue;
			compAbility.ClearAssistValue();
			float assistValue2 = compAbility.AssistValue;
			float valueChange = assistValue2 - assistValue;
			AssistValueChange evt = EventTrackSolver.Instance.GetEvt<AssistValueChange>();
			evt.valueBefore = assistValue;
			evt.valueAfter = assistValue2;
			evt.valueChange = valueChange;
			evt.reason = reason.ToString();
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public void EndRemain(Entity entity)
	{
		CompMotion compMotion = entity.GetCompMotion();
		if (!compMotion.IsRemain)
		{
			return;
		}
		compMotion.IsRemain = false;
		if (compMotion.IsRemainShowCharacter)
		{
			compMotion.IsRemainShowCharacter = false;
			Singleton<GameManager>.instance.ecsManager.systemBehave.SetMotionMustDo(entity);
			MonoECS.instance.FireChangeEffect(entity, GameLoader.meta.switchSkillChangeCharacter.hide.effectAssetID, GameLoader.meta.switchSkillChangeCharacter.hide.delayTime, isConnect: false, default, null, null, noOwner: true).Forget();
			MonoECS.instance.SetBehaveActive(entity, value: false);
			MonoECS.instance.EntityDissolve(entity, 0f, isShow: false);
			MonoECS.instance.ResetEffect(entity, isBack: true);
			compMotion.SetBool("isActive", b: false);
			CompBehave? compBehave = entity.GetCompBehave();
			GameObject weaponModel = compBehave.MonoEntity.weaponModel;
			if ((object)weaponModel != null && weaponModel.TryGetComponent<Animator>(out var component))
			{
				component.SetTrigger(WeaponAnimExit);
			}
			compBehave.EntityTags.RemoveTag(EntityTag.IgnoreAttack);
			compBehave.EntityTags.RemoveTag(EntityTag.IgnoreTrap);
		}
	}

	public bool TryRogueAssist(Entity before, Entity after)
	{
		if (!before.IsValid || !after.IsValid)
		{
			return false;
		}
		if (before.InTag(MotionTag_backUp.ForbidSwitchSkill))
		{
			return false;
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtTryAssist evt = systemAbility.GetEvt<EvtTryAssist>(before, null);
		evt.mainEntity = before;
		evt.before = before;
		evt.after = after;
		systemAbility.FireEvt(evt);
		bool canAssist = evt.canAssist;
		systemAbility.ReleaseEvt(evt);
		if (!canAssist)
		{
			return false;
		}
		return true;
	}
}
