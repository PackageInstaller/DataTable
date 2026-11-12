using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._10301;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Skill = CommonHelper.StringToHash("Skill");

	private int perkId_1 = 1030101;

	private int buffId_1 = 801030110;

	private int perkId_2 = 1030102;

	private int addEnergy_2 = 10;

	private int maxAddEnergy_2 = 50;

	private int perkId_3 = 1030103;

	private int buffId_3 = 801030120;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>();

	private int curAddEnergy_2;

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		curAddEnergy_2 = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			curAddEnergy_2 = 0;
			if (GetPerk(perkId_1))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_1);
			}
			if (GetPerk(perkId_3))
			{
				_actor.buffComponent.AddBuff(buffId_3, _actor);
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			curAddEnergy_2 = 0;
		}
	}

	private void OnReceiveDamageBeDeath(IEvent evt)
	{
		AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = evt as AdventureActorReceiveDamageCanCauseDeadEvent;
		_ = adventureActorReceiveDamageCanCauseDeadEvent.to;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageCanCauseDeadEvent.from.Id && GetPerk(perkId_2) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag, hitTag_Skill) && curAddEnergy_2 < maxAddEnergy_2)
		{
			curAddEnergy_2 += addEnergy_2;
			actor.skillMgr.ModifyEnergyByPercent(actor.mainSkillId, addEnergy_2);
		}
	}
}
