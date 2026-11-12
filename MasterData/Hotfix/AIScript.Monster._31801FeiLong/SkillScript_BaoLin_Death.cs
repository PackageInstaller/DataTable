using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_BaoLin_Death : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		PlayFx("", 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, default);
		yield return WaitTime(Config.delayTime_BaoLin_Active);
		BeginAttack(0, "", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, ""))
		{
			long areaEffectId = PlayAreaEffect("", _actor.tsTransform.Position);
			TriggerOther(areaEffectId);
		}
	}

	private void TriggerOther(long areaEffectId)
	{
		if (areaEffectId <= 0)
		{
			return;
		}
		AreaEffectEntity areaEffect = GetAreaEffect(areaEffectId);
		if (areaEffect == null)
		{
			return;
		}
		List<DeterministicCollider> list = new List<DeterministicCollider>();
		areaEffect.DeterministicCollision(list, 256);
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (DeterministicCollider item in list)
		{
			if (item.Entity is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.CheckTag(Config.tag_BaoLin) && !monsterAdventureActor.IsDead())
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = monsterAdventureActor;
				adventureActorCustomEvent.actor = monsterAdventureActor;
				adventureActorCustomEvent.eventHashCode = Config.eventHashCode_BaoLin_Explosion;
				monsterAdventureActor.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}
}
