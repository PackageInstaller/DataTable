using System.Collections.Generic;
using AIScript.Monster.Template;

namespace AIScript.Monster._15510FengNiao;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private static readonly int area_tag = CommonHelper.StringToHash("FengNiaoUltraWarning");

	private const int num_dodge = 5;

	private int[] teamIDs = new int[4] { 1096562176, 1952805747, 1918065779, 1867013987 };

	private bool area_finish;

	private bool dodge_finish;

	private bool damadge_finish;

	private int num_dodge_current;

	private bool beHit;

	private bool enterArea;

	private List<int> monsterIds;

	public override void OnStart()
	{
		base.OnStart();
		num_dodge_current = 0;
		beHit = false;
		enterArea = false;
		area_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengNiao_001);
		dodge_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengNiao_002);
		damadge_finish = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FengNiao_003);
		if (!area_finish)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		}
		if (!dodge_finish)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfectDodge);
		}
		if (!damadge_finish)
		{
			monsterIds = new List<int>();
			for (int i = 0; i < teamIDs.Length; i++)
			{
				monsterIds.Add(CommonHelper.GetMonsterTeammateId(teamIDs[1], i));
			}
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		if (!area_finish)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		}
		if (!dodge_finish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfectDodge);
		}
		if (!damadge_finish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (_actor != null && adventureAreaEnterExitEvent.triggerCollider?.Entity != null && adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag(area_tag) && _player != null && adventureAreaEnterExitEvent.triggerCollider.Entity.Id == _player.Id)
		{
			enterArea = adventureAreaEnterExitEvent.iEnter;
		}
	}

	private void OnTriggerPerfectDodge(IEvent evt)
	{
		if (!((evt as AdventurePerfectDodgeTrigger).actor != _player))
		{
			num_dodge_current++;
			if (num_dodge_current == 5)
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengNiao_002);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && adventureActorReceiveDamageEvent.to == _player && adventureActorReceiveDamageEvent.from is MonsterAdventureActor monsterAdventureActor && monsterIds != null && monsterIds.Contains(monsterAdventureActor.dataID))
		{
			beHit = true;
		}
	}

	public void OnUpdate()
	{
		if (!area_finish && _actor.logicVariable.GetLogicTagToggle("UltraSkillAchievementReady") && enterArea)
		{
			area_finish = true;
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengNiao_001);
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		base.OnActorDied(e);
		if (e is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.Id == _actor.Id && !(adventureActorDiedEvent.killer == null) && adventureActorDiedEvent.killer.Id != _actor.Id && !damadge_finish && !beHit)
		{
			ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FengNiao_003);
		}
	}
}
