using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214033 : DiscScriptBase
{
	private const int discId = 214033;

	private int buff_state = 4033041;

	private List<int> skillId_s1 = new List<int> { 403301, 403302, 403303, 403304, 403305, 403306 };

	private List<int> buff_1_dmg = new List<int> { 4033001, 4033002, 4033003, 4033004, 4033005, 4033006 };

	private List<int> once_1_skill = new List<int> { 4033007, 4033008, 4033009, 4033010, 4033011, 4033012 };

	private List<int> buff_1_dehurt = new List<int> { 4033041, 4033041, 4033041, 4033041, 4033041, 4033041 };

	private FP hpPercent_1 = 0.5;

	private List<int> skillId_s2 = new List<int> { 4033101, 4033102, 4033103, 4033104, 4033105 };

	private List<int> buff_2_atk = new List<int> { 4033106, 4033107, 4033108, 4033109, 4033110 };

	private int stage_1;

	private int stage_2;

	private int lv_s1;

	private int lv_s2;

	private bool isBuffAdd;

	private CoroutineNode corBuff;

	private AdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		(int, int) discInfo = GetDiscInfo(214033, skillId_s1);
		stage_1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214033, skillId_s2);
		stage_2 = discInfo.Item1;
		lv_s2 = discInfo.Item2;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && lv_s1 > 0)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_1_dmg.get_Item(stage_1), _actor);
			}
		}
		if (lv_s1 > 0 && mainCtrActor != null && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
		{
			StartCoroutine(ref corBuff, DoAddBuff());
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		StopCoroutine(ref corBuff);
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.actorElementInfo.elementType == HotfixEnum.elementType.SE && damageEvent.damageType == HotfixEnum.damageType.SKILL && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && mainCtrActor.actorHealthInfo.hpPercentage > hpPercent_1)
		{
			AdventureActor.AddFromAttr(once_1_skill.get_Item(stage_1), actor);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (lv_s2 <= 0 || !(evt is AdventureActorGetBuff { sender: PlayerAdventureActor { isAssist: false } } adventureActorGetBuff) || adventureActorGetBuff.eventInfo.buffId != buff_state)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_2_atk.get_Item(stage_2), _actor);
			}
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (lv_s2 <= 0 || !(evt is AdventureActorRemoveBuff { sender: PlayerAdventureActor { isAssist: false } } adventureActorRemoveBuff) || adventureActorRemoveBuff.eventInfo.buffId != buff_state)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(buff_2_atk.get_Item(stage_2));
			}
		}
	}

	private IEnumerator DoAddBuff()
	{
		while (true)
		{
			if (mainCtrActor != null && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				isBuffAdd = mainCtrActor.buffComponent.CheckBuffByBuffID(buff_state);
				if (mainCtrActor.actorHealthInfo.hpPercentage > hpPercent_1)
				{
					if (!isBuffAdd)
					{
						for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
						{
							PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
							if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE)
							{
								playerAdventureActor.buffComponent.AddBuff(buff_1_dehurt.get_Item(stage_1), _actor);
							}
						}
					}
				}
				else if (isBuffAdd)
				{
					for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
					{
						PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
						if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.SE)
						{
							playerAdventureActor2.buffComponent.RemoveBuffByBuffId(buff_1_dehurt.get_Item(stage_1));
						}
					}
				}
			}
			yield return null;
		}
	}
}
