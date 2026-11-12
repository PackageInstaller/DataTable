using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214006 : DiscScriptBase
{
	private const int discId = 214006;

	private List<int> skillId_s1 = new List<int> { 4006000, 4006001, 4006002, 4006003, 4006004 };

	private List<int> buff_s1v1_atk = new List<int> { 4006000, 4006001, 4006002, 4006003, 4006004 };

	private List<int> buff_s1v1_extra = new List<int> { 4006005, 4006005, 4006005, 4006005, 4006005 };

	private int buff_s1v2_dmg = 4006006;

	private int maxCount_s1v2 = 6;

	private int buff_s1v3_dmg = 4006007;

	private FP range_s1v3 = 20;

	private string effect_s1v3 = "FX/ActorCommon/fx_common_base_astrolabe_13501";

	private int buff_s1v4_atk = 4006008;

	private int buff_s1v5_atk = 4006009;

	private FP interval_slv5 = 1;

	private int lv_s1;

	private int stage_s1;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<LogicEntity> entities = new List<LogicEntity>();

	private int summonCount;

	private FP triggerTime;

	private PlayFX playFX = new PlayFX();

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		summonCount = 0;
		triggerTime = 0;
		(stage_s1, lv_s1) = GetDiscInfo(214006, skillId_s1);
		if (lv_s1 < 1)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_s1v1_atk.get_Item(stage_s1), playerAdventureActor);
			}
		}
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		PlayerAdventureActor playerAdventureActor = evt.sender as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && lv_s1 > 0 && playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			playerAdventureActor.buffComponent.AddBuff(buff_s1v1_extra.get_Item(stage_s1), playerAdventureActor);
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.from != null && damageEvent.from is PlayerAdventureActor playerAdventureActor && damageEvent.to as MonsterAdventureActor != null && lv_s1 >= 5 && playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE && (mainCtrActor.LogicTime - triggerTime > interval_slv5 || triggerTime <= 0))
		{
			playerAdventureActor.buffComponent.AddBuff(buff_s1v5_atk, playerAdventureActor);
			triggerTime = mainCtrActor.LogicTime;
		}
	}

	private void OnActorSpawned(IEvent _evt)
	{
		AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)_evt;
		if (adventurActorSpawned == null)
		{
			return;
		}
		AdventureActor adventureActor = adventurActorSpawned.sender as AdventureActor;
		if (!(adventureActor is MonsterAdventureActor) || !adventureActor.IsPlayerMinion(out var summoner))
		{
			return;
		}
		if (lv_s1 >= 2)
		{
			summonCount++;
			if (summonCount <= maxCount_s1v2)
			{
				CommonUtils.GetAllSummons(monsters);
				for (int i = 0; i < monsters.Count; i++)
				{
					monsters.get_Item(i).buffComponent.RemoveBuffByBuffId(buff_s1v2_dmg);
					monsters.get_Item(i).buffComponent.AddBuffNum(buff_s1v2_dmg, summonCount, monsters.get_Item(i));
				}
			}
		}
		if (lv_s1 >= 4 && summoner.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			summoner.buffComponent.AddBuff(buff_s1v4_atk, summoner);
		}
	}

	protected override void OnDied(AdventureActorDiedEvent evt)
	{
		if (!(evt.actor is MonsterAdventureActor) || !evt.actor.IsPlayerMinion(out var _))
		{
			return;
		}
		if (lv_s1 >= 2)
		{
			summonCount--;
			if (summonCount <= maxCount_s1v2)
			{
				int buffID = buff_s1v2_dmg;
				CommonUtils.GetAllSummons(monsters);
				for (int i = 0; i < monsters.Count; i++)
				{
					monsters.get_Item(i).buffComponent.RemoveBuffByBuffId(buffID, 1);
				}
			}
		}
		if (lv_s1 < 3)
		{
			return;
		}
		CommonUtils.SearchNearTargetsByCircle(evt.actor, range_s1v3, isConfront: true, includeSelf: false, entities);
		for (int j = 0; j < entities.Count; j++)
		{
			MonsterAdventureActor monsterAdventureActor = entities.get_Item(j) as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_s1v3_dmg, evt.actor);
			}
		}
		playFX.Play(evt.actor, effect_s1v3, 1f, evt.actor.transform.position, evt.actor.transform.rotation);
	}
}
