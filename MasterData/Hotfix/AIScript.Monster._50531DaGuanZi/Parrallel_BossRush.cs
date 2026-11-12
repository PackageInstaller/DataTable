using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._50531DaGuanZi;

public class Parrallel_BossRush : Parallel_BossRush
{
	private readonly List<int> dashSkillIds = new List<int> { 5053112, 5053106 };

	private readonly int dashSkillHitTag = CommonHelper.StringToHash("DaGuanZi_Dash");

	private readonly string bossTagId = "";

	private readonly List<string> debuff_tags = new List<string> { "DeBuff", "Stun" };

	private readonly int trSkillId = 5053109;

	private readonly int mjSkillId = 5053105;

	private readonly int onceId_ult = 35053101;

	private readonly int onceId_normal = 35053102;

	private readonly int onceId_mark = 35053103;

	private readonly int onceId_skill = 35053104;

	private readonly List<int> jumpSkillIds = new List<int> { 5053103, 5053111, 5053108 };

	private readonly int jumpSkillHitTag = CommonHelper.StringToHash("DaGuanZi_Jump");

	private readonly HotfixEnum.scoreBossBehavior jumpMissScoreEnum = HotfixEnum.scoreBossBehavior.TriggerCommon1;

	private readonly string bossTagId8 = "100015";

	private readonly int buffId_defend = 631015010;

	private readonly int buffId_amplify = 631015020;

	private readonly int initialDefendStacks = 1;

	private readonly FP defendInterval = 5;

	private readonly string bossTagId_markSkillUp = "";

	private readonly int buffId_markSkillUp;

	private bool hasTag;

	private bool hasTag8;

	private bool hasTag_markSkillUp;

	private bool iBeHit;

	private bool jumpBeHit;

	private int bossState;

	private CoroutineNode _defendCor;

	public override void OnStart()
	{
		base.OnStart();
		bossState = 1;
		iBeHit = false;
		jumpBeHit = false;
		hasTag = _actor.CheckTag(bossTagId);
		hasTag8 = _actor.CheckTag(bossTagId8);
		hasTag_markSkillUp = _actor.CheckTag(bossTagId_markSkillUp);
		if (hasTag8 && buffId_defend > 0)
		{
			StartCoroutine(ref _defendCor, DoAddDefendStack());
		}
	}

	public override void OnDisable()
	{
		StopCoroutine(ref _defendCor);
		base.OnDisable();
	}

	private IEnumerator DoAddDefendStack()
	{
		while (_actor != null && _actor.state != ActorState.Action)
		{
			yield return null;
		}
		if (_actor == null)
		{
			yield break;
		}
		if (initialDefendStacks > 0)
		{
			_actor.buffComponent?.AddBuffNum(buffId_defend, initialDefendStacks, _actor);
		}
		while (true)
		{
			yield return _actor.WaitTime(defendInterval);
			if (_actor == null)
			{
				break;
			}
			_actor.buffComponent?.AddBuffNum(buffId_defend, 1, _actor);
		}
	}

	private void ClearDebuff()
	{
		if (_actor != null && debuff_tags.Count > 0)
		{
			for (int i = 0; i < debuff_tags.Count; i++)
			{
				_actor.buffComponent?.RemoveBuffByTag(CommonHelper.StringToHash(debuff_tags.get_Item(i)));
			}
		}
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnActorCastSkill(castSkillEvent);
		if (!(_actor != null) || !(castSkillEvent.sender as AdventureActor == _actor))
		{
			return;
		}
		if (dashSkillIds.Contains(castSkillEvent.skillEventInfo.skillId))
		{
			iBeHit = false;
		}
		if (jumpSkillIds.Contains(castSkillEvent.skillEventInfo.skillId))
		{
			jumpBeHit = false;
		}
		if (hasTag)
		{
			if (castSkillEvent.skillEventInfo.skillId == trSkillId)
			{
				bossState = 1;
				ClearDebuff();
			}
			else if (castSkillEvent.skillEventInfo.skillId == mjSkillId)
			{
				bossState = 2;
				ClearDebuff();
			}
		}
	}

	protected override void OnActorCastEndSkill(AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnActorCastEndSkill(castSkillEvent);
		if (_actor != null && castSkillEvent.sender as AdventureActor == _actor)
		{
			if (dashSkillIds.Contains(castSkillEvent.skillEventInfo.skillId) && !iBeHit && _monster.CheckScoreBossBehaviour(11))
			{
				_monster.TriggerScoreBossBehaviour(11);
			}
			if (jumpSkillIds.Contains(castSkillEvent.skillEventInfo.skillId) && !jumpBeHit && _monster.CheckScoreBossBehaviour((int)jumpMissScoreEnum))
			{
				_monster.TriggerScoreBossBehaviour((int)jumpMissScoreEnum);
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent elementMarkTriggerEvent)
	{
		base.OnElementMarkTrigger(elementMarkTriggerEvent);
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		if (playerAdventureActor == null || elementMarkTriggerEvent.triggerActor != playerAdventureActor)
		{
			return;
		}
		if (hasTag_markSkillUp && buffId_markSkillUp > 0 && elementMarkTriggerEvent.markActor == _actor && _actor.buffComponent != null)
		{
			_actor.buffComponent.AddBuff(buffId_markSkillUp, playerAdventureActor);
		}
		if (!hasTag8 || buffId_defend <= 0 || !(_actor.buffComponent != null) || !_actor.buffComponent.RemoveBuffByBuffId(buffId_defend, 1) || buffId_amplify <= 0)
		{
			return;
		}
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = list.get_Item(i);
			if ((object)playerAdventureActor2 != null && playerAdventureActor2.isAssist && playerAdventureActor2.isResident)
			{
				playerAdventureActor2.buffComponent?.AddBuffNum(buffId_amplify, 1, _actor);
			}
		}
	}

	protected override void OnReceiveBeforeHit(IEvent evt)
	{
		if (!hasTag)
		{
			return;
		}
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (!(monsterAdventureActor == _actor))
		{
			return;
		}
		if (bossState == 1)
		{
			if (adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				AdventureActor.AddToAttr(onceId_ult, monsterAdventureActor);
			}
			else if (adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.NORMAL)
			{
				AdventureActor.AddToAttr(onceId_normal, monsterAdventureActor);
			}
		}
		else if (bossState == 2)
		{
			if (adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.MARK)
			{
				AdventureActor.AddToAttr(onceId_mark, monsterAdventureActor);
			}
			else if (adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				AdventureActor.AddToAttr(onceId_skill, monsterAdventureActor);
			}
		}
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.to is PlayerAdventureActor)
		{
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, dashSkillHitTag))
			{
				iBeHit = true;
			}
			if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, jumpSkillHitTag))
			{
				jumpBeHit = true;
			}
		}
	}
}
