using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214039 : DiscScriptBase
{
	private const int discId = 214039;

	private int buff;

	private List<int> skillId_s1 = new List<int> { 403901, 403902, 403903, 403904, 403905, 403906 };

	private List<int> buff_1_dmg = new List<int> { 4039041, 4039042, 4039043, 4039044, 4039045, 4039046 };

	private List<int> skillId_s3 = new List<int> { 4039201, 4039202, 4039203, 4039204, 4039205 };

	private List<int> buff_3_Mark = new List<int> { 4039200, 4039200, 4039200, 4039200, 4039200 };

	private List<int> buff_3_Skill = new List<int> { 4039201, 4039202, 4039203, 4039204, 4039205 };

	private int lv_s1;

	private int lv_s3;

	private int stage_s1;

	private int stage_s3;

	private bool inUltra;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		inUltra = false;
		(stage_s3, lv_s3) = GetDiscInfo(214039, skillId_s3);
		(stage_s1, lv_s1) = GetDiscInfo(214039, skillId_s1);
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		if (lv_s1 > 0 && castSkillEvent.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE && !playerAdventureActor.isAssist && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			inUltra = true;
		}
		if (lv_s3 <= 0 || !(castSkillEvent.sender is PlayerAdventureActor playerAdventureActor2) || playerAdventureActor2.actorElementInfo.elementType != HotfixEnum.elementType.LE || playerAdventureActor2.isAssist || castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		int buffNumByID = playerAdventureActor2.buffComponent.GetBuffNumByID(buff_3_Mark.get_Item(stage_s3));
		if (buffNumByID <= 0)
		{
			return;
		}
		playerAdventureActor2.buffComponent.RemoveBuffByBuffId(buff_3_Mark.get_Item(stage_s3));
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor3 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor3.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				playerAdventureActor3.buffComponent.RemoveBuffByBuffId(buff_3_Skill.get_Item(stage_s3));
				playerAdventureActor3.buffComponent.AddBuffNum(buff_3_Skill.get_Item(stage_s3), buffNumByID, playerAdventureActor3);
			}
		}
	}

	protected override void OnCastEndSkill(AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnCastEndSkill(castSkillEvent);
		if (lv_s1 > 0 && castSkillEvent.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE && !playerAdventureActor.isAssist && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			inUltra = false;
		}
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnReceiveDamage(damageEvent);
		if (lv_s3 > 0 && damageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE && damageEvent.damageType == HotfixEnum.damageType.SKILL && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.LE && !mainCtrActor.isAssist)
		{
			mainCtrActor.buffComponent.AddBuff(buff_3_Mark.get_Item(stage_s3), playerAdventureActor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent _evt)
	{
		base.OnElementMarkTrigger(_evt);
		if (lv_s1 <= 0 || !inUltra || !(_evt.triggerActor is PlayerAdventureActor playerAdventureActor) || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.LE)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				playerAdventureActor2.buffComponent.AddBuff(buff_1_dmg.get_Item(stage_s1), playerAdventureActor2);
			}
		}
	}
}
