using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214024 : DiscScriptBase
{
	private const int discId = 214024;

	private List<int> skillId_s3 = new List<int> { 4024201, 4024202, 4024203, 4024204, 4024205 };

	private List<int> buff_s3 = new List<int> { 4024200, 4024200, 4024200, 4024200, 4024200 };

	private List<int> once_s3 = new List<int> { 4024201, 4024202, 4024203, 4024204, 4024205 };

	private int lv_s3;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		(stage_s3, lv_s3) = GetDiscInfo(214024, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && lv_s3 > 0)
		{
			PlayerAdventureActor playerAdventureActor = adventureActorGetBuff.from as PlayerAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE && playerAdventureActor.isAssist && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Wind))
			{
				playerAdventureActor.buffComponent.AddBuff(buff_s3.get_Item(stage_s3), playerAdventureActor);
			}
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforeHit(damageEvent);
		if (lv_s3 > 0 && damageEvent.from is PlayerAdventureActor playerAdventureActor && damageEvent.to is MonsterAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE && playerAdventureActor.isAssist && playerAdventureActor.buffComponent.CheckBuffByBuffID(buff_s3.get_Item(stage_s3)))
		{
			AdventureActor.AddFromAttr(once_s3.get_Item(stage_s3), playerAdventureActor);
		}
	}
}
