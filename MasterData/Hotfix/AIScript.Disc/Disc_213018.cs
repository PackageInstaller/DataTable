using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_213018 : DiscScriptBase
{
	private const int discId = 213018;

	private List<int> skillId_s1 = new List<int> { 3018000, 3018001, 3018002, 3018003, 3018004 };

	private const int num_sc = 4021000;

	private const int power_sc = 4021001;

	private const int cd_sc = 4021002;

	private List<int> skillId_s2 = new List<int> { 40211, 0, 0, 0, 0 };

	private const int onceID = 4021100;

	private const int onceID2 = 4021101;

	private int skill1_level;

	private int skill2_level;

	private FP power_value;

	private FP cd_value;

	private int num_value;

	private int currntNum;

	private readonly Dictionary<long, FP> _personTriggerTimeDic = new Dictionary<long, FP>(20);

	public bool CheckPersonCd(long uid, FP Cd)
	{
		if (Cd <= 0 || Cd == default(FP))
		{
			return true;
		}
		bool result = false;
		if (_personTriggerTimeDic.TryGetValue(uid, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				_personTriggerTimeDic.set_Item(uid, _actor.LogicTime);
			}
		}
		else
		{
			_personTriggerTimeDic.Add(uid, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		skill1_level = GetDiscSkillv(213018, skillId_s1);
		skill2_level = GetDiscSkillv(213018, skillId_s2);
		if (skill1_level > 0)
		{
			currntNum = 0;
			power_value = CommonUtils.GetScriptValue(_actor, 4021001);
			cd_value = CommonUtils.GetScriptValue(_actor, 4021002);
			num_value = CommonUtils.GetScriptValue(_actor, 4021000).AsInt();
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnPlayerActorKill(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorDiedEvent diedEvent)
	{
		base.OnPlayerActorKill(actor, target, diedEvent);
		if (skill1_level >= 2 && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			currntNum++;
			if (currntNum >= num_value && CheckPersonCd(actor.Id, cd_value))
			{
				currntNum = 0;
				actor.playerSkillCd.AddEnergy(power_value);
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (skill2_level >= 1 && actor.actorElementInfo.elementType == HotfixEnum.elementType.WE && target != null && target.actorHealthInfo.hpPercentage >= FDP.FromDouble(0.999))
		{
			AdventureActor.AddFromAttr(4021100, actor);
			if (damageEvent.skillSlotType == HotfixEnum.skillSlotType.D)
			{
				AdventureActor.AddFromAttr(4021101, actor);
			}
		}
	}
}
