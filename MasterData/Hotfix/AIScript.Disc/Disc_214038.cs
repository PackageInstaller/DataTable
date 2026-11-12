using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214038 : DiscScriptBase
{
	private const int discId = 214038;

	private List<int> skillId_s3 = new List<int> { 4038201, 4038202, 4038203, 4038204, 4038205 };

	private List<int> buff_3_dmg = new List<int> { 4038201, 4038202, 4038203, 4038204, 4038205 };

	private List<int> count_3 = new List<int> { 30, 30, 30, 30, 30 };

	private int lv_s3;

	private int stage_s3;

	private int curCount;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		curCount = 0;
		(stage_s3, lv_s3) = GetDiscInfo(214038, skillId_s3);
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnReceiveDamage(damageEvent);
		if (lv_s3 <= 0 || !(damageEvent.from is PlayerAdventureActor { isAssist: false } playerAdventureActor) || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.LE || damageEvent.skillSlotType != HotfixEnum.skillSlotType.B || playerAdventureActor.buffComponent.CheckBuffByBuffID(buff_3_dmg.get_Item(stage_s3)) || ++curCount <= count_3.get_Item(stage_s3))
		{
			return;
		}
		curCount = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor2.actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				playerAdventureActor2.buffComponent.AddBuff(buff_3_dmg.get_Item(stage_s3), playerAdventureActor2);
			}
		}
	}
}
