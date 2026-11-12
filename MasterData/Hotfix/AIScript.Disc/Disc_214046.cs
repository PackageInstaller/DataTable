using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214046 : DiscScriptBase
{
	private const int discId = 214046;

	private List<int> skillId_s1 = new List<int> { 404601, 404602, 404603, 404604, 404605, 404606 };

	private List<int> buffId_1 = new List<int> { 4046001, 4046002, 4046003, 4046004, 4046005, 4046006 };

	private List<int> skillId_s2 = new List<int> { 4046101, 4046102, 4046103, 4046104, 4046105 };

	private List<int> buffId_2 = new List<int> { 4046121, 4046122, 4046123, 4046124, 4046125 };

	private List<int> skillId_s3 = new List<int> { 4046201, 4046202, 4046203, 4046204, 4046205 };

	private List<int> buffId_3 = new List<int> { 4046201, 4046202, 4046203, 4046204, 4046205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214046, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214046, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214046, skillId_s3);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
	}

	protected override void OnReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (damageEvent.from != null && damageEvent.from is PlayerAdventureActor playerAdventureActor && damageEvent.to as MonsterAdventureActor != null && lv_s1 > 0 && !playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE && damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
		{
			playerAdventureActor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), playerAdventureActor);
			if (lv_s2 > 0)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), playerAdventureActor);
			}
			if (lv_s3 > 0)
			{
				playerAdventureActor.buffComponent.AddBuff(buffId_3.get_Item(stage_s3), playerAdventureActor);
			}
		}
	}
}
