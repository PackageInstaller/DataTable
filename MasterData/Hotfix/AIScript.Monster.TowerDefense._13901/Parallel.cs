using System.Collections.Generic;

namespace AIScript.Monster.TowerDefense._13901;

public class Parallel : TowerCharacterParalletBase
{
	public const int buffId_Soul = 801390050;

	private const int buffId_Base = 801390030;

	private const int perkId_1 = 1390101;

	private const int buffId_1 = 801390060;

	private const int perkId_3 = 1390103;

	public const int buffId_3 = 801390040;

	private const int maxCount = 3;

	public const int perkId_4 = 1390104;

	public const string comboTag_Skill_P4 = "139_Skill_Sup_P22";

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1390107] = 25 };

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff { sender: AdventureActor sender } adventureActorGetBuff && sender == _actor && adventureActorGetBuff.eventInfo.buffId == 801390050)
		{
			_actor.buffComponent?.AddBuff(801390030, _actor);
			if (GetPerk(1390101))
			{
				_actor.buffComponent?.AddBuff(801390060, _actor);
			}
			if (GetPerk(1390103) && adventureActorGetBuff.buff.GetBuffNum() >= 3)
			{
				_actor.buffComponent?.RemoveBuffByBuffId(801390050);
				_actor.buffComponent?.RemoveBuffByBuffId(801390030);
				_actor.buffComponent?.RemoveBuffByBuffId(801390060);
				_actor.buffComponent?.AddBuff(801390040, _actor);
			}
		}
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
		if (!evt.isNew || evt.actorDataId != _actor.dataID)
		{
			return;
		}
		if (evt.perkId == 1390101)
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(801390050);
			if (buffNumByID > 0)
			{
				_actor.buffComponent.AddBuffNum(801390060, buffNumByID, _actor);
			}
		}
		if (evt.perkId == 1390103 && _actor.buffComponent.GetBuffNumByID(801390050) >= 3)
		{
			_actor.buffComponent.RemoveBuffByBuffId(801390050);
			_actor.buffComponent.RemoveBuffByBuffId(801390030);
			_actor.buffComponent?.RemoveBuffByBuffId(801390060);
			_actor.buffComponent.AddBuff(801390040, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		_ = monster == null;
	}

	public void OnUpdate()
	{
	}
}
